//
//  ImageCustomClass.m
//  Smart Classroom Manager
//
//  Created by Developer on 12/10/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "ImageCustomClass.h"

@implementation ImageCustomClass

+(UIImage *) image : (UIImage *) image resize :(CGSize) size{
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImage;
}

@end
