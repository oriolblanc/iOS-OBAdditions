//
//  Utils.m
//
//  Created by Oriol Blanc Gimeno on 08/09/10.
//  Copyright 2011 Oriol Blanc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@implementation Utils

#pragma mark -
#pragma mark Device orientation

// Device orientation
static int deviceOrientation = UIDeviceOrientationPortrait;

+ (int) getDeviceOrientation {
	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	if ((orientation) &&
		( //filter the orientation we want.
		 // one of the reason to exist of this filter : 
		 // the condition (UIDeviceOrientationIsPortrait([Utils getDeviceOrientation])||
	     //               (UIDeviceOrientationIsLandscape([Utils getDeviceOrientation])
		 // is NOT true on start up of the application.
		 // an other reason : we do't care/want the faceup/down/unknow orientation.
		 
		 (orientation == UIDeviceOrientationPortrait) ||
		 (orientation == UIDeviceOrientationPortraitUpsideDown) ||
		 (orientation == UIDeviceOrientationLandscapeLeft) ||
		 (orientation == UIDeviceOrientationLandscapeRight)
		 )
		) {
		deviceOrientation = orientation;
	}
	return deviceOrientation;
}

+ (void) setDeviceOrientation:(int)orientation {
	deviceOrientation = orientation;
}

+ (BOOL) isDeviceLandscape {
    
    return UIDeviceOrientationIsLandscape([Utils getDeviceOrientation]);
}

+ (BOOL) isDevicePortrait {
    
    return UIDeviceOrientationIsPortrait([Utils getDeviceOrientation]);    
}

+ (BOOL)isSimulator {
    
    return TARGET_IPHONE_SIMULATOR;
}

#pragma mark -

+ (NSString *) dateToString:(NSDate *)date withFormat:(NSDateFormatterStyle)format {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:format];
	[dateFormatter setLocale:[NSLocale currentLocale]];
	NSString *result = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:date]];
	[dateFormatter release];
	return result;
}

+ (NSString *) dateTimeToString:(NSDate *)date withFormat:(NSDateFormatterStyle)format {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:format];
	[dateFormatter setTimeStyle:format];
	[dateFormatter setLocale:[NSLocale currentLocale]];
	NSString *result = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:date]];
	[dateFormatter release];
	return result;
}

+ (BOOL)stringOnlyContainsDigits:(NSString *)string {
    NSCharacterSet *numbers = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:string];
    return [numbers isSupersetOfSet:stringSet];
}

+ (BOOL)stringOnlyContainsLetters:(NSString *)string {
    NSCharacterSet *letters = [NSCharacterSet letterCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:string];
    return [letters isSupersetOfSet:stringSet];
}

+ (NSString *)replacePointsByCommas:(NSString *)amount{
    
    NSNumberFormatter *inputFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    NSMutableString *input = [NSMutableString stringWithFormat:@"%@",amount];
    [input replaceOccurrencesOfString:@"." withString:@"," options:0 range:NSMakeRange(0, [amount length])];
    [inputFormatter setDecimalSeparator:@","];
    [inputFormatter setMaximumFractionDigits:2];
    [inputFormatter setMinimumFractionDigits:2];
    
    NSNumber *amountNumber = [inputFormatter numberFromString:input];
    return [inputFormatter stringFromNumber:amountNumber];
}

+ (void)swizzleSelector:(SEL)orig ofClass:(Class)c withSelector:(SEL)newSelector;
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, newSelector);
    
    if (class_addMethod(c, orig, method_getImplementation(newMethod),
                        method_getTypeEncoding(newMethod)))
    {
        class_replaceMethod(c, newSelector, method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    }
    else
    {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

+ (BOOL)canSendMail
{
    return [MFMailComposeViewController canSendMail];
}

+ (UIViewController *)openComposeMailViewController:(NSString *)recipient withSubject:(NSString *)subject withMailDismissDelegate:(id<MFMailComposeViewControllerDelegate> *)delegate
{
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    mailViewController.mailComposeDelegate = (id<MFMailComposeViewControllerDelegate>)delegate;
    
    NSArray *recipients = [NSArray arrayWithObjects:recipient, nil];
    
    [mailViewController setToRecipients:recipients];
    [mailViewController setSubject:subject];
    
    return [mailViewController autorelease];
}

@end

@implementation UITabBar(customAction)

/* Not being used */
/*
- (id <CAAction>)customActionForLayer:(CALayer *)layer forKey:(NSString *)key {
    if ([key isEqualToString:@"position"]) {
        CATransition *pushFromRight = [[CATransition alloc] init];
        pushFromRight.duration = 0.25; 
        pushFromRight.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]; 
        pushFromRight.type = kCATransitionPush; 
        pushFromRight.subtype = kCATransitionFromRight;
        return [pushFromRight autorelease];
    } 
    return [self defaultActionForLayer:layer forKey:key];
} */
@end

@implementation UIButton (customAction)

- (void)setImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
}

@end


