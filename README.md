# Schedule 1329

This is a small iOS app with Courses description catalogue for Moscow school No.1329
(in spite of app's name, the schedule was decided not to be included by managers).
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

### Used techniques:
- **GUI**: StoryBoard's, xib's, Constraint's, `UINavigationController`, `UITableView`, `UIAlertController`
- **Networking:** `NSURLSession`, `NSMutableURLRequest`
- **Data storing:** `NSUserDefaults`
- **Architectural:** Singleton pattern (`Settings` class), `NSNotificationCenter`
- Other: `[UIApplication openURL: options: completionHandler: ]`
