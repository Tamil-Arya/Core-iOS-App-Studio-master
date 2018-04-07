//
//  UIViewController+MFSideMenuAdditions.h
//  MFSideMenuDemoBasic
//
//  Created by Bhushan Bawa on 04/03/14.
//  Copyright (c) 2014 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MFSideMenuContainerViewController;

// category on UIViewController to provide reference to the menuContainerViewController in any of the contained View Controllers
@interface UIViewController (MFSideMenuAdditions)

@property(nonatomic,readonly,retain) MFSideMenuContainerViewController *menuContainerViewController;

@end

