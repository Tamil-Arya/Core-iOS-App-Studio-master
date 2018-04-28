//
//  Attendance_overview.m
//  ELAR
//
//  Created by Bhushan Bawa on 09/02/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Attendance_overview.h"
#import "Text_color_.h"
#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "NSString+HTML.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "UIImageView+WebCache.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"
@interface Attendance_overview ()

@end

@implementation Attendance_overview
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

- (void) REfress_Attendance_overview:(NSNotification *) notification
{
    
    [self Navigation_bar];
    
    [self performSelector:@selector(CallTheServer_Attendance_overview_API) withObject:nil afterDelay:0.5];
    
}


-(void)Navigation_bar
{
    user_pic = [[UIImageView alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"USR_image"]]);
    [user_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"customer_logo"]]]
                placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    
//    user_pic.frame=CGRectMake(50, 0, 30, 30);
    
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
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Attendance overview" value:@"" table:nil];
    
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(REfress_Attendance_overview:)
                                                 name:@"REfress_Attendance_overview"
                                               object:nil];

    
    [self Navigation_bar];

    
   self.view.backgroundColor=[UIColor whiteColor];
    
    mtableview = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    mtableview.dataSource = self;
    mtableview.delegate = self;
 mtableview.backgroundColor=[UIColor whiteColor];
[self.view addSubview:mtableview];
[self mStartIndicater];
[self performSelector:@selector(CallTheServer_Attendance_overview_API) withObject:nil afterDelay:0.5];


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
#pragma mark CallTheServer_CallTheServer_Attendance_overview_API Method
#pragma mark - -*********************


-(void)CallTheServer_Attendance_overview_API
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [dateFormatter dateFromString: date_value];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_correct_format = [dateFormatter stringFromDate:date];
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&date=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],date_correct_format,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@retrivals/get_attendence_overview",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"])
        
        {
            
            
            [mtableview reloadData];
            
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    Header_Back  = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 40)];
    Header_Back.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:192.0f/255.0f blue:133.0f/255.0f alpha:1.0];
    [self.view addSubview:Header_Back];

    Group_name = [[UILabel alloc] init];
    Group_name.textColor = [UIColor clearColor];
    [Group_name setFrame:CGRectMake(10, 0, Header_Back.frame.size.width/2, 40)];
   // Group_name.backgroundColor=[UIColor clearColor];
    Group_name.textColor=[UIColor whiteColor];
    Group_name.userInteractionEnabled=NO;
    Group_name.text= [[[[dict valueForKey:@"attendence"]objectAtIndex:section]valueForKey:@"name"]stringByConvertingHTMLToPlainText];
     Group_name.textAlignment=NSTextAlignmentLeft;
    [Header_Back addSubview:Group_name];
    
    
    
    Group_Count = [[UILabel alloc] init];
    Group_Count.textColor = [UIColor clearColor];
    [Group_Count setFrame:CGRectMake(Header_Back.frame.size.width/2, 0, (Header_Back.frame.size.width/2)-10, 40)];
   // Group_Count.backgroundColor=[UIColor redColor];
    Group_Count.textColor=[UIColor whiteColor];
    Group_Count.userInteractionEnabled=NO;
    Group_Count.text=[NSString stringWithFormat:@"%@ / %@",[[[[dict valueForKey:@"attendence"]objectAtIndex:section]valueForKey:@"left_students_count"]stringByConvertingHTMLToPlainText],[[[[dict valueForKey:@"attendence"]objectAtIndex:section]valueForKey:@"total_student_count"]stringByConvertingHTMLToPlainText]];
    Group_Count.textAlignment=NSTextAlignmentRight;
    [Header_Back addSubview:Group_Count];


    return Header_Back;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[dict valueForKey:@"attendence"]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyCellIdentifier = @"MyCellIdentifier";
    
    UITableViewCell *cell = [mtableview dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    NSArray *views=[cell.contentView subviews];
    for(int i=0;i<[views count];i++)
    {
        UIView *tempView=[views objectAtIndex:i];
        [tempView removeFromSuperview];
        tempView = nil;
    }
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
    }
    
    
    
    absent_day_students_L_LB = [[UILabel alloc] init];
    absent_day_students_L_LB.textColor = [UIColor clearColor];
    [absent_day_students_L_LB setFrame:CGRectMake(10, 0, (cell.frame.size.width/2)-10, 40)];
   // absent_day_students_L_LB.backgroundColor=[UIColor redColor];
    absent_day_students_L_LB.textColor=[UIColor whiteColor];
    absent_day_students_L_LB.userInteractionEnabled=NO;

    absent_day_students_L_LB.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:absent_day_students_L_LB];

    
    absent_day_students_R_LB = [[UILabel alloc] init];
    absent_day_students_R_LB.textColor = [UIColor clearColor];
    [absent_day_students_R_LB setFrame:CGRectMake(cell.frame.size.width/2, 0, (cell.frame.size.width/2)-10, 40)];
  //  absent_day_students_R_LB.backgroundColor=[UIColor redColor];
    absent_day_students_R_LB.textColor=[UIColor whiteColor];
    absent_day_students_R_LB.userInteractionEnabled=NO;
    
    absent_day_students_R_LB.textAlignment=NSTextAlignmentRight;
    [cell.contentView  addSubview:absent_day_students_R_LB];

    
    if (indexPath.row==0) {
        
        absent_day_students_L_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent" value:@"" table:nil];
        
        
        absent_day_students_R_LB.text=[[[dict valueForKey:@"attendence"]objectAtIndex:indexPath.section]valueForKey:@"absent_day_students_count"];
    }
    else if (indexPath.row==1)
    {
        
        
        
            absent_day_students_L_LB.text= [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not retrieved" value:@"" table:nil];
        
        absent_day_students_R_LB.text=[[[dict valueForKey:@"attendence"]objectAtIndex:indexPath.section]valueForKey:@"not_retrieved_students_count"];
    }
    else
    {
        
            absent_day_students_L_LB.text= [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent notes" value:@"" table:nil];
        
        absent_day_students_R_LB.text=[[[dict valueForKey:@"attendence"]objectAtIndex:indexPath.section]valueForKey:@"absent_note_students_count"];

    }
    
    
     cell.backgroundColor=[Text_color_ Retrieval_Color_code];
    return cell;
}

@end
