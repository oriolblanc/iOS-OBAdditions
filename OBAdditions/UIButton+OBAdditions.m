//
//  UIButton+OBAdditions.m
//
//  Created by Oriol Blanc on 02/04/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIButton+OBAdditions.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

#define kLabelTitleTag 1516
#define kLabelSubtitleTag 2342

static char UIButtonBlockKey;

@implementation UIButton (OBAdditions)

+ (id)buttonWithType:(UIButtonType)buttonType tapCallback:(UIButtonCallback)_callback
{
    UIButton *button = [self buttonWithType:buttonType];
    objc_setAssociatedObject(button, &UIButtonBlockKey, _callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [button addTarget:button action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
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
        
        [titleLabel release];
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
        [subtitleLabel release];
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

#pragma mark - Animations

- (void)animateShine
{
    CALayer *maskLayer = [CALayer layer];
    
    // Mask image ends with 0.15 opacity on both sides. Set the background color of the layer
    // to the same value so the layer can extend the mask image.
    maskLayer.backgroundColor = [[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.15f] CGColor];
    maskLayer.contents = (id)[[UIImage imageNamed:@"Mask.png"] CGImage];
    
    // Center the mask image on twice the width of the text layer, so it starts to the left
    // of the text layer and moves to its right when we translate it by width.
    maskLayer.contentsGravity = kCAGravityCenter;
    maskLayer.frame = CGRectMake(self.frame.size.width * -1, 0.0f, self.frame.size.width * 2, self.frame.size.height);
    
    // Animate the mask layer's horizontal position
    CABasicAnimation *maskAnim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    maskAnim.byValue = [NSNumber numberWithFloat:self.frame.size.width];
    maskAnim.repeatCount = 1;
    maskAnim.duration = 1.0f;
    [maskLayer addAnimation:maskAnim forKey:@"slideAnim"];
    
    self.layer.mask = maskLayer;
}

@end
