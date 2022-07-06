# ScrumDinger

Created: June 24, 2022 11:03 AM
Type: App

# Source of Truth

One data that will be shared between views. This is done to prevent inconsistent data and variable copies. 

## State

`@State` allows us to create a source of truth. View is defined depending on this variable. Users can interact and change these values so that new render is done.

![SUI_045-010~dark@2x.png](https://lh3.googleusercontent.com/zY3DQj4bFRi6lvoSpyahyx3AViRkOUcRIPfjQr5IdI3cJJZfpO-86FmqsO8J4GxjyfMvV7FqmEKCr0rz3HcQ2E0W7zrPtFv0i-Sd3alivi2s4NK8PkdWPpqGnFnNZ-YWp_9tMbUSfgQFAu9NsmLrQGidFhWuMtr5CzkEmB77lB-8PRiIkk33No8hy8l5DOaaUPG5VLLZZfu1YDKB2hdT9DUfBjP5h2ub-3Mi81sNUq8AHHNvQJ6z_7L0kyIg4wJLYtrMh-5Z9SHGDAYCJoNuR59Q_3hyZv9EKVNb96I9Mt9d4cMblrI85axIGn4wUXHXJK_06kI--wuSZ938V_VEtrN9JL7aTHNOCow-ySVnlC3QaHDJ5LKww1nWRs9moflWge43C_w_OFZq0i-fQ0HSJ8bJbiXl2Fl0p3pqH17pFl9WdVVExvsCTUSj1OvMjAYeKYBQLuRKLiNf1M_dfLE8OY0AMRlEIf9zEwehSbNEz0uf1xK6kjE4dH_bW-ZjIRvujbyesPKOeyWkgJKGaUSM2JFy9Jj4wk3IV8WxQq6ghmBSQiKNZ5nar3SQsYVqHzeIFdaSFENOjN0-_uGPGSpmYCVxu2jSZDCgsC_RKx93BjqMWtjIMA4kDJyve8BkxSbjV74wHggn10LrKuB3rXsrb-CKhShAHpOSWAYU6ZjjFH7JuhL5_BPMUh9mX0jnoZKAMeC5nAbbqbzwMnBmrescRWgkQZA1N9bajlGo94S-II9Oo-c2ADabB8De7_x5X3qEoCh3aVeCasZpxaqrMuLYCWSFa2e-L9a2EVVPLIR9kQuana6sxcVn3Avleop8InVhPEtzVxnO-A4ZzAIIJtt5rXLHw0e1ThFwz4o-2VcE0zk=w1632-h600-no?authuser=1)

These properties should be private so that we can avoid interference. `@State` allows us to create a mutable variable for the same view but what about the between views?

## Binding

`@Binding` allows us to share source of truth between views. It doesn’t store data but rather creates a connection for it. This connections allows for sync.

![SUI_045-020~dark@2x.png](https://lh3.googleusercontent.com/3e_uamxJk5Gc_EA7wKYP8KskGheacdaJWaA4WzA1RXBhCIOybF5CJ3m-9VWUoJ7InJWDDr0Pm5x_q3ncapJej8LKd_b-_OFG0MiHRU8oVGrtKFVwLG-Y4hRFUChkPEC9IrGm59rd05yknor53ydcSkD1LHaxUo98rNzC8rPpWfh_q4X9pBRxL_N5Cd5ORfF_q7ZDh9VsJ_J021-ifHELkpD-mqraTeNlvbRIAXatFCz7RJnu3O4pOaiS0nSMxk0792mYRQeAK-gjtKdeSSsyVDU9fSRg0V30wfnR6kRZVm8fZkm3AllyU-pTLJLBGpcvYY-xCdiwYo5oLwvRvLvkiwBlV1QSJ3fQ31ZWhpB2wAAqcU0RaO9ffB4AshX0LdQIy1IonBYzzG9-PnQ3MAMo3QB8fUInJjrUjTfry-xTBjyr6_QJlAjncdp7rFAX89mS1hOQKvpdEo-u8mtXiUbqO3cZ2MdfP9Icb7r7kDQEu1GR-81G_9HOPfW533Yi5gZGjNuujDx1OqU8Liq6AIMQICxoEuVauNtujQLmcf-BPWm9fNticG6fls4EaVJnk8hBn_MRtc_H6pUNW0Qt3EIbCYUO2J8-7iejDP2Sx2taNY7ojv1HPg4VMotzfFP-Wzdl1U8uXnapzWcAK7CzqG_Z7S-RZqwYqprzfEsWA10-6M3tTe_tOkiP4XND7Jeu76X41fZ7q5m7XcCLX-nrDxmJLbBXAHDIdIxEGJizJUa0gjJjkua55bXYdjI-vJXpgch-goHC8cH1bPBZsWjcLiRsFya7NW5OAkpIRG3qB5MhTbpDx-yXvI8i55rc6B1v4OeOkukfKG2mumkWLB2YZjZxBi-WRlLL-xSFkg9E469agFA=w1632-h400-no?authuser=1)

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

![Screen Shot 2022-06-29 at 12.03.57.png]([ScrumDinger%2062388f330cd94b99bd0fac4bcb784116/Screen_Shot_2022-06-29_at_12.03.57.png](https://lh3.googleusercontent.com/jonu6VwvQQEpvXTqRgDSjKZHqJ76TO4X4CkM4rlJHoVZJ4enESuycsBuwbZ_lM03JJIZoL98ulMzvp2X0-9yy6jB6i0g3qnikUBxsxGwdaK6A68Veh0-JEUuy6ZcQNWTyf958qBonYRbRXOweUEzE-ONipAg1ntpvmU53DantEFpcidn3D1yj0kE8mGWBxMlDmjQ4KJgcy5ajaAsWv-2P-zft3m0Ikx0O2yWIOhGQvjv24Z0wIGru9cucejGH1It3izh8CZ0j3W8dqUGPh5VLSzaGb2DHR_sKRdlaBAb297IhJOSmj-JgRjkW6s8XlCQgqeyVo2kcFTZGoqLoh9lykZ2Jg3TicBvLQzB8Nh4b9fcMca5w7Ajnlyz7rmeJ8MnSuL07UQSMuXY_7VqMAcDekqPKP-vjdcRC0JHxCdbiX-JcW2A-AKnbMHjcGyE_9u7kJ_A7_LK2utEwXi-f_FL2yFuLMYsERRx_BQYrnrxEN0gF1SHskqSmGl3dLFU6lfEjgcynIuPi8f3DlqOGqIC-HntVfYooLkVbun0P-e46nUr69b2ucsKpIOJTrNn-7TIqEzsIOwkDCNRPC4ce_vwIflbPTdF_If9HBEhPcdBtbDPeA_j4vp1PjEEvwFSREscM1Y66UZxYNwUUpRnEIKeiY0IB59lM7FYsx5ith7WvFijP6m4CsjoC0XcbNMUWwvfCv6JxRWbvZQ0Lwj9PkVRkl2EQTgOVUjzFEIjl3ZMj6w7GzN1ie1VMpvLBWtUCxlfBl-tcSCYoX6ozDevA-SKeZd52SQSnRS5y5ZL2E7UpoJf_fCGNa18Oa7QwdZ43tnYIu7BSJbNuqksUtqh6TgF9c6k3TcFP9EO4RIeNVQs35U=w1674-h488-no?authuser=1))

## Phases and Transitions

- **active:** A scene in the foreground that user can interact with
- **inactive:** The scene is visible but disabled for interaction
- **background:** Running but invisible app. State before termination

Current state can be read by `scenePhase` value. 

![SUI_067-020-010~dark@2x.png](https://lh3.googleusercontent.com/VNRzNta0mzlrXNgFk9a8GSJa04eOhUesPL-DQ8yRQUtyhITmhcfaGbv42UDPVVchNbKa4YWndnZtjTRbhAHGGbIS-7nn1jtXK-dc7bFI6aMxp_G66diJEwohjlyceP5txcvPgD4jVgTlpzKVbyqmoxfHuWqJDjIwBLEMg_7PgytZ6MeoWLSdar8QVEcbROXIwcvIb0RYWTqeo318zFXB6-1FA0l87hwT1sG9i8nE54-V2_5KvdB2g5uH4mgPCzaQXJ3zn-s9QqbOGUYHuwgnIZuwxzbXKR5XEq0irt_N-ON9HWRfvEZARr9IgZF6ahxrTn1qKDR5HZjJo-h8q6jybjTDseYcO6kDtgMLkkEh68rGW_l71Qu67CmIqou2_UKalkclMxf4D5ybkUEbJVDDMW2YZZyjKpdX2EX9uqYx1a6Y0VWbgutJLTk-107lyo1r5wS93eCgQ7q3QF3OjGrZWdmAhdqQchswZLm9a5BZRmjc1VQNeQvpb5ma6qYcp-AeWXhHERxgQ_4WJ-1AB8i2VVphPJnTd9Q4IB2fJL67EAhxYcSx8yPzRShFtXYBolRZ5QofOMXYVXNYuEld1Mm-34oGxWxIYaBjJE7V27PtdHR8F7u5Xk_8boLRe0yCHJVTyxrdlvMxovQZeABxTtOr_arAIwSfv6mgQEqsmhyVcXsDjY1CPT5RWOpsu4MZDRCamE_nBSSoqAs_GB0vFHJIOdL5msJZS9jFDTPQrKwytgyopf91LSbGHqXrd4b6P_a11wrhCO5V2mL9xgxwrZsvCUtkOkTgceemraaDCwEiciDwMieaeCp685Db5FPcUO02jS7Wxfasjek25rd7hTFaD0nhMYZM3dgvBlgqADtFMrc=w1632-h800-no?authuser=1)

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
