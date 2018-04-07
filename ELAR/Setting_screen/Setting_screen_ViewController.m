//
//  Setting_screen_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 11/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Setting_screen_ViewController.h"
#import "Text_color_.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "Font_Face_Controller.h"
#import "Utilities.h"
#import "Navigation_bar_Button.h"
#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "Change_Language_ViewController.h"
#import "ELR_loaders_.h"
#import "Users_panel_ViewController.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"

@interface Setting_screen_ViewController ()
{
    UIImageView *loader_image;
     APIWithProtocol * api;
}

@end
@implementation Setting_screen_ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

    
    // init table view
    mtableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height)) style:UITableViewStylePlain];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    mtableview.delegate = self;
    mtableview.dataSource = self;
    
    mtableview.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0];
    
    // add to canvas
    [self.view addSubview:mtableview];
    
    
    
    mtableview.tableFooterView = [UIView new];
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_authentication_token"];        }
    else
    {
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"];
    }
    
    
    
    [self Navigation_bar];
    
    [self mStartIndicater];
    [self performSelector:@selector(CallTheServer_show_notification) withObject:nil afterDelay:0.5];
    [self performSelector:@selector(CallTheServer_webgui_get_setting) withObject:nil afterDelay:0.5];
    
    
}

-(void)Navigation_bar
{
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
    
    
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Setting" value:@"" table:nil];

    [[self navigationItem] setBackBarButtonItem:backButton];
    
}

-(void)gotoBack
{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    for (UIViewController *controller in self.navigationController.viewControllers)
//    {
//        if ([controller isKindOfClass:[Users_panel_ViewController class]])
//        {
//            [self.navigationController popToViewController:controller animated:YES];
//            
//            break;
//        }
//    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    [self Navigation_bar];
    
    [mtableview reloadData];
    
    
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


-(void)CallTheServer_show_notification
{
    
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&user_id=%@&device_token=%@&language=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@news/get_settings",[Utilities API_link_url_subDomain]]];
        
        
        NSLog(@"request string %@",[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&user_id=%@&device_token=%@&language=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]] );

        
        
        

        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        NSLog(@"dict %@",dict);
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
//             NSLog(@"%@",[dict valueForKey:@"response"]);
//            
//            
//             NSLog(@"%@",[[dict valueForKey:@"response"]objectAtIndex:0]);
//            
//            
//             NSLog(@"%@",[[[dict valueForKey:@"response"]objectAtIndex:0]valueForKey:@"vibration"]);
//            
//            NSLog(@"%@",[[[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]objectAtIndex:0]valueForKey:@"edu_blog"]);
            
            
           
            
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
     [mtableview reloadData];
    
      [self mStopIndicater];
    
    
}

