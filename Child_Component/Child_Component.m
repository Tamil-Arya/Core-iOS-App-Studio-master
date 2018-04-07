//
//  Child_Component.m
//  ELAR
//
//  Created by Bhushan Bawa on 26/02/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Child_Component.h"
#import "Font_Face_Controller.h"
#import "UIImageView+WebCache.h"
#import "Text_color_.h"
#import "ELR_loaders_.h"
#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "NSString+HTML.h"

#import "NSString+FontAwesome.h"
#import "add_absent_note.h"
#import "add_retriever_note.h"
#import "Child_Information.h"
#import "retrieval_note.h"
#import "absent_note.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"

@interface Child_Component ()

@end

@implementation Child_Component
@synthesize indexOfChildSelected;

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
    
  //  user_pic.frame=CGRectMake(50, 0, 30, 30);
    
    CGSize size = CGSizeMake(30, 30);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11){
        
        [user_pic setImage: [ImageCustomClass image:user_pic.image resize:size]];
        
    } else {
        
        user_pic.frame=CGRectMake(0, 0, size.width, size.height);
        
    }
    user_pic.layer.cornerRadius=size.width*0.5;
    user_pic.layer.borderColor=[UIColor clearColor].CGColor;
    user_pic.layer.borderWidth=0;
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
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Child accounts" value:@"" table:nil];
    
    
    
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        
        
        self.navigationItem.hidesBackButton = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 //       UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
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

}

-(void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)load_view
{
    [self Navigation_bar];

    
    componet=[[NSMutableDictionary alloc]init];
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 40, [[UIScreen mainScreen]bounds].size.width-10, [[UIScreen mainScreen]bounds].size.height-40) collectionViewLayout:flowLayout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    _collectionView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_collectionView];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [self mStartIndicater];
    [self performSelector:@selector(CallTheServer_Child_Component_API) withObject:nil afterDelay:0.5];

    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    Current_Date_STR=@"";
    
   [self load_view];
}








-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    
    self.navigationItem.hidesBackButton = YES;
    
    
    //////////////////// Hide UInavigation Bar \\\\\\\\\\\\\\
    
    self.navigationController.navigationBarHidden=NO;
    
    
    
       
    
       self.view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    
}




-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];

    // self.navigationItem.title = @"Back";
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
#pragma mark CallTheServer_Child_Component_API Method
#pragma mark - -*********************


