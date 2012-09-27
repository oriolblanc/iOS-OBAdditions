//
//  UIActionSheet+OBAdditions.m
//
//  Created by Oriol Blanc on 28/09/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIActionSheet+OBAdditions.h"
#import <objc/runtime.h>

@interface UIActionSheet () <UIActionSheetDelegate>

@end

static char UIActionSheetBlockKey;

@implementation UIActionSheet (OBAdditions)

- (id)initWithTitle:(NSString *)title dismissedCallback:(UIActionSheetDismissedCallback)callback cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [self initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    
    if (self)
    {
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *buttonTitle = otherButtonTitles; buttonTitle != nil; buttonTitle = va_arg(args, NSString *))
        {
            [self addButtonWithTitle:buttonTitle];
        }
        
        va_end(args);
        
        if (cancelButtonTitle)
        {
            self.cancelButtonIndex = [self addButtonWithTitle:cancelButtonTitle];
        }
        
        if (callback != NULL)
        {
            objc_setAssociatedObject(self, &UIActionSheetBlockKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
    }
    
    return self;
}

+ (void)showActionSheetInView:(UIView *)view withTitle:(NSString *)title dismissedCallback:(UIActionSheetDismissedCallback)callback cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIActionSheet *actionSheet = [[self alloc] initWithTitle:title dismissedCallback:callback cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    
    if (actionSheet)
    {
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *buttonTitle = otherButtonTitles; buttonTitle != nil; buttonTitle = va_arg(args, NSString *))
        {
            [actionSheet addButtonWithTitle:buttonTitle];
        }
        
        va_end(args);
        
        if (cancelButtonTitle)
        {
            actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:cancelButtonTitle];
        }
        
        if (callback != NULL)
        {
            objc_setAssociatedObject(actionSheet, &UIActionSheetBlockKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        
        [actionSheet showInView:view];
        [actionSheet release];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIActionSheetDismissedCallback callback = (UIActionSheetDismissedCallback)objc_getAssociatedObject(self, &UIActionSheetBlockKey);
    if (callback)
    {
        callback(self, buttonIndex);
    }
}

@end
