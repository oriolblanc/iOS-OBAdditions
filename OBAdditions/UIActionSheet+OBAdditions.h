//
//  UIActionSheet+OBAdditions.h
//
//  Created by Oriol Blanc on 28/09/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIActionSheet;
typedef void (^UIActionSheetDismissedCallback)(UIActionSheet *actionSheet, NSUInteger buttonIndex);

@interface UIActionSheet (OBAdditions)

- (id)initWithTitle:(NSString *)title
  dismissedCallback:(UIActionSheetDismissedCallback)callback
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...
NS_REQUIRES_NIL_TERMINATION;

+ (void)showActionSheetInView:(UIView *)view
                    withTitle:(NSString *)title
            dismissedCallback:(UIActionSheetDismissedCallback)callback
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...
NS_REQUIRES_NIL_TERMINATION;

@end
