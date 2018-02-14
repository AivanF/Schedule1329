//
//  PRButton.m
//  Schedule1329
//
//  Created by Aivan on 14/02/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import "PRButton.h"

@implementation PRButton

- (CGSize)intrinsicContentSize {
    CGRect titleFrameMax = UIEdgeInsetsInsetRect(UIEdgeInsetsInsetRect(UIEdgeInsetsInsetRect(
                                                                                             self.bounds, self.alignmentRectInsets), self.contentEdgeInsets), self.titleEdgeInsets
                                                 );
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(titleFrameMax.size.width, CGFLOAT_MAX)];
    
    CGSize superSize = [super intrinsicContentSize];
    
    CGSize result = CGSizeMake(
                               titleSize.width + (self.bounds.size.width - titleFrameMax.size.width),
                               MAX(superSize.height, titleSize.height + (self.bounds.size.height - titleFrameMax.size.height))
                               );
    
//    NSLog(@"hh: %d %d", (int)titleSize.height, (int)result.height);
    
    return result;
}

@end
