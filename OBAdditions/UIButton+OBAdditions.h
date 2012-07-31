//
//  UIButton+OBAdditions.h
//
//  Created by Oriol Blanc on 02/04/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIButton;
typedef void (^UIButtonCallback)(UIButton *button);

@interface UIButton (OBAdditions)

+ (id)buttonWithType:(UIButtonType)buttonType
         tapCallback:(UIButtonCallback)_callback;
- (id)initWithFrame:(CGRect)frame
        tapCallback:(UIButtonCallback)_callback;

- (void)setTitle:(NSString *)title andSubtitle:(NSString *)subtitle forState:(UIControlState)state;

- (UILabel *)additionalTitleLabel;
- (UILabel *)additionalSubtitleLabel;

#pragma mark - Animations

- (void)animateShine;

@end
