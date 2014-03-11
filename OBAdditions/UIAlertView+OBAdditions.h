//
//  UIAlertView+OBAdditions.h
//
//  Created by Oriol Blanc on 31/07/12.
//  Copyright (c) 2012 Oriol Blanc Gimeno. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIAlertView;

typedef void (^UIAlertViewCallback)(UIAlertView *alertView, NSUInteger buttonIndex);

@interface UIAlertView (OBAdditions)

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  dismissedCallback:(UIAlertViewCallback)callback
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...
NS_REQUIRES_NIL_TERMINATION;

+ (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
             dismissedCallback:(UIAlertViewCallback)callback
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ...
NS_REQUIRES_NIL_TERMINATION;

@end
