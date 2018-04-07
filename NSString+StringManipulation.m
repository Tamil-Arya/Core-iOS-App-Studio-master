//
//  NSString+StringManipulation.m
//  Smart Classroom Manager
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "NSString+StringManipulation.h"

@implementation NSString (StringManipulation)


- (BOOL)containsString:(NSString *)substring
{
    NSRange range = [self rangeOfString : substring];
    BOOL found = ( range.location != NSNotFound );
    return found;
}

@end
