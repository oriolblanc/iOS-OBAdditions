//
//  UIButton+OBAdditions.m
//
//  Created by Oriol Blanc on 02/04/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIButton+OBAdditions.h"
#import <objc/runtime.h>

#define kLabelTitleTag 1516
#define kLabelSubtitleTag 2342

static char UIButtonBlockKey;

@implementation UIButton (OBAdditions)

+ (id)buttonWithType:(UIButtonType)buttonType
    forControlEvents:(UIControlEvents)controlEvents
         tapCallback:(UIButtonCallback)_callback
{
    UIButton *button = [self buttonWithType:buttonType];
    objc_setAssociatedObject(button, &UIButtonBlockKey, _callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [button addTarget:button action:@selector(buttonTapped) forControlEvents:controlEvents];
    
    return button;
}

+ (id)buttonWithType:(UIButtonType)buttonType tapCallback:(UIButtonCallback)callback
{
    return [self buttonWithType:buttonType forControlEvents:UIControlEventTouchUpInside tapCallback:callback];
}

- (id)initWithFrame:(CGRect)frame tapCallback:(UIButtonCallback)_callback
{
    if ((self = [self initWithFrame:frame]))
    {
        objc_setAssociatedObject(self, &UIButtonBlockKey, _callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)buttonTapped
{
    UIButtonCallback callback = (UIButtonCallback)objc_getAssociatedObject(self, &UIButtonBlockKey);
    if (callback)
    {
        callback(self);
    }
}

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
        
        [self addSubview:titleLabel];
    }
    [titleLabel setText:title];
    
    if (subtitleLabel == nil)
    {
        UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.size.height - 2, titleLabel.frame.size.width, titleLabel.frame.size.height - 5)];
        subtitleLabel.tag = kLabelSubtitleTag;
        subtitleLabel.backgroundColor = [UIColor clearColor];
        subtitleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        subtitleLabel.textAlignment = UITextAlignmentCenter;
        
        [self addSubview:subtitleLabel];
    }
    [subtitleLabel setText:subtitle];
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
