//
//  UIWebView+OBAdditions.h
//
//  Created by Oriol Blanc Gimeno on 24/07/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIWebView+OBAdditions.h"

@implementation UIWebView (OBAdditions)

- (void)loadDocument:(NSString*)documentName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];
}

- (void)setBounces:(BOOL)bounces
{
    for (id subview in self.subviews)
    {
        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
        {
            ((UIScrollView *)subview).bounces = bounces;
        }
    }
}

@end
