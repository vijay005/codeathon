//
//  NSString+KeyWordFinder.m
//  OcrSdkDemo
//
//  Created by Nitin Chauhan on 09/05/15.
//  Copyright (c) 2015 ABBYY. All rights reserved.
//

#import "NSString+KeyWordFinder.h"

@implementation NSString (KeyWordFinder)


// Check string contain keyword

-(BOOL)isStringcontainKeyword:(NSString *)string{
    
    if ([self rangeOfString:string].location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}




@end
