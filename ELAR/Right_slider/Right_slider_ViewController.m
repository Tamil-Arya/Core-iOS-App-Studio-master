 //
//  Right_slider_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 08/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Right_slider_ViewController.h"
#import "Font_Face_Controller.h"
#import "UIImageView+WebCache.h"


#import "API.h"
#import "JSON.h"

#import "Curriculum_Deatil_ViewController.h"


#import "Text_color_.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "Font_Face_Controller.h"
#import "Utilities.h"
#import "NSString+HTML.h"
#import "Setting_screen_ViewController.h"
#import "AppDelegate.h"
#import "ELR_loaders_.h"
#import "LogoutManager.h"


#import "ViewFoodMenuWebViewViewController.h"
@interface Right_slider_ViewController ()
{
    AppDelegate *appDelegate;
    UIImageView *loader_image;
}

@end

@implementation Right_slider_ViewController

#pragma mark -
#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems {
    // self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
    
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
      //  self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
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
                                            style:UIBarButtonItemStylePlain
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

- (void)YourSelector:(NSNotification *)notification
{
    
}

-(void)load_view
{
    
 
    other_account=[[NSMutableArray alloc]init];
    User_array=[[NSMutableArray alloc]init];
    
    
    other_account=[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"other_accounts"]];
    
    User_array=[[NSUserDefaults standardUserDefaults]valueForKey:@"User"];
    
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]);
    
    
    
    profilepic_LOGIN=[[UIImageView alloc]init];
    [profilepic_LOGIN sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[User_array valueForKey:@"USR_image"]]] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    
    
    
    
    profilepic_LOGIN.frame=CGRectMake(10, 40, 40, 40);
    profilepic_LOGIN.layer.cornerRadius=40*0.5;
    profilepic_LOGIN.layer.borderColor=[UIColor clearColor].CGColor;
    profilepic_LOGIN.layer.borderWidth=1;
    profilepic_LOGIN.clipsToBounds=YES;
    profilepic_LOGIN.userInteractionEnabled=YES;
    profilepic_LOGIN.contentMode = UIViewContentModeScaleToFill;
    profilepic_LOGIN.backgroundColor=[UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
    [self.view addSubview:profilepic_LOGIN];
    
    
    school_LOGIN_LB=[[UILabel alloc]init];
    school_LOGIN_LB.backgroundColor=[UIColor whiteColor];
    school_LOGIN_LB.text=[[User_array valueForKey:@"customer_name"]stringByConvertingHTMLToPlainText];
    school_LOGIN_LB.numberOfLines = 0;
    school_LOGIN_LB.frame=CGRectMake(profilepic_LOGIN.frame.origin.x+profilepic_LOGIN.frame.size.width+3, 25, 150, 20);
    school_LOGIN_LB.textColor=[UIColor grayColor];
    school_LOGIN_LB.font=[Font_Face_Controller opensanssemibold:13];
    school_LOGIN_LB.textAlignment=NSTextAlignmentLeft;
    [school_LOGIN_LB sizeToFit];
    [self.view addSubview:school_LOGIN_LB];
    
    
    
    Name_LOGIN_LB=[[UILabel alloc]init];
    Name_LOGIN_LB.backgroundColor=[UIColor whiteColor];
    Name_LOGIN_LB.text=[NSString stringWithFormat:@"%@ %@",[User_array valueForKey:@"USR_Firstname"],[User_array valueForKey:@"USR_Lastname"]];
    Name_LOGIN_LB.frame=CGRectMake(profilepic_LOGIN.frame.origin.x+profilepic_LOGIN.frame.size.width+5, school_LOGIN_LB.frame.origin.y+school_LOGIN_LB.frame.size.height, 150, 25);
    Name_LOGIN_LB.textColor=[UIColor blackColor];
    Name_LOGIN_LB.font=[Font_Face_Controller opensansregular:11];
    Name_LOGIN_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:Name_LOGIN_LB];
    
    
    
    
    User_type_LOGIN_LB=[[UILabel alloc]init];
    User_type_LOGIN_LB.backgroundColor=[UIColor whiteColor];
    
    
    if (
        [[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]isEqualToString:@"sw"])
    {
        User_type_LOGIN_LB.text=[[User_array valueForKey:@"user_type_sw"]stringByConvertingHTMLToPlainText];
        
        
    }
    else
    {
        User_type_LOGIN_LB.text=[[User_array valueForKey:@"user_type"]stringByConvertingHTMLToPlainText];
        
    }
    

    
    
   // User_type_LOGIN_LB.text=[[User_array valueForKey:@"user_type"]stringByConvertingHTMLToPlainText];
    User_type_LOGIN_LB.frame=CGRectMake(profilepic_LOGIN.frame.origin.x+profilepic_LOGIN.frame.size.width+5, Name_LOGIN_LB.frame.origin.y+Name_LOGIN_LB.frame.size.height-5, 150, 20);
    User_type_LOGIN_LB.textColor=[UIColor blackColor];
    User_type_LOGIN_LB.font=[Font_Face_Controller opensansregular:11];
    User_type_LOGIN_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:User_type_LOGIN_LB];
    
    
    
    
    User_name_LOGIN_LB=[[UILabel alloc]init];
    User_name_LOGIN_LB.backgroundColor=[UIColor whiteColor];
    User_name_LOGIN_LB.text=[[User_array valueForKey:@"username"]stringByConvertingHTMLToPlainText];
    
    User_name_LOGIN_LB.frame=CGRectMake(15, profilepic_LOGIN.frame.origin.y+profilepic_LOGIN.frame.size.height+2, 40, 18);
    User_name_LOGIN_LB.textColor=[UIColor blackColor];
    User_name_LOGIN_LB.font=[Font_Face_Controller opensansLight:9];
    User_name_LOGIN_LB.textAlignment=NSTextAlignmentLeft;
    
    [self.view addSubview:User_name_LOGIN_LB];
    
    
    // init table view
    tableViewm = [[UITableView alloc] initWithFrame:CGRectMake(0, User_name_LOGIN_LB.frame.origin.y+User_name_LOGIN_LB.frame.size.height+10, self.view.frame.size.width, (self.view.frame.size.height-200)) style:UITableViewStylePlain];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    tableViewm.delegate = self;
    tableViewm.dataSource = self;
    
    tableViewm.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0];
    
    // add to canvas
    [self.view addSubview:tableViewm];
    
    
    
    tableViewm.tableFooterView = [UIView new];
    
    
    
    website_view=[[UIView alloc]init];
    website_view.backgroundColor=[UIColor clearColor];
    website_view.frame=CGRectMake(0, self.view.frame.size.height-90,self.view.frame.size.width, 30);
    [self.view addSubview:website_view];
    
    
    
    UITapGestureRecognizer *website_view_Tap = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(website_view_action)];
    
    [website_view addGestureRecognizer:website_view_Tap];
    
    setting_view=[[UIView alloc]init];
    setting_view.backgroundColor=[UIColor clearColor];
    setting_view.frame=CGRectMake(0, self.view.frame.size.height-60,self.view.frame.size.width, 30);
    [self.view addSubview:setting_view];
    
    
    
    UITapGestureRecognizer *setting_view_Tap = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(setting_view_action)];
    
    [setting_view addGestureRecognizer:setting_view_Tap];
    
    
    
    
    
    logout_view=[[UIView alloc]init];
    logout_view.backgroundColor=[UIColor clearColor];
    logout_view.frame=CGRectMake(0,self.view.frame.size.height-30,self.view.frame.size.width, 30);
    [self.view addSubview:logout_view];
    
    
    UITapGestureRecognizer *logout_view_Tap = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(logout_view_action)];
    
    [logout_view addGestureRecognizer:logout_view_Tap];
    
    
    
    //////////////////// Setting_BTN Button\\\\\\\\\\\\\\
    
    Website_BTN = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // [LOgOut_BTN addTarget:self
    //      action:@selector(LOgOut_delete)
    //  forControlEvents:UIControlEventTouchUpInside];
    //BTN_Save_Draft.backgroundColor=[UIColor colorWithRed:242.0f/255.0f green:158.0f/255.0f blue:195.0f/255.0f alpha:1.0];
