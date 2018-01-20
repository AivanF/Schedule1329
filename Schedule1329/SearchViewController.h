//
//  SearchViewController.h
//  Schedule1329
//
//  Created by Aivan on 21/12/2017.
//  Copyright © 2017 AivanF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController  <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblAllCourses;
@property (weak, nonatomic) IBOutlet UITextField *txtDetails;


// TextField Delegate protocol

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

// TableView Data Source protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

// TableView Delegate protocol

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