-(void)CallTheServer_webgui_get_setting
{
    
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&language=%@&authentication_token=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],Token_value]:[NSString stringWithFormat:@"%@users/webgui_get_setting",[Utilities API_link_url_subDomain]]];
        
        
        NSLog(@"request string %@",[NSString stringWithFormat:@"securityKey=%@&language=%@&authentication_token=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],Token_value] );
        
        
        
        
        
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dictionary = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        NSLog(@"dict %@",dictionary);
        
        if ([[dictionary valueForKey:@"status"] isEqualToString:@"true"]) {
         //  [mtableview reloadData];
            
            [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"App_Settings"] objectForKey:@"Retrieval_List"]forKey:@"Retrieval_List"];
            [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"App_Settings"] objectForKey:@"Edu_Blog"]forKey:@"Edu_Blog"];
            [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"App_Settings"] objectForKey:@"News"]forKey:@"News"];
            
            NSLog(@"retrievallist=>%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Retrieval_List"]);

            
            
        }else if([[dictionary valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
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
    [mtableview reloadData];
    
    [self mStopIndicater];
    
    
}


-(void) webserviceToGetWebGuiUpdateSetting:(NSMutableDictionary *)dics  {
    
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
    
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&view_type=%@&view_status=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[dics valueForKey:@"key"],[dics valueForKey:@"value"]]:[NSString stringWithFormat:@"%@users/webgui_Update_setting",[Utilities API_link_url_subDomain]]];
        
        NSLog(@"responseString=>%@",responseString);
        
        NSLog(@"request string %@",[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&view_type=%@&view_status=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[dics valueForKey:@"key"],[dics valueForKey:@"value"]] );
        
        NSDictionary *responseDict = [responseString JSONValue];
        NSLog(@"dict=>%@",responseDict);
        dictionary = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"App_Settings"] objectForKey:@"Retrieval_List"]forKey:@"Retrieval_List"];
        [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"App_Settings"] objectForKey:@"Edu_Blog"]forKey:@"Edu_Blog"];
        [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"App_Settings"] objectForKey:@"News"]forKey:@"News"];
        
        NSLog(@"retrievallist=>%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Retrieval_List"]);
        
        if ([[dictionary valueForKey:@"status"] isEqualToString:@"true"]) {
            
            NSIndexPath* indexPath1 = [NSIndexPath indexPathForRow:0 inSection:7];
            NSIndexPath* indexPath2 = [NSIndexPath indexPathForRow:1 inSection:7];
            NSIndexPath* indexPath3 = [NSIndexPath indexPathForRow:2 inSection:7];
         // NSIndexPath* indexPath4 = [NSIndexPath indexPathForRow:3 inSection:6];
            // Add them in an index path array
            NSArray* indexArray = [NSArray arrayWithObjects:indexPath1,indexPath2,indexPath3, nil];
            // Launch reload for the two index path
            [mtableview reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
            
        }else if([[dictionary valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
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
    
    mtableview.userInteractionEnabled=YES;
    
    
    
    [self mStopIndicater];
}

- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    
}

#pragma mark - -*********************
#pragma mark TableView HeightForHeader Method
#pragma mark - -*********************

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 20;
    }
    
    else if (section==2 || section == 7 || section == 8)
    {
        return 35;
    }
    
    else
    {
        
        return 20;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//        if (indexPath.section == 6 && indexPath.row == 0) {
//            
//            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"Teacher"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"Lärare"]) {
//                return 30;
//            } else {
//                return 0;
//            }
//    }
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"teacher"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"lärare"]) {
         if (indexPath.section == 7 && indexPath.row == 0) {
             return 30;
         }
    } else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"studerande"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"student"]) {
        if (indexPath.section == 7 && indexPath.row == 0) {
            return 0;
        }
    } else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        if (indexPath.section == 7 && indexPath.row == 0) {
            return 0;
        }
    }
    return 30;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (section==1) {
        return 3;
    }
    else if (section==2)
    {
        return 6;
    }
    else if (section==3)
    {
        return 4;
    }
    else if (section==4)
    {
        return 5;
    }
    else if (section==5)
    {
        return 5;
    } else if (section==6)
    {
        return 1;
    }
    else if (section == 7){
        return 3;
    }
    else if(section == 8)
    {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}


#pragma mark - -*********************
#pragma mark TableView DataSource Method
#pragma mark - -*********************


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeader = [[UIView alloc] init];
    sectionHeader.frame=CGRectMake(0, 0,mtableview.frame.size.width, 35);
