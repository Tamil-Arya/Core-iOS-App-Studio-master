//
//  EDU_Blog_Home_screen_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 23/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "EDU_Blog_Home_screen_ViewController.h"
#import "EDU_Blog_Post_ViewController.h"
#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "NSString+HTML.h"
#import "UIImageView+WebCache.h"
#import "EDU_Blog_Filter_ViewController.h"
#import "Open_Random_files_ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "Edit_Post _ViewController.h"
#import "ELR_loaders_.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"

@interface EDU_Blog_Home_screen_ViewController ()
{
    UITextView *Student_name;
}
@end

@implementation EDU_Blog_Home_screen_ViewController
@synthesize photos;
@synthesize thumbs;



#pragma mark -
#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems {
    // self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
    
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
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
    
    
    
    // [self rightSideMenuButtonPressed];
    
    
}





- (void) Refress_Post:(NSNotification *) notification
{
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_EDU_POST_API) withObject:nil afterDelay:0.5];
    
}


- (void) Filter_Post:(NSNotification *) notification
{
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Filter_API:) withObject:notification.object afterDelay:0.5];
    
}


#pragma mark - -*********************
#pragma mark Call Student_API Method
#pragma mark - -*********************


-(void)CallTheServer_Filter_API:(NSMutableDictionary *)dict_values
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSString *responseString = [API makeCallPostData_ALLs:dict_values:[NSString stringWithFormat:@"%@picture_diary/get_filtered_posts",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        NSLog(@"dict====>%@",dict);
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            [tableViewm reloadData];
            
        }else if([[dict valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
        }
        
    }
    
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
        
    }
    
    
    [refreshControl endRefreshing];
    
    [self mStopIndicater];
    
    
}


-(void)Top_Left_background_action
{
    EDU_Blog_Post_ViewController *objEDU_Blog_Post_ViewController=[[EDU_Blog_Post_ViewController alloc]init];
    [self.navigationController pushViewController:objEDU_Blog_Post_ViewController animated:YES];
    
}

-(void)Filter_action
{
    EDU_Blog_Filter_ViewController *objSetting_ViewController=[[EDU_Blog_Filter_ViewController alloc]init];
    // objSetting_ViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:objSetting_ViewController];
    
    [self presentViewController:HomeNavController animated:YES completion:nil];
}


-(void)Navigation_bar
{
    user_pic = [[UIImageView alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"USR_image"]]);
    [user_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"USR_image"]]]
                placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    
    //   user_pic.frame=CGRectMake(50, 0, 30, 30);
    CGSize size = CGSizeMake(30, 30);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11){
        
        [user_pic setImage: [ImageCustomClass image:user_pic.image resize:size]];
        
    } else {
        
        user_pic.frame=CGRectMake(0, 0, size.width, size.height);
        
    }
    
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
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Edu Blog" value:@"" table:nil];
    
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    CGSize size1;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=11){
        size1 = CGSizeMake(20, 20);
    } else {
        size1 = CGSizeMake(30, 30);
    }
    
    UIImage *butImage = [ImageCustomClass image:[UIImage imageNamed:@"back-2"] resize:size1];
    
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


- (void) REfress_EDU_Home:(NSNotification *) notification
{
    search.placeholder=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Search" value:@"" table:nil];
    Left_Publish_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Create" value:@"" table:nil];
    Right_Publish_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Post" value:@"" table:nil];
    Filter_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Filter" value:@"" table:nil];
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_EDU_POST_API) withObject:nil afterDelay:0.5];
    [self Navigation_bar];
    
}


