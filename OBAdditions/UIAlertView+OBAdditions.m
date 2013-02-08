//
//  UIAlertView+OBAdditions.m
//
//  Created by Oriol Blanc on 31/07/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIAlertView+OBAdditions.h"
#import <objc/runtime.h>

static char UIAlertViewBlockKey;

@implementation UIAlertView (OBAdditions)

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  dismissedCallback:(UIAlertViewCallback)callback
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    if (self)
    {
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *buttonTitle = otherButtonTitles; buttonTitle != nil; buttonTitle = va_arg(args, NSString *))
        {
            [self addButtonWithTitle:buttonTitle];
        }
        va_end(args);
        
        if (callback != NULL)
        {
            objc_setAssociatedObject(self, &UIAlertViewBlockKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
    }
    
    return self;
}

+ (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
             dismissedCallback:(UIAlertViewCallback)callback
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ...
{
	UIAlertView *alertView = [[self alloc] initWithTitle:title message:message dismissedCallback:callback cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    if (alertView)
    {
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *buttonTitle = otherButtonTitles; buttonTitle != nil; buttonTitle = va_arg(args, NSString *))
        {
            [alertView addButtonWithTitle:buttonTitle];
        }
        va_end(args);
    }
    
    [alertView show];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIAlertViewCallback callback = (UIAlertViewCallback)objc_getAssociatedObject(self, &UIAlertViewBlockKey);
    
    if (callback != NULL)
    {
        callback(self, buttonIndex);
    }
}


@end