sectionHeader.backgroundColor=[UIColor colorWithRed:235.0f/255.0f green:234.0f/255.0f blue:242.0f/255.0f alpha:1.0];
    
    UILabel *Student_name = [[UILabel alloc] init];
    Student_name.backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:234.0f/255.0f blue:242.0f/255.0f alpha:1.0];
    Student_name.font = [Font_Face_Controller opensanssemibold:13];
    Student_name.textColor=[UIColor lightGrayColor];
    Student_name.tag=section-1;
    
    if (section==1) {
        
        
        Student_name.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"GENERAL" value:@"" table:nil];
        [sectionHeader addSubview:Student_name];
        
         Student_name.frame = CGRectMake(7, sectionHeader.frame.origin.y,mtableview.frame.size.width-90, 20);

        
    }
    else if (section==2)
    {
        Student_name.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"NOTIFICATIONS" value:@"" table:nil];
        [sectionHeader addSubview:Student_name];
        Student_name.frame = CGRectMake(7, sectionHeader.frame.origin.y+15,mtableview.frame.size.width-90, 15);

    }
    else if (section == 7)
    {
        Student_name.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Web Version" value:@"" table:nil];
        [sectionHeader addSubview:Student_name];
        Student_name.font = [Font_Face_Controller opensanssemibold:10];
        Student_name.textColor=[UIColor blackColor];

        Student_name.frame = CGRectMake(7, sectionHeader.frame.origin.y+15,mtableview.frame.size.width-90, 15);
    }
    else if (section==8)
    {
        Student_name.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Version" value:@"" table:nil];
        [sectionHeader addSubview:Student_name];
        Student_name.frame = CGRectMake(7, sectionHeader.frame.origin.y+15,mtableview.frame.size.width-90, 15);
        
    }

    else
    {
         sectionHeader.frame=CGRectMake(0, 0,mtableview.frame.size.width, 20);
        Student_name.frame = CGRectMake(7, 0,mtableview.frame.size.width-90, 20);
    }
    
    
    
    return sectionHeader;
    
}


// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    NSLog(@"\n\n At Indexpath  %ld  %ld",(long)indexPath.row, (long)indexPath.section);
    
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
    
    
    NSLog(@"%ld",(long)[[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row]integerValue]);
    
    
    title=[[UILabel alloc]init];
    title.frame=CGRectMake(20, 0, 200, 30);
     title.font = [Font_Face_Controller opensansregular:10];
    title.textColor = [UIColor lightGrayColor];
    title.tag=[[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row]integerValue];
    [cell.contentView addSubview:title];
    
    
    switchView = [[UISwitch alloc] initWithFrame:CGRectMake(mtableview.frame.size.width-55, 0, 20, 20)];
    switchView.tag=[[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row]integerValue];
    [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    switchView.transform = CGAffineTransformMakeScale(0.75, 0.75);
    
    
    [cell.contentView addSubview:switchView];

    
    if (indexPath.section==1) {
        
        if (indexPath.row==0) {
            
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Vibration" value:@"" table:nil];
             title.textColor = [UIColor blackColor];
             title.font = [Font_Face_Controller opensanssemibold:10];
            
            
            if ([[[[dict valueForKey:@"response"]objectAtIndex:0]valueForKey:@"vibration"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
                
            }

             cell.accessoryType=UITableViewCellAccessoryNone;
        }
        else if (indexPath.row==1)
        {
              title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Sound" value:@"" table:nil];
             title.textColor = [UIColor blackColor];
            title.font = [Font_Face_Controller opensanssemibold:10];
            
            
            if ([[[[dict valueForKey:@"response"]objectAtIndex:0]valueForKey:@"sound"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }

             cell.accessoryType=UITableViewCellAccessoryNone;
        }
        else if (indexPath.row==2)
        {
            
            LANGUAGE_LB=[[UILabel alloc]init];
            LANGUAGE_LB.frame=CGRectMake(cell.frame.size.width-130, 0, 100, 30);
            LANGUAGE_LB.font = [Font_Face_Controller opensansregular:10];
            LANGUAGE_LB.textColor = [UIColor lightGrayColor];
            
            
            
            
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]isEqualToString:@"sw"])
            {
                
                 LANGUAGE_LB.text=@"svenska";
                
            }
            else
            {
                LANGUAGE_LB.text=@"English";
            }
           
            LANGUAGE_LB.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:LANGUAGE_LB];
            
              title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Language" value:@"" table:nil];
             title.textColor = [UIColor blackColor];
            title.font = [Font_Face_Controller opensanssemibold:10];
            [switchView removeFromSuperview];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        }
        
    }
    
    else if (indexPath.section==2)
    {
        
            if (indexPath.row==0) {
                
                title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Edu Blog" value:@"" table:nil];
                  title.textColor = [UIColor blackColor];
                title.font = [Font_Face_Controller opensanssemibold:10];
                
                
                if ([[[[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]objectAtIndex:0]valueForKey:@"edu_blog"]isEqualToString:@"1"]) {
                    
                    [switchView setOn:YES animated:NO];
                    
                }
                else
                {
                    [switchView setOn:NO animated:NO];
                }
                
                
            }
            else if (indexPath.row==1)
            {
                title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Individual posts" value:@"" table:nil];
                
                if ([[[[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]objectAtIndex:0]valueForKey:@"individual_post"]isEqualToString:@"1"]) {
                    
                    [switchView setOn:YES animated:NO];
                    
                }
                else
                {
                    [switchView setOn:NO animated:NO];
                }
                
                
                if ([[[[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]objectAtIndex:0]valueForKey:@"edu_blog"]isEqualToString:@"0"]) {
                    
                    switchView.userInteractionEnabled=NO;
                    
                }
                
                
            }
            else if (indexPath.row==2)
            {
                title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Posts for groups" value:@"" table:nil];
                
                
                if ([[[[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]objectAtIndex:0]valueForKey:@"group_post"]isEqualToString:@"1"]) {
                    
                    [switchView setOn:YES animated:NO];
                    
                }
                else
                {
                    [switchView setOn:NO animated:NO];
                }

                
                if ([[[[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]objectAtIndex:0]valueForKey:@"edu_blog"]isEqualToString:@"0"]) {
                    
                    switchView.userInteractionEnabled=NO;
                    
                }
                
                
            }
            else if (indexPath.row==3)
            {
                title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Posts for school" value:@"" table:nil];
                
                
                if ([[[[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]objectAtIndex:0]valueForKey:@"school_post"]isEqualToString:@"1"]) {
                    
                    [switchView setOn:YES animated:NO];
                    
                }
                else
                {
                    [switchView setOn:NO animated:NO];
                }
                
                if ([[[[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]objectAtIndex:0]valueForKey:@"edu_blog"]isEqualToString:@"0"]) {
                    
                    switchView.userInteractionEnabled=NO;
                    
                }

                
            }
            
            else if (indexPath.row==4)
            {
                title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Comments" value:@"" table:nil];
                
                
                
                if ([[[[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]objectAtIndex:0]valueForKey:@"comments"]isEqualToString:@"1"]) {
                    
                    [switchView setOn:YES animated:NO];
                    
                }
                else
                {
                    [switchView setOn:NO animated:NO];
                }
                
                
                if ([[[[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]objectAtIndex:0]valueForKey:@"edu_blog"]isEqualToString:@"0"]) {
                    
                    switchView.userInteractionEnabled=NO;
                    
                }
                
            }
            else if (indexPath.row==5)
            {
                title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Comments in own discussion" value:@"" table:nil];
                
                
                if ([[[[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]objectAtIndex:0]valueForKey:@"own_comments"]isEqualToString:@"1"]) {
                    
                    [switchView setOn:YES animated:NO];
                    
                }
                else
                {
                    [switchView setOn:NO animated:NO];
                }
                
                
                if ([[[[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]objectAtIndex:0]valueForKey:@"edu_blog"]isEqualToString:@"0"]) {
                    
                    switchView.userInteractionEnabled=NO;
                    
                }
                
                
            }
        
         cell.accessoryType=UITableViewCellAccessoryNone;

    }
    
    else if (indexPath.section==3)
    {
        
        if (indexPath.row==0) {
            
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"NEWS" value:@"" table:nil];
             title.textColor = [UIColor blackColor];
            title.font = [Font_Face_Controller opensanssemibold:10];
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"news"]objectAtIndex:0]valueForKey:@"news"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            
            
        }
        else if (indexPath.row==1)
        {
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Group posts" value:@"" table:nil];
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"news"]objectAtIndex:0]valueForKey:@"news_group_post"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"news"]objectAtIndex:0]valueForKey:@"news"]isEqualToString:@"0"]) {
                
                switchView.userInteractionEnabled=NO;
                
            }
            
        }
        else if (indexPath.row==2)
        {
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"School posts" value:@"" table:nil];
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"news"]objectAtIndex:0]valueForKey:@"news_school_post"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"news"]objectAtIndex:0]valueForKey:@"news"]isEqualToString:@"0"]) {
                
                switchView.userInteractionEnabled=NO;
                
            }
        }
        
        
        else if (indexPath.row==3)
        {
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Course posts" value:@"" table:nil];
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"news"]objectAtIndex:0]valueForKey:@"news_course_post"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"news"]objectAtIndex:0]valueForKey:@"news"]isEqualToString:@"0"]) {
                
                switchView.userInteractionEnabled=NO;
                
            }
        }
        
        cell.accessoryType=UITableViewCellAccessoryNone;
        
    }
    
    
       
    else if (indexPath.section==4)
    {
        
        
        if (indexPath.row==0) {
            
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Attendance" value:@"" table:nil];
             title.textColor = [UIColor blackColor];
            title.font = [Font_Face_Controller opensanssemibold:10];
            
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"attendence"]objectAtIndex:0]valueForKey:@"attendence"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            
            
        }
        else if (indexPath.row==1)
        {
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Individual in school" value:@"" table:nil];
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"attendence"]objectAtIndex:0]valueForKey:@"attendence_individual_school"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"attendence"]objectAtIndex:0]valueForKey:@"attendence"]isEqualToString:@"0"]) {
                
                switchView.userInteractionEnabled=NO;
                
            }

            
        }
        else if (indexPath.row==2)
        {
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Individual in common group" value:@"" table:nil];
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"attendence"]objectAtIndex:0]valueForKey:@"attendence_individual_group"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"attendence"]objectAtIndex:0]valueForKey:@"attendence"]isEqualToString:@"0"]) {
                
                switchView.userInteractionEnabled=NO;
                
            }
            
        }
        else if (indexPath.row==3)
        {
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absence note" value:@"" table:nil];
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"attendence"]objectAtIndex:0]valueForKey:@"absence_note"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"attendence"]objectAtIndex:0]valueForKey:@"attendence"]isEqualToString:@"0"]) {
                
                switchView.userInteractionEnabled=NO;
                
            }
            
        }
        else if (indexPath.row==4)
        {
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retrieval note" value:@"" table:nil];
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"attendence"]objectAtIndex:0]valueForKey:@"retriever_note"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"attendence"]objectAtIndex:0]valueForKey:@"attendence"]isEqualToString:@"0"]) {
                
                switchView.userInteractionEnabled=NO;
                
            }
        }
        
         cell.accessoryType=UITableViewCellAccessoryNone;
       
    }
    else if (indexPath.section==5)
    {
      
        
        if (indexPath.row==0) {
            
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Forum" value:@"" table:nil];
            title.textColor = [UIColor blackColor];
            title.font = [Font_Face_Controller opensanssemibold:10];
            
            
            NSLog(@"dict=>%@",dict);
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"forum"]objectAtIndex:0]valueForKey:@"forum"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            
            
        }
        else if (indexPath.row==1)
        {
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Whole school related posts" value:@"" table:nil];
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"forum"]objectAtIndex:0]valueForKey:@"forum_school_post"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"forum"]objectAtIndex:0]valueForKey:@"forum"]isEqualToString:@"0"]) {
                
                switchView.userInteractionEnabled=NO;
                
            }
            
            
        }
        else if (indexPath.row==2)
        {
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Forum groups" value:@"" table:nil];
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"forum"]objectAtIndex:0]valueForKey:@"forum_group_post"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"forum"]objectAtIndex:0]valueForKey:@"forum"]isEqualToString:@"0"]) {
                
                switchView.userInteractionEnabled=NO;
                
            }
            
        }
        else if (indexPath.row==3)
        {
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Forum Course" value:@"" table:nil];
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"forum"]objectAtIndex:0]valueForKey:@"forum_course_post"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"forum"]objectAtIndex:0]valueForKey:@"forum"]isEqualToString:@"0"]) {
                
                switchView.userInteractionEnabled=NO;
                
            }
            
        }
        else if (indexPath.row==4)
        {
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Comments on post" value:@"" table:nil];
            
            
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"forum"]objectAtIndex:0]valueForKey:@"forum_comment_post"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
            if ([[[[[dict valueForKey:@"response"]valueForKey:@"forum"]objectAtIndex:0]valueForKey:@"forum"]isEqualToString:@"0"]) {
                
                switchView.userInteractionEnabled=NO;
                
            }
        }
