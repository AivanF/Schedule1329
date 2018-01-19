//
//  Course.m
//  Schedule1329
//
//  Created by Aivan on 19/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import "Course.h"

@implementation Course

- (instancetype)initPaid:(BOOL)isit {
    self = [super init];
    
    if (self) {
        _teachersName = nil;
        _contacts = nil;
        _place = nil;
        
        _dates = nil;
        _classesForm = nil;
        _activityKind = nil;
        _unionName = nil;
        _hoursPerWeek = nil;
        
        _ages = nil;
        _grades = nil;
        
        _costMonth = nil;
        _costYear = nil;
    }
    
    return self;
}

- (BOOL)isValid {
    if (!_teachersName || !_contacts || !_place) {
        return NO;
    }
    if (!_classesForm || !_activityKind || !_unionName || !_hoursPerWeek) {
        return NO;
    }
    if (!_ages || !_grades) {
        return NO;
    }
    if (_isPaid) {
        if (!_dates || !_costMonth || !_costYear) {
            return NO;
        }
    }
    return YES;
}

@end
