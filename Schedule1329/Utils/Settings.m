//
//  Settings.m
//  Schedule1329
//
//  Created by Aivan on 19/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//


#import "Settings.h"


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
    [data writeToFile:[path absoluteString] atomically:YES];
}


/// Loads data from file.
id loadFromFile(NSString *name) {
    NSURL *path = [getDocumentsDirectory() URLByAppendingPathComponent:(NSString*_Nonnull)name];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[path absoluteString]];
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
//            _allCoursesObjects = @[];
            _allCourses = @"";
            [self save];
            [defaults setObject:@"yep" forKey:@"welldone"];
        } else {
            [self load];
        }
    }
    
    return self;
}

- (void)load {
//    _allCourses = [defaults stringForKey:@"allcourses"];
    _allCourses = loadFromFile(@"allcourses");
}

- (void)save {
//    [defaults setObject:_allCourses forKey:@"allcourses"];
    saveToFile(@"allcourses", _allCourses);
    [defaults synchronize];
}

Settings *sharedSettings = NULL;

+ (Settings *)sharedInstance {
    @synchronized(self) {
        if (sharedSettings == nil) {
            sharedSettings = [[super alloc] init];
        }
    }
    return sharedSettings;
}

@end