-(void)CallTheServer_Child_Component_API
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&parent_id=%@&selected_date=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_id"],Current_Date_STR,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@users/get_parent_components",[Utilities API_link_url_subDomain]]];
        
      //
        
        
        
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        mutableRetrievedDictionary = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[mutableRetrievedDictionary valueForKey:@"status"] isEqualToString:@"true"]) {
            
            NSLog(@"%@",mutableRetrievedDictionary);

            [[NSUserDefaults standardUserDefaults]setObject:[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:0]valueForKey:@"date"] forKey:@"CalenderDate_Selected"];
            [[NSUserDefaults standardUserDefaults]synchronize];

            
            NSLog(@"%u",[[mutableRetrievedDictionary valueForKey:@"ComComponent"]count]);
            NSLog(@"%@",[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:0]valueForKey:@"name"]);
            
            NSLog(@"%@",[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]valueForKey:@"name"]objectAtIndex:1]);
            [_collectionView reloadData];
            
            
        }else if([[mutableRetrievedDictionary valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[mutableRetrievedDictionary valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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
#pragma mark CallTheServer_Child_Component_Next_date_API Method
#pragma mark - -*********************


-(void)CallTheServer_Child_Component_Next_date_API
{
    if ([API connectedToInternet]==YES) {
        
        
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            NSDate *date = [dateFormatter dateFromString:Current_Date_STR];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            Current_Date_STR = [dateFormatter stringFromDate:date];
        
        //------------ Call API for signup With Post Method --------------//
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&parent_id=%@&selected_date=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_id"],Current_Date_STR,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@users/get_parent_components",[Utilities API_link_url_subDomain]]];
        
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        UpdateRetrievedDictionary = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[UpdateRetrievedDictionary valueForKey:@"status"] isEqualToString:@"true"]) {
            
          
            NSMutableDictionary *cellDict = [[UpdateRetrievedDictionary valueForKey:@"ComComponent"] mutableCopy];
            
            
        
            [[mutableRetrievedDictionary valueForKey:@"ComComponent"] replaceObjectAtIndex:0 withObject:cellDict];

            NSLog(@"%@",mutableRetrievedDictionary);
            
            
            [_collectionView reloadData];
            
            
        }else if([[UpdateRetrievedDictionary valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[UpdateRetrievedDictionary valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //  return  [[dict valueForKey:@"Offer Detail"]count];
    
    return  [[mutableRetrievedDictionary valueForKey:@"ComComponent"]count];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    for (UIView *subView in [cell subviews]) {
        [subView removeFromSuperview];
    }
    
    
    panel_IMG = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width-40)/2, (cell.frame.size.height-40)/2, 40,40)];
    
    
    
    
    [cell addSubview:panel_IMG];
    
    
    
    
    Component_name=[[UILabel alloc]initWithFrame:CGRectMake(10,10, (cell.frame.size.width-10)/2,40)];
    Component_name.text=[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"name"];
    Component_name.textColor=[UIColor whiteColor];
    Component_name.font=[Font_Face_Controller opensanssemibold:13];
   
    [cell addSubview:Component_name];
    
    
    
    if ([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"id"]isEqualToString:@"0"]) {
        
        Component_name.frame=CGRectMake(5,10,100,20);
         Component_name.textAlignment=NSTextAlignmentLeft;
        Component_name.font=[Font_Face_Controller opensansLight:13];
        
        Current_Date=[[UITextField alloc]initWithFrame:CGRectMake(cell.frame.size.width-105, 10, 100,20)];
        Current_Date.borderStyle=UITextBorderStyleNone;
        Current_Date.text=[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"date"];
        Current_Date.textColor=[UIColor whiteColor];
        Current_Date.font=[Font_Face_Controller opensansLight:10];
        Current_Date.textAlignment=NSTextAlignmentRight;
        Current_Date.backgroundColor=[UIColor clearColor];
        [cell addSubview:Current_Date];
        
        datepicker=[[UIDatePicker alloc]init];
        datepicker.datePickerMode=UIDatePickerModeDate;
        [Current_Date setInputView:datepicker];
        
        UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        [toolBar setTintColor:[UIColor grayColor]];
        
        
        
        
        UIBarButtonItem *Cancel=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedCancel)];
        
        UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate)];
        UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBar setItems:[NSArray arrayWithObjects:Cancel,space,doneBtn, nil]];
        [Current_Date setInputAccessoryView:toolBar];

        
        
        NSLog(@"%@",[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"drop_off_time"]);
        
        
         NSLog(@"%@",[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"retrieval_time"]);
                     
        
        
        if (![[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"drop_off_time"]isEqualToString:@""] && ![[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"retrieval_time"]isEqualToString:@""]) {
            
            if ([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"absent"]isEqualToString:@"true"]) {
                
             Show_msg=[[UILabel alloc]initWithFrame:CGRectMake(10, (cell.frame.size.height-20)/2, cell.frame.size.width-20,20)];
                Show_msg.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent" value:@"" table:nil];
                Show_msg.textColor=[UIColor whiteColor];
                Show_msg.font=[Font_Face_Controller opensansLight:9];
                Show_msg.textAlignment=NSTextAlignmentCenter;
                [cell addSubview:Show_msg];
                
            }
            else
            {
        
        Todays_Dropoff_Time=[[UILabel alloc]initWithFrame:CGRectMake(10, (cell.frame.size.height-40)/2, cell.frame.size.width-20,20)];
        Todays_Dropoff_Time.text=[NSString stringWithFormat:@"%@ %@",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Todays Dropoff Time :" value:@"" table:nil],[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"drop_off_time"]];
        Todays_Dropoff_Time.textColor=[UIColor whiteColor];
        Todays_Dropoff_Time.font=[Font_Face_Controller opensansLight:9];
        Todays_Dropoff_Time.textAlignment=NSTextAlignmentCenter;
        [cell addSubview:Todays_Dropoff_Time];

        
        
        Todays_Retrival_Time=[[UILabel alloc]initWithFrame:CGRectMake(10, Todays_Dropoff_Time.frame.origin.y+Todays_Dropoff_Time.frame.size.height, cell.frame.size.width-20,20)];
        Todays_Retrival_Time.text=[NSString stringWithFormat:@"%@ %@",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Todays Retrival Time :" value:@"" table:nil],[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"retrieval_time"]];
        Todays_Retrival_Time.textColor=[UIColor whiteColor];
        Todays_Retrival_Time.font=[Font_Face_Controller opensansLight:9];
        Todays_Retrival_Time.textAlignment=NSTextAlignmentCenter;
        [cell addSubview:Todays_Retrival_Time];
            }
        
        
        }
        else
        {
            if ([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"current_day"]isEqualToString:@"Sun"]) {
                
                
                Show_msg=[[UILabel alloc]initWithFrame:CGRectMake(10, (cell.frame.size.height-20)/2, cell.frame.size.width-20,20)];
                Show_msg.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Sunday" value:@"" table:nil];
                Show_msg.textColor=[UIColor whiteColor];
                Show_msg.font=[Font_Face_Controller opensansLight:9];
                Show_msg.textAlignment=NSTextAlignmentCenter;
                [cell addSubview:Show_msg];
                
                
                
            }

        }


        Pre_BTN = [UIButton buttonWithType: UIButtonTypeCustom];
        [Pre_BTN setFrame:CGRectMake(-10, (cell.frame.size.height-30)/2  , 30, 30)];
        [Pre_BTN setTitle:nil forState: UIControlStateNormal];
        [Pre_BTN setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-left"] forState:UIControlStateNormal];
        [Pre_BTN.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:15]];
        [Pre_BTN addTarget:self action:@selector(dateChangedPrevious) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:Pre_BTN];
        
        
        Next_BTN = [UIButton buttonWithType: UIButtonTypeCustom];
        [Next_BTN setFrame:CGRectMake(cell.frame.size.width-20, (cell.frame.size.height-30)/2 , 30, 30)];
        [Next_BTN setTitle:nil forState: UIControlStateNormal];
        [Next_BTN setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"] forState:UIControlStateNormal];
        [Next_BTN.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:15]];
        [Next_BTN addTarget:self action:@selector(dateChangedNext) forControlEvents:UIControlEventTouchUpInside];
        Next_BTN.titleLabel.textAlignment=NSTextAlignmentLeft;
        [cell addSubview:Next_BTN];

        
        
        cell.backgroundColor=[Text_color_ Retrieval_Color_code];
        
        Component_name.backgroundColor=[Text_color_ Retrieval_Color_code];
        
        
        if ([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"absent_note_icon"]isEqualToString:@"true"] && [[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"retriever_icon"]isEqualToString:@"true"]) {
            
            
            
            
            NSLog(@"%@",[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"leave_type"]);
            
        
        
        absent_note_IMG = [UIButton buttonWithType:UIButtonTypeCustom];
       [absent_note_IMG addTarget:self action:@selector(absent_note_IMG) forControlEvents:UIControlEventTouchUpInside];
        absent_note_IMG.frame=CGRectMake(cell.frame.size.width-30, cell.frame.size.height-30 , 20, 20);
            
            if([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"leave_type"]isEqualToString:@"sick"]){
                
                [absent_note_IMG setImage:[UIImage imageNamed:@"sickleave.png"] forState:UIControlStateNormal];
                
                
            }else if([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"leave_type"]isEqualToString:@"leave"]){
                
                
                [absent_note_IMG setImage:[UIImage imageNamed:@"vacation.png"] forState:UIControlStateNormal];
                
                
                
            }else if([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"leave_type"]isEqualToString:@"other"]){
                
                [absent_note_IMG setImage:[UIImage imageNamed:@"retrieval_note.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                  [absent_note_IMG setImage:[UIImage imageNamed:@"sickleave.png"] forState:UIControlStateNormal];
            }
            

            
        [cell addSubview:absent_note_IMG];
        
        
        retrival_note_IMG = [UIButton buttonWithType:UIButtonTypeCustom];
        [retrival_note_IMG addTarget:self action:@selector(retrival_note_IMG) forControlEvents:UIControlEventTouchUpInside];
        retrival_note_IMG.frame=CGRectMake(cell.frame.size.width-60, cell.frame.size.height-30 , 20, 20);
             [retrival_note_IMG setImage:[UIImage imageNamed:@"vanner.png"] forState:UIControlStateNormal];
        [cell addSubview:retrival_note_IMG];
        }
        else if ([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"absent_note_icon"]isEqualToString:@"true"])
        {
            absent_note_IMG = [UIButton buttonWithType:UIButtonTypeCustom];
            [absent_note_IMG addTarget:self action:@selector(absent_note_IMG) forControlEvents:UIControlEventTouchUpInside];
            absent_note_IMG.backgroundColor=[UIColor redColor];
            absent_note_IMG.frame=CGRectMake(cell.frame.size.width-30, cell.frame.size.height-30 , 20, 20);
            
            
            if([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"leave_type"]isEqualToString:@"sick"]){
                
                 [absent_note_IMG setImage:[UIImage imageNamed:@"sickleave.png"] forState:UIControlStateNormal];
                
                
            }else if([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"leave_type"]isEqualToString:@"leave"]){
                
                
                [absent_note_IMG setImage:[UIImage imageNamed:@"vacation.png"] forState:UIControlStateNormal];

                
                
            }else if([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"leave_type"]isEqualToString:@"other"]){
                
                [absent_note_IMG setImage:[UIImage imageNamed:@"retrieval_note.png"] forState:UIControlStateNormal];

            }
           
            else
            {
                [absent_note_IMG setImage:[UIImage imageNamed:@"sickleave.png"] forState:UIControlStateNormal];
            }
            
            [cell addSubview:absent_note_IMG];

        }
        
        else if([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"retriever_icon"]isEqualToString:@"true"])
        {
            retrival_note_IMG = [UIButton buttonWithType:UIButtonTypeCustom];
            [retrival_note_IMG addTarget:self action:@selector(retrival_note_IMG) forControlEvents:UIControlEventTouchUpInside];
            retrival_note_IMG.frame=CGRectMake(cell.frame.size.width-30, cell.frame.size.height-30 , 20, 20);
            [cell addSubview:retrival_note_IMG];
            
            [retrival_note_IMG setImage:[UIImage imageNamed:@"vanner.png"] forState:UIControlStateNormal];
            

        }

        
    }
    else if ([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"1"])
    {
        
        
        NSLog(@"%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"img_path"]]]);
        
        
        Component_name.frame=CGRectMake(0, panel_IMG.frame.origin.y+panel_IMG.frame.size.height+10, cell.frame.size.width,40);
        Component_name.textAlignment=NSTextAlignmentCenter;
        
        cell.backgroundColor=[Text_color_ Absence_note_Color_code];
        
        Component_name.backgroundColor=[Text_color_ Absence_note_Color_code];
        panel_IMG.backgroundColor=[Text_color_ Absence_note_Color_code];
        [panel_IMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"img_path"]]]
                     placeholderImage:[UIImage imageNamed:@"Placeholding.png"]];

        
    }
    else if ([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"2"])
    {
        
         Component_name.frame=CGRectMake(0, panel_IMG.frame.origin.y+panel_IMG.frame.size.height+10, cell.frame.size.width,40);
        Component_name.textAlignment=NSTextAlignmentCenter;
        cell.backgroundColor=[Text_color_ EDU_Blog_Color_code];
        
        Component_name.backgroundColor=[Text_color_ EDU_Blog_Color_code];
        [panel_IMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"img_path"]]]
                     placeholderImage:[UIImage imageNamed:@"Placeholding.png"]];

       
        
        
        
    }
    else if ([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"3"])
    {
        
        
        NSLog(@"%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"img_path"]]]);
        
         Component_name.frame=CGRectMake(0, panel_IMG.frame.origin.y+panel_IMG.frame.size.height+10, cell.frame.size.width,40);
        Component_name.textAlignment=NSTextAlignmentCenter;
        cell.backgroundColor=[Text_color_ Child_info_Color_code];
        [panel_IMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"img_path"]]]
                     placeholderImage:[UIImage imageNamed:@"Placeholding.png"]];


    }
    
    return cell;
}