#pragma mark - -*********************
#pragma mark ViewDidLoad Method
#pragma mark - -*********************
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self Navigation_bar];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(REfress_EDU_Home:)
                                                 name:@"REfress_EDU_Home"
                                               object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Filter_Post:)
                                                 name:@"Filter_Post"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Refress_Post:)
                                                 name:@"Refress_Post"
                                               object:nil];
    
    
    
    
    
    
    msearch_STR=@"";
    
    
    
    //////////////////// Search Bar \\\\\\\\\\\\\\
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    
    
    //////////////////// TopView Main background Lable\\\\\\\\\\\\\\
    
    Top_Main_Show_color=[[UIView alloc]init];
    Top_Main_Show_color.backgroundColor=[UIColor clearColor];
    Top_Main_Show_color.userInteractionEnabled=YES;
    Top_Main_Show_color.frame=CGRectMake(0,0, self.view.frame.size.width, 144);
    //  [self.view addSubview:Top_Main_Show_color];
    
    
    
    search = [[UISearchBar alloc] init];
    search.frame = CGRectMake(0,0, self.view.frame.size.width,50);
    search.placeholder=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Search" value:@"" table:nil];
    search.delegate = self;
    search.layer.borderColor=[UIColor clearColor].CGColor;
    
    search.barTintColor = [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0]; // Are these the same effect?
    [search setTintColor:[UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0]];
    [Top_Main_Show_color addSubview:search];
    
    //////////////////// dismissKeyboard\\\\\\\\\\\\\\
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    
    //////////////////// TopView Main background Lable\\\\\\\\\\\\\\
    
    Top_Main_background_color=[[UIView alloc]init];
    Top_Main_background_color.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    Top_Main_background_color.userInteractionEnabled=YES;
    Top_Main_background_color.frame=CGRectMake(0, search.frame.origin.y+search.frame.size.height, self.view.frame.size.width, 100);
    [Top_Main_Show_color addSubview:Top_Main_background_color];
    
    
    
    
    
    
    
    //////////////////// TopView Left background Lable\\\\\\\\\\\\\\
    
    Top_Left_background_color=[[UIView alloc]init];
    Top_Left_background_color.userInteractionEnabled=YES;
    Top_Left_background_color.backgroundColor=[UIColor colorWithRed:214.0f/255.0f green:106.0f/255.0f blue:154.0f/255.0f alpha:1.0];
    Top_Left_background_color.userInteractionEnabled=YES;
    Top_Left_background_color.frame=CGRectMake(0, 0, Top_Main_background_color.frame.size.width/2, 55);
    [Top_Main_background_color addSubview:Top_Left_background_color];
    
    
    
    UITapGestureRecognizer *Top_Left_background_action = [[UITapGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(Top_Left_background_action)];
    
    [Top_Left_background_color addGestureRecognizer:Top_Left_background_action];
    
    
    
    ////////////////////  Left_Publish  Lable\\\\\\\\\\\\\\
    
    
    Left_Publish_LB=[[UILabel alloc]init];
    Left_Publish_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    Left_Publish_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Create" value:@"" table:nil];
    Left_Publish_LB.frame=CGRectMake(Top_Left_background_color.frame.size.width-80,(Top_Left_background_color.frame.size.height-25)/2,50, 25);
    Left_Publish_LB.textColor=[UIColor whiteColor];
    // Left_Publish_LB.layer.cornerRadius=5;
    //Left_Publish_LB.clipsToBounds = YES;
    Left_Publish_LB.font=[Font_Face_Controller opensansLight:11];
    Left_Publish_LB.textAlignment=NSTextAlignmentCenter;
    [Top_Left_background_color addSubview:Left_Publish_LB];
    
    //////////////////  Left Image  Lable\\\\\\\\\\\\\\
    
    
    Left_Image=[[UIImageView alloc]init];
    Left_Image.image=[UIImage imageNamed:@"plus.png"];
    Left_Image.frame=CGRectMake((Left_Publish_LB.frame.origin.x-32)-20,(Top_Left_background_color.frame.size.height-32)/2,32, 32);
    [Top_Left_background_color addSubview:Left_Image];
    
    
    
    //////////////////// TopView Right background Lable\\\\\\\\\\\\\\
    
    Top_right_background_color=[[UIView alloc]init];
    Top_right_background_color.backgroundColor=[UIColor clearColor];
    Top_right_background_color.userInteractionEnabled=YES;
    Top_right_background_color.frame=CGRectMake(Top_Main_background_color.frame.size.width/2, 0, Top_Main_background_color.frame.size.width/2, 55);
    [Top_Main_background_color addSubview:Top_right_background_color];
    
    
    
    
    
    
    
    
    //////////////////  Right Image  Lable\\\\\\\\\\\\\\
    
    
    Right_Image=[[UIImageView alloc]init];
    Right_Image.image=[UIImage imageNamed:@"Edu-Blog.png"];
    
    
    Right_Image.frame=CGRectMake(30,(Top_right_background_color.frame.size.height-32)/2,32, 32);
    [Top_right_background_color addSubview:Right_Image];
    
    
    ////////////////////  Right Publish  Lable\\\\\\\\\\\\\\
    
    
    Right_Publish_LB=[[UILabel alloc]init];
    Right_Publish_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    Right_Publish_LB.frame=CGRectMake(Right_Image.frame.origin.x+Right_Image.frame.size.width+20,(Top_right_background_color.frame.size.height-25)/2,50, 25);
    Right_Publish_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Post" value:@"" table:nil];
    Right_Publish_LB.textColor=[UIColor whiteColor];
    Right_Publish_LB.font=[Font_Face_Controller opensansLight:11];
    Right_Publish_LB.textAlignment=NSTextAlignmentCenter;
    [Top_right_background_color addSubview:Right_Publish_LB];
    
    
    
    
    
    
    ////////////////////  Filter_LB   Lable\\\\\\\\\\\\\\
    
    
    Filter_LB=[[UILabel alloc]init];
    Filter_LB.userInteractionEnabled=YES;
    Filter_LB.backgroundColor=[UIColor clearColor];
    Filter_LB.frame=CGRectMake(10,Top_Left_background_color.frame.origin.x+Top_Left_background_color.frame.size.height,self.view.frame.size.width-20, 45);
    Filter_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Filter" value:@"" table:nil];
    Filter_LB.textColor=[UIColor whiteColor];
    Filter_LB.font=[Font_Face_Controller opensanssemibold:13];
    Filter_LB.textAlignment=NSTextAlignmentLeft;
    [Top_Main_background_color addSubview:Filter_LB];
    
    
    UITapGestureRecognizer *Filter_action = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(Filter_action)];
    
    [Filter_LB addGestureRecognizer:Filter_action];
    
    
    
    //////////////////  Right Image  Lable\\\\\\\\\\\\\\
    
    
    btnMenuss = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenuss.frame = CGRectMake(self.view.frame.size.width-40, 62, 30, 30);
    [btnMenuss setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-down"] forState:UIControlStateNormal];
    [btnMenuss setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnMenuss.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:18]];
    [btnMenuss addTarget:self action:@selector(Filter_action) forControlEvents:UIControlEventTouchUpInside];
    
    [Top_Main_background_color addSubview:btnMenuss];
    
    NSLog(@"ha ha ha :-%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]);
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"teacher"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"lärare"]) {
        
    }
    else
    {
        btnMenuss.frame=CGRectMake(self.view.frame.size.width-40, 0, 30, 30);
        Top_Main_Show_color.frame=CGRectMake(0,0, self.view.frame.size.width, 85);
        [Top_right_background_color removeFromSuperview];
        [Top_Left_background_color removeFromSuperview];
        Top_Main_background_color.frame=CGRectMake(0, search.frame.origin.y+search.frame.size.height, self.view.frame.size.width, 30);
        Filter_LB.frame=CGRectMake(10,0,self.view.frame.size.width-20, 30);
        Filter_IMG.frame=CGRectMake((Filter_LB.frame.size.width-7)-10,(Filter_LB.frame.size.height-4)/2,7, 4);
    }
    //////////////////  Table view  Lable\\\\\\\\\\\\\\
    // init table view
    tableViewm = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    tableViewm.delegate = self;
    tableViewm.dataSource = self;
    
    tableViewm.backgroundColor = [UIColor clearColor];
    tableViewm.showsVerticalScrollIndicator=NO;
    tableViewm.tableHeaderView = Top_Main_Show_color;
    // add to canvas
    [self.view addSubview:tableViewm];
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"teacher"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"lärare"]) {
        
        
        
        tableViewm.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        
        
    }
    else
    {
        tableViewm.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [tableViewm addSubview:refreshControl];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_EDU_POST_API) withObject:nil afterDelay:0.5];
    
    
    //
    
}


-(void)refresh
{
    
    
    msearch_STR=@"";
    
    
    
    [self performSelector:@selector(CallTheServer_EDU_POST_API) withObject:nil afterDelay:0.5];
    
    
    
}

-(void)Creat_Post
{
    
}



#pragma mark - -*********************
#pragma mark viewWillAppear Method
#pragma mark - -*********************
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    
    
    
    // [self.navigationItem setHidesBackButton:YES];
    [self Navigation_bar];
    
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
#pragma mark CallTheServer_Login_API Method
#pragma mark - -*********************


-(void)CallTheServer_EDU_POST_API
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        NSLog(@"Request %@",[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&parent_id=%@&device_token_app=%@&description_value=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],msearch_STR,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]);
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&parent_id=%@&device_token_app=%@&description_value=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],msearch_STR,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@picture_diary/posts",[Utilities API_link_url_subDomain]]];
        
        NSLog(@"%@",responseString);
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            NSLog(@"%@",[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"eduBlog_count"]);
            
            
            
            if (![[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"eduBlog_count"]isEqualToString:@"0"] || [[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"eduBlog_count"]isEqualToString:@" "]) {
                
                NSMutableDictionary *dic_values=[[NSMutableDictionary alloc]init];
                
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"USR_CUS_Rid"] forKey:@"USR_CUS_Rid"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"USR_Email"] forKey:@"USR_Email"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"USR_Firstname"] forKey:@"USR_Firstname"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"USR_Lastname"] forKey:@"USR_Lastname"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"USR_image"] forKey:@"USR_image"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"authentication_token"] forKey:@"authentication_token"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"customer_name"] forKey:@"customer_name"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"device_token_app"] forKey:@"device_token_app"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"group_id"] forKey:@"group_id"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"id"] forKey:@"id"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"last_student_id"] forKey:@"last_student_id"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"user_table_id"] forKey:@"user_table_id"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"user_type"] forKey:@"user_type"];
                
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"username"] forKey:@"username"];
                
                [dic_values setValue:@"0" forKey:@"eduBlog_count"];
                [dic_values setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"news_count"] forKey:@"news_count"];
                NSLog(@"%@",dic_values);
                
                
                
                
                
                [[NSUserDefaults standardUserDefaults] setObject:dic_values forKey:@"User"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"REfress_User_panel"
                 object:nil];
                
                
            }
            
            
            
            [tableViewm reloadData];
            
            
            
        }else if([[dict valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
        }
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
    }
    
    
    [refreshControl endRefreshing];
    
    [self mStopIndicater];
    
    
}

