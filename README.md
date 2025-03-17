### Summary: Include screenshots or a video of your app highlighting its features

The project is divided into modules. The app target contains only the SwiftUI App view, the main screen view, any supporting sub-views, and view models.

The modules are:
* Core - Utility functions, extensions, and UI components
* Model - Model objects that are used with the app
* Network - Network protocol and `NetworkError` definitions
* RecipeApi - API implementation conforms to the `NetworkService` protocol that uses the given endpoints to fetch and decode JSON.  Also contains mock versions of the endpoints that are used for testing and in SwiftUI Previews.
* TestUtilities - Utility functions and resources used to help with mocking out the network behavior.

I created three `PreviewModifier` structs from each endpoint to test and design the UI using SwiftUI Previews with minimal extra code. For dependency injection, I used an idea from the `SwiftLee` blog and added an `@Injected` property wrapper.  I've used this method in other projects and it works well.

The UI is designed to show the required elements. The recipe list is sectioned by cuisine for easier browsing.  I made use of the `sourceUrl` and `youTubeUrl` to add buttons to the row view to allow the user to view them using a SwiftUI `UIViewControllerRepresentable` View struct since `WKWebView` and friends still don't have native SwiftUI equivalents.  

The app also features a bespoke `ImageLoader` accompanied by a custom SwiftUI View `FetchImage`.  `ImageLoader` uses a Swift Concurrency `actor`. This allows protection from data races by ensuring that all calls to the public methods are properly synchronized to protect any mutable properties the actor has.

#### Screenshots
| Main Screen | Video | Refresh |
| ----- | ----- | ----- |
| ![Recipe-Fetcher-screenshot](https://github.com/user-attachments/assets/18080f10-0b37-4e79-b054-7a20e87573f4) | ![Video](https://github.com/user-attachments/assets/be0b9462-2cef-4e26-b25c-65212a86cac6) | ![Refresh](https://github.com/user-attachments/assets/33532bc6-0390-44de-830b-70aba4c3cfdf) |


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

When given an API contract, I will start off creating any model objects I see from the API responses. From there create the first versions of the network implementations to see how well the models work with the API.  Then I'll create unit tests for each of the endpoints. When creating unit tests for network endpoints, it's important to have a way to mock out the responses so that the API server is not constantly being hit by unit tests all the time.  With the mocks, I'll create a protocol that uses the network endpoints already made and instead of using the network code, I'll load a file that contains the expected JSON response. 

Starting from the model and network code allows me to better understand what other supporting model objects or classes may be needed. Unit testing this type of code is fairly easy to get going and gives me the confidence that any refactoring that needs to be done during the creation of the UI that I'm not breaking anything.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent about 6-8 hours. I spent small sections of time that I had working on a particular part of the project to help keep things focused and moving forward. 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I would have made the `NetworkService` protocol contain more error checking and allow for different HTTP methods, etc.  But, with this simple static JSON, this is all that was needed to be written.

### Weakest Part of the Project: What do you think is the weakest part of your project?

The UI design could have been done a bit better.  I wanted to add in search and better support for iPad, but I ran out of time.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

I have used the new `PreviewModifier` in other projects to make using SwiftUI previews easier and use less boilerplate code. The three endpoints given allowed me to extend my past use of `PreviewModifiers` to extend it to make it easier to provide test data in different states (happy path, empty, and malformed). 

This project is one of the first times that I've made use of an `actor`.  Generally, the idea works great and the developer doesn't have to think about data races. After I had already finished writing it, I came upon an article about "actor reentrancy". The example was very similar to what I had done for `ImageLoader`, but I hadn't taken "actor reentrancy" into account. I was able to easily go back and add what was needed to ensure that this wasn't a problem. I verified it by adding more use cases to the unit test.