//        else if (indexPath.row==5)
//        {
//            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Forum-My Post" value:@"" table:nil];
//            
//            
//            if ([[[[[dict valueForKey:@"response"]valueForKey:@"forum"]objectAtIndex:0]valueForKey:@"forum_only_mypost"]isEqualToString:@"1"]) {
//                
//                [switchView setOn:YES animated:NO];
//                
//            }
//            else
//            {
//                [switchView setOn:NO animated:NO];
//            }
//            if ([[[[[dict valueForKey:@"response"]valueForKey:@"forum"]objectAtIndex:0]valueForKey:@"forum"]isEqualToString:@"0"]) {
//                
//                switchView.userInteractionEnabled=NO;
//                
//            }
//        }

        
        cell.accessoryType=UITableViewCellAccessoryNone;
        
    }
    else if (indexPath.section==6)
    {
        if (indexPath.row == 0) {
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"" value:@"Published Evaluation" table:nil];
            [switchView setHidden:NO];
            
            
            if ([[[[dict valueForKey:@"response"]valueForKey:@"evaluation"]valueForKey:@"evaluation"]objectAtIndex:0] == NULL && [[[[[dict valueForKey:@"response"]valueForKey:@"evaluation"]objectAtIndex:0]valueForKey:@"evaluation"]isEqualToString:@"1"]) {
                
                [switchView setOn:YES animated:NO];
                
            }
            else
            {
                [switchView setOn:NO animated:NO];
            }
        }
    }
    else if (indexPath.section == 7){
        
        if (indexPath.row == 0) {
            
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"teacher"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"lärare"]) {
            
            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"" value:@"Attendance" table:nil];
            [switchView setHidden:NO];
            
        } else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"studerande"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"student"]){
            title.text= @"";
            [switchView setHidden:YES];
        } else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]){
            title.text= @"";
            [switchView setHidden:YES];
        }
            
            if ([[[dictionary objectForKey:@"App_Settings"] objectForKey:@"Retrieval_List"]isEqualToString:@"1"]) {
                [switchView setOn:YES animated:NO];
            } else {
                [switchView setOn:NO animated:NO];

            }
            
           
    }
