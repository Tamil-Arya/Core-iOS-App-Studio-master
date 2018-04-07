//
//  ELR_loaders_.m
//  ELAR
//
//  Created by Bhushan Bawa on 08/01/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "ELR_loaders_.h"

@implementation ELR_loaders_

 UIImageView *img;


+ (UIImageView *)Start_loader:(CGRect)value
{
   img=[[UIImageView alloc]init];
    img.frame=CGRectMake(value.origin.x, value.origin.y, 100, 100);
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"big-roller" withExtension:@"gif"];
    
    img.layer.cornerRadius=100*0.5;
    img.clipsToBounds=YES;
    img.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.5];
    UIImageView  *img_New=[[UIImageView alloc]init];
    img_New.frame=CGRectMake((img.frame.size.width-85)/2, (img.frame.size.height-85)/2, 85, 85);
    img_New.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    [img addSubview:img_New];
    
    
     return img;
    

}

+ (UIImageView *)busImage:(CGRect)value
{
    img=[[UIImageView alloc]init];
    img.frame=CGRectMake(value.origin.x, value.origin.y, 100, 100);
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"animated-big-image" withExtension:@"gif"];
    
    img.layer.cornerRadius=100*0.5;
    img.clipsToBounds=YES;
    img.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.5];
    UIImageView  *img_New=[[UIImageView alloc]init];
    img_New.frame=CGRectMake((img.frame.size.width-85)/2, (img.frame.size.height-85)/2, 85, 85);
    img_New.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    [img addSubview:img_New];
    
    
    return img;
    
    
}

+ (void)stop_loader
{
    [img removeFromSuperview];
    
}


@end
