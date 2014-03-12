//
//  UIView+OBAdditions.m
//
//  Created by Oriol Blanc on 3/14/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIView+OBAdditions.h"

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static char UIViewMaskAnimationKey;

@implementation UIView (OBAdditions)

- (void)removeAllSubviews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

- (UIView *)searchBarBackgroundView
{
    UIView *view = nil;
    
    for (UIView *subview in self.subviews)
    {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            view = subview;
            break;
        }
        else
        {
            view = [subview searchBarBackgroundView];
        }
    }
    
    return view;
}

- (UITextField *)textField
{
    UITextField *view = nil;
    
    for(UIView *subview in self.subviews)
    {
        if ([subview isKindOfClass:[UITextField class]])
        {
            view = (UITextField *)subview;
            break;
        }
        else
        {
            view = [subview textField];
        }
    }
    
    return view;
}

/**
 Get the current first responder without using a private API
 
 http://stackoverflow.com/questions/1823317/get-the-current-first-responder-without-using-a-private-api
 */
- (UIView *)findFirstResponder
{
    if (self.isFirstResponder)
        return self;
    
    for (UIView *subView in self.subviews)
    {
        UIView *firstResponder = [subView findFirstResponder];
        
        if (firstResponder != nil)
        {
            return firstResponder;
        }
    }
    
    return nil;
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
    
    objc_setAssociatedObject(self, &UIViewMaskAnimationKey, whiteView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    CALayer *maskLayer = [CALayer layer];
    
    // Mask image ends with 0.15 opacity on both sides. Set the background color of the layer
    // to the same value so the layer can extend the mask image.
    maskLayer.backgroundColor = [[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.0f] CGColor];
    maskLayer.contents = (id)[[UIImage imageNamed:@"shineWhiteMask.png"] CGImage];
    
    // Center the mask image on twice the width of the text layer, so it starts to the left
    // of the text layer and moves to its right when we translate it by width.
    maskLayer.contentsGravity = kCAGravityCenter;
    maskLayer.frame = CGRectMake(-whiteView.frame.size.width,
                                 0.0f,
                                 whiteView.frame.size.width * 2,
                                 whiteView.frame.size.height);
    
    // Animate the mask layer's horizontal position
    CABasicAnimation *maskAnim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    maskAnim.byValue = [NSNumber numberWithFloat:self.frame.size.width *9];
    maskAnim.repeatCount = repeatCount;
    maskAnim.duration = duration;
    maskAnim.delegate = self;
    maskAnim.removedOnCompletion = YES;
    
    [maskLayer addAnimation:maskAnim forKey:@"shineAnim"];
    
    whiteView.layer.mask = maskLayer;
}

#pragma mark - UIKit Dynamics & effects

- (void)addParallaxEffectWithMaxOffset:(CGFloat)maxOffset
{
    UIInterpolatingMotionEffect *parallaxEffectX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                   type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    UIInterpolatingMotionEffect *parallaxEffectY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                   type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    
    parallaxEffectX.minimumRelativeValue = @(-maxOffset);
    parallaxEffectX.maximumRelativeValue = @(maxOffset);
    
    parallaxEffectY.minimumRelativeValue = parallaxEffectX.minimumRelativeValue;
    parallaxEffectY.maximumRelativeValue = parallaxEffectX.maximumRelativeValue;
    
    UIMotionEffectGroup *effectGroup = [[UIMotionEffectGroup alloc] init];
    effectGroup.motionEffects = @[parallaxEffectX, parallaxEffectY];
    
    [self addMotionEffect:effectGroup];
}

#pragma mark - Get Parent Collection View

- (UICollectionView *)superCollectionView
{
	UIView *superview = self.superview;
    
	while (superview != nil)
    {
		if ([superview isKindOfClass:[UICollectionView class]])
        {
			return (id)superview;
		}
        
		superview = [superview superview];
	}
    
	return nil;
}

#pragma mark - Animations Callback

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    UIView *whiteMask = (UIView *)objc_getAssociatedObject(self, &UIViewMaskAnimationKey);
    [whiteMask removeFromSuperview];
//    [theAnimation remo]
}

@end
