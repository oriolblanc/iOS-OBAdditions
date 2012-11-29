//
//  UISwitch+OBAdditions.m
//
//  Created by Oriol Blanc on 29/11/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UISwitch+OBAdditions.h"
#import <objc/runtime.h>

static char UISwitchBlockKey;

@implementation UISwitch (OBAdditions)

- (void)setCallback:(UISwitchCallback)callback
{
    objc_setAssociatedObject(self, &UISwitchBlockKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(flipSwitch:) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)flipSwitch:(id)sender {
    UISwitchCallback callback = (UISwitchCallback)objc_getAssociatedObject(self, &UISwitchBlockKey);
    if (callback)
    {
        callback(self);
    }
}

@end