-(void)retrival_note_IMG
{
    retrieval_note *objretriever_note = [[retrieval_note alloc]init];
    
  
    
    objretriever_note.date_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
    
    
//    if([sender.currentTitle isEqualToString:@"color1"]){
//        
//        objretriever_note.color = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
//    }else if([sender.currentTitle isEqualToString:@"color2"]){
//        
//        objretriever_note.color = [UIColor colorWithRed:90.0f/255.0f green:187.0f/255.0f blue:94.0f/255.0f alpha:1.0];
//    }else if([sender.currentTitle isEqualToString:@"color3"]){
//        
//        objretriever_note.color= [UIColor colorWithRed:47.0f/255.0f green:188.0f/255.0f blue:208.0f/255.0f alpha:1.0];
//    }else if([sender.currentTitle isEqualToString:@"color4"]){
//        
//        objretriever_note.color = [UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
//    }else if([sender.currentTitle isEqualToString:@"color5"]){
//        
//        objretriever_note.color = [UIColor colorWithRed:136.0f/255.0f green:99.0f/255.0f blue:169.0f/255.0f alpha:1.0];
//    }else if([sender.currentTitle isEqualToString:@"color6"]){
//        
//        objretriever_note.color = [UIColor colorWithRed:236.0f/255.0f green:116.0f/255.0f blue:169.0f/255.0f alpha:1.0];
//    }else if([sender.currentTitle isEqualToString:@"color7"]){
//        
//        objretriever_note.color = [UIColor colorWithRed:241.0f/255.0f green:90.0f/255.0f blue:107.0f/255.0f alpha:1.0];
//    }
//    NSLog(@"%@",sender.currentTitle);
    //[[NSUserDefaults standardUserDefaults] setValue:sender.currentTitle forKey:@"student_id"];
    [self.navigationController pushViewController:objretriever_note animated:YES];
}