//    [Website_BTN setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-cloud"] forState:UIControlStateNormal];
    [Website_BTN setBackgroundImage:[UIImage imageNamed:@"Website Grey"] forState:UIControlStateNormal];
    [Website_BTN setBackgroundColor:[UIColor whiteColor]];
//    [Website_BTN.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:18]];
//    [Website_BTN setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    Website_BTN.frame = CGRectMake(5,0,30, 30);
    [website_view addSubview:Website_BTN];
    
    
    
    
    Website_LB=[[UILabel alloc]init];
    Website_LB.backgroundColor=[UIColor whiteColor];
    
    NSString * stringWithDomainName = [[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"];
    stringWithDomainName = [stringWithDomainName stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    
    
    Website_LB.text=stringWithDomainName;
    Website_LB.frame=CGRectMake(Website_BTN.frame.origin.x+Website_BTN.frame.size.height+5, 0, 300, 30);
    Website_LB.textColor=[UIColor grayColor];
    Website_LB.font=[Font_Face_Controller opensanssemibold:12];
    Website_LB.textAlignment=NSTextAlignmentLeft;
    
    [website_view addSubview:Website_LB];

    
    
    //////////////////// Setting_BTN Button\\\\\\\\\\\\\\
    
    LOgOut_BTN = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // [LOgOut_BTN addTarget:self
    //      action:@selector(LOgOut_delete)
    //  forControlEvents:UIControlEventTouchUpInside];
    //BTN_Save_Draft.backgroundColor=[UIColor colorWithRed:242.0f/255.0f green:158.0f/255.0f blue:195.0f/255.0f alpha:1.0];
    [LOgOut_BTN setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-power-off"] forState:UIControlStateNormal];
    [LOgOut_BTN.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:18]];
    [LOgOut_BTN setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    LOgOut_BTN.frame = CGRectMake(5,0,30, 30);
    [logout_view addSubview:LOgOut_BTN];
    
    
    
    
    LOgOut_LB=[[UILabel alloc]init];
    LOgOut_LB.backgroundColor=[UIColor whiteColor];
    LOgOut_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Sign out" value:@"" table:nil];
    LOgOut_LB.frame=CGRectMake(LOgOut_BTN.frame.origin.x+LOgOut_BTN.frame.size.height+5, 0, 300, 30);
    LOgOut_LB.textColor=[UIColor grayColor];
    LOgOut_LB.font=[Font_Face_Controller opensanssemibold:12];
    LOgOut_LB.textAlignment=NSTextAlignmentLeft;
    
    [logout_view addSubview:LOgOut_LB];
    
    
    //////////////////// Setting_BTN Button\\\\\\\\\\\\\\
    
    
    
    
    Setting_BTN = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //   [Setting_BTN addTarget:self
    // action:@selector(Setting_delete)
    //  forControlEvents:UIControlEventTouchUpInside];
    //BTN_Save_Draft.backgroundColor=[UIColor colorWithRed:242.0f/255.0f green:158.0f/255.0f blue:195.0f/255.0f alpha:1.0];
    [Setting_BTN setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-cog"] forState:UIControlStateNormal];
    [Setting_BTN.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:18]];
    [Setting_BTN setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    Setting_BTN.frame = CGRectMake(5,0,30, 30);
    [setting_view addSubview:Setting_BTN];
    
    
    
    
    Setting_LB=[[UILabel alloc]init];
    Setting_LB.backgroundColor=[UIColor whiteColor];
    Setting_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Setting" value:@"" table:nil];
    Setting_LB.frame=CGRectMake(Setting_BTN.frame.origin.x+Setting_BTN.frame.size.height+5, 0, 100, 30);
    Setting_LB.textColor=[UIColor grayColor];
    Setting_LB.font=[Font_Face_Controller opensanssemibold:12];
    Setting_LB.textAlignment=NSTextAlignmentLeft;
    
    [setting_view addSubview:Setting_LB];
    

}


- (void) REfress_Right_screen:(NSNotification *) notification
{
    
    [self load_view];
    
    [tableViewm reloadData];
    
    
    

}



#pragma mark - -*********************
#pragma mark CallTheServer_Login_API Method
#pragma mark - -*********************


-(void)CallTheServer_Refess
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&user_table_id=%@&language=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"user_table_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@news/change_language",[Utilities API_link_url_subDomain]]];
        
;
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        Refress = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[Refress valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"LoginStatues"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            
            NSLog(@"%@",[Refress valueForKey:@"ComComponent"]);
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[Refress valueForKey:@"ComComponent"] forKey:@"ComComponent"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
               NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"ComComponent"]);
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[Refress valueForKey:@"User"]forKey:@"User"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        
            
            [[NSUserDefaults standardUserDefaults]setObject:[[Refress valueForKey:@"User"]valueForKey:@"USR_image"] forKey:@"USR_image"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[Refress valueForKey:@"User"]valueForKey:@"id"] forKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[Refress valueForKey:@"User"]valueForKey:@"user_table_id"] forKey:@"user_table_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:[Refress valueForKey:@"other_accounts"]] forKey:@"other_accounts"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
                
                [[NSUserDefaults standardUserDefaults]setObject:[Refress valueForKey:@"children"]forKey:@"children"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
                [[NSUserDefaults standardUserDefaults]setObject:[[Refress valueForKey:@"User"]valueForKey:@"id"]forKey:@"parent_id"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
                
                
                
            }
            else
            {
                
                [[NSUserDefaults standardUserDefaults]setObject:[[Refress valueForKey:@"User"]valueForKey:@"authentication_token"]forKey:@"parent_authentication_token"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                

                
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"parent_id"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }

            
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[[[Refress valueForKey:@"User"]valueForKey:@"user_type"]stringByConvertingHTMLToPlainText]lowercaseString] forKey:@"user_type"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"REfress_User_panel"
             object:nil];

            
            
        }else if([[Refress valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[Refress valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        
        
        
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
    }
    
   [self mStopIndicater];
    
    
  
    
     [self load_view];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        
        
        
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_authentication_token"];        }
    else
    {
        
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(REfress_Right_screen:)
                                                 name:@"REfress_Right_screen"
                                               object:nil];
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

     [self load_view];
}



-(void)website_view_action
{
    ViewFoodMenuWebViewViewController *obj_Web_ViewController=[[ViewFoodMenuWebViewViewController alloc]init];
    NSString * urlToSend = [[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"];
    obj_Web_ViewController.foodMenuUrlReceived = [NSURL URLWithString: urlToSend ];
    obj_Web_ViewController.fromPage = @"Setting";

    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:obj_Web_ViewController];
    [self presentViewController:HomeNavController animated:YES completion:nil];
}


-(void)setting_view_action
{
    Setting_screen_ViewController *objSetting_ViewController=[[Setting_screen_ViewController alloc]init];
    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:objSetting_ViewController];
    
    [self presentViewController:HomeNavController animated:YES completion:nil];
}

-(void)logout_view_action
{
    
    
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Log out" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Do you want to log out?" value:@"" table:nil] delegate:self cancelButtonTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"NO" value:@"" table:nil] otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YES" value:@"" table:nil],nil];
    alter.tag=001;
    
    
    [alter show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==001) {
        
         if (buttonIndex==1) {
            
            
           [self mStartIndicater];
            
            [self performSelector:@selector(CallTheServer_LOG_OUT) withObject:nil afterDelay:0.5];
        }
    }
}
	

