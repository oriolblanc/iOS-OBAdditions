//
//  UITextField+OBAdditions.m
//
//  Created by Oriol Blanc on 16/09/11.
//  Copyright 2011 Oriol Blanc. All rights reserved.
//

#import "UITextField+OBAdditions.h"

@implementation UITextField (Utils)

//Call in UITextField delegate function shouldChangeCharactersInRange
- (BOOL)decimalField:(UITextField *)textField 
               rango:(NSRange)range 
   replacementString:(NSString *)string 
       characterSet1:(NSCharacterSet*)cs1 
       characterSet2:(NSCharacterSet*)cs2 
           maxLength:(NSUInteger)maxL 
         numDecimals:(NSUInteger)numDecimal
{
    if ([string isEqualToString:@""]) return YES;
    
    NSCharacterSet *myCharSet;
    NSString * texto = [textField text];
    
    //if we have insert a point or coma, quit from the charset
    if (([texto rangeOfString:@"."].location != NSNotFound)||([texto rangeOfString:@","].location != NSNotFound)) myCharSet = cs1;
    else myCharSet = cs2;
    
    for (int i = 0; i < [string length]; i++) {
        //we only can put a comma or point for less than 2 decimals
        if([string isEqualToString:@"."] || [string isEqualToString:@","]){
            if(texto.length == 1) return YES;
            if(range.location < (texto.length-numDecimal)) return NO;
        }
        unichar c = [string characterAtIndex:i];
        if (![myCharSet characterIsMember:c]) return NO;
        else{
            if (([texto rangeOfString:@"."].location != NSNotFound)||([texto rangeOfString:@","].location != NSNotFound)) {
                //if we have insert a point or comma
                NSArray *sep = ([texto rangeOfString:@"."].location != NSNotFound)?[texto componentsSeparatedByString:@"."]:[texto componentsSeparatedByString:@","];
                //decimal part has less than two characters
                if ([[sep objectAtIndex:([sep count]-1)]length] < numDecimal) {return ([texto length] <= maxL);}
                else{                    
                    if(range.location < (texto.length-numDecimal)) return ([texto length] <= maxL);
                    //decimal part has more than two characters
                    else return NO;
                }
            }
        }
    }
    return ([texto length] <= maxL);  
}


@end
