//
//  absent_note.m
//  SCM
//
//  Created by pnf on 12/18/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//

#import "absent_note.h"
#import "AppDelegate.h"
#import "JSON.h"
#import "Utilities.h"
#import "Font_Face_Controller.h"
#import "UIImageView+WebCache.h"
#import "Text_color_.h"
#import "API.h"
#import "NSString+HTML.h"
#import "UIImageView+WebCache.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "ELR_loaders_.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"

@interface absent_note ()

@end

@implementation absent_note
@synthesize datepicker;
@synthesize color;
@synthesize date_value;

#pragma mark -
#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems {
    // self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
    
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
       // self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
    } else {
        //self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    }
}

- (void)rightSideMenuButtonPressed {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        
        
        [self setupMenuBarButtonItems];
    }];
}

- (UIBarButtonItem *)backBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(backButtonPressed:)];
}

#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

-(void)Action_slider
{
    
    
    
    [self rightSideMenuButtonPressed];
    
    
}




-(void)Navigation_bar
{
    
    
    user_pic = [[UIImageView alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"USR_image"]]);
    [user_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"customer_logo"]]]
                placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    
    CGSize size = CGSizeMake(30, 30);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11){
        
        [user_pic setImage: [ImageCustomClass image:user_pic.image resize:size]];
        
    } else {
        
        user_pic.frame=CGRectMake(0, 0, size.width, size.height);
        
    }

    
 //   user_pic.frame=CGRectMake(50, 0, 30, 30);
    user_pic.layer.cornerRadius=size.width*0.5;
    user_pic.layer.borderColor=[UIColor clearColor].CGColor;
    user_pic.layer.borderWidth=1;
    user_pic.clipsToBounds=YES;
    user_pic.layer.masksToBounds = YES;
    user_pic.userInteractionEnabled=YES;
    user_pic.contentMode = UIViewContentModeScaleToFill;
    user_pic.backgroundColor=[UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
    UIBarButtonItem *imageButton = [[UIBarButtonItem alloc] initWithCustomView:user_pic];
    self.navigationItem.rightBarButtonItem = imageButton;
    
    UITapGestureRecognizer *tap_action_slider = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(Action_slider)];
    
    [user_pic addGestureRecognizer:tap_action_slider];
    
    
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName:[Font_Face_Controller opensanssemibold:15],
                                                                    NSForegroundColorAttributeName: [UIColor blackColor]
                                                                    };
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent Note" value:@"" table:nil];
        
    self.navigationItem.hidesBackButton = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size1;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=11){
        size1 = CGSizeMake(20, 20);
    } else {
        size1 = CGSizeMake(30, 30);
    }
    
    UIImage *butImage = [ImageCustomClass image:[UIImage imageNamed:@"back-2"] resize:size1];

//  UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [button setBackgroundImage:butImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(gotoBack) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    [[self navigationItem] setBackBarButtonItem:backButton];
    
}

-(void)gotoBack
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        
        
        
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_authentication_token"];        }
    else
    {
        
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"];
    }
    

    
     [self Navigation_bar];
    
       //-------Calendar selection tab end------------
    
    
   
    
    //background
    backgroundBox  = [[UIView alloc] initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height-64)];
    backgroundBox.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    backgroundBox.userInteractionEnabled=YES;
    [self.view addSubview:backgroundBox];
    
    //Userdetails box
    userdetailsBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    userdetailsBox.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
    [backgroundBox addSubview:userdetailsBox];
    
    userimage_background = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 , 100, 100)];
    userimage_background.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:121.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    [backgroundBox addSubview:userimage_background];
    
    //set User profile Image button
    imageView = [[UIImageView alloc]init];
    [imageView setFrame:CGRectMake(14, 14 , 92, 92)];
    imageView.backgroundColor=color;
    [backgroundBox addSubview:imageView];
    
    //add user name text
    usernamelabel = [[UILabel alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+10, 10 ,self.view.frame.size.width-115, 25)];
  
    usernamelabel.textColor = [UIColor whiteColor];
    [usernamelabel setFont:[Font_Face_Controller opensanssemibold:20]];
    usernamelabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:usernamelabel];
    
    //add guardians text
  guardianslabel = [[UILabel alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+10, 39 ,150, 20)];
    guardianslabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Guardians" value:@"" table:nil];
    guardianslabel.textColor = [UIColor whiteColor];
    [guardianslabel setFont:[Font_Face_Controller opensansLight:15]];
    guardianslabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:guardianslabel];
    
    deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton addTarget:self
               action:@selector(deleteButtonClicked:)
     forControlEvents:UIControlEventTouchUpInside];
