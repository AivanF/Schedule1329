# Schedule 1329

[The app is available on AppStore](https://itunes.apple.com/us/app/кружки-московской-школы-1329/id1348662488)

This is an iOS app with **Courses description catalogue** of Moscow school 1329
(in spite of project's name, the schedule was decided not to be included by project managers).
The iOS app is a part of group project at Software Engeneering course at NSU HSE. In addition, there are the following parts:
- [Server side](https://github.com/Alpha424/CoursesAppServer)
- [Android app](https://github.com/AplusD/school-1329-additional-lessons-catalog-Android)

Although, only this app is under my responsibility, not other parts, nor the whole project.
But I also created the icon for both apps.

### Features:
- The app saves courses list and can use it when there is not Internet connection.
- You can search for occurrence, send an e-mail, or open map by click on corresponding fields.
- Paid courses are marked in common catalogue.
- Keyoard is hiding by click ourside it or field being edited.
- Gestures are supported to show/hide bottom bar, or to exit from a course description.

### Used techniques:
- **GUI**: StoryBoard's, xib's, `UINavigationController`, `UITableView` (with dynamic cells height), `UIAlertController`, `UISearchController`, `UISwipeGestureRecognizer`
- **Networking:** `NSURLSession`, `NSMutableURLRequest`
- **Data storing:** `NSUserDefaults`
- **Architectural:** Singleton pattern (the `Settings` class), `NSTimer` `NSNotificationCenter`
- **Other apps interaction:** `[UIApplication openURL: options: completionHandler: ]`, Firebase Analytics
