//
//  UISwitch+OBAdditions.h
//
//  Created by Oriol Blanc on 29/11/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UISwitch;
typedef void (^UISwitchCallback)(UISwitch *switcher);

@interface UISwitch (OBAdditions)

- (void)setCallback:(UISwitchCallback)callback;

@end
