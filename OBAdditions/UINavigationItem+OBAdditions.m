//
//  UINavigationItem+OBAdditions.m
//
//  Created by Oriol Blanc on 04/10/11.
//  Copyright 2011 Oriol Blanc. All rights reserved.
//

#import "UINavigationItem+OBAdditions.h"

#define kNavBarWithTitleAndSubtitle 48
#define kLabelTitle 1516
#define kLabelSubtitle 2342

@implementation UINavigationItem (OBAdditions)

- (void)setButtonForTitleView:(UIButton *)button
{
    if(button == NULL){ //might be called with NULL argument
        return;
    }
    
    self.titleView = button;
}

- (void)setImageForTitleView:(UIImage*)image
{
    if(image == NULL){ //might be called with NULL argument
        return;
    }
    
    UIImageView *aTitleView = [[UIImageView alloc] initWithImage:image];
    self.titleView = aTitleView;
    [self.titleView setFrame: CGRectMake(0, 0, aTitleView.frame.size.width, aTitleView.frame.size.height)];
    [aTitleView release];
}

- (void)setTitle:(NSString*)title andSubtitle:(NSString*)subtitle
{
    UIView* headerTitleSubtitleView = [self.titleView viewWithTag:kNavBarWithTitleAndSubtitle];
        
    if (headerTitleSubtitleView == nil)
    {
        headerTitleSubtitleView = [self initHeaderTitleAndSubtitleView];
    }

    UILabel *titleView = (UILabel *) [headerTitleSubtitleView viewWithTag:kLabelTitle];
    titleView.text = title;
    UILabel *subtitleView = (UILabel *) [headerTitleSubtitleView viewWithTag:kLabelSubtitle];
    subtitleView.text = subtitle;
    
    self.titleView = headerTitleSubtitleView;
}

- (UIView*)initHeaderTitleAndSubtitleView
{
    CGRect headerTitleSubtitleFrame = CGRectMake(0, 0, 200, 44);    
    UIView* _headerTitleSubtitleView = [[[UILabel alloc] initWithFrame:headerTitleSubtitleFrame] autorelease];
    [_headerTitleSubtitleView setTag:kNavBarWithTitleAndSubtitle];
    _headerTitleSubtitleView.backgroundColor = [UIColor clearColor];
    _headerTitleSubtitleView.autoresizesSubviews = YES;
    
    CGRect titleFrame = CGRectMake(0, 0, 200, 30);  
        
    UILabel *titleView = [[[UILabel alloc] initWithFrame:titleFrame] autorelease];
    [titleView setTag:kLabelTitle];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:15];
    titleView.textAlignment = UITextAlignmentCenter;
    titleView.textColor = [UIColor whiteColor];
    titleView.shadowColor = [Theme colorForKey:kColorKeySubtitleShadowColor];
    titleView.shadowOffset = CGSizeMake(0, -1);
    titleView.text = @"";
    titleView.adjustsFontSizeToFitWidth = YES;
    [_headerTitleSubtitleView addSubview:titleView];
    
    CGRect subtitleFrame = CGRectMake(0, 19, 200, 22);   
    UILabel *subtitleView = [[[UILabel alloc] initWithFrame:subtitleFrame] autorelease];
    [subtitleView setTag:kLabelSubtitle];
    subtitleView.backgroundColor = [UIColor clearColor];
    subtitleView.font = [UIFont boldSystemFontOfSize:10];
    subtitleView.textAlignment = UITextAlignmentCenter;
    subtitleView.textColor = [UIColor colorWithWholeRed:217 wholeGreen:198 wholeBlue:234 alpha:1];
    subtitleView.shadowColor = [Theme colorForKey:kColorKeySubtitleShadowColor];
    subtitleView.shadowOffset = CGSizeMake(0, -1);
    subtitleView.text = @"";
    subtitleView.adjustsFontSizeToFitWidth = YES;
    [_headerTitleSubtitleView addSubview:subtitleView];
    
    _headerTitleSubtitleView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                                 UIViewAutoresizingFlexibleRightMargin |
                                                 UIViewAutoresizingFlexibleTopMargin |
                                                 UIViewAutoresizingFlexibleBottomMargin);

    return _headerTitleSubtitleView;
}

@end
