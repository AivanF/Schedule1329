//
//  Course.h
//  Schedule1329
//
//  Created by Aivan on 19/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EventCoursesUpdate @"AllCoursesUpdate"

@interface Course : NSObject

/// Is course paid or free
@property BOOL *isPaid;

/// All: full teachers name
@property NSString *teachersName;
/// All: feedback contacts
@property NSString *contacts;
/// All: classes place
@property NSString *place;

/// Paid only: start/end dates of the classes
@property NSString *dates;
/// All: form of the classes
@property NSString *classesForm;
/// All: kind of activity
@property NSString *activityKind;
/// All: association name
@property NSString *unionName;
/// All: hours per week
@property NSString *hoursPerWeek;

/// All: appropriate students ages
@property NSString *ages;
/// All: appropriate students grades
@property NSString *grades;

/// Paid only: course cost per month
@property NSString *costMonth;
/// Paid only: course cost per year
@property NSString *costYear;


/// Initializes Course object.
- (instancetype)initPaid:(BOOL)isit;

/// Returns if object is valid.
- (BOOL)isValid;

/// Describes Course object.
- (NSString *)description;

/// Parses JSON and saves courses objects.
+ (void)parseCourses:(NSDictionary *)dictionary maybeError:(NSError *)err;

/// Returns array with all courses objects.
+ (NSArray *)allCourses;

@end