-(void)CallTheServer_LOG_OUT
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&user_table_id=%@&device_token_app=%@&language=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"user_table_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@users/logout",[Utilities API_link_url_subDomain]]];
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate LOg_Out];
            
        }else if([[dict valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
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
#pragma mark Activity Indicater
#pragma mark - -*********************

-(void)mStartIndicater
{
    
    
    loader_image=[ELR_loaders_ Start_loader:CGRectMake(-5,[[UIScreen mainScreen]bounds].size.height/2,85,85)];
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
#pragma mark TableView HeightForHeader Method
#pragma mark - -*********************

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}



#pragma mark - -*********************
#pragma mark TableView DataSource Method
#pragma mark - -*********************


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeader = [[UIView alloc] init];
    sectionHeader.frame=CGRectMake(0, 0,tableViewm.frame.size.width, 20);
    sectionHeader.backgroundColor=[UIColor whiteColor];
    
    UILabel *curriculum_tags = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,tableViewm.frame.size.width, 20)];
    curriculum_tags.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0];
    curriculum_tags.font = [Font_Face_Controller opensanssemibold:13];
    curriculum_tags.tag=section;
    curriculum_tags.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"   Other accounts" value:@"" table:nil];
    curriculum_tags.userInteractionEnabled=YES;
    
    
    curriculum_tags.textAlignment = NSTextAlignmentLeft;
    curriculum_tags.textColor=[UIColor lightGrayColor];
    
    [sectionHeader addSubview:curriculum_tags];
    
    
    return sectionHeader;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 70;
   
}


- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    
     
    return other_account.count;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableViewm dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSArray *views=[cell.contentView subviews];
    for(int i=0;i<[views count];i++)
    {
        UIView *tempView=[views objectAtIndex:i];
        [tempView removeFromSuperview];
        tempView = nil;
    }
    if (cell == NULL)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[other_account objectAtIndex:indexPath.row] valueForKey:@"USR_image"]]);
    
    
    profilepic=[[UIImageView alloc]init];
          [profilepic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[other_account objectAtIndex:indexPath.row] valueForKey:@"USR_image"]]] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    
    profilepic.frame=CGRectMake(10, 15, 40, 40);
    profilepic.layer.cornerRadius=40*0.5;
    profilepic.layer.borderColor=[UIColor clearColor].CGColor;
    profilepic.layer.borderWidth=0;
    profilepic.clipsToBounds=YES;
    profilepic.userInteractionEnabled=YES;
    profilepic.contentMode = UIViewContentModeScaleToFill;
    profilepic.backgroundColor=[UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
     [cell.contentView addSubview:profilepic];
    
    
    school_LB=[[UILabel alloc]init];
    school_LB.backgroundColor=[UIColor clearColor];
     school_LB.text=[[[other_account objectAtIndex:indexPath.row] valueForKey:@"customer_name"]stringByConvertingHTMLToPlainText];
  
    school_LB.frame=CGRectMake(profilepic.frame.origin.x+profilepic.frame.size.width+7, 8, 150, 20);
    school_LB.textColor=[UIColor grayColor];
    school_LB.font=[Font_Face_Controller opensanssemibold:13];
    school_LB.textAlignment=NSTextAlignmentLeft;
   
    [cell.contentView addSubview:school_LB];
    
    
    
    Name_LB=[[UILabel alloc]init];
    Name_LB.backgroundColor=[UIColor clearColor];
   Name_LB.text=[NSString stringWithFormat:@"%@ %@",[[other_account objectAtIndex:indexPath.row] valueForKey:@"USR_Firstname"],[[other_account objectAtIndex:indexPath.row] valueForKey:@"USR_Lastname"]];
   
    Name_LB.frame=CGRectMake(profilepic_LOGIN.frame.origin.x+profilepic_LOGIN.frame.size.width+7, school_LB.frame.origin.y+school_LB.frame.size.height-5, 150, 20);
    Name_LB.textColor=[UIColor blackColor];
    Name_LB.font=[Font_Face_Controller opensansregular:11];
    Name_LB.textAlignment=NSTextAlignmentLeft;
  
    [cell.contentView addSubview:Name_LB];
    

    
    
    User_type_LB=[[UILabel alloc]init];
    User_type_LB.backgroundColor=[UIColor clearColor];
    
    
    
    if (
        [[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]isEqualToString:@"sw"])
    {
        User_type_LB.text=[[[other_account objectAtIndex:indexPath.row] valueForKey:@"user_type_sw"] stringByConvertingHTMLToPlainText];

        
    }
    else
    {
        User_type_LB.text=[[[other_account objectAtIndex:indexPath.row] valueForKey:@"user_type"] stringByConvertingHTMLToPlainText];

    }
    
    
    
    
    User_type_LB.frame=CGRectMake(profilepic.frame.origin.x+profilepic.frame.size.width+7, Name_LB.frame.origin.y+Name_LB.frame.size.height-5, 150, 20);
    User_type_LB.textColor=[UIColor blackColor];
    User_type_LB.font=[Font_Face_Controller opensansregular:11];
    User_type_LB.textAlignment=NSTextAlignmentLeft;
  
    [cell.contentView addSubview:User_type_LB];

    
    
    
    User_name_LB=[[UILabel alloc]init];
    User_name_LB.backgroundColor=[UIColor clearColor];
    User_name_LB.text=[[other_account objectAtIndex:indexPath.row] objectForKey:@"username"];
    User_name_LB.frame=CGRectMake(15, profilepic.frame.origin.y+profilepic.frame.size.height-5, 35, 20);
    User_name_LB.textColor=[UIColor blackColor];
    User_name_LB.font=[Font_Face_Controller opensansLight:8];
    User_name_LB.textAlignment=NSTextAlignmentCenter;
   
    [cell.contentView addSubview:User_name_LB];

    
    
    cell.backgroundColor=[UIColor clearColor];
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
//    if ([[[[[other_account objectAtIndex:indexPath.row]valueForKey:@"user_type"] stringByConvertingHTMLToPlainText] lowercaseString]isEqualToString:@"parent"] ||[[[other_account objectAtIndex:indexPath.row]valueForKey:@"user_type"] isEqualToString:@"parent"] ||  [[[other_account objectAtIndex:indexPath.row]valueForKey:@"user_type"] isEqualToString:@"F&ouml;r&auml;lder"]) {
//        
//    }
//    else
//    {
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_switch_user:) withObject:[other_account objectAtIndex:indexPath.row] afterDelay:0.5];
   // }
    
}


