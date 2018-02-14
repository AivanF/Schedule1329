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
#import "AppDelegate.h"

@interface SearchViewController ()
{
    NSArray *_content;
    BOOL _hasfocus;
    UISearchController *_searchController;
    BOOL _opened;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up minor things
    _opened = YES;
    [_labLastUpdate setText:[Settings sharedInstance].lastUpdate];
    
    [self setOpened:YES];
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fire:)
                                   userInfo:nil
                                    repeats:NO];
    
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDownFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [_viewDown addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [_viewDown addGestureRecognizer:recognizer];
    
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [_viewDown addGestureRecognizer:tapper];
    
    // Set up major things
    _hasfocus = NO;
    _content = @[];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.dimsBackgroundDuringPresentation = NO;
    
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.placeholder = @"Искать кружки";
    [_searchController.searchBar setValue:@"Отмена" forKey:@"_cancelButtonText"];
    [_searchController.searchBar sizeToFit];
    
    self.navigationItem.titleView = _searchController.searchBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventCoursesUpdate:)
                                                 name:EventCoursesUpdate
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventNewLastUpdate:)
                                                 name:EventNewLastUpdate
                                               object:nil];
    [self updateContent];
}

- (void)viewDidAppear:(BOOL)animated {
    if ([Settings sharedInstance].searchPhrase) {
        [_searchController.searchBar setText:[Settings sharedInstance].searchPhrase];
        [Settings sharedInstance].searchPhrase = nil;
        
        [self updateContent];
        
        [_tblAllCourses setContentOffset:CGPointZero animated:YES];
    }
}

- (void)updateContent {
    NSString *filterText = _searchController.searchBar.text;
    
    // Check if has filter options
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
        [_labCount setText:[NSString stringWithFormat:@"Найдено: %d шт", (int)[_content count]]];
        [AppDelegate event_search:filterText];
        
    } else {
        // Use raw data
        _content = [Course allCourses];
        [_labCount setText:[NSString stringWithFormat:@"Все кружки (%d шт)", (int)[_content count]]];
    }
    
    // Sort objects
    _content = [_content sortedArrayUsingSelector:@selector(compare:)];
    
    [_tblAllCourses reloadData];
}

- (void)fire:(NSTimer *)t {
    [self setOpened:NO];
}

- (void)setOpened:(BOOL)v {
    if (v == _opened) {
        return;
    }
    _opened = v;
    if (_opened) {
        [UIView animateWithDuration:0.3f animations:^{
            _heighter.constant = 100;
            [self.view layoutIfNeeded];
        }];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            _heighter.constant = 28;
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)handleSwipeUpFrom:(UISwipeGestureRecognizer *)recognizer {
    [self setOpened:YES];
}

- (void)handleSwipeDownFrom:(UISwipeGestureRecognizer *)recognizer {
    [self setOpened:NO];
}

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
    [self setOpened:!_opened];
}

- (void)eventNewLastUpdate:(NSNotification *)notification {
    [_labLastUpdate setText:[Settings sharedInstance].lastUpdate];
}

- (void)eventCoursesUpdate:(NSNotification *)notification {
    [self updateContent];
}

#pragma mark - SearchBar Delegate protocol

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _hasfocus = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    _hasfocus = NO;
}

#pragma mark - SearchResults Updating protocol

- (void)updateSearchResultsForSearchController:(UISearchController *)aSearchController {
    [self updateContent];
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
    
    [cell.labPaid setHidden:!cur.isPaid];
    
    if (row % 2) {
        [cell setBackgroundColor:[Settings sharedInstance].colorOddCell];
    } else {
        [cell setBackgroundColor:[Settings sharedInstance].colorEvenCell];
    }
    
    return cell;
}

#pragma mark - TableView Delegate protocol

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_hasfocus) {
        [_searchController.searchBar resignFirstResponder];
    } else {
        [Settings sharedInstance].selectedCourse = [_content objectAtIndex:[indexPath row]];
        [AppDelegate event_viewItem:[Settings sharedInstance].selectedCourse.unionName
                               name:[Settings sharedInstance].selectedCourse.unionName
                           category:@"CourseDetails"];
        [self performSegueWithIdentifier:@"showDetails" sender:self];
    }
}

@end
