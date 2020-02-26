# Messages

A test programming task for the fine folks at Fournova.

## Notes

### Storyboards

Normally I try to stay away from xibs and storyboards and write all my views programmatically with little help from [Cartography](https://github.com/robb/Cartography) for laying them out. I often find Interface Builder quite limited in more complex situations and I don't like that it's impossible to see what attributes are explicitly customized. I also don't like the fact that storyboards take the ownership of all controllers and other objects that are created from it. I have nothing agains magic as long as it's possible to look at the tricks behind it all, but since storyboards are all proprietary stuff I find it hard to trust them.

However, I used storyboards for this project since I was curios, thought that it might take faster to prototype, and they are friendly to designers and others who are not that technical.

Everything went pretty well except that I wasted few hours trying to get the message details scroll view work properly using only the storyboard. Firstly, scroll views in storyboards really want to use auto-resizing masks, and when disabled, everything breaks down and no constraints can fix it, leading to bunch of meaningless warnings that I couldn't get rid off.

So I ended up with manually adding a width constraint between the scroll view and its document view, so that the document view fills the available space horizontally. I also made the document view flipped so that it starts from the top of the scroll view. I find that these two adjustments together with a fully constraint based layout in the document view is the least hacky and the most sensible way to wrap something in a scroll view.

### Model framework

Model framework contains only a single `Message` struct so it might seem like an overkill to create a separate framework just for that, but in a real life situation I think it is very important to encapsulate model objects from the very beginning of a project so that AppKit/UIKit doesn't slowly creep into it.

Such encapsulation also helps later when writing unit tests so that they can be run quickly and independently by not being embedded in the app. Also, any other framework that might later link against this can also be tested without being embedded in the app if there are no dependencies on UI frameworks.

### App state

I'm a huge fan of unidirectional data flow (like [ReSwift](https://github.com/ReSwift/ReSwift)) and having a single struct that represents the app's state. I find that a good implementation of it greatly helps with modularization and reasoning how the app changes state. Certainly, Cocoa makes it impossible to store state just in a single space, but I like to think of app state as the canonical state of the app and all the local states are there for performance and API limitation reasons.

Either way, since this app is so simple and tiny I did not want to use any external library or even separate action structs since there are only three actions in the app: change sort order of messages, change the selected message, and mark message as read. However, I needed to some kind of state to keep track of the marked as read status of messages.

This `AppState` is recreated from the test messages every time the app is launched, but it could be very easily written to disk using `Codable` protocol and `JSONEncoder`, and read from the disk when app launches again. Since this wasn't asked for and it's easier to test the app if there are fresh unread messages every time it's launched, I skipped the implementation of this.

### Gravatar service

The Gravatar service is intended to be used as a single single instance for a single image view, meaning that fetching a new avatar will cancel the previous data task if there was any. This makes it easy to use it in reusable table view cells or in the reusable message details view.

There is a possible improvement for cases where multiple requests are started for the same avatar, but I think `URLSession` should limit the number of concurrent requests and once one of them finish the rest should hit the `URLSession`'s cache.

## Finally

Thanks for the interesting test assignment—it was quite fun to poke around Interface Builder even with the few frustrating moments :)
