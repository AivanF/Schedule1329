//
//  AppDelegate.h
//  Schedule1329
//
//  Created by Aivan on 21/12/2017.
//  Copyright © 2017 AivanF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