//    [deleteButton setTitle:@"delete" forState:UIControlStateNormal];
    [deleteButton setImage:[UIImage imageNamed:@"deletIconForPresentModal"] forState:UIControlStateNormal];
    deleteButton.frame = CGRectMake(self.view.frame.size.width - 80, self.view.frame.size.height - 80, 40.0, 40.0);
    [self.view addSubview:deleteButton];
    
    
//    deletIconForPresentModal
    
    
    [self.view bringSubviewToFront:deleteButton];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"profile9.png"]];

    [self mStartIndicater];
    [self performSelector:@selector(CallTheServer_absent_note_API) withObject:nil afterDelay:0.5];

}

- (IBAction)deleteButtonClicked:(id)sender {
    
     [self mStartIndicater];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [dateFormatter dateFromString: dateSelected];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
    //here convert date in NSString
    
    //    {"securityKey":"H67jdS7wwfh","loginUserID":"44","id":"","language":"en"}
    
    NSString * Token_value;
    
    
    NSDictionary * postDict;
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        
        postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",receivedAbsentNoteId,@"id",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];
    }
    else
    {
        postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",receivedAbsentNoteId,@"id",@"id",@"language",nil];
    }
    
    NSLog(@"postDict %@",postDict);
    
    //    NSString *requestString = [NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],date_correct_format];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/delete_absent_desc",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@ "Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSError * error;
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //        NSLog(@"data:%@",data);
        if (data != nil) {
            id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //        NSLog(@"dictionaryreceived %@",str);
            NSLog(@"dictionaryreceived %@",dictionaryreceived);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self mStopIndicater];
                if(dictionaryreceived == nil)
                {
                    
                }
                else
                {
                    if (dictionaryreceived[@"status"]) {
                        
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Absent note deleted successfully" preferredStyle:UIAlertControllerStyleAlert];
                        
                        
                        
                        UIAlertAction* OKAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                                         handler:^(UIAlertAction * action) {
                                                                          
                                                                             UIViewController *View = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
                                                                             [self.navigationController popToViewController:View animated:YES];
                                                                             
                                                                        
                                                                             
                                                                         }];
                        
                        [alertController addAction:OKAction];
                        
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                    else
                    {
//                        [self showAlert:[dictionaryreceived objectForKey:@"msg"]];
                        
                    }
                    //                    [self ParseArray:dictionaryreceived WithTag:WEBSERVICE_GROUPS];
                }
                
            });
        }
    }];
    
    [postDataTask resume];
    
    
}

-(void)buttonClicked:(UIButton *)sender
{
    [self mStartIndicater];
    [self performSelector:@selector(CallTheServer_Retrieval_times_API) withObject:nil afterDelay:0.5];

}

#pragma mark - -*********************
#pragma mark Activity Indicater
#pragma mark - -*********************

-(void)mStartIndicater
{
    loader_image=[ELR_loaders_ Start_loader:CGRectMake(([[UIScreen mainScreen]bounds].size.width-85)/2,[[UIScreen mainScreen]bounds].size.height/2,85,85)];
    [self.view addSubview:loader_image];
    
    
}

#pragma mark - -*********************
#pragma mark Stop Indicater
#pragma mark - -*********************

-(void)mStopIndicater
{
    
    [loader_image removeFromSuperview];
    
    
}


#pragma mark - -*********************
#pragma mark CallTheServer_Retrieval_times_API
#pragma mark - -*********************


