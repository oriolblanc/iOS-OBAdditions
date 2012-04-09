//
//  UIButton+OBAdditions.m
//
//  Created by Oriol Blanc on 02/04/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIButton+OBAdditions.h"

#define kLabelTitleTag 1516
#define kLabelSubtitleTag 2342

@implementation UIButton (OBAdditions)

- (void)setTitle:(NSString *)title andSubtitle:(NSString *)subtitle forState:(UIControlState)state
{
    UILabel *label = self.titleLabel;
    [label removeFromSuperview];
    
    UILabel *titleLabel = (UILabel *)[self viewWithTag:kLabelTitleTag];   
    
    UILabel *subtitleLabel = (UILabel *)[self viewWithTag:kLabelSubtitleTag];   
    
    if (titleLabel == nil)
    {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, self.frame.size.width, self.frame.size.height / 2)];
        titleLabel.tag = kLabelTitleTag;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:10.0];
        titleLabel.textAlignment = UITextAlignmentCenter;
        [titleLabel setText:title];
        
        [self addSubview:titleLabel];
        
        [titleLabel release];
    }
    
    if (subtitleLabel == nil)
    {
        UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.size.height - 2, titleLabel.frame.size.width, titleLabel.frame.size.height - 5)];
        subtitleLabel.tag = kLabelSubtitleTag;
        subtitleLabel.backgroundColor = [UIColor clearColor];
        subtitleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        subtitleLabel.textAlignment = UITextAlignmentCenter;
        [subtitleLabel setText:subtitle];    
        
        [self addSubview:subtitleLabel];
        [subtitleLabel release];
    }
}

- (UILabel *)additionalTitleLabel
{
    return (UILabel *)[self viewWithTag:kLabelTitleTag];
}

- (UILabel *)additionalSubtitleLabel
{
    return (UILabel *)[self viewWithTag:kLabelSubtitleTag];
}

@end
