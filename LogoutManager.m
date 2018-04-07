//
//  LogoutManager.m
//  Smart Classroom Manager
//
//  Created by Tamil Selvan R on 03/04/18.
//  Copyright © 2018 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "LogoutManager.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@interface LogoutManager()<UIAlertViewDelegate>{
    AppDelegate *appDelegate;

}

@end

@implementation LogoutManager
#pragma mark -
#pragma mark Default Manager
+ (LogoutManager *)sharedManager {
    static LogoutManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}
-(void)forceLogoutForChangePassword{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Password has been Updated" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Log out", nil];
    [alert show];
    
    
//    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Log out" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Password has been updated Please do log out?" value:@"" table:nil] delegate:self cancelButtonTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"NO" value:@"" table:nil] otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YES" value:@"" table:nil],nil];
//    alter.tag=01;
//
//    [alter show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
   // if (alertView.tag==01) {
        
        //if (buttonIndex==1) {
            appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate LOg_Out];
    
//}
//}
}
@end
