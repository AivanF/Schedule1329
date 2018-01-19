//
//  Settings.h
//  Schedule1329
//
//  Created by Aivan on 19/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

/// JSON with description of all the courses.
@property NSDictionary *allCourses;
//@property NSArray *allCoursesObjects;

/// Initializes settings object.
- (instancetype)init;
/// Saves app settings.
- (void)save;

/// Returns common instance.
+ (Settings *)sharedInstance;

@end