#pragma mark - -*********************
#pragma mark TableView HeightForHeader Method
#pragma mark - -*********************

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}





#pragma mark - -*********************
#pragma mark TableView DataSource Method
#pragma mark - -*********************

- (void)viewDidLayoutSubviews {
    [Student_name setContentOffset:CGPointZero animated:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeader = [[UIView alloc] init];
    sectionHeader.frame=CGRectMake(0, 0,tableViewm.frame.size.width, 35);
    sectionHeader.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    
    
    Student_name = [[UITextView alloc] initWithFrame:CGRectMake(0, 0,tableViewm.frame.size.width-90, 20)];
    Student_name.backgroundColor = [Text_color_ EDU_Blog_Color_code];
    Student_name.font = [Font_Face_Controller opensanssemibold:13];
    Student_name.tag=section-1;
    Student_name.editable = NO;
    //    Student_name.backgroundColor = [UIColor redColor];
    
    //    Student_name.contentInset = UIEdgeInsetsMake(0,0,0,0);
    //    Student_name.scrollEnabled = NO;
    
    
    [Student_name setTextContainerInset:UIEdgeInsetsZero];
    Student_name.textContainer.lineFragmentPadding = 0;
    
    //    CGPoint p = [Student_name contentOffset];
    //    Student_name.text = terms;
    //    [Student_name setContentOffset:p animated:NO];
    //    [Student_name scrollRangeToVisible:NSMakeRange([tv.text length], 0)];
    
    
    NSLog(@"%@",[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"category"]);
    
    NSLog(@"%ld",(long)section);
    
    if ([[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"category"]isEqualToString:@"student"]) {
        
        
        if ([[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"students"]count]>=2) {
            
            Student_name.text =[NSString stringWithFormat:@"%@#  %@# %@",[[[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"students"]objectAtIndex:0]valueForKey:@"name"]stringByConvertingHTMLToPlainText],[[[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"students"]objectAtIndex:1]valueForKey:@"name"]stringByConvertingHTMLToPlainText],@"..."];
            
            // Student_name.text = @"More";
            
            
        }
        else
        {
            if ([[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"students"]count]>=2) {
                
                
                Student_name.text =[NSString stringWithFormat:@"%@#  %@#",[[[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"students"]objectAtIndex:0]valueForKey:@"name"]stringByConvertingHTMLToPlainText],[[[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"students"]objectAtIndex:1]valueForKey:@"name"]stringByConvertingHTMLToPlainText]];
                
            }
            else
            {
                
                Student_name.text =[NSString stringWithFormat:@"%@#", [[[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"students"]objectAtIndex:0]valueForKey:@"name"]stringByConvertingHTMLToPlainText]];
            }
            
        }
        
        
        //        [Student_name scrollRangeToVisible:NSMakeRange(0, 0)];
    }
    
    else if  ([[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"category"]isEqualToString:@"class"]) {
        
        if ([[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"groups"]count]==0) {
            
            
            
            Student_name.text = [NSString stringWithFormat:@"%@#",[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"category"]stringByConvertingHTMLToPlainText]];
            
        }
        else
        {
            
            
            if ([[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"groups"]count]>=3) {
                
                Student_name.text =[NSString stringWithFormat:@"%@#  %@# %@",[[[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"groups"]objectAtIndex:0]valueForKey:@"name"]stringByConvertingHTMLToPlainText],[[[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"groups"]objectAtIndex:1]valueForKey:@"name"]stringByConvertingHTMLToPlainText],@"More"];
                
                // Student_name.text = @"More";
                
                
            }
            else
            {
                if ([[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"groups"]count]>=2) {
                    
                    
                    Student_name.text =[NSString stringWithFormat:@"%@#  %@#",[[[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"groups"]objectAtIndex:0]valueForKey:@"name"]stringByConvertingHTMLToPlainText],[[[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"groups"]objectAtIndex:1]valueForKey:@"name"]stringByConvertingHTMLToPlainText]];
                    
                }
                else
                {
                    
                    Student_name.text = [NSString stringWithFormat:@"%@#",[[[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"groups"]objectAtIndex:0]valueForKey:@"name"]stringByConvertingHTMLToPlainText]];
                }
                
            }
            
            
        }
        
    }
    
    else
    {
        Student_name.text = [NSString stringWithFormat:@"%@#",[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"category"]stringByConvertingHTMLToPlainText]];
        
    }
    
    
    Student_name.textAlignment = NSTextAlignmentLeft;
    Student_name.textColor=[UIColor whiteColor];
    
    [sectionHeader addSubview:Student_name];
    
    
    
    UILabel *Tearch_name = [[UILabel alloc] initWithFrame:CGRectMake(7, Student_name.frame.origin.y+Student_name.frame.size.height-2, tableViewm.frame.size.width-100, 15)];
    Tearch_name.backgroundColor = [Text_color_ EDU_Blog_Color_code];
    Tearch_name.font = [Font_Face_Controller opensansregular:10];
    Tearch_name.text = [NSString stringWithFormat:@"%@ %@",[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"teacher_name"]stringByConvertingHTMLToPlainText],[[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"created"]stringByConvertingHTMLToPlainText]];
    Tearch_name.textAlignment = NSTextAlignmentLeft;
    Tearch_name.textColor=[UIColor whiteColor];
    [sectionHeader addSubview:Tearch_name];
    
    
    
    
    if (![[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"associated_curriculum_tags"]count]==0) {
        
        
        //////////////////  Edit_IMG Image  Lable\\\\\\\\\\\\\\
        
        
        cap_IMGs=[[UIImageView alloc]init];
        cap_IMGs.image=[UIImage imageNamed:@"topi.png"];
        cap_IMGs.frame=CGRectMake(tableViewm.frame.size.width-75,(sectionHeader.frame.size.height-25)/2,25, 25);
        cap_IMGs.userInteractionEnabled=YES;
        cap_IMGs.tag=section;
        [sectionHeader addSubview:cap_IMGs];
        
        
        
        UITapGestureRecognizer * cap_IMG_URL = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector( cap_IMG_action:)];
        
        
        [cap_IMGs addGestureRecognizer: cap_IMG_URL];
        
        
        
    }
    
    
    
    
    if (([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"teacher"] ||[[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"lärare"]) && [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"]isEqualToString:[[[dict valueForKey:@"posts"]objectAtIndex:section]valueForKey:@"user_id"]]) {
        
        UIImageView *Edit_IMG=[[UIImageView alloc]init];
        Edit_IMG.image=[UIImage imageNamed:@"pen.png"];
        Edit_IMG.frame=CGRectMake(tableViewm.frame.size.width-35,(sectionHeader.frame.size.height-25)/2,25, 25);
        Edit_IMG.userInteractionEnabled=YES;
        Edit_IMG.tag=section;
        
        [sectionHeader addSubview:Edit_IMG];
        
        
        UITapGestureRecognizer * Edit_IMG_URL = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector( Edit_IMG_action:)];
        
        
        [Edit_IMG addGestureRecognizer: Edit_IMG_URL];
        
        
    }
    else
    {
        cap_IMGs.frame=CGRectMake(tableViewm.frame.size.width-35,(sectionHeader.frame.size.height-25)/2,25, 25);
    }
    
    
    //      [Student_name setContentOffset:CGPointZero animated:NO];
    
    return sectionHeader;
    
    
}


