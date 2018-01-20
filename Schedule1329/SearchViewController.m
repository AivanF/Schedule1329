//
//  SearchViewController.m
//  Schedule1329
//
//  Created by Aivan on 21/12/2017.
//  Copyright © 2017 AivanF. All rights reserved.
//

#import "SearchViewController.h"
#import "Course.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tblAllCourses setBackgroundColor:[UIColor colorWithRed:0.9f
                                                       green:0.9f
                                                        blue:1.0f
                                                       alpha:1.0f]];
    
//    [self performSegueWithIdentifier:@"showDetails" sender:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventCoursesUpdate:)
                                                 name:EventCoursesUpdate
                                               object:nil];
}

- (void)eventCoursesUpdate:(NSNotification *)notification {
//    NSLog(@"SearchViewController-eventCoursesUpdate");
    [_tblAllCourses reloadData];
}

@end
