//
//  MFSideMenuShadow.h
//  MFSideMenuDemoSearchBar
//
//  Created by Bhushan Bawa on 04/03/14.
//  Copyright (c) 2014 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MFSideMenuShadow : NSObject

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat opacity;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) UIView *shadowedView;

+ (MFSideMenuShadow *)shadowWithView:(UIView *)shadowedView;
+ (MFSideMenuShadow *)shadowWithColor:(UIColor *)color radius:(CGFloat)radius opacity:(CGFloat)opacity;

- (void)draw;
- (void)shadowedViewWillRotate;
- (void)shadowedViewDidRotate;

@end
