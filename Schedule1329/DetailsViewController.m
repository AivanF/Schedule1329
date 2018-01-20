//
//  DetailsViewController.m
//  Schedule1329
//
//  Created by Aivan on 19/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UINavigationBar *barNav;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Creates a back button instead of default behaviour (displaying title of previous screen)
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
//                                                                   style:UIBarButtonItemStylePlain
//                                                                  target:self
//                                                                  action:@selector(backAction)];
    
//    tipsDetailViewController.navigationItem.leftBarButtonItem = backButton;
//    _barNav.backItem = backButton;
//    [_barNav setItem]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
