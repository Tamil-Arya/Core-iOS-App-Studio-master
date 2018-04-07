//
//  Save_Draft_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 19/01/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Save_Draft_ViewController.h"
#import "UIImageView+WebCache.h"
#import "Utilities.h"
#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "API.h"
#import "JSON.h"
#import "NSString+HTML.h"
#import "UIImageView+WebCache.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "ELR_loaders_.h"
#import "Save_Draft_Filter_ViewController.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"
@interface Save_Draft_ViewController ()

@end

@implementation Save_Draft_ViewController

#pragma mark -
#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems {
    // self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
    
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        //self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
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
    
   // user_pic.frame=CGRectMake(50, 0, 30, 30);
    
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
    user_pic.layer.masksToBounds=YES;
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
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"SAVE DRAFT" value:@"" table:nil];
    
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  //  UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    my_draft=@"";
    from_date=@"";
    to_date=@"";
    description_value=@"";
    
    [self Navigation_bar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Save_Draft_Post:)
                                                 name:@"Save_Draft_Post"
                                               object:nil];
    
     self.view.backgroundColor=[UIColor whiteColor];
    
    ////////////////////  Filter_LB   Lable\\\\\\\\\\\\\\
    
    
    Filter_LB=[[UILabel alloc]init];
    Filter_LB.userInteractionEnabled=YES;
    Filter_LB.backgroundColor=[UIColor clearColor];
    Filter_LB.frame=CGRectMake(0,64,self.view.frame.size.width, 45);
    Filter_LB.text=[NSString stringWithFormat:@"   %@",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Filter" value:@"" table:nil]];
    Filter_LB.textColor=[UIColor colorWithRed:92.0f/255.0f green:92.0f/255.0f blue:92.0f/255.0f alpha:1.0];
    Filter_LB.font=[Font_Face_Controller opensanssemibold:13];
    Filter_LB.textAlignment=NSTextAlignmentLeft;
    Filter_LB.backgroundColor=[UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0];
    [self.view addSubview:Filter_LB];
    
    
    UITapGestureRecognizer *Filter_action = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(Filter_action)];
    
    [Filter_LB addGestureRecognizer:Filter_action];
    
    
    //////////////////  Right Image  Lable\\\\\\\\\\\\\\
    
    
    UIButton *btnMenuss = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenuss.frame = CGRectMake(self.view.frame.size.width-40, 70, 30, 30);
    [btnMenuss setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-down"] forState:UIControlStateNormal];
    [btnMenuss setTitleColor:[UIColor colorWithRed:92.0f/255.0f green:92.0f/255.0f blue:92.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    [btnMenuss.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:18]];
    [self.view addSubview:btnMenuss];
    
    
    // init table view
    mtableview = [[UITableView alloc] initWithFrame:CGRectMake(0, Filter_LB.frame.origin.y+Filter_LB.frame.size.height, self.view.frame.size.width, ((self.view.frame.size.height)-(Filter_LB.frame.origin.y+Filter_LB.frame.size.height))-50) style:UITableViewStylePlain];
    mtableview.delegate = self;
    mtableview.dataSource = self;
    mtableview.separatorColor=[UIColor clearColor];
    mtableview.backgroundColor = [Text_color_ EDU_Blog_Color_code];
  mtableview.showsVerticalScrollIndicator=NO;
    [self.view addSubview:mtableview];
    
    
    
    UIView *MVIEWS=[[UIView alloc]init];
    MVIEWS.frame=CGRectMake(0,self.view.frame.size.height-50,self.view.frame.size.width, 50);
    MVIEWS.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    [self.view addSubview:MVIEWS];
    
    
    //////////////////// Remember No Button\\\\\\\\\\\\\\
    
    Remove_Draft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [Remove_Draft addTarget:self
                   action:@selector(Remove_Draft:)
         forControlEvents:UIControlEventTouchUpInside];
    Remove_Draft.backgroundColor=[UIColor colorWithRed:245.0f/255.0f green:186.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    [Remove_Draft setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"REMOVE DRAFT" value:@"" table:nil] forState:UIControlStateNormal];
    [Remove_Draft setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    Remove_Draft.frame = CGRectMake(0,0,(self.view.frame.size.width/2)-5, 50);
     [Remove_Draft.titleLabel setFont:[Font_Face_Controller opensansLight:16]];
    [MVIEWS addSubview:Remove_Draft];
    
    
    
    
    
    //////////////////// Remember YES Button\\\\\\\\\\\\\\
    
    Use_Draft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [Use_Draft addTarget:self
                   action:@selector(Use_Draft:)
         forControlEvents:UIControlEventTouchUpInside];
    Use_Draft.backgroundColor=[UIColor colorWithRed:245.0f/255.0f green:186.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    [Use_Draft setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"USE DRAFT" value:@"" table:nil] forState:UIControlStateNormal];
    [Use_Draft.titleLabel setFont:[Font_Face_Controller opensansLight:16]];
    [Use_Draft setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    Use_Draft.frame = CGRectMake((self.view.frame.size.width/2)+5,0,(self.view.frame.size.width/2)-5, 50);
    [MVIEWS addSubview:Use_Draft];
    
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [mtableview addSubview:refreshControl];


    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_drafts_API) withObject:nil afterDelay:0.5];

   
}


-(void)Remove_Draft:(UIButton *)SENDER

{
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Remove_Draft_API) withObject:nil afterDelay:0.5];
}


