//
//  Utils.h
//
//  Created by Oriol Blanc Gimeno on 08/09/10.
//  Copyright 2011 Oriol Blanc All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface Utils : NSObject {
}

// Device orientation
+ (int) getDeviceOrientation;
+ (void) setDeviceOrientation:(int)orientation;
+ (BOOL) isDeviceLandscape;
+ (BOOL) isDevicePortrait;
+ (BOOL)isSimulator;

+ (NSString *) dateToString:(NSDate *)date withFormat:(NSDateFormatterStyle)format;
+ (NSString *) dateTimeToString:(NSDate *)date withFormat:(NSDateFormatterStyle)format;

+ (BOOL)stringOnlyContainsDigits:(NSString *)string;
+ (BOOL)stringOnlyContainsLetters:(NSString *)string;

+ (NSString *)replacePointsByCommas:(NSString *)amount;

+ (void)swizzleSelector:(SEL)orig ofClass:(Class)c withSelector:(SEL)newSelector;

+ (BOOL)canSendMail;
+ (UIViewController *)openComposeMailViewController:(NSString *)recipient withSubject:(NSString *)subject withMailDismissDelegate:(id<MFMailComposeViewControllerDelegate>)delegate;

@end

@interface UITabBar(customAction)
@end

@interface UIButton(customAction)
@end
