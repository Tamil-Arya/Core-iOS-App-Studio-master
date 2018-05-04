
//
//  AppDelegate.m
//  ELAR
//
//  Created by Bhushan Bawa on 05/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "AppDelegate.h"
#import "Login_ViewController.h"
#import "Remember_Me_ViewController.h"
#import "Users_panel_ViewController.h"
#import "EDU_Blog_Home_screen_ViewController.h"
#import "EDU_Blog_Filter_ViewController.h"

#import "EDU_Blog_Post_ViewController.h"
#import "Curriculum_Tags_ViewController.h"

#import "MFSideMenuContainerViewController.h"
#import "Right_slider_ViewController.h"
#import "Single_Post_ViewController.h"

#import "Single_NEWS_Post_ViewController.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "ELR_loaders_.h"
#import "TermOfUseViewController.h"

#import "ReachabilityManager.h"
#define TERM_OF_CONDITION_URL @"https://dev.elar.se/mobile_api/get_userterms_formobile"

@interface AppDelegate ()
@property (nonatomic) UIImageView *loader_image;

@end

@implementation AppDelegate
@synthesize window;




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [ReachabilityManager sharedManager];

    
    [Fabric with:@[[Crashlytics class]]];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"ios" forKey:@"user_type_app"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
   
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]isEqualToString:@"en"]) {
        
         
        [[NSUserDefaults standardUserDefaults]setObject:@"en" forKey:@"langugae"];
        [[NSUserDefaults standardUserDefaults]synchronize];
         
    }
    else
    {
      
        
        [[NSUserDefaults standardUserDefaults]setObject:@"sw" forKey:@"langugae"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Session"]isEqualToString:@"YES"]) {
        
        
       
        [self LOg_in];
        
        
    }
    
    else {
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        NSObject * object = [prefs objectForKey:@"Default_subdomain"];
        if(object != nil){
            
        }
        else{
            [[NSUserDefaults standardUserDefaults]setValue:@"http://elar.se/" forKey:@"Default_subdomain"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
        }
        
        
        
        Login_ViewController *leftMenuViewControllers = [[Login_ViewController alloc] init];
        
        nav=[[UINavigationController alloc]initWithRootViewController:leftMenuViewControllers];
        
        self.window.rootViewController = nav;

      }

    
    [self removeEventsFromCalendar];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    [self.window makeKeyAndVisible];

    return YES;
}

-(void) removeEventsFromCalendar{
    
    // delete the calendar events
    
    NSMutableArray * arrayWithEventId = [[NSUserDefaults standardUserDefaults]objectForKey:@"eventId"];
    
    NSMutableArray * arrayWithEventStartDate = [[[NSUserDefaults standardUserDefaults]objectForKey:@"eventStartDate"] mutableCopy];
    NSMutableArray * arrayWithEventendDate = [[[NSUserDefaults standardUserDefaults]objectForKey:@"eventEndDate"] mutableCopy];
    
    NSLog(@"%@",arrayWithEventId);
    
    
    for (int i = 0; i<arrayWithEventStartDate.count; i++) {
        EKEventStore* store = [EKEventStore new];
        //    NSDate* currentStart = [NSDate dateWithTimeInterval:0 sinceDate:[NSDate date]];
        
        int seconds_in_year = 60*60*24*365;
        
        //    NSDate *endDate = (NSDate *)[arrayWithEventendDate objectAtIndex:i];
        
        // enumerate events by one year segment because iOS do not support predicate longer than 4 year !
        NSDate *start = (NSDate *)[arrayWithEventStartDate objectAtIndex:i];
        NSDate *finish = (NSDate *)[arrayWithEventendDate objectAtIndex:i];
        
        // use Dictionary for remove duplicates produced by events covered more one year segment
        NSMutableDictionary *eventsDict = [NSMutableDictionary dictionaryWithCapacity:1024];
        
        
        while ([start compare:finish] == NSOrderedAscending) {
            
            NSDate* currentFinish = [NSDate dateWithTimeInterval:seconds_in_year sinceDate:start];
            
            if ([currentFinish compare:finish] == NSOrderedDescending) {
                currentFinish = [NSDate dateWithTimeInterval:0 sinceDate:finish];
            }
            NSPredicate *predicate = [store predicateForEventsWithStartDate:start endDate:currentFinish calendars:nil];
            [store enumerateEventsMatchingPredicate:predicate
                                         usingBlock:^(EKEvent *event, BOOL *stop) {
                                             
                                             if (event) {
                                                 [eventsDict setObject:event forKey:event.eventIdentifier];
                                             }
                                             
                                         }];
            start = [NSDate dateWithTimeInterval:(seconds_in_year + 1) sinceDate:start];
            
        }
        
        NSArray *events = [eventsDict allValues];
        for (EKEvent *event in events) {
            NSError* err = nil;
            [store removeEvent:event span:EKSpanFutureEvents commit:YES error:&err];
            
        }
    }

}

-(NSArray *)viewControllers {
    NSArray *viewControllers = [self.window subviews];
    if (viewControllers != nil && viewControllers.count > 0) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:viewControllers];
        [array removeObjectAtIndex:0];
        return array;
    }
    return viewControllers;
}

