//
//  UIButton+OBAdditions.m
//
//  Created by Oriol Blanc on 02/04/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIButton+OBAdditions.h"

@implementation UIButton (OBAdditions)

- (void)setTitle:(NSString *)title andSubtitle:(NSString *)subtitle forState:(UIControlState)state
{
    UILabel *label = self.titleLabel;
    [label removeFromSuperview];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:10.0];
    titleLabel.textAlignment = UITextAlignmentCenter;
    [titleLabel setText:title];
    
    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.size.height, titleLabel.frame.size.width, titleLabel.frame.size.height - 5)];
    subtitleLabel.backgroundColor = [UIColor clearColor];
    subtitleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    subtitleLabel.textAlignment = UITextAlignmentCenter;
    [subtitleLabel setText:subtitle];    

    LogFrame(self.frame);
    LogFrame(titleLabel.frame);
    LogFrame(subtitleLabel.frame);
    [self addSubview:titleLabel];
    [self addSubview:subtitleLabel];
}

@end
