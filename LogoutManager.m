//
//  LogoutManager.m
//  Smart Classroom Manager
//
//  Created by Tamil Selvan R on 03/04/18.
//  Copyright © 2018 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "LogoutManager.h"
#import "AppDelegate.h"
#import "Right_slider_ViewController.h"
#import <UIKit/UIKit.h>
#import "Attendance_overview.h"

@interface LogoutManager()<UIAlertViewDelegate,Right_slider_ViewControllerDelegate>{
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
    
    
    Attendance_overview *attendanceClass = [[Attendance_overview alloc]init];
    
    if ([attendanceClass CallTheServer_ForVerifyPassword]) {
    
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Log out Needed" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Password has been updated." value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Log out" value:@"" table:nil],nil];

    [alter show];
    }
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