-(void)LOg_in
{
    
//    NSArray *subViewArray = [self.window     subviews];
//    for (id obj in subViewArray)
//    {
//        [obj removeFromSuperview];
//
//    }
    [self mStartIndicater];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",[[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]capitalizedString]);

     if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        leftMenuChildren_LIST = [[Children_LIST alloc] init];
        
        nav=[[UINavigationController alloc]initWithRootViewController:leftMenuChildren_LIST];
        
    }
    else
    {
         leftMenuViewController = [[Users_panel_ViewController alloc] init];
        
       nav=[[UINavigationController alloc]initWithRootViewController:leftMenuViewController];

    }
    
    
   
    
    
    Right_slider_ViewController *obj_SideMenuViewController=[[Right_slider_ViewController alloc]init];
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:nav
                                                    
                                                    leftMenuViewController:nil
                                                    rightMenuViewController:obj_SideMenuViewController];
    self.window.rootViewController = container;
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];
    [self mStopIndicater];


}
-(void)LOg_Out
{
    
    
    NSString *device_token=[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"];
    
    NSString *langugae=[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"];
    
    
    
    //NSString *app_main_url=[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"];
    
    
       NSString *Default_subdomainngugae=[[NSUserDefaults standardUserDefaults]valueForKey:@"Default_subdomain"];

    NSString *user_type_app=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type_app"];

    
    NSString  *Default_subdomain_name=[[NSUserDefaults standardUserDefaults]valueForKey:@"Default_subdomain_name"];
    

    
    NSArray *subViewArray = [self.window subviews];
    for (id obj in subViewArray)
    {
        [obj removeFromSuperview];
        
    }
    
    
    [self resetDefaults];
    
    [self removeEventsFromCalendar];
    
    [[NSUserDefaults standardUserDefaults]setObject:Default_subdomain_name forKey:@"Default_subdomain_name"];
    [[NSUserDefaults standardUserDefaults]synchronize];



    
    
    [[NSUserDefaults standardUserDefaults]setObject:Default_subdomainngugae forKey:@"Default_subdomain"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:device_token forKey:@"device_token_app"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:langugae forKey:@"langugae"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:user_type_app forKey:@"user_type_app"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    

    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    Login_ViewController *leftMenuViewController = [[Login_ViewController alloc] init];
    
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:leftMenuViewController];
    
    self.window.rootViewController = nav;
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    [self.window makeKeyAndVisible];


}


- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}






- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    
    application.applicationIconBadgeNumber = 0;
    NSLog(@"userInfo %@",userInfo);
    for (id key in userInfo) {
        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }
    
    [application setApplicationIconBadgeNumber:[[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue]];
    NSLog(@"Badge %d",[[[userInfo objectForKey:@"aps"] objectForKey:@"id"] intValue]);
    NSLog(@"Badge %d",[[[userInfo objectForKey:@"aps"] objectForKey:@"type"] intValue]);

    
    NSMutableDictionary *dicts=[[NSMutableDictionary alloc]init];
    [dicts setValue:[[userInfo objectForKey:@"aps"] objectForKey:@"id"] forKey:@"id"];
     [dicts setValue:[[userInfo objectForKey:@"aps"] objectForKey:@"type"] forKey:@"type"];
    
    
    
    
    if (application.applicationState == UIApplicationStateActive)
    {
        
        
        //Create a view to hold the label and add images or whatever, place it off screen at -100
        UIView *alertview = [[UIView alloc] initWithFrame:CGRectMake(0, -100, CGRectGetWidth(self.window.bounds), 60)];
        alertview.backgroundColor=[UIColor whiteColor];
        
        
        
        UIImageView *logoimg=[[UIImageView alloc]init];
        logoimg.frame=CGRectMake(20, 20, 29, 29);
        logoimg.image=[UIImage imageNamed:@"notifivation_icon.png"];
        [alertview addSubview:logoimg];
        
        
        //Create a label to display the message and add it to the alertView
        UILabel *app_name = [[UILabel alloc] initWithFrame:CGRectMake(logoimg.frame.origin.x+logoimg.frame.size.width+10, 20, 100, 15)];
        app_name.text = @"ELAR";
        app_name.font=[UIFont boldSystemFontOfSize:14];
        app_name.textColor=[UIColor colorWithRed:36.0f/255.0f green:41.0f/255.0f blue:49.0f/255.0f alpha:1.0];
        app_name.backgroundColor=[UIColor clearColor];
        
        [alertview addSubview:app_name];
        
        
        //Create a label to display the message and add it to the alertView
        UILabel *theMessage = [[UILabel alloc] initWithFrame:CGRectMake(logoimg.frame.origin.x+logoimg.frame.size.width+10, app_name.frame.origin.y+app_name.frame.size.height, CGRectGetWidth(alertview.bounds), 15)];
        theMessage.text = [[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]valueForKey:@"body"];
        theMessage.textColor=[UIColor colorWithRed:36.0f/255.0f green:41.0f/255.0f blue:49.0f/255.0f alpha:1.0];
        theMessage.font=[UIFont systemFontOfSize:11];
        theMessage.backgroundColor=[UIColor clearColor];
        [alertview addSubview:theMessage];
        
        //Add the alertView to your view
        [self.window addSubview:alertview];
        
        
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             alertview.frame =CGRectMake(0, 0, CGRectGetWidth(self.window.bounds), 60);
                             
                             
                             [UIView animateWithDuration:1.0
                                                   delay:6.0
                                                 options: UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  alertview.frame =CGRectMake(0, -100, CGRectGetWidth(self.window.bounds), 60);
                                              }
                                              completion:nil];
                             
                             
                         }
                         completion:nil];
        
        
    }
    else
    {
        
        if ([[dicts valueForKey:@"type"]isEqualToString:@"news"]) {
        
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"Single_NEWS_Post"              object:dicts];
            
        }

        else if ([[dicts valueForKey:@"type"]isEqualToString:@"edu_blog"])
        {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"Single_Post"
             object:dicts];

        }
        
        
        else if ([[dicts valueForKey:@"type"]isEqualToString:@"absent_note"])
        {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"absent_note"
             object:[userInfo objectForKey:@"aps"]];

        }
        else if ([[dicts valueForKey:@"type"]isEqualToString:@"retriever_note"])
        {
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"retriever_note"
             object:[userInfo objectForKey:@"aps"]];
        }
        
        else if ([[dicts valueForKey:@"type"]isEqualToString:@"attendance_list"])
        {

        }
        else if ( [[dicts valueForKey:@"type"] isEqualToString:@"forum"]) // forum
        {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"Forum_Notification"
             object:[userInfo objectForKey:@"aps"]];
        }
        else
        {
//            [[NSNotificationCenter defaultCenter]
//             postNotificationName:@"Single_NEWS_Post"              object:dicts];

        }