-(void)Use_Draft:(UIButton *)SENDER

{
    
    
    

    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"POST_screen_Save_Draft"
     object:[[dict valueForKey:@"drafts"]objectAtIndex:Index_Paths]];
    
    [self.navigationController popViewControllerAnimated:YES];
    

}

-(void)refresh
{
    my_draft=@"";
    from_date=@"";
    to_date=@"";
    description_value=@"";

    
   [self performSelector:@selector(CallTheServer_get_drafts_API) withObject:nil afterDelay:0.5];
    
    
    
}



-(void)Filter_action
{
    Save_Draft_Filter_ViewController *objSetting_ViewController=[[Save_Draft_Filter_ViewController alloc]init];
    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:objSetting_ViewController];
    
    [self presentViewController:HomeNavController animated:YES completion:nil];

}


- (void) Save_Draft_Post:(NSNotification *) notification
{
    
    
    NSLog(@"%@",notification.object);
    
    
    
    my_draft=[notification.object valueForKey:@"Mine_Only"];
    from_date=[notification.object valueForKey:@"from_date"];
    to_date=[notification.object valueForKey:@"to_date"];
    description_value=[[notification.object valueForKey:@"Description"]stringByConvertingHTMLToPlainText];
    
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_drafts_API) withObject:nil afterDelay:0.5];
    
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
#pragma mark Call get_drafts_API Method
#pragma mark - -*********************


-(void)CallTheServer_get_drafts_API
{
    if ([API connectedToInternet]==YES) {
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&from_date=%@&to_date=%@&my_draft=%@&description_value=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],from_date,to_date,my_draft,description_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@picture_diary/get_drafts",[Utilities API_link_url_subDomain]]];
        NSLog(@"%@",[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&from_date=%@&to_date=%@&my_draft=%@&description_value=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],from_date,to_date,my_draft,description_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]);
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            [mtableview reloadData];
            
            
            
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
    
    
    [refreshControl endRefreshing];
    
    [self mStopIndicater];
    
    
}



#pragma mark - -*********************
#pragma mark Call Student_API Method
#pragma mark - -*********************


