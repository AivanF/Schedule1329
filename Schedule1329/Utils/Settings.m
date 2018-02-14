//
//  Settings.m
//  Schedule1329
//
//  Created by Aivan on 19/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//


#import "Settings.h"

#pragma mark - Files handling functions

NSURL* getDocumentsDirectory() {
    NSArray<NSURL *> * paths = [[NSFileManager defaultManager]
                                URLsForDirectory:NSDocumentDirectory
                                inDomains:NSUserDomainMask];
    return paths[0];
}

/// Saves serialisable data to file.
void saveToFile(NSString *name, id todo) {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:todo];
    NSURL *path = [getDocumentsDirectory() URLByAppendingPathComponent:(NSString*_Nonnull)name];
    if ([data writeToFile:[path absoluteString] atomically:YES]) {
        NSLog(@"File '%@' saved!", path);
    } else {
        NSLog(@"File '%@' was NOT saved!", path);
    }
}

/// Loads data from file.
id loadFromFile(NSString *name) {
    NSURL *path = [getDocumentsDirectory() URLByAppendingPathComponent:(NSString*_Nonnull)name];
    NSLog(@"File '%@' loaded!", path);
    id res = [NSKeyedUnarchiver unarchiveObjectWithFile:[path absoluteString]];
    NSLog(@"%@", path);
    return res;
}


@interface Settings () {
    NSUserDefaults *defaults;
}
@end

@implementation Settings

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _allCourses = nil;
        _selectedCourse = nil;
        _lastUpdate = @"Неизвестно";
        
        defaults = [NSUserDefaults standardUserDefaults];
        if (nil == [defaults objectForKey:@"welldone"]) {
            [defaults setObject:@"yep" forKey:@"welldone"];
            [self save];
        } else {
            [self load];
        }
        
        self.colorOddCell = [UIColor whiteColor];
        self.colorEvenCell = [UIColor colorWithRed:0.94f
                                             green:0.94f
                                              blue:1.0f
                                             alpha:1.0f];
    }
    
    return self;
}

- (void)load {
//    NSLog(@"Settings-load");
    _allCourses = [defaults objectForKey:@"allcourses"];
    _lastUpdate = [defaults objectForKey:@"lastupdate"];
//    _allCourses = loadFromFile(@"allcourses");
    
}

- (void)save {
//    NSLog(@"Settings-save");
//    if (_allCourses) {
//        saveToFile(@"allcourses", _allCourses);
//    }
    [defaults setObject:_allCourses forKey:@"allcourses"];
    [defaults setObject:_lastUpdate forKey:@"lastupdate"];
    [defaults synchronize];
}

Settings *__sharedSettings = nil;

+ (Settings *)sharedInstance {
    @synchronized(self) {
        if (__sharedSettings == nil) {
            __sharedSettings = [[super alloc] init];
        }
    }
    return __sharedSettings;
}

@end
