//
//  Settings.h
//  Schedule1329
//
//  Created by Aivan on 19/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EventCoursesUpdate @"AllCoursesUpdate"
#define EventNewLastUpdate @"NewLastUpdate"


@class Course;

@interface Settings : NSObject

/// JSON with description of all the courses.
@property NSDictionary *allCourses;

/// Date of last courses list checking.
@property NSString *lastUpdate;

/// Seleced object from search to description.
@property Course *selectedCourse;

/// Chosen words from description to search.
@property NSString *searchPhrase;

/// Colors of courses table cells
@property UIColor *colorEvenCell, *colorOddCell;


/// Initializes settings object.
- (instancetype)init;

/// Saves app settings.
- (void)save;

/// Returns common instance.
+ (Settings *)sharedInstance;

@end
