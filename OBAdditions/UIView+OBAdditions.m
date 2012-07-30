//
//  UIView+OBAdditions.m
//
//  Created by Oriol Blanc on 3/14/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIView+OBAdditions.h"

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

@end
