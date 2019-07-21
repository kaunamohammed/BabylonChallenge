# BabylonChallenge

# Features

- View list of posts ✅
- View list of comments ✅
- View related posts ✅
- View author's profile ✅
- Offline mode ✅

# Summary 

The mobile challenge has been a very rewarding experience, I found the requirements for the challenge very clear, but with enough flexibility to enable me to express myself and showcase my skills. 

In completing the challenge, my time was mostly spent on design, and achieving clean, maintainable and documented code. Taking me to a total of 5 days.

The key challenge I encountered was in deciding and implementing the right architecture that will allow me to achieve a good level of code separation, scalability and testability. I have detailed the challenges and solutions below.

# Architecture

I think one of the most debated topics in iOS development is the choice of architecture e.g. MVC, MVVM(-C) or MVP. In order to pick an architecture that I believed was suitable for the task, I considered a few goals in mind;

- Separation of Concerns
- Scalability
- Testability

I eventually went with the MVVM-C architecture. It has three key players, ```Model``` ```View```, ```ViewModel``` and ```Coordinator```. I went with this architecture because it offered me the ability to separate core components like navigation, networking and presentation.
It can be argued that MVVM-C might have been overengineering and simply navigating in the traditional way and sticking with **MVC** will have been better for an app of this scale, that would be a credible arguement. 

However, as iOS developers we rarely write basic apps and from personal experience, business requirements often changes as the app scales, our ViewControllers become massive, testing is not as straightforward and it becomes harder to reason about the code or make changes.

The ```Coordinator``` abstracted away the navigation and dependency injection from the ViewControllers, it also injected the ViewController dependencies and has a one-to-one communication with its ViewController. Furthermore, it is also easier to spin up a completely different navigation flow based on a new feature and write unit tests to test the navigation logic without having to launch the app.

The ```ViewModel``` allowed me to handle business logic seperately and it made the code more easily testable. It was also responsible for interacting with the networking layer and passing data to/from the ViewController.

Together, I was able to achieve a good level of separation between different layers of the app.

## Notes on MVVM-C

- There is still a chance for *Massive View Model* and it becoming a code dumping ground
- The major issue would be that what happens when someone unfamiliar with the subject of MVVM-C but understands another architecture looks at the code. It may be confusing and they may not know where to get started.
- There is no clear standard for Coordinators and so when reading about it, there are variants of how to actually implement it

# Third-Party

I did not want to hit ``` pod install ``` too much in this project as I wanted to showcase my skills. However, I introduced;

- [CoordinatorLibrary](https://github.com/kaunamohammed/CoordinatorLibrary) by me. I used this library to handle navigation
- [RxSwift](https://github.com/ReactiveX/RxSwift). I used this library to handle asyncronous operations and data binding to UI
- [RxRealm](https://github.com/RxSwiftCommunity/RxRealm). I used this library to be able to observe realm

# Finally

I would like to express my gratitude for the opportunity to work on this project. I look forward to hearing back from you.