//        else if (indexPath.row == 1){
//            title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"" value:@"Schedule" table:nil];
//            if ([[[dictionary objectForKey:@"App_Settings"] objectForKey:@"Schedule"]isEqualToString:@"1"]) {
//                [switchView setOn:YES animated:NO];
//            } else {
//                [switchView setOn:NO animated:NO];
//                
//            }
//        }
        else if (indexPath.row == 1){
             title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"" value:@"Edu Blog" table:nil];
            if ([[[dictionary objectForKey:@"App_Settings"] objectForKey:@"Edu_Blog"]isEqualToString:@"1"]) {
                [switchView setOn:YES animated:NO];
            } else {
                [switchView setOn:NO animated:NO];
                
            }
           
        }
        else if (indexPath.row == 2){
             title.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"" value:@"News" table:nil];
            if ([[[dictionary objectForKey:@"App_Settings"] objectForKey:@"News"]isEqualToString:@"1"]) {
                [switchView setOn:YES animated:NO];
            } else {
                [switchView setOn:NO animated:NO];
                
            }
            
        }
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    
  else if (indexPath.section == 8)
    {
        title.text =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        switchView.hidden = YES;
        title.textColor = [UIColor blackColor];
    }
    NSLog(@"%@",[[dict valueForKey:@"response"]valueForKey:@"edu_blog"]);
    

    cell.backgroundColor=[UIColor clearColor];
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
   NSLog(@"\n\n At Indexpath Ended  %@",indexPath);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
         if (indexPath.row==2)
        {
            
            
            Change_Language_ViewController *obj_Show_Offer_ViewController=[[Change_Language_ViewController alloc]init];
            [self.navigationController pushViewController:obj_Show_Offer_ViewController animated:YES];

            
            
        }
        
    }
    
    
    
}

