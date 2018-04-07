//
//  ELR_loaders_.h
//  ELAR
//
//  Created by Bhushan Bawa on 08/01/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+animatedGIF.h"
#import "AppDelegate.h"
@interface ELR_loaders_ : UIImageView
{
    AppDelegate *app;
    
}

+ (UIImageView *)Start_loader:(CGRect)value;
+ (UIImageView *)busImage:(CGRect)value;
+ (void)stop_loader;
@end