- (void) Edit_IMG_action: (UITapGestureRecognizer *)recognizer
{
    
    UIView *view = recognizer.view; //cast pointer to the derived class if needed
    NSLog(@"%d", view.tag);
    
    
    Edit_Post__ViewController *obj_Edit_Post=[[Edit_Post__ViewController alloc]init];
    obj_Edit_Post.post_id=[[[dict valueForKey:@"posts"]objectAtIndex:view.tag]valueForKey:@"id"];
    
    [self.navigationController pushViewController:obj_Edit_Post animated:YES];
    
    
}

- (void) cap_IMG_action: (UITapGestureRecognizer *)recognizer
{
    
    UIView *view = recognizer.view; //cast pointer to the derived class if needed
    NSLog(@"%d", view.tag);
    
    
    
    
    NSLog(@"%@",[[[dict valueForKey:@"posts"]objectAtIndex:view.tag]valueForKey:@"associated_curriculum_tags"]);
    
    
    
    Curriculum_Tags_ViewController *objCurriculum_Tags_ViewController=[[Curriculum_Tags_ViewController alloc]init];
    objCurriculum_Tags_ViewController.dict=[[dict valueForKey:@"posts"]objectAtIndex:view.tag];
    
    [self.navigationController pushViewController:objCurriculum_Tags_ViewController animated:YES];
    
    
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"indexPath.row %ld", indexPath.row);
    CGSize labelHeight = [self heigtForCellwithString:[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"description"] stringByConvertingHTMLToPlainText]    withFont:[Font_Face_Controller opensansregular:11]];
    
    //////////////// No files no test ///////////////////
    
    if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && [[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 && [[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0 &&[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"description"]isEqualToString:@""])
    {
        labelHeight.height = labelHeight.height+90;
    }
    
    
    
    //////////////// images and videos and random_files ///////////////////
    
    else  if (![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && ![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 && ![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        
        if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==1) {
            
            labelHeight.height = labelHeight.height+50;
            
        }
        else
        {
            labelHeight.height = labelHeight.height+60;
        }
        
        
    }
    
    
    //////////////// No files  ///////////////////
    
    else  if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && [[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 && [[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0 )
    {
        NSLog(@"%ld", (long)indexPath.section);
        if (labelHeight.height<200){
            labelHeight.height = labelHeight.height+90;
        }else{
            labelHeight.height = labelHeight.height+150;
            
        }
        
        // labelHeight.height = labelHeight.height+150;
    }
    //////////////// images and videos ///////////////////
    
    else if (![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && ![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 &&[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        labelHeight.height = labelHeight.height+380;
        
    }
    
    //////////////// videos and random_files ///////////////////
    
    
    else if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && ![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 && ![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        
        if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==1)
        {
            
            labelHeight.height = labelHeight.height+250;
        }
        else
        {
            labelHeight.height = labelHeight.height+260;
        }
        
        
    }
    
    
    ////////////////  videos ///////////////////
    
    else if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && ![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 &&[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        labelHeight.height = labelHeight.height+220;
        
    }
    
    
    ////////////////  images and  random_files///////////////////
    
    
    else if (![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && [[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 &&![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        
        
        //        if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==1)
        //        {
        //
        labelHeight.height = labelHeight.height+340;
        //        }
        //        else
        //        {
        //             labelHeight.height = labelHeight.height+260;
        //        }
        
        
        
        
    }
    
    
    ////////////////  images ///////////////////
    
    else if (![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && [[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 &&[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        if (labelHeight.height<50){
            labelHeight.height = labelHeight.height+225;
        }else{
            labelHeight.height = labelHeight.height+380;
            
        }
        
    }
    
    
    else if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && ![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 &&[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        labelHeight.height = labelHeight.height+215;
        
    }
    
    else if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && [[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 &&![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        
        if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==1)
        {
            
            labelHeight.height = labelHeight.height+200;
        }
        else
        {
            labelHeight.height = labelHeight.height+105;
        }
        
    }
    
    
    else if (![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        NSLog(@"have random");
        labelHeight.height = labelHeight.height+380;
        
    }
    
    else if (![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0)
    {
        NSLog(@"have iamge");
        
        labelHeight.height = labelHeight.height+225;
        
    }
    
    else if (![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0)
    {
        labelHeight.height = labelHeight.height+205;
        
    }
    else
    {
        labelHeight.height = labelHeight.height+65;
        
    }
    
    
    
    return labelHeight.height; // the return height + your other view height
}

-(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont *)font{
    
    CGSize constraint = CGSizeMake(tableViewm.frame.size.width,9999); // Replace 300 with your label width
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    rect.size = CGSizeMake(rect.size.width, rect.size.height +2);
    
    return rect.size;
    
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return [[dict valueForKey:@"posts"]count];
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    
    
    
    
    
    description=[[UITextView alloc]init];
    description.backgroundColor=[UIColor clearColor];
    description.text=[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"description"];
    //    description.numberOfLines = 0;
    description.frame=CGRectMake(5, 5, tableViewm.frame.size.width-10, 40);
    
    
    description.textColor=[UIColor blackColor];
    description.font=[Font_Face_Controller opensansLight:11];
    description.textAlignment=NSTextAlignmentCenter;
    description.editable = NO;
    [description sizeToFit];
    [cell.contentView addSubview:description];
    
    
    
    if (![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0)
    {
        
        //create the scrollview with specific frame
        scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, description.frame.origin.y+description.frame.size.height,[[UIScreen mainScreen]bounds].size.width, 150)];
        scrollView.userInteractionEnabled=YES;
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        scrollView.tag=indexPath.row;
        //array for views to add to the scrollview
        scrollView_views = [[NSMutableArray alloc] init];
        scrollView.backgroundColor=[UIColor clearColor];
        //array for colors of views
        
        
        
        
        
        
        for (int i = 0; i <[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]; i++) {
            
            
            
            Demoimg=[[UIImageView alloc]init];
            Demoimg.userInteractionEnabled=YES;
            Demoimg.frame=CGRectMake(0,20,scrollView.frame.size.width, 110);
            Demoimg.contentMode = UIViewContentModeScaleAspectFit;
            
            __block UIActivityIndicatorView *activityIndicatorsss = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            CGRect frame = activityIndicatorsss.frame;
            frame.origin.x = (Demoimg.frame.size.width- frame.size.width )/ 2;
            frame.origin.y = ((Demoimg.frame.size.height+30)-frame.size.height)  / 2;
            activityIndicatorsss.frame = frame;
            activityIndicatorsss.hidesWhenStopped = YES;
            Demoimg.backgroundColor=[UIColor colorWithRed:197.0/255.0f green:197.0/255.0f blue:197.0/255.0f alpha:0.4];
            [Demoimg addSubview:activityIndicatorsss];
            [activityIndicatorsss startAnimating];
            
            
            
            NSURL *uris = [NSURL URLWithString:[Utilities API_link_url_subDomain_for_IMG:[[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]objectAtIndex:i]valueForKey:@"id"]]];
            
            
            NSLog(@"BhushaN_IMG%@",[Utilities API_link_url_subDomain_for_IMG:[[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]objectAtIndex:i]valueForKey:@"id"]]);
            
            
            [Demoimg sd_setImageWithURL:uris placeholderImage:nil completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType,NSURL *imageUrl){
                if (image) {
                    
                    Demoimg.backgroundColor=[UIColor whiteColor];
                    
                    [activityIndicatorsss stopAnimating];
                    [activityIndicatorsss removeFromSuperview];
                    
                }
            }];
            
            
            Demoimg.tag=indexPath.section;
            
            [scrollView_views addObject:Demoimg];
            
            UITapGestureRecognizer *image_URL = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(Full_image_action:)];
            
            [Demoimg addGestureRecognizer:image_URL];
            
        }
        
        
        //add pages to scrollview
        [scrollView addPages:scrollView_views];
        
        //add scrollview to the view
        [cell.contentView addSubview:scrollView];
        
        
        if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]>=2)
        {
            
            [scrollView setHasPageControl:YES];
            
        }
        
    }
    
    else
    {
        scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, description.frame.origin.y+description.frame.size.height-5,[[UIScreen mainScreen]bounds].size.width,0)];
        [cell.contentView addSubview:scrollView];
    }
    
    
    NSLog(@"%f",scrollView.frame.origin.y);
    
    
    
    if (![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0)
    {
        
        
        
        
        //create the scrollview with specific frame
        scrollView_Vedio = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, scrollView.frame.origin.y+scrollView.frame.size.height+10,tableViewm.frame.size.width, 150)];
        [scrollView_Vedio setShowsHorizontalScrollIndicator:NO];
        [scrollView_Vedio setShowsVerticalScrollIndicator:NO];
        scrollView_Vedio.userInteractionEnabled=YES;
        scrollView_Vedio.tag=indexPath.row;
        //array for views to add to the scrollview
        scrollView_views__Vedio = [[NSMutableArray alloc] init];
        //scrollView_views__Vedio.backgroundColor=[UIColor clearColor];
        //array for colors of views
        
        
        
        for (int i = 0; i <[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]; i++) {
            Demoimg__Vedio=[[UIImageView alloc]init];
            Demoimg__Vedio.userInteractionEnabled=YES;
            Demoimg__Vedio.frame=CGRectMake(0,20,scrollView_Vedio.frame.size.width, 110);
            // Demoimg__Vedio.contentMode=UIViewContentModeScaleAspectFill;
            Demoimg__Vedio.contentMode = UIViewContentModeScaleAspectFit;
            
            //            [Demoimg__Vedio sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]objectAtIndex:i]valueForKey:@"imagename"]]]
            //                       placeholderImage:[UIImage imageNamed:@"images.jpeg"]];
            
            
            
            
            
            __block UIActivityIndicatorView *activityIndicators = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            CGRect frame = activityIndicators.frame;
            frame.origin.x = (Demoimg__Vedio.frame.size.width- frame.size.width )/ 2;
            frame.origin.y = ((Demoimg__Vedio.frame.size.height+30)-frame.size.height)  / 2;
            activityIndicators.frame = frame;
            activityIndicators.hidesWhenStopped = YES;
            Demoimg__Vedio.backgroundColor=[UIColor colorWithRed:197.0/255.0f green:197.0/255.0f blue:197.0/255.0f alpha:0.4];
            [Demoimg__Vedio addSubview:activityIndicators];
            [activityIndicators startAnimating];
            
            
            
            NSURL *uris = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]objectAtIndex:i]valueForKey:@"imagename"]]];
            
            
            
            
            [Demoimg__Vedio sd_setImageWithURL:uris placeholderImage:nil completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType,NSURL *imageUrl){
                if (image) {
                    [activityIndicators stopAnimating];
                    [activityIndicators removeFromSuperview];
                    Demoimg__Vedio.backgroundColor=[UIColor clearColor];
                    
                }
            }];
            
            
            Demoimg__Vedio.tag=[[[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]objectAtIndex:i]valueForKey:@"id"]integerValue];
            
            //   Demoimg__Vedio.tag=i+5;
            
            
            
            [scrollView_views__Vedio addObject:Demoimg__Vedio];
            
            
            
            //////////////////// Save_Draft No Button\\\\\\\\\\\\\\
            
            Play_BTN = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            Play_BTN.tag=[[[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]objectAtIndex:i]valueForKey:@"id"]integerValue];
            Play_BTN.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.4];
            [Play_BTN setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-play"] forState:UIControlStateNormal];
            [Play_BTN.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:18]];
            [Play_BTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            Play_BTN.frame = CGRectMake((scrollView_Vedio.frame.size.width-45)/2,(scrollView_Vedio.frame.size.height-45)/2,45, 45);
            Play_BTN.layer.cornerRadius=45*0.5;
            Play_BTN.clipsToBounds=YES;
            [Demoimg__Vedio addSubview:Play_BTN];
            
            
            UITapGestureRecognizer *videos_URL = [[UITapGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(videos_action:)];
            
            
            [Demoimg__Vedio addGestureRecognizer:videos_URL];
            
            
            
            UITapGestureRecognizer *videos_URLs = [[UITapGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(videos_action:)];
            
            
            [Play_BTN addGestureRecognizer:videos_URLs];
            
            
            
            
        }
        
        
        //add pages to scrollview
        [scrollView_Vedio addPages:scrollView_views__Vedio];
        
        //add scrollview to the view
        [cell.contentView addSubview:scrollView_Vedio];
        
        
        if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]>=2)
        {
            
            [scrollView_Vedio setHasPageControl:YES];
            
        }
        
        
        
        
        
    }
    else
    {
        scrollView_Vedio = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, scrollView.frame.origin.y+scrollView.frame.size.height+10,tableViewm.frame.size.width, 0)];
        
    }
    
    
    
    
    
    if (![[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        
        NSInteger Sframe=scrollView_Vedio.frame.origin.y+scrollView_Vedio.frame.size.height+10;
        
        
        
        if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==1) {
            
            
            
            download_IMG=[[UIImageView alloc]init];
            download_IMG.frame=CGRectMake(8, Sframe+3, 15, 15);
            download_IMG.image=[UIImage imageNamed:@"down_arrow_grey.png"];
            [cell.contentView addSubview:download_IMG];
            
            number_of_random_files=[[UILabel alloc]init];
            number_of_random_files.frame=CGRectMake(20,Sframe, 300, 15);
            number_of_random_files.tag=indexPath.row;
            number_of_random_files.text=[[[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]objectAtIndex:0]valueForKey:@"random_file_name"]stringByConvertingHTMLToPlainText];
            
            number_of_random_files.tag=[[[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]objectAtIndex:0]valueForKey:@"id"]integerValue];
            
            number_of_random_files.font=[Font_Face_Controller opensansregular:13];
            number_of_random_files.textColor=[UIColor grayColor];
            
            number_of_random_files.userInteractionEnabled=YES;
            
            
            
            
            [cell.contentView addSubview:number_of_random_files];
            
            UITapGestureRecognizer *random_file = [[UITapGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(random_file_action:)];
            
            
            [number_of_random_files addGestureRecognizer:random_file];
            
            
        }
        else
        {
            
            for (int s=0; s<=1; s++) {
                
                
                download_IMG=[[UIImageView alloc]init];
                download_IMG.frame=CGRectMake(8, Sframe+3, 15, 15);
                download_IMG.image=[UIImage imageNamed:@"down_arrow_grey.png"];
                [cell.contentView addSubview:download_IMG];
                
                
                number_of_random_files=[[UILabel alloc]init];
                number_of_random_files.frame=CGRectMake(20,Sframe, 300, 10);
                number_of_random_files.tag=s;
                number_of_random_files.text=[[[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]objectAtIndex:s]valueForKey:@"random_file_name"]stringByConvertingHTMLToPlainText];
                
                
                number_of_random_files.tag=[[[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]objectAtIndex:s]valueForKey:@"id"]integerValue];
                
                
                number_of_random_files.font=[Font_Face_Controller opensansregular:13];
                number_of_random_files.textColor=[UIColor grayColor];
                number_of_random_files.userInteractionEnabled=YES;
                
                
                [cell.contentView addSubview:number_of_random_files];
                
                Sframe=Sframe+15;
                
                
                UITapGestureRecognizer *random_file = [[UITapGestureRecognizer alloc]
                                                       initWithTarget:self
                                                       action:@selector(random_file_action:)];
                
                
                [number_of_random_files addGestureRecognizer:random_file];
                
                
            }
        }
        
        
        
        
    }
    else
    {
        number_of_random_files=[[UILabel alloc]init];
        number_of_random_files.frame=CGRectMake(20,scrollView_Vedio.frame.origin.y+scrollView_Vedio.frame.size.height,300, 0);
    }
    
    
    
    Like=[UIButton buttonWithType:UIButtonTypeCustom];
    Like.frame=CGRectMake(7,number_of_random_files.frame.origin.y+number_of_random_files.frame.size.height+12, 16, 16);
    
    if ([[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"already_liked"] isEqualToString:@"no"]) {
        
        [Like setBackgroundImage:[UIImage imageNamed:@"unlike.png"] forState:UIControlStateNormal];
        
    }
    
    else
    {
        [Like setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
    }
    
    Like.backgroundColor=[UIColor clearColor];
    Like.tag=indexPath.section;
    [Like addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:Like];
    
    
    number_of_like =[[UILabel alloc]init];
    number_of_like.frame =CGRectMake(Like.frame.origin.x+Like.frame.size.width+5, number_of_random_files.frame.origin.y+number_of_random_files.frame.size.height+12, 16,16);
    
    number_of_like.textAlignment=NSTextAlignmentCenter;
    number_of_like.textColor=[UIColor grayColor];
    
    number_of_like.font = [Font_Face_Controller opensansregular:13];
    number_of_like.text=[[[[dict valueForKey:@"posts"]objectAtIndex:indexPath.section]valueForKey:@"picture_diary_like_count"]stringByConvertingHTMLToPlainText];
    number_of_like.adjustsFontSizeToFitWidth=YES;
    number_of_like.minimumScaleFactor=0.5;
    [cell.contentView addSubview:number_of_like];
    
    cell.backgroundColor=[UIColor whiteColor];
    
    return cell;
}

- (void) Full_image_action: (UITapGestureRecognizer *)recognizer
{
    
    UIView *view = recognizer.view; //cast pointer to the derived class if needed
    NSLog(@"index_path:---->>>> %d", view.tag);
    
    NSLog(@"images:---->>>> %@",[[[dict valueForKey:@"posts"]objectAtIndex:view.tag]valueForKey:@"images"]);
    
    NSLog(@"images:---->>>> %@",[[[[dict valueForKey:@"posts"]objectAtIndex:view.tag]valueForKey:@"images"]valueForKey:@"id"]);
    //
    photos = [[NSMutableArray alloc] init];
    thumbs = [[NSMutableArray alloc] init];
    MWPhoto *photo, *thumb;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = YES;
    BOOL autoPlayOnAppear = NO;
    
    array_With_Image_Of_Each_Tag = [NSMutableArray array];
    
    for (int i = 0; i <[[[[dict valueForKey:@"posts"]objectAtIndex:view.tag]valueForKey:@"images"]count]; i++) {
        
        
        photo = [MWPhoto photoWithURL:[NSURL URLWithString:[Utilities API_link_url_subDomain_for_IMG:[[[[[dict valueForKey:@"posts"]objectAtIndex:view.tag]valueForKey:@"images"]objectAtIndex:i]valueForKey:@"id"]]]];
        array_With_Image_Of_Each_Tag = [[[dict valueForKey:@"posts"]objectAtIndex:view.tag]valueForKey:@"images"];
        [photos addObject:photo];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[Utilities API_link_url_subDomain_for_IMG:[[[[[dict valueForKey:@"posts"]objectAtIndex:view.tag]valueForKey:@"images"]objectAtIndex:i]valueForKey:@"id"]]]]];
        
        
        
    }
    
    self.photos = photos;
    self.thumbs = thumbs;
    
    // Create browser
    browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:0];
    
    
    UIButton *btnName = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btnName setFrame:CGRectMake(0, 0, 23, 21)];
    
    [btnName setBackgroundImage:[UIImage imageNamed:@"do wn_arrow_grey.png"] forState:UIControlStateNormal];
    
    [btnName addTarget:self action:@selector(downloadButtonClickedInPhotoViewer) forControlEvents:UIControlEventTouchUpInside];
    
    //    browser.actionButton = [[UIBarButtonItem alloc] initWithCustomView:btnName];
    
    // Test custom selection images
    //    browser.customImageSelectedIconName = @"ImageSelected.png";
    //    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    
    // Reset selections
    if (displaySelectionButtons) {
        
        _selections = [NSMutableArray new];
        for (int i = 0; i < photos.count; i++) {
            [_selections addObject:[NSNumber numberWithBool:NO]];
        }
        
    }
    
    // Show
    
    // Push
    [self.navigationController pushViewController:browser animated:YES];
    // [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Test reloading of data after delay
    double delayInSeconds = 3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        //        // Test removing an object
        //        [_photos removeLastObject];
        //        [browser reloadData];
        //
        //        // Test all new
        //        [_photos removeAllObjects];
        //        [_photos addObject:[MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"photo3" ofType:@"jpg"]]];
        //        [browser reloadData];
        //
        //        // Test changing photo index
        //        [browser setCurrentPhotoIndex:9];
        
        //        // Test updating selections
        //        _selections = [NSMutableArray new];
        //        for (int i = 0; i < [self numberOfPhotosInPhotoBrowser:browser]; i++) {
        //            [_selections addObject:[NSNumber numberWithBool:YES]];
        //        }
        //        [browser reloadData];
        
    });
    
    
}


