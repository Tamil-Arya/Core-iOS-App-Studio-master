//
//  Email_validation.m
//  TagNBrag.temp_caseinsensitive_rename
//
//  Created by Bhushan Bawa on 24/03/14.
//  Copyright (c) 2014 pnf. All rights reserved.
//

#import "Email_validation.h"

@implementation Email_validation


#pragma mark - -*********************
#pragma mark Email Id Validatsion  Check Method
#pragma mark - -*********************

+ (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}


@end
