//
//  UITextField+OBAdditions.h
//
//  Created by Oriol Blanc on 16/09/11.
//  Copyright 2011 Oriol Blanc. All rights reserved.
//

#define kKeyboardPortraitHeight 216
#define kKeyboardLandscapeHeight 162

@interface UITextField (OBAdditions) 

- (BOOL)decimalField:(UITextField *)textField 
               rango:(NSRange)range 
   replacementString:(NSString *)string 
       characterSet1:(NSCharacterSet*)cs1 
       characterSet2:(NSCharacterSet*)cs2 
           maxLength:(NSUInteger)maxL 
         numDecimals:(NSUInteger)numDecimal;

@end