-(void)CallTheServer_Remove_Draft_API
{
    if ([API connectedToInternet]==YES) {
        
      
        //------------ Call API for signup With Post Method --------------//
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&post_id=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],Post_id,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@picture_diary/delete_post",[Utilities API_link_url_subDomain]]];
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict_Remove_Drfat = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        if ([[dict_Remove_Drfat valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            NSMutableArray *dssss=[[NSMutableArray alloc]init];
            
            [dssss addObject:dict];
            
            
            [[[dssss objectAtIndex:0]valueForKey:@"drafts"]  removeObjectAtIndex:Index_Paths];
            
            dict =nil;
            
            dict=[[NSMutableDictionary alloc]init];
            
            
           [dict setValuesForKeysWithDictionary:[dssss objectAtIndex:0]];
            [mtableview reloadData];
            
        }else if([[dict_Remove_Drfat valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict_Remove_Drfat valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark - -*********************
#pragma mark TableView DataSource Method
#pragma mark - -*********************


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
   
    

    
    UIView *sectionHeader = [[UIView alloc] init];
    sectionHeader.frame=CGRectMake(0, 0,mtableview.frame.size.width, 35);
    sectionHeader.backgroundColor=[UIColor whiteColor];
    
    UILabel *Date_LB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,(mtableview.frame.size.width/4)-10, sectionHeader.frame.size.height-2)];
    //Student_name.backgroundColor = [UIColor redColor];
    Date_LB.font = [Font_Face_Controller opensansregular:13];
    Date_LB.tag=section-1;
    Date_LB.textColor=[UIColor whiteColor];
    Date_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Date" value:@"" table:nil];
    Date_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    Date_LB.textAlignment=NSTextAlignmentCenter;
    [sectionHeader addSubview:Date_LB];
    
    
    
    
    UILabel *BY_LB = [[UILabel alloc] initWithFrame:CGRectMake(Date_LB.frame.size.width+1, 0,(mtableview.frame.size.width/4)-10, sectionHeader.frame.size.height-2)];
    BY_LB.font = [Font_Face_Controller opensansregular:13];
    BY_LB.tag=section-1;
    BY_LB.textColor=[UIColor whiteColor];
    BY_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"BY" value:@"" table:nil];
    BY_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    BY_LB.textAlignment=NSTextAlignmentCenter;
    [sectionHeader addSubview:BY_LB];
    
    
    
    
    UILabel *paperclip_LB = [[UILabel alloc] initWithFrame:CGRectMake(sectionHeader.frame.size.width-((mtableview.frame.size.width/4)-50), 0,(mtableview.frame.size.width/4)-50, sectionHeader.frame.size.height-2)];
    paperclip_LB.font = [Font_Face_Controller opensansregular:13];
    paperclip_LB.tag=section-1;
    paperclip_LB.textColor=[UIColor whiteColor];
    paperclip_LB.text=[NSString fontAwesomeIconStringForIconIdentifier:@"fa-paperclip"];
    [paperclip_LB setFont:[UIFont fontWithName:@"FontAwesome" size:18]];
    paperclip_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    paperclip_LB.textAlignment=NSTextAlignmentCenter;
    [sectionHeader addSubview:paperclip_LB];

    
    
    
    UILabel *FOR_LB = [[UILabel alloc] initWithFrame:CGRectMake((BY_LB.frame.origin.x+BY_LB.frame.size.width)+1, 0,(paperclip_LB.frame.origin.x-(BY_LB.frame.origin.x+BY_LB.frame.size.width))-2, sectionHeader.frame.size.height-2)];
    FOR_LB.font = [Font_Face_Controller opensansregular:13];
    FOR_LB.tag=section-1;
    FOR_LB.textColor=[UIColor whiteColor];
    FOR_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"FOR" value:@"" table:nil];
    FOR_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    FOR_LB.textAlignment=NSTextAlignmentCenter;
    [sectionHeader addSubview:FOR_LB];


    
    return sectionHeader;
    
    
}


#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[dict valueForKey:@"drafts"]count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [mtableview dequeueReusableCellWithIdentifier:@"Cell"];
    
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
    
    UIView *selectedView = [[UIView alloc]init];
   
    selectedView.backgroundColor = [UIColor colorWithRed:214.0f/255.0f green:106.0f/255.0f blue:154.0f/255.0f alpha:1.0];
    cell.selectedBackgroundView =  selectedView;
    
    UILabel *Date_LB_Cell = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,(mtableview.frame.size.width/4)-10, 38)];
    //Student_name.backgroundColor = [UIColor redColor];
    Date_LB_Cell.font = [Font_Face_Controller opensansLight:11];
    Date_LB_Cell.tag=indexPath.row;
    Date_LB_Cell.textColor=[UIColor whiteColor];
    Date_LB_Cell.lineBreakMode = NSLineBreakByWordWrapping;
    Date_LB_Cell.numberOfLines = 0;
    Date_LB_Cell.text=[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PictureDiary"]valueForKey:@"created"]stringByConvertingHTMLToPlainText];

    Date_LB_Cell.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    Date_LB_Cell.textAlignment=NSTextAlignmentCenter;
       [cell.contentView addSubview:Date_LB_Cell];
    
    
    
    UILabel *BY_LB_Cell = [[UILabel alloc] initWithFrame:CGRectMake(Date_LB_Cell.frame.size.width+1, 0,(mtableview.frame.size.width/4)-10, 38)];
    BY_LB_Cell.font = [Font_Face_Controller opensansLight:11];
    BY_LB_Cell.tag=indexPath.row;
    BY_LB_Cell.textColor=[UIColor whiteColor];
    BY_LB_Cell.text=[NSString stringWithFormat:@"%@ %@",[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryTeacher"]valueForKey:@"USR_FirstName"]stringByConvertingHTMLToPlainText],[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryTeacher"]valueForKey:@"USR_LastName"]stringByConvertingHTMLToPlainText]];
    BY_LB_Cell.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    BY_LB_Cell.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:BY_LB_Cell];
    
    
    
    
    if (![[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]count]==0) {
        
        
        NSLog(@"%@",[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]objectAtIndex:0]valueForKey:@"type"]);
        
        
        
        
        
        if ([[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]objectAtIndex:0]valueForKey:@"type"]isEqualToString:@"other"])
        {

              UIImageView *paperclip_LB_Cell = [[UIImageView alloc] initWithFrame:CGRectMake(mtableview.frame.size.width-((mtableview.frame.size.width/4)-50), 0,(mtableview.frame.size.width/4)-50, 38)];
             paperclip_LB_Cell.backgroundColor=[Text_color_ EDU_Blog_Color_code];
            
            
            
            
             NSLog(@"%@",[NSString stringWithFormat:@"%@",[Utilities API_link_url_subDomain_for_IMG:[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]objectAtIndex:0]valueForKey:@"id"]]]);
            
            [paperclip_LB_Cell sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Utilities API_link_url_subDomain_for_IMG:[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]objectAtIndex:0]valueForKey:@"id"]]]]
                                 placeholderImage:[UIImage imageNamed:@"profile9.png"]];
            
             [cell.contentView addSubview:paperclip_LB_Cell];
            
             fFrame=paperclip_LB_Cell.frame;
            
            
            if ([[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]count]>=1) {
                
                UILabel *count_LB = [[UILabel alloc] initWithFrame:CGRectMake(paperclip_LB_Cell.frame.size.width-20, 0,20, 20)];
                count_LB.textColor=[UIColor whiteColor];
                  count_LB.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.6];
                count_LB.font=[Font_Face_Controller opensanssemibold:13];
                count_LB.textAlignment=NSTextAlignmentCenter;

                count_LB.text=[NSString stringWithFormat:@"%u",[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]count]];
                [paperclip_LB_Cell addSubview:count_LB];
                
            }


            
        }
        
        else if ([[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]objectAtIndex:0]valueForKey:@"type"]isEqualToString:@"video"])
        {
            UILabel *video_LB = [[UILabel alloc] initWithFrame:CGRectMake(mtableview.frame.size.width-((mtableview.frame.size.width/4)-50), 0,(mtableview.frame.size.width/4)-50, 38)];
            video_LB.font = [Font_Face_Controller opensansregular:13];
            video_LB.tag=indexPath.row;
            video_LB.textColor=[UIColor whiteColor];
            video_LB.text=[NSString fontAwesomeIconStringForIconIdentifier:@"fa-file-video-o"];
            [video_LB setFont:[UIFont fontWithName:@"FontAwesome" size:18]];
            video_LB.backgroundColor=[Text_color_ EDU_Blog_Color_code];
            video_LB.textAlignment=NSTextAlignmentCenter;
            [cell.contentView addSubview:video_LB];

            fFrame=video_LB.frame;
            
            
            if ([[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]count]>=1) {
                
                UILabel *count_LB = [[UILabel alloc] initWithFrame:CGRectMake(video_LB.frame.size.width-20, 0,20, 20)];
                count_LB.textColor=[UIColor whiteColor];
                   count_LB.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.6];
                count_LB.font=[Font_Face_Controller opensanssemibold:13];
                count_LB.textAlignment=NSTextAlignmentCenter;

                count_LB.text=[NSString stringWithFormat:@"%u",[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]count]];
                [video_LB addSubview:count_LB];
                
            }
            



        }
        
        else if ([[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]objectAtIndex:0]valueForKey:@"type"]isEqualToString:@"random"])
        {
           
              UILabel *random_LB = [[UILabel alloc] initWithFrame:CGRectMake(mtableview.frame.size.width-((mtableview.frame.size.width/4)-50), 0,(mtableview.frame.size.width/4)-50, 38)];
            random_LB.font = [Font_Face_Controller opensansregular:13];
            random_LB.tag=indexPath.row;
            random_LB.textColor=[UIColor whiteColor];
            random_LB.text=[NSString fontAwesomeIconStringForIconIdentifier:@"fa-file-o"];
            [random_LB setFont:[UIFont fontWithName:@"FontAwesome" size:18]];
            random_LB.backgroundColor=[Text_color_ EDU_Blog_Color_code];
            random_LB.textAlignment=NSTextAlignmentCenter;
          [cell.contentView addSubview:random_LB];
            
            fFrame=random_LB.frame;
            
            if ([[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]count]>=1) {
                
                UILabel *count_LB = [[UILabel alloc] initWithFrame:CGRectMake(random_LB.frame.size.width-20, 0,20, 20)];
                count_LB.textColor=[UIColor whiteColor];
                 count_LB.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.6];
                count_LB.font=[Font_Face_Controller opensanssemibold:13];
                count_LB.textAlignment=NSTextAlignmentCenter;
             //   count_LB.text=[NSString stringWithFormat:@"%u",[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryContent"]count]];
                [random_LB addSubview:count_LB];
                
            }
            

            

        }
        else
        {
            UIImageView *paperclip_LB_Cell = [[UIImageView alloc] initWithFrame:CGRectMake(mtableview.frame.size.width-((mtableview.frame.size.width/4)-50), 0,(mtableview.frame.size.width/4)-50, 38)];
            paperclip_LB_Cell.backgroundColor=[Text_color_ EDU_Blog_Color_code];
            
            [cell.contentView addSubview:paperclip_LB_Cell];
            
            fFrame=paperclip_LB_Cell.frame;

        }
     
        
    }
    
    else
    {
        
        UIImageView *paperclip_LB_Cell = [[UIImageView alloc] initWithFrame:CGRectMake(mtableview.frame.size.width-((mtableview.frame.size.width/4)-50), 0,(mtableview.frame.size.width/4)-50, 38)];
         paperclip_LB_Cell.backgroundColor=[Text_color_ EDU_Blog_Color_code];
        
        [cell.contentView addSubview:paperclip_LB_Cell];
        
        fFrame=paperclip_LB_Cell.frame;

    }

    NSLog(@"%f",fFrame.origin.x);
    
    
    
    UILabel *FOR_LB = [[UILabel alloc] initWithFrame:CGRectMake((BY_LB_Cell.frame.origin.x+BY_LB_Cell.frame.size.width)+1, 0,(fFrame.origin.x-(BY_LB_Cell.frame.origin.x+BY_LB_Cell.frame.size.width))-2, 38)];
    FOR_LB.font = [Font_Face_Controller opensansLight:11];
    FOR_LB.tag=indexPath.row;
    FOR_LB.textColor=[UIColor whiteColor];
    FOR_LB.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    FOR_LB.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    FOR_LB.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:FOR_LB];

    if ([[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PictureDiary"]valueForKey:@"category"]isEqualToString:@"school"]) {
    
   
        
    FOR_LB.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Preschool" value:@"" table:nil];
        
        
    }
    
    
    else if ([[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PictureDiary"]valueForKey:@"category"]isEqualToString:@"student"])
    {
    
    
        if ([[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryStudent"]count]>=3) {
            
            
           
            
        FOR_LB.text =[NSString stringWithFormat:@"%@#  %@# %@",[[[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryStudent"]valueForKey:@"Student"]objectAtIndex:0]valueForKey:@"USR_FirstName"]stringByConvertingHTMLToPlainText],[[[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryStudent"]valueForKey:@"Student"]objectAtIndex:1]valueForKey:@"USR_FirstName"]stringByConvertingHTMLToPlainText],@"..."];
            
        }
        else
        {
            if ([[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryStudent"]count]==2) {
                
                
            FOR_LB.text =[NSString stringWithFormat:@"%@#  %@#",[[[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryStudent"]valueForKey:@"Student"]objectAtIndex:0]valueForKey:@"USR_FirstName"]stringByConvertingHTMLToPlainText],[[[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryStudent"]valueForKey:@"Student"]objectAtIndex:1]valueForKey:@"USR_FirstName"]stringByConvertingHTMLToPlainText]];
                
                
            }
            else
            {
                
                
        FOR_LB.text =[NSString stringWithFormat:@"%@",[[[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryStudent"]valueForKey:@"Student"]objectAtIndex:0]valueForKey:@"USR_FirstName"]stringByConvertingHTMLToPlainText]];
                    
                    }
            
        }
        
        
    }
    
    else if  ([[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PictureDiary"]valueForKey:@"category"]isEqualToString:@"class"]) {
        
//        
//        
//        NSLog(@"%u",[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryGroup"]count]);
//        
//        
//          NSLog(@"%@",[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryGroup"]);
//        
//        
//          NSLog(@"%@",[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryGroup"]valueForKey:@"ClaClass"]);
        
        if ([[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryGroup"]count]==0) {

        }
        else
        {
            
            
            if ([[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryGroup"]count]>=3) {
                
                             
                
                FOR_LB.text =[NSString stringWithFormat:@"%@#  %@# %@",[[[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryGroup"]valueForKey:@"ClaClass"]objectAtIndex:0]valueForKey:@"name"]stringByConvertingHTMLToPlainText],[[[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryGroup"]valueForKey:@"ClaClass"]objectAtIndex:1]valueForKey:@"name"]stringByConvertingHTMLToPlainText],@"More"];
                
                
            }
            else
            {
                if ([[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryGroup"]count]==2) {
                    
                    
                        FOR_LB.text =[NSString stringWithFormat:@"%@#  %@#",[[[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryGroup"]valueForKey:@"ClaClass"]objectAtIndex:0]valueForKey:@"name"]stringByConvertingHTMLToPlainText],[[[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryGroup"]valueForKey:@"ClaClass"]objectAtIndex:1]valueForKey:@"name"]stringByConvertingHTMLToPlainText]];
                    
                    
                 
                    
                }
                else
                {
                    
                    FOR_LB.text = [NSString stringWithFormat:@"%@#",[[[[[[[dict valueForKey:@"drafts"]objectAtIndex:indexPath.row]valueForKey:@"PicturediaryGroup"]valueForKey:@"ClaClass"]objectAtIndex:0]valueForKey:@"name"]stringByConvertingHTMLToPlainText]];
                }
                
            }
            
            
        }
        
    }
    
    cell.backgroundColor=[UIColor whiteColor];
    
    
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[[dict valueForKey:@"drafts"]objectAtIndex:Index_Paths]);

    
      Index_Paths=indexPath.row;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
