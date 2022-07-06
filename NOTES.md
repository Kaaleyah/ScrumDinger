# ScrumDinger

Created: June 24, 2022 11:03 AM
Type: App

# Source of Truth

One data that will be shared between views. This is done to prevent inconsistent data and variable copies. 

## State

`@State` allows us to create a source of truth. View is defined depending on this variable. Users can interact and change these values so that new render is done.

![SUI_045-010~dark@2x.png](ScrumDinger%2062388f330cd94b99bd0fac4bcb784116/SUI_045-010dark2x.png)

These properties should be private so that we can avoid interference. `@State` allows us to create a mutable variable for the same view but what about the between views?

## Binding

`@Binding` allows us to share source of truth between views. It doesn’t store data but rather creates a connection for it. This connections allows for sync.

![SUI_045-020~dark@2x.png](ScrumDinger%2062388f330cd94b99bd0fac4bcb784116/SUI_045-020dark2x.png)

Parent has the `@State` property while child is connected to it by `@Binding` connection.

---

```swift
var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $data.title)
            }
        }
    }
```

$ sign create a binding for data .title

# Reference Types

## Observable Classes

```swift
class ScrumTimer: ObservableObject {
   @Published var activeSpeaker = ""
   @Published var secondsElapsed = 0
   @Published var secondsRemaining = 0
   // ...
}
```

These `@Published` properties of a `ObservableObjec`t class will trigger a UI update when they change.

## Monitoring Objects

To make SwiftUI monitor an object, we can add following attributes and create a new source of truth.

```swift
struct MeetingView: View {
   @StateObject var scrumTimer = ScrumTimer()
   // ...
}
```

`@StateObject` initializes the object in the view and keeps it available for the view and other view that we pass.

```swift
struct ChildView: View {
   @ObservedObject var timer: ScrumTimer
   // ...
}
```

`@ObservedObject` is used to indicate that object is passed from another view. No need for an initial value.

## Linking Observables

```swift
struct MeetingView: View {
   @StateObject var scrumTimer = ScrumTimer()
   var body: some View {
      VStack {
         ChildView(timer: scrumTimer)
      }
   }
   // ...
}
```

We can simply pass the object via argument.

```swift
struct ParentView: View {
   @StateObject var scrumTimer = ScrumTimer()
   var body: some View {
      VStack {
         ChildView()
            .environmentObject(scrumTimer)
      }
   }
   // ...
}

struct ChildView: View {
   @EnvironmentObject var timer: ScrumTimer
   // ...
}
```

Or instead of passing them individually, we can place these objects into environment. By use of the `.environmentObject(_ :)` modifier, any parent view can access that child view.

`@EnvironmentObject` wrapper now can access object even if there is no intermediate views that wraps it.

---

![Screen Shot 2022-06-29 at 12.03.57.png](ScrumDinger%2062388f330cd94b99bd0fac4bcb784116/Screen_Shot_2022-06-29_at_12.03.57.png)

## Phases and Transitions

- **active:** A scene in the foreground that user can interact with
- **inactive:** The scene is visible but disabled for interaction
- **background:** Running but invisible app. State before termination

Current state can be read by `scenePhase` value. 

![SUI_067-020-010~dark@2x.png](ScrumDinger%2062388f330cd94b99bd0fac4bcb784116/SUI_067-020-010dark2x.png)

An event like a user interaction or notification causes an app to respond. A closure runs in response to the event, which might result in a mutation in the source of truth. After observing a mutation, SwiftUI updates the view and renders the UI.

## Life Cycle Events

- **onAppear(perform: )** Trigger an action whenever a view appears.
- **onDisappear(perform: )** Trigger an action whenever a view disappears.
- **task(priority: _: )** When view appears run actions asynchronously.

---

## iOS Versions

Some features are only available in latest iOS versions. To apply the app to all versions you can set some features to only certain versions.

```swift
struct ScrumsListSeparator: ViewModifier {
   func body(content: Content) -> some View {
      if #available(iOS 15, *) {
         content
            .listRowSeparator(.hidden)
      } else {
         content
     }
   }
}
```

`#available` part allows app to work that part only ıf iOS 15 is available.

```swift
@available(iOS 15.1, *)
func setupGroupSession() {...}
```

We can also make some functions only available to certain versions.

---

## ****Defining an Asynchronous Function****

To define a asynchronous function, just place `async` between parameter list and ->. 

```swift
class ViewModel: ObservableObject {
   @Published var participants: [Participant] = []

   func fetchParticipants() async -> [Participant] {...}
}
```

### Calling Async Function

await will suspend the code until the corresponding function is completed. 

```swift
class ViewModel: ObservableObject {
   @Published var participants: [Participant] = []

   func refresh() async {
      let fetchedParticipants = await fetchParticipants()
      self.participants = fetchedParticipants
   }
   func fetchParticipants() async -> [Participant] {...}
}
```

In this case, the code will wait until `fetchParticipants()` is completed. With asynchronous functions, the code will compile linearly, next line will wait for previous line to finish its work.

```swift
struct ContentView: View {
   @StateObject var model = ViewModel()
 
   var body: some View {
      NavigationView {
         List {
            ForEach(model.participants) { participant in
               ...
            }
         }
         .task {
            await model.refresh()
         }
      }
   }
}
```

.task modifier will work after view appears and it will be cancelled when view disappears.