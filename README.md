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

- [CoordinatorLibrary](https://github.com/kaunamohammed/CoordinatorLibrary)

**Justification**

CoordinatorLibrary was heavily inspired by the "Coordinator Pattern" and was built for a few reasons:

- absract away navigation logic from the UIViewController
- remove some boilerplate in implementing the pattern

- [RxSwift](https://github.com/ReactiveX/RxSwift)

**Justification**

RxSwift solves the problem of streaming values over time. Nowadays, a lot of apps we make as iOS developers handle user interaction, asyncronous operations i.e. network requests and similar events. RxSwift solves a lot of the problem around reacting to these events and simplifies non-trivial use cases such as syncronizing network requests or retry mechanisms, allowing us as developers to focus on just observing these events and reacting to them accordingly.

- [RxRealm](https://github.com/RxSwiftCommunity/RxRealm)

**Justification**

RxRealm provides a thin wrapper around Realm. It allowed me to expose Realm objects as an observable stream and bind directly to UI such as UITableView.

- [SwiftLint](https://github.com/realm/SwiftLint)

**Justification**

SwiftLint is a powerful tool that really serves to make us as developers adhere to certain standards when coding in Swift. If I was to assemble a team to build v2 of this app and they all came with slightly different coding styles and conventions, SwiftLint gives the power to limit deviations from coding standards I would set out for the app, it also comes equipped with the ability to autocorrct issues such as line length or trailing white spaces, saving a lot of development time on formatting code.

# Finally

I would like to express my gratitude for the opportunity to work on this project. I look forward to hearing back from you.
