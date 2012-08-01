//
//  UIView+OBAdditions.m
//
//  Created by Oriol Blanc on 3/14/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIView+OBAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (OBAdditions)

- (void)removeAllSubviews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

#pragma mark - Animate Fade In / Fade Out

- (void)animateFade:(UIViewFadeType)fadeInOrOut
       withDuration:(NSTimeInterval)duration
{
    self.alpha = fadeInOrOut == UIViewFadeTypeIn ? 0.0 : 1.0;
    [UIView animateWithDuration:duration animations:^{
        self.alpha = fadeInOrOut == UIViewFadeTypeIn ? 1.0 : 0.0;
    }];
}

- (void)animateFadeInWithDuration:(NSTimeInterval)duration
{
    [self animateFade:UIViewFadeTypeIn withDuration:duration];
}

- (void)animateFadeOutWithDuration:(NSTimeInterval)duration
{
    [self animateFade:UIViewFadeTypeOut withDuration:duration];
}

#pragma mark - Shine Animations

- (void)animateShineWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount
{
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [whiteView setBackgroundColor:[UIColor whiteColor]];
    [whiteView setUserInteractionEnabled:NO];
    [self addSubview:whiteView];
    
    CALayer *maskLayer = [CALayer layer];
    
    // Mask image ends with 0.15 opacity on both sides. Set the background color of the layer
    // to the same value so the layer can extend the mask image.
    maskLayer.backgroundColor = [[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.0f] CGColor];
    maskLayer.contents = (id)[[UIImage imageNamed:@"ShineMask.png"] CGImage];
    
    // Center the mask image on twice the width of the text layer, so it starts to the left
    // of the text layer and moves to its right when we translate it by width.
    maskLayer.contentsGravity = kCAGravityCenter;
    maskLayer.frame = CGRectMake(-whiteView.frame.size.width,
                                 0.0f,
                                 whiteView.frame.size.width * 2,
                                 whiteView.frame.size.height);
    
    // Animate the mask layer's horizontal position
    CABasicAnimation *maskAnim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    maskAnim.byValue = [NSNumber numberWithFloat:self.frame.size.width * 9];
    maskAnim.repeatCount = HUGE_VALF;
    maskAnim.duration = 3.0f;
    [maskLayer addAnimation:maskAnim forKey:@"shineAnim"];
    
    whiteView.layer.mask = maskLayer;
}

@end
