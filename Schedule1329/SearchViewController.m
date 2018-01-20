//
//  SearchViewController.m
//  Schedule1329
//
//  Created by Aivan on 21/12/2017.
//  Copyright © 2017 AivanF. All rights reserved.
//

#import "SearchViewController.h"
#import "CellCourse.h"
#import "Course.h"
#import "Settings.h"

@interface SearchViewController ()
{
    NSArray *_content;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _content = @[];
//    [_tblAllCourses setBackgroundColor:[UIColor colorWithRed:0.9f
//                                                       green:0.9f
//                                                        blue:1.0f
//                                                       alpha:1.0f]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventCoursesUpdate:)
                                                 name:EventCoursesUpdate
                                               object:nil];
    [self updateContent];
}

- (void)updateContent {
    // Check if has filter options
    NSString *filterText = _txtDetails.text;
    BOOL filter = NO;
    NSMutableArray *parts = nil;
    if ([filterText length] > 0) {
        parts = [[filterText componentsSeparatedByString:@" "] mutableCopy];
        [parts removeObject:@""];
        filter = [parts count] > 0;
    }
    
    if (filter) {
        // Filter by words
        NSMutableArray *current = [NSMutableArray new];
        for (Course *el in [Course allCourses]) {
            BOOL well = YES;
            for (NSString *word in parts) {
                well = well && [el containsString:word];
                if (!well)
                    break;
            }
            if (well) {
                [current addObject:el];
            }
        }
        _content = current;
        
    } else {
        // Use raw data
        _content = [Course allCourses];
    }
    
    // Sort objects
    _content = [_content sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"Conent size: %d", (int)[_content count]);
    
    [_tblAllCourses reloadData];
}

- (void)eventCoursesUpdate:(NSNotification *)notification {
    [self updateContent];
}

#pragma mark - TextField Delegate protocol

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self updateContent];
    return NO;
}

#pragma mark - TableView Data Source protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_content count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellCourse *cell = [tableView dequeueReusableCellWithIdentifier:@"CellCourse"];
    if (cell == nil) {
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"CellCourse" bundle:nil];
        cell = (CellCourse *)temporaryController.view;
    }
    NSInteger row = [indexPath row];
    Course *cur = _content[row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.labUnionName.text = cur.unionName;
    cell.labActivityKind.text = cur.activityKind;
    cell.labAges.text = cur.ages;
    
    if (row % 2) {
        [cell setBackgroundColor:[Settings sharedInstance].colorOddCell];
    } else {
        [cell setBackgroundColor:[Settings sharedInstance].colorEvenCell];
    }
    
    // TODO: indicate paid courses!
    
    return cell;
}

#pragma mark - TableView Delegate protocol

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [Settings sharedInstance].selectedCourse = [_content objectAtIndex:[indexPath row]];
    [self performSegueWithIdentifier:@"showDetails" sender:nil];
}

@end