-(void)absent_note_IMG
{
    
    
      absent_note *objabsent_note = [[absent_note alloc]init];
    objabsent_note.date_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
    [self.navigationController pushViewController:objabsent_note animated:YES];
    
//    if([sender.currentTitle isEqualToString:@"color1"]){
//        
//        objabsent_note.color = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
//    }else if([sender.currentTitle isEqualToString:@"color2"]){
//        
//        objabsent_note.color = [UIColor colorWithRed:90.0f/255.0f green:187.0f/255.0f blue:94.0f/255.0f alpha:1.0];
//    }else if([sender.currentTitle isEqualToString:@"color3"]){
//        
//        objabsent_note.color= [UIColor colorWithRed:47.0f/255.0f green:188.0f/255.0f blue:208.0f/255.0f alpha:1.0];
//    }else if([sender.currentTitle isEqualToString:@"color4"]){
//        
//        objabsent_note.color = [UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
//    }else if([sender.currentTitle isEqualToString:@"color5"]){
//        
//        objabsent_note.color = [UIColor colorWithRed:136.0f/255.0f green:99.0f/255.0f blue:169.0f/255.0f alpha:1.0];
//    }else if([sender.currentTitle isEqualToString:@"color6"]){
//        
//        objabsent_note.color = [UIColor colorWithRed:236.0f/255.0f green:116.0f/255.0f blue:169.0f/255.0f alpha:1.0];
//    }else if([sender.currentTitle isEqualToString:@"color7"]){
//        
//        objabsent_note.color = [UIColor colorWithRed:241.0f/255.0f green:90.0f/255.0f blue:107.0f/255.0f alpha:1.0];
//    }
//    

}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSLog(@"%f",[[UIScreen mainScreen] bounds].size.width);
    
    
    
    if ((int)[[UIScreen mainScreen] bounds].size.width == 320)
    {
        retval = CGSizeMake(145, 145);
    }
    
    else if ((int)[[UIScreen mainScreen] bounds].size.width == 375)
    {
        retval = CGSizeMake(172, 172);
    }
    
    
    
    else {
        
        retval = CGSizeMake(192, 192);
    }
    
    
    
    return retval;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%@",[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"date"]);
    
    
    
    [[NSUserDefaults standardUserDefaults]setValue:Current_Date.text forKey:@"CalenderDate_Selected"];
    [[NSUserDefaults standardUserDefaults]synchronize];

     NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]);
    
    
    if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"0"]) {
        
        
        
    }
    else if ([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"1"])
    {
        add_absent_note *objadd_absent_note=[[add_absent_note alloc]init];
        objadd_absent_note.add_check=@"yes";
        [self.navigationController pushViewController:objadd_absent_note animated:YES];    }
    else if ([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"2"])
    {
        
        add_retriever_note *objadd_retriever_note=[[add_retriever_note alloc]init];
         objadd_retriever_note.add_check=@"yes";
        [self.navigationController pushViewController:objadd_retriever_note animated:YES];
    }
    
    else if ([[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"3"])
    {
        
       Child_Information *obj_EDU_Blog_Home_screen_ViewController=[[Child_Information alloc]init];
        [self.navigationController pushViewController:obj_EDU_Blog_Home_screen_ViewController animated:YES];
    }

}


