//
//  GlobalConstants.swift
//  ExpensifyCodingTest
//
//  Created by Kauna Mohammed on 05/06/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import Foundation

public struct GlobalConstants {
  
  public struct ErrorMessage {
    static let couldntRetrieveExpenses = "We couldn't create your expense. Please try again"
    static let internalError = "An internal error has occured"
    static let invalidCredentials = "We couldn't find a user with this partner/userId"
    static let notOnMainThread = "You are not on the main thread, please switch to the main thread"
    static let errorFulfillingRequest = "There was an error fulfiling your request"
    static let internalError2 = "Looks like there was a problem. Please try again later"
  }
  
}
