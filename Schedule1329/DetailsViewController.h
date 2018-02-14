//
//  DetailsViewController.h
//  Schedule1329
//
//  Created by Aivan on 19/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CellDetail;

@interface DetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblDetails;
- (void)clickCell:(CellDetail*)cell;

// TableView Data Source protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

// TableView Delegate protocol

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
