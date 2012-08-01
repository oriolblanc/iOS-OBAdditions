//
//  UIView+OBAdditions.h
//
//  Created by Oriol Blanc on 3/14/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

typedef enum
{
    UIViewFadeTypeIn,
    UIViewFadeTypeOut
}UIViewFadeType;

@interface UIView (OBAdditions)

- (void)removeAllSubviews;

#pragma mark - Fade In / Out animations

- (void)animateFade:(UIViewFadeType)fadeInOrOut
       withDuration:(NSTimeInterval)duration;

- (void)animateFadeInWithDuration:(NSTimeInterval)duration;

- (void)animateFadeOutWithDuration:(NSTimeInterval)duration;

#pragma mark - Shine animations

- (void)animateShineWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount;

@end
