//
//  Change_Language_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 07/01/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Change_Language_ViewController.h"
#import "Font_Face_Controller.h"
#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "ELR_loaders_.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"
@interface Change_Language_ViewController ()

@end

@implementation Change_Language_ViewController


-(void)Navigation_bar
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 //   UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
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
    
    
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Language" value:@"" table:nil];
    
     
}

-(void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
       
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self Navigation_bar];
    
    
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        
        
        
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_authentication_token"];        }
    else
    {
        
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"];
    }
    

    

    language_ARR=[[NSMutableArray alloc]init];
    
    
    _cellSelected=[[NSMutableArray alloc]init];

    
    // init table view
    mtableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height)) style:UITableViewStylePlain];
    mtableview.delegate = self;
    mtableview.dataSource = self;
    
    mtableview.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0];
    mtableview.scrollEnabled=NO;
    
    // add to canvas
    [self.view addSubview:mtableview];
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]isEqualToString:@"sw"]) {
        [language_ARR addObject:@"Engelska"];
        [language_ARR addObject:@"Svenska"];
        
        myIP = [NSIndexPath indexPathForRow:1 inSection:0] ;
        
      
        
           }
    else
    {
        [language_ARR addObject:@"English"];
        [language_ARR addObject:@"Swedish"];
        
       myIP = [NSIndexPath indexPathForRow:0 inSection:0] ;
        
       

        
    }
    
    [_cellSelected addObject:myIP];
    
    
    mtableview.tableFooterView = [UIView new];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

     [self.navigationItem setHidesBackButton:YES];
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return language_ARR.count;
}
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    
    if ([_cellSelected containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }

       
    title=[[UILabel alloc]init];
    title.frame=CGRectMake(20, 0, 200, cell.frame.size.height);
    title.font = [Font_Face_Controller opensansregular:13];
    title.textColor = [UIColor lightGrayColor];
    title.tag=[[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row]integerValue];
    title.text=[language_ARR objectAtIndex:indexPath.row];
    
    [cell.contentView addSubview:title];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    
    [language_ARR removeAllObjects];
    
    
   
    [mtableview deselectRowAtIndexPath:indexPath animated:YES];
    
    [_cellSelected removeAllObjects];
    
        [_cellSelected addObject:indexPath];
    
    
    if (indexPath.row==0) {
        
        [[NSUserDefaults standardUserDefaults]setObject:@"en" forKey:@"langugae"];
        [[NSUserDefaults standardUserDefaults]synchronize];
//        [self mStartIndicater];
        
        
         [self performSelectorInBackground:@selector(CallTheServer_show_Update:) withObject:@"0"];
        
       // [self performSelector:@selector(CallTheServer_show_Update:) withObject:@"0" afterDelay:0.5];
        
        
        }
            else
            {
                [[NSUserDefaults standardUserDefaults]setObject:@"sw" forKey:@"langugae"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
//                [self mStartIndicater];
                
                
                [self performSelectorInBackground:@selector(CallTheServer_show_Update:) withObject:@"1"];
                
                
//                [self performSelector:@selector(CallTheServer_show_Update:) withObject:@"1" afterDelay:0.5];
            }
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]isEqualToString:@"sw"]) {
        [language_ARR addObject:@"engelska"];
        [language_ARR addObject:@"svenska"];
        
          myIP = [NSIndexPath indexPathForRow:1 inSection:0] ;
        
        
        
    }
    else
    {
        [language_ARR addObject:@"English"];
        [language_ARR addObject:@"Swedish"];
        
         myIP = [NSIndexPath indexPathForRow:0 inSection:0] ;
        
        
        
        
    }

    
    
        [mtableview reloadData];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"REfress_Right_screen"
     object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"REfress_NEWS_Home"
     object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"REfress_NEWS_Post"
     object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"REfress_NEWS_EDIT"
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"REfress_EDU_Home"
     object:nil];

    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"REfress_EDU_POST"
     object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"REfress_EDU_EDIT"
     object:nil];
    
    
    //*********** Attendance_overview_List **************
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"REfress_Attendance_overview"
     object:nil];
    
    
    
    //*********** Globle Refress **************

    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"REfress_retrieval_list"
     object:nil];

    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"REfress_User_panel"
     object:nil];
    
    
    
    
    [self Navigation_bar];

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }



#pragma mark - -*********************
#pragma mark CallTheServer_Login_API Method
#pragma mark - -*********************


-(void)CallTheServer_show_Update:(NSString *)value
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&user_id=%@&device_token=%@&language=%@&language_device=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],value]:[NSString stringWithFormat:@"%@news/update_settings",[Utilities API_link_url_subDomain]]];
        
        
        NSLog(@"%@",responseString);
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
    
    //mtableview.userInteractionEnabled=YES;
    
    //[self mStopIndicater];
    
    
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