-(void)CallTheServer_Retrieval_times_API
{
    if ([API connectedToInternet]==YES) {
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [dateFormatter dateFromString: date_value];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],date_correct_format]:[NSString stringWithFormat:@"%@retrivals/approve_absence",[Utilities API_link_url_subDomain]]];
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"REfress_List_retrieval"
             object:nil];
          
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
            
        }else if([[dict valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
    }
    
    
    [self mStopIndicater];
    
}






#pragma mark - -*********************
#pragma mark Call get_retriver_note Method
#pragma mark - -*********************


-(void)CallTheServer_absent_note_API
{
    if ([API connectedToInternet]==YES) {
        
        
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [dateFormatter dateFromString: date_value];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],date_correct_format]:[NSString stringWithFormat:@"%@retrivals/get_absence_note",[Utilities API_link_url_subDomain]]];
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            
            receivedAbsentNoteId =[[dict valueForKey:@"data"]valueForKey:@"wholedaysick_id"];
            dateSelected = [[dict valueForKey:@"data"]valueForKey:@"sickdate"];
            
              usernamelabel.text = [[[dict valueForKey:@"data"]valueForKey:@"student_name"]stringByConvertingHTMLToPlainText];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [Utilities API_link_url_IMG], [[dict valueForKey:@"data"]valueForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
            
            for (int a=0; a<([[[dict valueForKey:@"data"]valueForKey:@"parents"] count]); a++) {
                
                if(a==2){
                    break;
                }
                UIView *guardiandetailsBox;
                if(a==0){
                    //guardian1 details box
                    guardiandetailsBox  = [[UIView alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+10, 61, self.view.frame.size.width-130, 22)];
                }else{
                    guardiandetailsBox  = [[UIView alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+10, 88, self.view.frame.size.width-130, 22)];
                }
                guardiandetailsBox.backgroundColor = [UIColor colorWithRed:216.0f/255.0f green:121.0f/255.0f blue:26.0f/255.0f alpha:1.0];
                [backgroundBox addSubview:guardiandetailsBox];
                
                UILabel *guardiannamelabel;
                if(a==0){
                    //add guardian1 text
                    guardiannamelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 1 ,130, 20)];
                }else{
                    guardiannamelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 1 ,130, 20)];
                }
                guardiannamelabel.text = [NSString stringWithFormat:@"%@ %@",[[[[dict valueForKey:@"data"]valueForKey:@"parents"][a] valueForKey:@"USR_FirstName"]stringByConvertingHTMLToPlainText],[[[[dict valueForKey:@"data"]valueForKey:@"parents"][a] valueForKey:@"USR_LastName"]stringByConvertingHTMLToPlainText]];
                guardiannamelabel.textColor = [UIColor whiteColor];
                if(result.width<=320){
                    [guardiannamelabel setFont:[Font_Face_Controller opensansLight:12]];
                }else{
                    [guardiannamelabel setFont:[Font_Face_Controller opensansLight:16]];
                }
                guardiannamelabel.textAlignment=NSTextAlignmentLeft;
                [guardiandetailsBox addSubview:guardiannamelabel];
                
                UILabel *guardianphonelabel;
                if(a==0){
                    //add guardian1 phone text
                    guardianphonelabel = [[UILabel alloc] initWithFrame:CGRectMake(guardiandetailsBox.frame.size.width-115, 1 ,110, 20)];
                }else{
                    guardianphonelabel = [[UILabel alloc] initWithFrame:CGRectMake(guardiandetailsBox.frame.size.width-115, 1 ,110, 20)];
                }
                guardianphonelabel.text = [[[[dict valueForKey:@"data"]valueForKey:@"parents"][a] valueForKey:@"contact_number"]stringByConvertingHTMLToPlainText];
                guardianphonelabel.textColor = [UIColor whiteColor];
                if(result.width<=320){
                    [guardianphonelabel setFont:[Font_Face_Controller opensansLight:12]];
                }else{
                    [guardianphonelabel setFont:[Font_Face_Controller opensansLight:16]];
                }
                guardianphonelabel.textAlignment=NSTextAlignmentRight;
                [guardiandetailsBox addSubview:guardianphonelabel];
            }
            
            
            
            //-------------User details box end-----------------//
            
            
            
            
            //--------------absentnote details box start--------//
            
            fullpagescrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  185, self.view.frame.size.width, self.view.frame.size.height-164)];
            fullpagescrollview.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
            fullpagescrollview.delegate = self;
            [self.view addSubview:fullpagescrollview];
            
            //absentnote box background view
            absentnotedetailsBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 100)];
            absentnotedetailsBox.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
            [fullpagescrollview addSubview:absentnotedetailsBox];
            
//            //absentnote text Label
//            absentnotelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 ,200, 25)];
//            absentnotelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absence note" value:@"" table:nil];
//            absentnotelabel.textColor = [UIColor whiteColor];
//            [absentnotelabel setFont:[Font_Face_Controller opensanssemibold:18]];
//            absentnotelabel.textAlignment=NSTextAlignmentLeft;
//            [absentnotedetailsBox addSubview:absentnotelabel];
            
            //absentnote desc text Label
            absentnotedesclabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 ,150, 22)];
            absentnotedesclabel.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
            absentnotedesclabel.textColor = [UIColor whiteColor];
            [absentnotedesclabel setFont:[Font_Face_Controller opensanssemibold:16]];
            absentnotedesclabel.textAlignment=NSTextAlignmentLeft;
            [absentnotedetailsBox addSubview:absentnotedesclabel];
            
