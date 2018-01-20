//
//  CellDetail.h
//  Schedule1329
//
//  Created by Aivan on 20/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellDetail : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnValue;

- (IBAction)clickItem:(id)sender;

@end