//

    }

    
    
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
   
    
    
    NSString *newToken = [deviceToken description];
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"Token %@",newToken);
    
    [[NSUserDefaults standardUserDefaults]setObject:newToken forKey:@"device_token_app"];
     [[NSUserDefaults standardUserDefaults]setObject:@"ios" forKey:@"user_type_app"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    NSLog(@"My token is: %@", deviceToken);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  
        return (UIInterfaceOrientationIsPortrait(interfaceOrientation));
    
}



-(void)webServiceCallForTermsOfConditions {
    
    [self mStartIndicater];

    NSMutableDictionary *dicdddd=[[NSMutableDictionary alloc]init];
    [dicdddd setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
    [dicdddd setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"] forKey:@"loginUserID"];
    [dicdddd setValue:@"ios" forKey:@"platform"];
    NSError * error;
    
    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",TERM_OF_CONDITION_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@ "Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dicdddd options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //        NSLog(@"data:%@",data);
        if (data != nil || data == NULL) {
            id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(dictionaryreceived != nil){
                    
                    NSInteger isTrue =[[dictionaryreceived objectForKey:@"status"] integerValue];
                   [self mStopIndicater];
                    if (isTrue) {
                    
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TermOfUseViewController" bundle:nil];
                        TermOfUseViewController *myNewVC = (TermOfUseViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TermOfUseViewController"];
                        //self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"TermOfUseViewController"];
                    
                    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:myNewVC];
                    
                    self.window.rootViewController = nav;
                    
                    self.window.backgroundColor = [UIColor whiteColor];
                    
                    [self.window makeKeyAndVisible];
                    [self mStopIndicater];
                    }
                }
                
            });
        
        }
        [self mStopIndicater];

    }];
    
    [postDataTask resume];
    [self mStopIndicater];

    
}

#pragma mark - -*********************
#pragma mark Activity Indicater
#pragma mark - -*********************

-(void)mStartIndicater
{
    
    self.loader_image=[ELR_loaders_ Start_loader:CGRectMake(([[UIScreen mainScreen]bounds].size.width-85)/2,[[UIScreen mainScreen]bounds].size.height/2,85,85)];
    [self.window addSubview:self.loader_image];
    
    [self.loader_image setHidden:NO];
    
    
}

#pragma mark - -*********************
#pragma mark Stop Indicater
#pragma mark - -*********************

-(void)mStopIndicater
{
    [self.loader_image setHidden:YES];
    //    [loader_image removeFromSuperview];
    
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults]setObject:@"isTrue" forKey:@"applicationDidEnterBackground"];
  
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
    
    if ([[ReachabilityManager sharedManager]isReachable]) {
        UIViewController *topVc = [self topMostController];
        if (![topVc isKindOfClass:[Login_ViewController class]]) {
            [self webServiceCallForTermsOfConditions];
        }
    }else{
        [self mStopIndicater];

        [[ReachabilityManager sharedManager]showAlertForNoInternetNotification];
    }
    
    
    
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}
- (UIViewController *)topMostController {
    UIViewController * topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController || [topController isMemberOfClass:[UINavigationController class]]) {
        if([topController isMemberOfClass:[UINavigationController class]]) {
            topController = [topController childViewControllers].lastObject;
        } else {
            topController = topController.presentedViewController;
        }
    }
    
    return topController;
}
@end