//            //writtenby text Label
//            writtenbylabel = [[UILabel alloc] initWithFrame:CGRectMake(10, absentnotedesclabel.frame.origin.y+absentnotedesclabel.frame.size.height+5 ,[@"Written by:" sizeWithFont:[Font_Face_Controller opensansLight:16]].width, 20)];
//            writtenbylabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Written by:" value:@"" table:nil];
//            writtenbylabel.textColor = [UIColor whiteColor];
//            [writtenbylabel setFont:[Font_Face_Controller opensansLight:16]];
//            writtenbylabel.textAlignment=NSTextAlignmentLeft;
//            [absentnotedetailsBox addSubview:writtenbylabel];
            
            //writtenbyvalue text  Label
            writtenbyvaluelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, absentnotedesclabel.frame.origin.y+absentnotedesclabel.frame.size.height+5  ,[[[dict valueForKey:@"data"]valueForKey:@"written_by"] sizeWithFont:[Font_Face_Controller opensansLight:16]].width, 20)];
            writtenbyvaluelabel.text = [[dict valueForKey:@"data"]valueForKey:@"written_by"];
            writtenbyvaluelabel.textColor = [UIColor whiteColor];
            [writtenbyvaluelabel setFont:[Font_Face_Controller opensansLight:16]];
            writtenbyvaluelabel.textAlignment=NSTextAlignmentLeft;
            [absentnotedetailsBox addSubview:writtenbyvaluelabel];
            
            //writtenbydate text  Label
            writtenbydatelabel = [[UILabel alloc] initWithFrame:CGRectMake(writtenbyvaluelabel.frame.origin.x+writtenbyvaluelabel.frame.size.width+5, absentnotedesclabel.frame.origin.y+absentnotedesclabel.frame.size.height+5  ,[[[dict valueForKey:@"data"]valueForKey:@"created"] sizeWithFont:[Font_Face_Controller opensansLight:16]].width, 20)];
            writtenbydatelabel.text = [[dict valueForKey:@"data"]valueForKey:@"created"];
            writtenbydatelabel.textColor = [UIColor whiteColor];
            [writtenbydatelabel setFont:[Font_Face_Controller opensansLight:16]];
            writtenbydatelabel.textAlignment=NSTextAlignmentLeft;
            [absentnotedetailsBox addSubview:writtenbydatelabel];
            
            
            //absentnotedescription text Label
            descriptionabsentnote = [[[dict valueForKey:@"data"]valueForKey:@"description"]stringByConvertingHTMLToPlainText];
            absentnotedescriptionlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, writtenbydatelabel.frame.origin.y+writtenbydatelabel.frame.size.height+5 ,self.view.frame.size.width-20, 10)];
            absentnotedescriptionlabel.numberOfLines = 0;
            absentnotedescriptionlabel.text = descriptionabsentnote;
            absentnotedescriptionlabel.textColor = [UIColor whiteColor];
            [absentnotedescriptionlabel setFont:[Font_Face_Controller opensansLight:16]];
            [absentnotedescriptionlabel sizeToFit];
            absentnotedescriptionlabel.textAlignment=NSTextAlignmentLeft;
            [absentnotedetailsBox addSubview:absentnotedescriptionlabel];
            //set absentnote background view height dynamically as per the text added in description
            absentnotedetailsBox.frame=CGRectMake(0, 10, self.view.frame.size.width, ( absentnotedescriptionlabel.frame.origin.y+absentnotedescriptionlabel.frame.size.height)+10);
            
            
            fullpagescrollview.contentSize = CGSizeMake(self.view.frame.size.width, absentnotedescriptionlabel.frame.origin.y+absentnotedescriptionlabel.frame.size.height+80);
            
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]init];
            tap2.numberOfTapsRequired = 1;
            [fullpagescrollview addGestureRecognizer:tap2];
            [tap2 addTarget:self action:@selector(datePickerView)];

            
            
            if (![[[dict valueForKey:@"data"]valueForKey:@"approved"]isEqualToString:@"1"]) {
                
                  if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"teacher"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"lärare"]) {
                // Cancel Button
                Add_Remove_button = [UIButton buttonWithType: UIButtonTypeCustom];
                [Add_Remove_button setFrame:CGRectMake((backgroundBox.frame.size.width-270)/2,300, 270, 40)];
                Add_Remove_button.backgroundColor=[UIColor clearColor];
                Add_Remove_button.layer.cornerRadius=5;
                
                [Add_Remove_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [Add_Remove_button setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Remove drop-off and Retrieval times" value:@"" table:nil] forState:UIControlStateNormal];
                
                Add_Remove_button.titleLabel.font=[Font_Face_Controller opensansLight:13];
                [Add_Remove_button setBackgroundColor:[UIColor colorWithRed:249.0f/255.0f green:174.0f/255.0f blue:99.0f/255.0f alpha:1.0]];
                
                [Add_Remove_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.view addSubview:Add_Remove_button];
                
                  }
            }

            
        }else if([[dict valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
    }
    
    [self.view bringSubviewToFront:deleteButton];

    [self mStopIndicater];
    
}

- (void) dateChanged:(id)sender{
    // handle date changes
    UIDatePicker *picker = (UIDatePicker *)sender;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    date_value = [dateFormatter stringFromDate:[picker date]];
    
    [selected_date_btn setTitle:date_value forState: UIControlStateNormal];

    
    [self mStartIndicater];
    [self performSelector:@selector(CallTheServer_absent_note_API) withObject:nil afterDelay:0.5];
}


-(void)datePickerView
{
    [datepicker removeFromSuperview];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [datepicker removeFromSuperview];
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [datepicker removeFromSuperview];
    [textField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
