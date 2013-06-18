//
//  UISearchBar+OBAdditions.m
//
//  Created by Fernando García on 29/06/12.
//  Copyright 2011 Oriol Blanc. All rights reserved.
//

#import "UISearchBar+OBAdditions.h"

@implementation UISearchBar (OBAdditions)

- (UIView *)backgroundView
{
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            return subview;
        }
    }
    
    return nil;
}

- (UITextField *)textField
{
    UITextField *view = nil;
    
    for(UIView *subview in self.subviews)
    {
        if ([subview isKindOfClass:[UITextField class]])
        {
            view = (UITextField *)subview;
        }
    }
        
    return view;
}

@end