#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < photos.count)
        return [photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < thumbs.count)
        return [thumbs objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    indexOf_Image_viewed = index;
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) downloadButtonClickedInPhotoViewer
{
    //    CGImageRef imageToDownload = [[photos objectAtIndex:0] CGImage];
    
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        //
        //        loader_image=[ELR_loaders_ Start_loader:CGRectMake(([[UIScreen mainScreen]bounds].size.width-85)/2,[[UIScreen mainScreen]bounds].size.height/2,85,85)];
        //        [browser addSubview:loader_image];
        
        
        NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[Utilities API_link_url_subDomain_for_IMG:[[array_With_Image_Of_Each_Tag objectAtIndex:indexOf_Image_viewed]valueForKey:@"id"]]]];
        
        UIImage *imageToBeSaved = [[UIImage alloc]initWithData:imageData];
        
        UIImageWriteToSavedPhotosAlbum(imageToBeSaved, nil, nil, nil);
        
        dispatch_async( dispatch_get_main_queue(), ^{
            UIAlertView * downloadAlert = [[UIAlertView alloc]initWithTitle:@"Downloaded" message:@"Image saved to Camera roll" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [downloadAlert show];
            //            [loader_image removeFromSuperview];
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
        });
    });
    
    //     UIImage* uiImage = [[UIImage alloc] initWithCGImage:(imageToDownload)];
    //
    //    NSData *imageData = UIImagePNGRepresentation(uiImage);
    
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentsDirectory = [paths objectAtIndex:0];
    //
    //    NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"cached"]];
    //
    //    NSLog(@"pre writing to file");
    //    if (![imageData writeToFile:imagePath atomically:NO])
    //    {
    //        NSLog(@"Failed to cache image data to disk");
    //    }
    //    else
    //    {
    //        NSLog(@"the cachedImagedPath is %@",imagePath);
    //    }
}
#pragma mark - Load Assets

