//
//  Router.swift
//  ExpensifyCodingTest
//
//  Created by Kauna Mohammed on 05/06/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import Foundation

final class Router: NetworkRouter {

    private var task: URLSessionTask?
    public init() {}
    func request(endPoint: EndPoint, completion: @escaping ((Result<Data, NetworkError>) -> Void)) {
        let session = URLSession.shared
        guard let request = buildRequest(from: endPoint) else { return }
        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else { completion(.failure(.unknown)); return }
                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200...299:
                        if let responseData = data {
                            completion(.success(responseData))
                        } else {
                            completion(.failure(.noData))
                        }
                    case 401...500: completion(.failure(.authError))
                    case 501...599: completion(.failure(.badRequest))
                    case 600: completion(.failure(.outdated))
                    default: completion(.failure(.failed))
                    }
                }
            }
        })
        task?.resume()
    }
    func cancel() {
        task?.cancel()
    }
    private func buildRequest(from endPoint: EndPoint) -> URLRequest? {
        guard let url = endPoint.url else { return nil }
        var request =  URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("accept", forHTTPHeaderField: "application/json")
        return request
    }

}
