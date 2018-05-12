//
//  AppDelegate.h
//  ELAR
//
//  Created by Bhushan Bawa on 05/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Users_panel_ViewController.h"
#import "Children_LIST.h"
@import GoogleSignIn;
@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>
{
    Users_panel_ViewController *leftMenuViewController;
    Children_LIST *leftMenuChildren_LIST;
    UINavigationController *nav;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) id delegate;
-(void)LOg_in;
-(void)LOg_Out;
-(void) removeEventsFromCalendar;

@end


