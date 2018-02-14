//
//  DetailsViewController.m
//  Schedule1329
//
//  Created by Aivan on 19/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import "DetailsViewController.h"
#import "CellDetail.h"
#import "Settings.h"
#import "Course.h"
#import "AppDelegate.h"

@interface DetailsViewController ()
{
    uint _count;
    Course *_selected;
}

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
    
    _selected = [Settings sharedInstance].selectedCourse;
    if (_selected) {
        _count = 9;
        
        if (_selected.isPaid) {
            _count += 3;
        }
    } else {
        _count = 0;
    }
    
    _tblDetails.rowHeight = UITableViewAutomaticDimension;
    _tblDetails.estimatedRowHeight = 64;
    [_tblDetails setNeedsLayout];
    [_tblDetails layoutIfNeeded];
}


- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickCell:(CellDetail*)cell {
    NSString *selectedValue = [cell.btnValue currentTitle];
    
    switch (cell.index) {
        case 6: case 7: case 8:
        case 9: case 10: case 11:
            // nothing
            break;
            
        case 2:{
            // send email
            [AppDelegate event_select:@"click_email" content:selectedValue];
            NSString *message = [NSString stringWithFormat:@"Отправить письмо на этот адрес?\n%@", selectedValue];
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"E-mail"
                                                                           message:message
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Отправить" style:UIAlertActionStyleDefault
                handler:^(UIAlertAction * action) {
                    NSString *url = [selectedValue stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
                    
                    NSString *subject = [_selected.unionName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
                    
                    NSString *body = [NSString stringWithFormat:@"Здравствуйте, %@", _selected.teachersName];
                    body = [body stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
                    
                    url = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", url, subject, body];
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]
                                                       options:[NSDictionary new]
                                             completionHandler:^(BOOL success) {
                                                 NSLog(@"Email sent: %s", success ? "true" : "false");
                                                 if (success) {
                                                     [AppDelegate event_select:@"done_email" content:selectedValue];
                                                 } else {
                                                     [AppDelegate event_select:@"fail_email" content:selectedValue];
                                                 }
                                             }];
                }];
            
            UIAlertAction* no = [UIAlertAction actionWithTitle:@"Нет" style:UIAlertActionStyleCancel
                handler:^(UIAlertAction * action) {
                }];
            
            [alert addAction:no];
            [alert addAction:yes];
            [self presentViewController:alert animated:YES completion:nil];
        }break;
            
        case 3:{
            // open maps
            [AppDelegate event_select:@"click_maps" content:selectedValue];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Карта"
                                                                           message:@"Открыть адрес на карте?"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                handler:^(UIAlertAction * action) {
                    NSString *url = [selectedValue stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
                    
                    url = [NSString stringWithFormat:@"http://maps.google.com/?q=%@", url];
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]
                                                       options:[NSDictionary new]
                                             completionHandler:^(BOOL success) {
                                                 NSLog(@"Maps opened: %s", success ? "true" : "false");
                                                 if (success) {
                                                     [AppDelegate event_select:@"done_maps" content:selectedValue];
                                                 } else {
                                                     [AppDelegate event_select:@"fail_maps" content:selectedValue];
                                                 }
                                             }];
                }];
            
            UIAlertAction* no = [UIAlertAction actionWithTitle:@"Нет" style:UIAlertActionStyleCancel
                handler:^(UIAlertAction * action) {
                }];
            
            [alert addAction:no];
            [alert addAction:yes];
            [self presentViewController:alert animated:YES completion:nil];
        }break;
            
        default:{
            [AppDelegate event_select:@"click_search" content:selectedValue];
            NSString *message = [NSString stringWithFormat:@"Искать \"%@\"?", selectedValue];
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Поиск"
                                                                           message:message
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                handler:^(UIAlertAction * action) {
                    // save value
                    [Settings sharedInstance].searchPhrase = selectedValue;
                    [AppDelegate event_select:@"done_search" content:selectedValue];
                    
                    // and go back:
                    [self.navigationController popViewControllerAnimated:YES];
//                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
            
            UIAlertAction* no = [UIAlertAction actionWithTitle:@"Нет" style:UIAlertActionStyleCancel
                handler:^(UIAlertAction * action) {
                }];
            
            [alert addAction:no];
            [alert addAction:yes];
            [self presentViewController:alert animated:YES completion:nil];
            
        }break;
    }
}

#pragma mark - TableView Data Source protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)setupCell:(CellDetail *)cell at:(NSInteger)row {
    if (row >= _count) {
        NSLog(@"Courses count error!");
    }
    
    switch (row) {
        case 0:
            cell.labTitle.text = @"Название";
            [cell.btnValue setTitle:_selected.unionName forState:UIControlStateNormal];
            break;
        case 1:
            cell.labTitle.text = @"ФИО педагога";
            [cell.btnValue setTitle:_selected.teachersName forState:UIControlStateNormal];
            break;
        case 2:
            cell.labTitle.text = @"Обратная связь";
            [cell.btnValue setTitle:_selected.contacts forState:UIControlStateNormal];
            break;
        case 3:
            cell.labTitle.text = @"Место проведения занятий";
            [cell.btnValue setTitle:_selected.place forState:UIControlStateNormal];
            break;
        case 4:
            cell.labTitle.text = @"Форма проведения занятий";
            [cell.btnValue setTitle:_selected.classesForm forState:UIControlStateNormal];
            break;
        case 5:
            cell.labTitle.text = @"Вид деятельности (направленность)";
            [cell.btnValue setTitle:_selected.activityKind forState:UIControlStateNormal];
            break;
        case 6:
            cell.labTitle.text = @"Часов в неделю";
            [cell.btnValue setTitle:_selected.hoursPerWeek forState:UIControlStateNormal];
            break;
        case 7:
            cell.labTitle.text = @"Возраст обучающихся";
            [cell.btnValue setTitle:_selected.ages forState:UIControlStateNormal];
            break;
        case 8:
            cell.labTitle.text = @"Классы";
            [cell.btnValue setTitle:_selected.grades forState:UIControlStateNormal];
            break;
            
        case 9:
            cell.labTitle.text = @"Начало занятий/окончание учебного периода";
            [cell.btnValue setTitle:_selected.dates forState:UIControlStateNormal];
            break;
        case 10:
            cell.labTitle.text = @"Стоимость обучения в месяц (руб)";
            [cell.btnValue setTitle:_selected.costMonth forState:UIControlStateNormal];
            break;
        case 11:
            cell.labTitle.text = @"Стоимость за годовой учебный период";
            [cell.btnValue setTitle:_selected.costYear forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellDetail *cell = [tableView dequeueReusableCellWithIdentifier:@"CellDetail"];
    if (cell == nil) {
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"CellDetail" bundle:nil];
        cell = (CellDetail *)temporaryController.view;
    }
    NSInteger row = [indexPath row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.btnValue.titleLabel.numberOfLines = 0;
    
    [self setupCell:cell at:row];
    cell.index = (int)row;
    cell.ctrl = self;
    
//    [cell sizeToFit];
//    [cell.btnValue.titleLabel sizeToFit];
//    [cell.btnValue sizeToFit];
    
//    NSLog(@"H: %d %d",
//          (int)cell.btnValue.bounds.size.height,
//          (int)cell.btnValue.titleLabel.bounds.size.height);
    
    return cell;
}

#pragma mark - TableView Delegate protocol

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
//    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end