- (void)loadAssets {
    if (NSClassFromString(@"PHAsset")) {
        
        // Check library permissions
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    [self performLoadAssets];
                }
            }];
        } else if (status == PHAuthorizationStatusAuthorized) {
            [self performLoadAssets];
        }
        
    } else {
        
        // Assets library
        [self performLoadAssets];
        
    }
}

- (void)performLoadAssets {
    
    // Initialise
    _assets = [NSMutableArray new];
    
    // Load
    if (NSClassFromString(@"PHAsset")) {
        
        // Photos library iOS >= 8
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            PHFetchOptions *options = [PHFetchOptions new];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            PHFetchResult *fetchResults = [PHAsset fetchAssetsWithOptions:options];
            [fetchResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [_assets addObject:obj];
            }];
            if (fetchResults.count > 0) {
                //  [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            }
        });
        
    } else {
        
        // Assets Library iOS < 8
        _ALAssetsLibrary = [[ALAssetsLibrary alloc] init];
        
        // Run in the background as it takes a while to get all assets from the library
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
            NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc] init];
            
            // Process assets
            void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result != nil) {
                    NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                    if ([assetType isEqualToString:ALAssetTypePhoto] || [assetType isEqualToString:ALAssetTypeVideo]) {
                        [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                        NSURL *url = result.defaultRepresentation.url;
                        [_ALAssetsLibrary assetForURL:url
                                          resultBlock:^(ALAsset *asset) {
                                              if (asset) {
                                                  @synchronized(_assets) {
                                                      [_assets addObject:asset];
                                                      if (_assets.count == 1) {
                                                          // Added first asset so reload data
                                                          //[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                                      }
                                                  }
                                              }
                                          }
                                         failureBlock:^(NSError *error){
                                             NSLog(@"operation was not successfull!");
                                         }];
                        
                    }
                }
            };
            
            // Process groups
            void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) {
                if (group != nil) {
                    [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetEnumerator];
                    [assetGroups addObject:group];
                }
            };
            
            // Process!
            [_ALAssetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                            usingBlock:assetGroupEnumerator
                                          failureBlock:^(NSError *error) {
                                              NSLog(@"There is an error");
                                          }];
            
        });
        
    }
    
}



