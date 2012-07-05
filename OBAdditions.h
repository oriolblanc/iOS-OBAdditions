//
//  OBAdditions.h
//
//  Created by Oriol Blanc on 03/04/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "Utils.h"
#import "OBTheme.h"

#import "NSData+OBAdditions.h"
#import "NSDate+OBAdditions.h"
#import "NSNumber+OBAdditions.h"
#import "NSString+OBAdditions.h"

#import "UIButton+OBAdditions.h"
#import "UIColor+OBAdditions.h"
#import "UILabel+OBAdditions.h"
#import "UINavigationBar+OBAdditions.h"
#import "UINavigationItem+OBAdditions.h"
#import "UITextField+OBAdditions.h"
#import "UIView+OBAdditions.h"
#import "UIImage+OBAdditions.h"
#import "UIImageView+OBAdditions.h"
#import "UISearchBar+OBAdditions.h"

// Log methods
#define LogMethod()         NSLog(@"%@", NSStringFromSelector(_cmd));
#define LogFrame(f)         NSLog(@"Frame: %@", NSStringFromCGRect(f));
#define LogSize(s)          NSLog(@"Size: %@", NSStringFromCGSize(s));
#define LogMainThread()     NSLog(@"Main thread: %d", [[NSThread currentThread] isMainThread]);
