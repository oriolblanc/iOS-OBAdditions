//
//  UINavigationBar+OBAdditions.m
//
//  Created by Oriol Blanc on 28/09/11.
//  Copyright 2011 Oriol Blanc. All rights reserved.
//

#import "UINavigationBar+OBAdditions.h"
 
#define kNavBarImageTag 6183746
#define kNavBarProgressTag 123321

#define kProgressBarTintColor self.tintColor

@implementation UINavigationBar (OBAdditions)

- (void)customizeBackgroundImage:(UIImage *)image tintColor:(UIColor *)tintColor
{    
    static BOOL methodsSwizzled = NO;
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        if (!methodsSwizzled)   
        {
            [Utils swizzleSelector:@selector(insertSubview:atIndex:)
                           ofClass:[self class]
                      withSelector:@selector(additionalInsertSubview:atIndex:)];
            [Utils swizzleSelector:@selector(sendSubviewToBack:)
                           ofClass:[self class]
                      withSelector:@selector(additionalSendSubviewToBack:)];
            
            methodsSwizzled = YES;
        }
        
        UIImageView *imageView = (UIImageView *)[self viewWithTag:kNavBarImageTag];
        if (imageView == nil)
        {
            imageView = [[UIImageView alloc] initWithImage:
                         image];
            [imageView setTag:kNavBarImageTag];
            [self insertSubview:imageView atIndex:0];
        }
    }
    
    self.tintColor = tintColor;
}

- (void)setTitleTextAttributes
{
    if ([self respondsToSelector:@selector(setTitleTextAttributes:)]) // Only iOS5+
    {
        UIColor *titleViewTextColor = [UIColor whiteColor];
        UIColor *titleViewShadowColor = [UIColor colorWithWhite:0.1 alpha:0.6];
        CGSize titleViewShadowOffset = CGSizeMake(0, -1);
        
        NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:titleViewTextColor, UITextAttributeTextColor, titleViewShadowColor, UITextAttributeTextShadowColor, [NSValue valueWithCGSize:titleViewShadowOffset], UITextAttributeTextShadowOffset, nil];
        [self setTitleTextAttributes:textAttributes];
    }
}

- (void)additionalInsertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [self additionalInsertSubview:view atIndex:index];
    
    UIView *backgroundImageView = [self viewWithTag:kNavBarImageTag];
    if (backgroundImageView != nil)
    {
        [self additionalSendSubviewToBack:backgroundImageView];
    }
}

- (void)additionalSendSubviewToBack:(UIView *)view
{
    [self additionalSendSubviewToBack:view];
    
    UIView *backgroundImageView = [self viewWithTag:kNavBarImageTag];
    if (backgroundImageView != nil)
    {
        [self additionalSendSubviewToBack:backgroundImageView];
    }
}

- (void)setProgressBarPercentage:(float)percentage
{
    UIProgressView *progressView = (UIProgressView *)[self viewWithTag:kNavBarProgressTag];   
    
    if (progressView == nil)
    {
        progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        
        if ([progressView respondsToSelector:@selector(setProgressTintColor:)]) // Only iOS5+
        {
            [progressView setProgressTintColor:kProgressBarTintColor];
        }
        
        CGRect frame = CGRectMake(110, 18, 100, 21);
        [progressView setFrame:frame];
        [progressView setTag:kNavBarProgressTag];
        [self addSubview:progressView];
    }
    
    [progressView setProgress:percentage];
}

- (void)hideProgressBar
{
    UIProgressView *progressView = (UIProgressView *)[self viewWithTag:kNavBarProgressTag];   
    [progressView removeFromSuperview];
}

@end