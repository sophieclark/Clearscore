# Clearscore

Technical task for clearscore.

## Architecture
I chose to go with MVVM-C as there isn't a lot of presentation logic needed, but keeps code easily testable.

### Model
All of the applications data will be stored in models. Currently the application has no caching or data storing so this is lost when the app quits.

### View
These are composed of View Controllers and Views. I have tried to split views into separate subviews where it makes sense so that they can be easily reused. I chose to create the views programatically as I persoanlly find that easier, and implemented a `NiblessViewController` and `NiblessView` which I subclass from. 

### View Model
The view model fetches and prepares data for the consumption of the views.

### Coordinator
I used a coordinator layer to handle the navigation around the app. This makes it easier to handle moving to any view controller from anywhere in the app as it should prevent view controllers and models from being intrinsically linked to any other view models and controllers.

### Networking 
I created a struct which stores an endpoint which is passed into a fetcher. The endpoint is an enum to allow you to set test data more easily and reduce code duplication when passing test data during tests. It also creates a single source of truth for the endpoint URLs which makes it easier to update if they ever change. 

To do the networking I created a protocol called Networkable with an implemented function `fetch` which does the network call and returns the result as a publisher. This can be expanded in the future to allow for different request types i.e. "GET", "PUT", "POST", "DELETE", but for now this wasn't needed.

## Testing
I have added both unit tests and automation tests. Due to the size of the app there are not many Automation tests, but I have covered all the journeys between the dasboard and credit report, as well as the various success and error states.
 
## Combine
I chose to use combine as I think it makes code easier to read as you avoid having lots of nested completion blocks which can be sometimes difficult to track when debugging code. It also simplifies asyncronous and multithreaded code. 

## Future improvements
One improvement I would make is to add a refresh function such as pull to refresh on the homescreen, and possibly in the credit report view. This would mean the user wouldn't have to quit and reload the app to get new data. 
I would also try and make improvements to the UI. Whilst functional it's not the prettiest looking! This would mostly take place on the credit report screen. I would most likely make the changes and insights views into horizontal scroll views and present information on the short term debt in one cell and long term in another, with the same for the insights.
The accessibility on the app could also be improved by making the fonts dynamic and also adding some more accessibility labels. 