- (void) switchChanged:(id)sender {
   
   UISwitch * switchControl = sender;
    
    
    
    mtableview.userInteractionEnabled=NO;
    
  
    NSMutableDictionary *dicss=[[NSMutableDictionary alloc]init];
    NSString *value;
    
     NSLog(@"%ld",(long)switchControl.tag);
    switch(switchControl.tag)
    {
        case 10:
            value=@"vibration";
            break;
        case 11:
            value=@"sound";
            
            break;
        case 12:
           value=@"";
            
            break;
            
        case 20:
            value=@"edu_blog";
            break;
            
        case 21:
            value=@"individual_post";
            break;
        case 22:
            value=@"group_post";
            
            break;
        case 23:
           value=@"school_post";
            
            break;
        case 24:
           value=@"comments";
            
            break;
            
        case 25:
            value=@"own_comments";
            
            break;
            
        case 30:
            value=@"news";
            
            break;
            
            
        case 31:
            value=@"news_group_post";
            
            break;
            
        case 32:
            value=@"news_school_post";
            
            break;
            
        case 33:
            value=@"news_course_post";
            
            break;
    case 40:
            value=@"attendence";
            
            break;

        case 41:
            value=@"attendence_individual_school";
            
            break;

        case 42:
            value=@"attendence_individual_group";
            
            break;

        case 43:
            value=@"absence_note";
            
            break;

        case 44:
            value=@"retriever_note";
            
            break;

    case 50:
        value=@"forum";
            
        break;
            
        case 51:
            value=@"forum_school_post";
            
            break;
        case 52:
            value=@"forum_group_post";
            
            break;
        case 53:
            value=@"forum_course_post";
            
            break;
        case 54:
            value=@"forum_comment_post";
            
            break;
            
        case 55:
            value=@"forum_only_mypost";
            
            break;
     case 60:
            value = @"evaluation";
            break;
        
    case 70:
            value = @"retrieval_list";
            break;
            
//    case 61:
//            value = @"schedule";
//            break;
            
    case 71:
            value = @"edublog";
            break;
            
    case 72:
            value = @"news";
            break;
        }
    
    

    
   
    
    
    
    UISwitch *mySwitch = (UISwitch *)sender;
    if ([mySwitch isOn]) {
        
      [dicss setValue:@"1" forKey:@"value"];
      [dicss setValue:value forKey:@"key"];
      NSLog(@"its on!");
    } else {
        
        
        [dicss setValue:@"0" forKey:@"value"];
        [dicss setValue:value forKey:@"key"];
        
        NSLog(@"its off!");
    }
    
    
    
    [self mStartIndicater];
    if (switchControl.tag > 60 ) {
        [self performSelector:@selector(webserviceToGetWebGuiUpdateSetting:) withObject:dicss afterDelay:0.5];
    } else {
    [self performSelector:@selector(CallTheServer_show_Update:) withObject:dicss afterDelay:0.5];
    
    }
   
    

  
}



#pragma mark - -*********************
#pragma mark CallTheServer_Login_API Method
#pragma mark - -*********************


-(void)CallTheServer_show_Update:(NSMutableDictionary *)dics
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&user_id=%@&device_token=%@&language=%@&%@=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[dics valueForKey:@"key"],[dics valueForKey:@"value"]]:[NSString stringWithFormat:@"%@news/update_settings",[Utilities API_link_url_subDomain]]];
        
        NSLog(@"request string %@",[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&user_id=%@&device_token=%@&language=%@&%@=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[dics valueForKey:@"key"],[dics valueForKey:@"value"]] );
        
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
    
    mtableview.userInteractionEnabled=YES;

    [self mStopIndicater];
    
    
    
}


//#pragma mark - API Protocol service
//
//-(void)dataIsReceived:(id)dataReceived withMsgType:(int)msgType
//{
//    if (msgType == WEBSERVICE_TO_GET_WebGui_Update_Setting_URL_TAG) {
//        [self mStopIndicater];
//        NSLog(@"data received %@",dataReceived);
////        [self displayWebViewWithKey:dataReceived[@"Authentication_number_SCM"]];
//    }
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
