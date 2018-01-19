//
//  SearchViewController.m
//  Schedule1329
//
//  Created by Aivan on 21/12/2017.
//  Copyright © 2017 AivanF. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tblAllCourses setBackgroundColor:[UIColor colorWithRed:0.9f
                                                       green:0.9f
                                                        blue:1.0f
                                                       alpha:1.0f]];
    
    [self performSegueWithIdentifier:@"showDetails" sender:nil];
}

@end