- (void) videos_action: (UITapGestureRecognizer *)recognizer
{
    
    self.navigationController.navigationBarHidden = YES;
    
    UIView *view = recognizer.view; //cast pointer to the derived class if needed
    NSLog(@"%d", view.tag);
    
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"SELF.id contains[cd] %@", [NSString stringWithFormat:@"%d",view.tag]];
    NSArray *beginWithB = [[[dict valueForKey:@"posts"] valueForKey:@"videos"] filteredArrayUsingPredicate:namePredicate];
    
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.id contains[cd] %@", [NSString stringWithFormat:@"%d",view.tag]];
    
    NSArray *filtered = [ [beginWithB objectAtIndex:0]
                         filteredArrayUsingPredicate:predicate];
    
    NSLog(@"%@",[filtered valueForKey:@"videoname_mp4"]);
    
    
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[filtered valueForKey:@"videoname_mp4"]objectAtIndex:0]]);
    
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[filtered valueForKey:@"videoname_mp4"]]);
    
    
    
    NSString *uel_STR=[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[filtered valueForKey:@"videoname_mp4"]objectAtIndex:0]];
    
    
    NSLog(@"%@",uel_STR);
    
    
    
    
    
    fileURLForVideo = [NSURL URLWithString:uel_STR];
    
    moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURLForVideo];
    [moviePlayerController.view setFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
    [self.view addSubview:moviePlayerController.view];
    moviePlayerController.fullscreen = NO;
    [moviePlayerController play];
    
    
    [self customVieForHeader];
    
    //    UIButton *pauseButton=[[UIButton alloc]init];
    //    [pauseButton setFrame:CGRectMake(0,0, 50, 50)];
    //    [pauseButton setBackgroundColor:[UIColor yellowColor]];
    //    [pauseButton setTag:123456789];
    //    [pauseButton setAccessibilityValue:@"445"];
    //    [pauseButton setAccessibilityLabel:@"445"];
    //    [pauseButton addTarget:self action:@selector(pauseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:pauseButton];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:nil];
    
    
}


