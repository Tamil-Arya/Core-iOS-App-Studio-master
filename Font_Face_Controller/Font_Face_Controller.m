//
//  Font_Face_Controller.m
//  ELAR
//
//  Created by Bhushan Bawa on 04/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Font_Face_Controller.h"

@implementation Font_Face_Controller

+ (UIFont *)opensansLight:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"OpenSans-Light" size:fontSize];
}
+ (UIFont *)opensansregular:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"OpenSans" size:fontSize];
}
+ (UIFont *)opensanssemibold:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"OpenSans-Semibold" size:fontSize];
}


@end