-(void)ShowSelectedCancel
{
    [Current_Date resignFirstResponder];
    
}

-(void)ShowSelectedDate
{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    // [formatter setDateFormat:@"dd/MMM/YYYY"];
    Current_Date.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datepicker.date]];
    
    
    [[NSUserDefaults standardUserDefaults]setObject: Current_Date.text forKey:@"CalenderDate_Selected"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
         Current_Date_STR=Current_Date.text;
    
    
    [Current_Date resignFirstResponder];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Child_Component_Next_date_API) withObject:nil afterDelay:0.5];
    
}



-(void)dateChangedNext
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date_to_be_incremented = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]];
    
    int daysToAdd = 1;
    NSDate *updated_date = [date_to_be_incremented dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    NSString *date_correct_format = [dateFormatter stringFromDate:updated_date];
    [[NSUserDefaults standardUserDefaults] setValue:date_correct_format forKey:@"CalenderDate_Selected"];
    
    
    Current_Date.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
     Current_Date_STR=Current_Date.text;
    
    //[selected_date_btn setTitle:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"] forState: UIControlStateNormal];
    
   [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Child_Component_Next_date_API) withObject:nil afterDelay:0.5];

}

-(void)dateChangedPrevious
{
    // handle previous date changes
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date_to_be_incremented = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]];
    
    int daysToAdd = -1;
    NSDate *updated_date = [date_to_be_incremented dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    NSString *date_correct_format = [dateFormatter stringFromDate:updated_date];
    [[NSUserDefaults standardUserDefaults] setValue:date_correct_format forKey:@"CalenderDate_Selected"];
    
    
    Current_Date.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
         Current_Date_STR=Current_Date.text;
    
    // [selected_date_btn setTitle:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"] forState: UIControlStateNormal];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Child_Component_Next_date_API) withObject:nil afterDelay:0.5];
}






- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