-(void) customVieForHeader
{
    //    UIView * viewForHeader = [UIView view];
    navbarForVideo = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 400, 50)];
    navbarForVideo.translucent = YES;
    
    //do something like background color, title, etc you self
    [self.view addSubview:navbarForVideo];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStylePlain target:self action:@selector(refreshPropertyList:)];
    //    self.navigationItem.rightBarButtonItem = anotherButton;
    
    //    UIBarButtonItem * item1= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"download"] style:UIBarButtonItemStylePlain target:self action:@selector(yourButtonAction1)];
    //    navbar.topItem.rightBarButtonItem = item1;
    
    
    downloadButtonForVideo=[[UIButton alloc]init];
    [downloadButtonForVideo setFrame:CGRectMake(self.view.frame.size.width - 50,15, 30, 30)];
    //    [downloadButton setBackgroundColor:[UIColor yellowColor]];
    //    [downloadButton setImage:[UIImage imageNamed:@"down_arrow_grey"] forState:UIControlStateNormal];
    [downloadButtonForVideo setBackgroundImage: [UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    [downloadButtonForVideo setTag:123456789];
    [downloadButtonForVideo setAccessibilityValue:@"445"];
    [downloadButtonForVideo setAccessibilityLabel:@"445"];
    [downloadButtonForVideo addTarget:self action:@selector(DownloadVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadButtonForVideo];
    
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    //    [button setBackgroundImage:butImage forState:UIControlStateNormal];
    //    [button addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    button.frame = CGRectMake(20, 25, 20, 20);
    //    [button setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    //    [self.view addSubview:button];
    
    
}

-(void)DownloadVideo
{
    //download the file in a seperate thread.
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        NSLog(@"Downloading Started");
    //       // NSString *urlToDownload = @"http://www.somewhere.com/thefile.mp4";
    ////        NSURL  *url = [NSURL URLWithString:urlToDownload];
    //        NSData *urlData = [NSData dataWithContentsOfURL:fileURLForVideo];
    //        if ( urlData )
    //        {
    //            NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //            NSString  *documentsDirectory = [paths objectAtIndex:0];
    //
    //            NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"thefile.mp4"];
    //
    //            //saving is done on main thread
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //                [urlData writeToFile:filePath atomically:YES];
    //                NSLog(@"File Saved !");
    //            });
    //        }
    //
    //    });
    
    
    
    
    //    NSURL *videoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"Your Video Url or Path"]];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    downloadButtonForVideo.enabled = NO;
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(q, ^{
        
        NSData *videoData = [NSData dataWithContentsOfURL:fileURLForVideo];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Write it to cache directory
            NSString *videoPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"file2.mp4"];
            [videoData writeToFile:videoPath atomically:YES];
            
            // After that use this path to save it to PhotoLibrary
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:videoPath] completionBlock:^(NSURL *assetURL, NSError *error)
             {
                 if (error)
                 {
                     NSLog(@"Error");
                 }
                 else
                 {
                     NSLog(@"Success");
                     downloadButtonForVideo.enabled = YES;
                     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                     UIAlertView * successAlert = [[UIAlertView alloc]initWithTitle:@"" message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Video is downloaded to your Photos" value:@"" table:nil] delegate:nil cancelButtonTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil] otherButtonTitles:nil, nil];
                     [successAlert show];
                     //                     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                     //                     NSString *documentsDirectory = [paths objectAtIndex:0];
                     //
                     //                     NSString *sourcePath = [documentsDirectory stringByAppendingPathComponent:@"file2.mp4"];
                     //                     UISaveVideoAtPathToSavedPhotosAlbum(sourcePath,nil,nil,nil);
                     
                 }
                 
             }];
        });
    });
}

-(void)doneButtonClick:(NSNotification*)aNotification{
    
    [moviePlayerController.view removeFromSuperview];
    [navbarForVideo removeFromSuperview];
    [downloadButtonForVideo removeFromSuperview];
    
    self.navigationController.navigationBarHidden = NO;
    
    MPMoviePlayerController *player = [aNotification object];
    
    [player stop];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
}


- (void) movieFinishedCallback:(NSNotification*) aNotification {
    MPMoviePlayerController *player = [aNotification object];
    
    [player stop];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    [moviePlayerController.view removeFromSuperview];
    
    NSLog(@"stopped?");
}


- (void) random_file_action: (UITapGestureRecognizer *)recognizer
{
    
    
    UIView *view = recognizer.view; //cast pointer to the derived class if needed
    NSLog(@"%d", view.tag);
    
    
    
    
    Open_Random_files_ViewController *objOpen_Random_files_ViewController=[[Open_Random_files_ViewController alloc]init];
    objOpen_Random_files_ViewController.URL_VALUE=[Utilities API_link_url_subDomain_for_other_files:[NSString stringWithFormat:@"%d",view.tag]];
    [self.navigationController pushViewController:objOpen_Random_files_ViewController animated:YES];
    
    
    
}



#pragma mark - -*********************
#pragma mark Like Button Method
#pragma mark - -*********************



-(void)like:(UIButton *)sender
{
    
    UIButton *btn = (UIButton *)sender;
    //
    //
    indexvalues=sender.tag;
    
    
    if ([API connectedToInternet]==YES) {
        
        
        NSMutableDictionary *cellDict = [[[dict valueForKey:@"posts"] objectAtIndex:btn.tag] mutableCopy];
        
        
        NSInteger value=[[[[dict valueForKey:@"posts"] objectAtIndex:btn.tag]valueForKey:@"picture_diary_like_count"]integerValue];
        
        
        
        
        
        
        if ([[[[dict valueForKey:@"posts"] objectAtIndex:btn.tag]valueForKey:@"already_liked"] isEqualToString:@"no"]) {
            
            
            
            [cellDict setObject:[NSString stringWithFormat:@"%d",value+1] forKey:@"picture_diary_like_count"];
            
            [cellDict setObject:@"yes" forKey:@"already_liked"];
            
            [Like setBackgroundImage:[UIImage imageNamed:@"unlike.png"] forState:UIControlStateNormal];
            
            
        }
        
        else
        {
            [cellDict setObject:[NSString stringWithFormat:@"%d",value-1] forKey:@"picture_diary_like_count"];
            
            [cellDict setObject:@"no" forKey:@"already_liked"];
            
            [Like setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        }
        
        
        
        [[dict valueForKey:@"posts"] replaceObjectAtIndex:btn.tag withObject:cellDict];
        
        // [btn setBackgroundColor:[UIColor greenColor]];
        
        [tableViewm reloadData];
        
        
        [self performSelectorInBackground:@selector(Like_APi_backend:) withObject:[[[dict valueForKey:@"posts"] objectAtIndex:btn.tag]valueForKey:@"id"]];
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
        
    }
    
    
}


-(void)Like_APi_backend :(NSString *)value

{
    
    if ([API connectedToInternet]==YES) {
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&parent_id=%@&language=%@&post_id=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],value]:[NSString stringWithFormat:@"%@picture_diary/like_post",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict_like = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        
        
        
        if ([[dict_like valueForKey:@"status"]isEqualToString:@"true"]) {
            
            
            //            NSMutableDictionary *svalue=[[NSMutableDictionary alloc]init];
            //
            //
            //
            //            [svalue setValue:[[[[dict valueForKey:@"result"]valueForKey:@"data"]objectAtIndex:indexvalues]valueForKey:@"tot_likes"] forKey:@"like_count"];
            //
            //
            //
            //
            //
            //
            //            [svalue setValue:value forKey:@"post_id"];
            //            [svalue setValue:[[[[dict valueForKey:@"result"]valueForKey:@"data"]objectAtIndex:indexvalues]valueForKey:@"melike"] forKey:@"melike"];
            //
            
            
            
            
            
        }
        
        
        
        NSLog(@"%@",[[dict_like valueForKey:@"result"]valueForKey:@"message"]);
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
        
    }
    
    
    
    
    
}




#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %d row", indexPath.row);
}

#pragma mark - -*********************
#pragma mark Search Bar Method
#pragma mark - -*********************


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    msearch_STR=searchBar.text;
    
    [searchBar resignFirstResponder];
    searchBar.text=@"";
    
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_EDU_POST_API) withObject:nil afterDelay:0.5];
    
    
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
    searchBar.text=@"";
    
    //  [searchBar setShowsCancelButton:NO animated:YES];
    
    
}




- (void)dismissKeyboard
{
    // hide the keyboard
    [search resignFirstResponder];
    // remove the overlay button
    
    search.text=@"";
    
}

#pragma mark - -*********************
#pragma mark ViewDidLoad Method
#pragma mark - -*********************

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
