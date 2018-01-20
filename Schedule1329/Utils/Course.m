//
//  Course.m
//  Schedule1329
//
//  Created by Aivan on 19/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import "Course.h"
#import "Settings.h"

@implementation Course

#pragma mark - Instance methods

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

- (NSString *)description {
    // https://stackoverflow.com/q/12422599/5308802
    
    const char *cstr = [_unionName cStringUsingEncoding:NSUTF16StringEncoding];
    
    if (!cstr) {
        return @"Oh...";
    }
    
    NSString *un;
//    un = [NSString stringWithCString:cstr encoding:NSUTF16StringEncoding];
    un = @"";
    
    if (_isPaid) {
        return [NSString stringWithFormat:@"Course paid %@", un];
    } else {
        return [NSString stringWithFormat:@"Course free %@", un];
    }
}


#pragma mark - Static methods


NSArray *__allCourses = nil;

+ (void)parseCourses:(NSDictionary *)dictionary maybeError:(NSError *)err {
    if (err) {
        NSLog(@"Course+parseCourses: Error with Courses data reading");
        return;
    }
    
    NSMutableArray *current = [NSMutableArray new];
    
    uint fdone = 0, pdone = 0;
    NSArray *free = [dictionary objectForKey:@"free"];
    if (free) {
        for (NSDictionary *el in free) {
            Course *obj = [[Course alloc] initPaid:NO];
            
            obj.teachersName = el[@"ФИО педагога"];
            obj.contacts = el[@"Обратная связь"];
            obj.place = el[@"Место проведения занятий"];
            
            obj.classesForm = el[@"Форма проведения занятий"];
            obj.activityKind = el[@"Вид деятельности (направленность)"];
            obj.unionName = el[@"Наименование объединения"];
            obj.hoursPerWeek = el[@"Часов в неделю"];
            
            obj.ages = el[@"Возраст обучающихся"];
            obj.grades = el[@"Классы"];
            
            if ([obj isValid]) {
                [current addObject:obj];
                fdone++;
            } else {
                NSLog(@"Course+parseCourses: invalid free course object: %@", el);
            }
        }
    }
    NSArray *paid = [dictionary objectForKey:@"paid"];
    if (paid) {
        for (NSDictionary *el in paid) {
            Course *obj = [[Course alloc] initPaid:YES];
            
            obj.teachersName = el[@"ФИО педагога"];
            obj.contacts = el[@"Обратная связь"];
            obj.place = el[@"Место проведения занятий"];
            
            obj.dates = el[@"Начало занятий/окончание учебного периода"];//
            obj.classesForm = el[@"Форма проведения занятий"];
            obj.activityKind = el[@"Вид деятельности (направленность)"];
            obj.unionName = el[@"Наименование объединения"];
            obj.hoursPerWeek = el[@"Часов в неделю"];
            
            obj.ages = el[@"Возраст обучающихся"];
            obj.grades = el[@"Классы"];
            
            obj.costMonth = el[@"Стоимость обучения в месяц (руб)"];//
            obj.costYear = el[@"Стоимость за годовой учебный период"];//
            
            if ([obj isValid]) {
                [current addObject:obj];
                pdone++;
            } else {
                NSLog(@"Course+parseCourses: invalid paid course object: %@", el);
            }
        }
    }
    NSLog(@"Course+parseCourses: parsed %d free and %d paid courses!", fdone, pdone);
    
    @synchronized (self) {
        __allCourses = current;
    }
    
    if (fdone + pdone > 0) {
        [Settings sharedInstance].allCourses = dictionary;
        [[Settings sharedInstance] save];
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:EventCoursesUpdate
     object:self];
}

+ (NSArray *)allCourses {
    return __allCourses;
}


@end

