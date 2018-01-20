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
        defaults = [NSUserDefaults standardUserDefaults];
        if (nil == [defaults objectForKey:@"welldone"]) {
            _allCourses = nil;
            [defaults setObject:@"yep" forKey:@"welldone"];
            [self save];
        } else {
            [self load];
        }
    }
    
    return self;
}

- (void)load {
//    NSLog(@"Settings-load");
    _allCourses = [defaults objectForKey:@"allcourses"];
//    _allCourses = loadFromFile(@"allcourses");
    
}

- (void)save {
//    NSLog(@"Settings-save");
//    if (_allCourses) {
//        saveToFile(@"allcourses", _allCourses);
//    }
    [defaults setObject:_allCourses forKey:@"allcourses"];
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