-(void)CallTheServer_switch_user:(NSMutableDictionary *)dic
{
    
    
       
    if ([API connectedToInternet]==YES) {
        
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&current_authentication_token=%@&user_type_app=%@&device_token_app=%@&user_table_id=%@&language=%@",@"H67jdS7wwfh",[dic valueForKey:@"authentication_token"],Token_value,@"ios",[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"user_table_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@users/switch_user",[Utilities API_link_url_subDomain]]];
        
        
        NSLog(@"%@",[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&current_authentication_token=%@&user_type_app=%@&device_token_app=%@&user_table_id=%@&language=%@",@"H67jdS7wwfh",[dic valueForKey:@"authentication_token"],Token_value,@"ios",[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"user_table_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]);
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            NSMutableDictionary *dic_values=[[NSMutableDictionary alloc]init];
            
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"USR_CUS_Rid"] forKey:@"USR_CUS_Rid"];
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"USR_Email"] forKey:@"USR_Email"];
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"USR_Firstname"] forKey:@"USR_Firstname"];
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"USR_Lastname"] forKey:@"USR_Lastname"];
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"USR_image"] forKey:@"USR_image"];
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"authentication_token"] forKey:@"authentication_token"];
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"customer_name"] forKey:@"customer_name"];
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"device_token_app"] forKey:@"device_token_app"];
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"group_id"] forKey:@"group_id"];
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"id"] forKey:@"id"];
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"last_student_id"] forKey:@"last_student_id"];
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"user_table_id"] forKey:@"user_table_id"];
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"user_type"] forKey:@"user_type"];
            
            
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"user_type_sw"] forKey:@"user_type_sw"];

       
            [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"username"] forKey:@"username"];
            
              [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"eduBlog_count"] forKey:@"eduBlog_count"];
              [dic_values setValue:[[dict valueForKey:@"User"]valueForKey:@"news_count"] forKey:@"news_count"];
            NSLog(@"%@",dic_values);
            
            
            [[NSUserDefaults standardUserDefaults] setObject:dic_values forKey:@"User"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[dict valueForKey:@"User"]valueForKey:@"USR_image"] forKey:@"USR_image"];
            
            
            [[NSUserDefaults standardUserDefaults]synchronize];

            [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"LoginStatues"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[dict valueForKey:@"ComComponent"] forKey:@"ComComponent"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[dict valueForKey:@"User"]valueForKey:@"id"] forKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[dict valueForKey:@"User"]valueForKey:@"user_table_id"] forKey:@"user_table_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:[dict valueForKey:@"other_accounts"]] forKey:@"other_accounts"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[[[dict valueForKey:@"User"]valueForKey:@"user_type"]stringByConvertingHTMLToPlainText]lowercaseString] forKey:@"user_type"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
                
                [[NSUserDefaults standardUserDefaults]setObject:[dict valueForKey:@"children"]forKey:@"children"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:[[dict valueForKey:@"User"]valueForKey:@"id"]forKey:@"parent_id"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
                [[NSUserDefaults standardUserDefaults]setObject:[[dict valueForKey:@"User"]valueForKey:@"authentication_token"]forKey:@"parent_authentication_token"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
                
            }
            else
            {
                
                [[NSUserDefaults standardUserDefaults]setObject:[dict valueForKey:@"authentication_token"] forKey:@"authentication_token"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                

                
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"parent_id"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }

            


            
            appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate LOg_in];
            
        }else if([[dict valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
