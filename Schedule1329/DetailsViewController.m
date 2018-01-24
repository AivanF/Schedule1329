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

@interface DetailsViewController ()
{
    uint _count;
    Course *_selected;
}

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selected = [Settings sharedInstance].selectedCourse;
    if (_selected) {
        _count = 9;
        
        if (_selected.isPaid) {
            _count += 3;
        }
    } else {
        _count = 0;
    }
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
            
            // TODO: test it on a real device!
            
            NSString *message = [NSString stringWithFormat:@"Отправить письмо на этот адрес?\n%@", selectedValue];
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"E-mail"
                                                                           message:message
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Отправить" style:UIAlertActionStyleDefault
                handler:^(UIAlertAction * action) {
                    // ?subject=title&body=content
                    NSString *url = [selectedValue stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
                    url = [NSString stringWithFormat:@"mailto:%@", url];;
                    
                    NSLog(@"Trying to open: %@", url);
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]
                                                       options:[NSDictionary new]
                                             completionHandler:^(BOOL success) {
                                                 NSLog(@"Email sent: %s", success ? "true" : "false");
                                             }];
                }];
            
            UIAlertAction* no = [UIAlertAction actionWithTitle:@"Нет" style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * action) {}];
            
            [alert addAction:no];
            [alert addAction:yes];
            [self presentViewController:alert animated:YES completion:nil];
        }break;
            
        case 3:{
            // open maps
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Карта"
                                                                           message:@"Открыть адрес на карте?"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                handler:^(UIAlertAction * action) {
                    NSString *url = [selectedValue stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
                    url = [NSString stringWithFormat:@"http://maps.google.com/?q=%@", url];;
                    
                    NSLog(@"Trying to open: %@", url);
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]
                                                       options:[NSDictionary new]
                                             completionHandler:^(BOOL success) {
                                                 NSLog(@"Maps opened: %s", success ? "true" : "false");
                                             }];
                }];
            
            UIAlertAction* no = [UIAlertAction actionWithTitle:@"Нет" style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * action) {}];
            
            [alert addAction:no];
            [alert addAction:yes];
            [self presentViewController:alert animated:YES completion:nil];
        }break;
            
        default:{
            NSString *message = [NSString stringWithFormat:@"Искать \"%@\"?", selectedValue];
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Поиск"
                                                                           message:message
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                handler:^(UIAlertAction * action) {
                    // save value
                    [Settings sharedInstance].searchPhrase = selectedValue;
                    
                    // and go back:
                    [self.navigationController popViewControllerAnimated:YES];
//                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
            
            UIAlertAction* no = [UIAlertAction actionWithTitle:@"Нет" style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * action) {}];
            
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellDetail *cell = [tableView dequeueReusableCellWithIdentifier:@"CellDetail"];
    if (cell == nil) {
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"CellDetail" bundle:nil];
        cell = (CellDetail *)temporaryController.view;
    }
    NSInteger row = [indexPath row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    
    cell.index = (int)row;
    cell.ctrl = self;
    
    // TODO: multiline descriptions?
    
    return cell;
}

#pragma mark - TableView Delegate protocol

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end
