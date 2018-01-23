//
//  CellDetail.m
//  Schedule1329
//
//  Created by Aivan on 20/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import "CellDetail.h"
#import "DetailsViewController.h"

@implementation CellDetail

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickItem:(id)sender {
    [self.ctrl clickCell:self];
}

@end
