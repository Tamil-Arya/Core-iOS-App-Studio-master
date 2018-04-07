//
//  Save_Draft_Filter_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 19/01/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Save_Draft_Filter_ViewController.h"
#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "NSString+HTML.h"
#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "ELR_loaders_.h"
#import "Selection_list_ViewController.h"


@interface Save_Draft_Filter_ViewController ()

@end

@implementation Save_Draft_Filter_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Notification=@"";

     
    //////////////////// Screen Back_ground Color \\\\\\\\\\\\\\
    
    self.view.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    
    
    //////////////////// Hide UInavigation Bar \\\\\\\\\\\\\\
    
    self.navigationController.navigationBarHidden=YES;
    
    
    
    UIDatePicker *picker1   = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 210, 320, 216)];
    [picker1 setDatePickerMode:UIDatePickerModeDate];
    picker1.backgroundColor = [UIColor clearColor];
    [picker1 addTarget:self action:@selector(startDateSelected:) forControlEvents:UIControlEventValueChanged];
    
    //    [picker1 addSubview:toolBar];
    // Here birthTxt is Textfield Name replace with your name
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneToucheds:)];
//    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelToucheds:)];

    
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(cancelToucheds:)];
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(doneToucheds:)];
    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    
    
    
    
    ////////////////////Select_Group Lable\\\\\\\\\\\\\\
    
    
    Select_Group_LB=[[UILabel alloc]init];
    // Select_Group_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    Select_Group_LB.frame=CGRectMake(15,50,200, 25);
    Select_Group_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Filter" value:@"" table:nil];
    Select_Group_LB.textColor=[UIColor whiteColor];
    Select_Group_LB.font=[Font_Face_Controller opensanssemibold:16];
    Select_Group_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:Select_Group_LB];
    
     //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Select_Group_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Select_Group_LB.frame.origin.y+Select_Group_LB.frame.size.height, self.view.frame.size.width-30, 35)];
    
    
    Select_Group_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Filter" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    
    Select_Group_TXT.borderStyle = UITextBorderStyleNone;
    Select_Group_TXT.font = [UIFont systemFontOfSize:15];
    Select_Group_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    Select_Group_TXT.delegate = self;
    Select_Group_TXT.backgroundColor=[UIColor whiteColor];
    Select_Group_TXT.textColor=[UIColor blackColor];
    Select_Group_TXT.font=[Font_Face_Controller opensansLight:13];
    Select_Group_TXT.tag=001;
    Select_Group_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    Select_Group_TXT.layer.masksToBounds = YES;
    Select_Group_TXT.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:Select_Group_TXT];
    
       
    ////////////////////Frome Lable\\\\\\\\\\\\\\
    
    
    Frome_LB=[[UILabel alloc]init];
    // Select_Group_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    Frome_LB.frame=CGRectMake(15,Select_Group_TXT.frame.origin.y+Select_Group_TXT.frame.size.height+10,200, 25);
    Frome_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"From" value:@"" table:nil];
    Frome_LB.textColor=[UIColor whiteColor];
    Frome_LB.font=[Font_Face_Controller opensanssemibold:16];
    Frome_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:Frome_LB];
    
    
    
    
    ////////////////////To Lable\\\\\\\\\\\\\\
    
    
    To_LB=[[UILabel alloc]init];
    // Select_Group_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    To_LB.frame=CGRectMake((Select_Group_TXT.frame.size.width+50)/2,Select_Group_TXT.frame.origin.y+Select_Group_TXT.frame.size.height+10,200, 25);
    To_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"To" value:@"" table:nil];
    To_LB.textColor=[UIColor whiteColor];
    To_LB.font=[Font_Face_Controller opensanssemibold:16];
    To_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:To_LB];
    
    
    
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Frome_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Frome_LB.frame.origin.y+Frome_LB.frame.size.height, (Select_Group_TXT.frame.size.width-20)/2, 35)];
    Frome_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YYYY-DD-MM" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    
    Frome_TXT.borderStyle = UITextBorderStyleNone;
    Frome_TXT.font = [UIFont systemFontOfSize:15];
    Frome_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    Frome_TXT.delegate = self;
    Frome_TXT.backgroundColor=[UIColor whiteColor];
    Frome_TXT.textColor=[UIColor blackColor];
    Frome_TXT.font=[Font_Face_Controller opensansLight:13];
    Frome_TXT.tag=004;
    Frome_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    Frome_TXT.layer.masksToBounds = YES;
    Frome_TXT.textAlignment=NSTextAlignmentCenter;
    Frome_TXT.rightViewMode = UITextFieldViewModeAlways;
    Frome_TXT.rightView = [self golble_img:(Select_Group_TXT.frame.size.height-30)/2];
    
    Frome_TXT.inputView  = picker1;
    [self.view addSubview:Frome_TXT];
    Frome_TXT.inputAccessoryView = toolBar;
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    To_TXT = [[UITextField alloc] initWithFrame:CGRectMake((Select_Group_TXT.frame.size.width+50)/2, To_LB.frame.origin.y+To_LB.frame.size.height, (Select_Group_TXT.frame.size.width-20)/2, 35)];
    To_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YYYY-DD-MM" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    
    To_TXT.borderStyle = UITextBorderStyleNone;
    To_TXT.font = [UIFont systemFontOfSize:15];
    To_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    To_TXT.delegate = self;
    To_TXT.backgroundColor=[UIColor whiteColor];
    To_TXT.textColor=[UIColor blackColor];
    To_TXT.font=[Font_Face_Controller opensansLight:13];
    To_TXT.tag=005;
    To_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    To_TXT.layer.masksToBounds = YES;
    To_TXT.textAlignment=NSTextAlignmentCenter;
    To_TXT.rightViewMode = UITextFieldViewModeAlways;
    To_TXT.rightView = [self golble_img:(Select_Group_TXT.frame.size.height-30)/2];
    
    
    To_TXT.inputView  = picker1;
    
    
    [self.view addSubview:To_TXT];
    To_TXT.inputAccessoryView = toolBar;
    
    
    
    
    
    //////////////////// Save_Draft No Button\\\\\\\\\\\\\\
    
    check_uncheck = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [check_uncheck addTarget:self
                      action:@selector(aMethod_CHeck_Uncheck:)
            forControlEvents:UIControlEventTouchUpInside];
    check_uncheck.backgroundColor=[UIColor whiteColor];
    check_uncheck.frame = CGRectMake(15,To_TXT.frame.origin.y+To_TXT.frame.size.height+10,20, 20);
    [self.view addSubview:check_uncheck];
    
    
    
    
    
    
    Notify_LB=[[UILabel alloc]init];
    Notify_LB.backgroundColor=[UIColor clearColor];
    Notify_LB.frame=CGRectMake(check_uncheck.frame.origin.x+check_uncheck.frame.size.width+5,To_TXT.frame.origin.y+To_TXT.frame.size.height+10,150, 20);
    Notify_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Mine Only" value:@"" table:nil];
    Notify_LB.textColor=[UIColor whiteColor];
    Notify_LB.font=[Font_Face_Controller opensansregular:12];
    Notify_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:Notify_LB];

    
    
    
    //////////////////// Remember No Button\\\\\\\\\\\\\\
    
    BTN_Cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [BTN_Cancel addTarget:self
                   action:@selector(aMethod_Cancel:)
         forControlEvents:UIControlEventTouchUpInside];
    BTN_Cancel.backgroundColor=[UIColor colorWithRed:245.0f/255.0f green:186.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    [BTN_Cancel setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] forState:UIControlStateNormal];
    [BTN_Cancel.titleLabel setFont:[Font_Face_Controller opensansregular:20]];
    [BTN_Cancel setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    BTN_Cancel.frame = CGRectMake(0,self.view.frame.size.height-50,(self.view.frame.size.width/2)-5, 50);
    [self.view addSubview:BTN_Cancel];
    
    
    
    
    
    //////////////////// Remember YES Button\\\\\\\\\\\\\\
    
    BTN_Filter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [BTN_Filter addTarget:self
                   action:@selector(aMethod_Filter:)
         forControlEvents:UIControlEventTouchUpInside];
    BTN_Filter.backgroundColor=[UIColor colorWithRed:245.0f/255.0f green:186.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    [BTN_Filter setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Filter" value:@"" table:nil] forState:UIControlStateNormal];
    [BTN_Filter.titleLabel setFont:[Font_Face_Controller opensansregular:20]];
    [BTN_Filter setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    BTN_Filter.frame = CGRectMake((self.view.frame.size.width/2)+5,self.view.frame.size.height-50,(self.view.frame.size.width/2)-5, 50);
    [self.view addSubview:BTN_Filter];
    
    
    
    
    
}


-(void)aMethod_CHeck_Uncheck:(UIButton *)sender
{
    UIButton *BTN=(UIButton *)sender;
    
    
    if (button_check==false) {
        [BTN setBackgroundImage:[UIImage imageNamed:@"with_check.png"] forState:UIControlStateNormal];
        button_check=true;
        
        
        Notification=@"1";
        
    }
    else
    {
        [BTN setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        button_check=false;
        
        Notification=@"";
    }
    
       
}



-(void)viewWillAppear:(BOOL)animated
{    [super viewWillAppear:YES];

    self.navigationController.navigationBarHidden=YES;
}



- (void)startDateSelected:(id)sender
{
    
    // 2015-05-08 11:03:03 +0000
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd  HH:mm:ss Z"];
    
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[sender date]]];
    
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"YYYY-MM-dd"];
    NSString *newDateString = [dateFormatter2 stringFromDate:date];
    
    NSLog(@"value: %@",newDateString);
    
    pickre_STR =newDateString;
    
    NSLog(@"value: %@",[sender date]);
    
}



- (void)cancelToucheds:(UIBarButtonItem *)sender
{
    //    if (tagvale==004) {
    //        pickre_STR=nil;
    //    }
    //    else
    //    {
    //
    //    }
    
    // hide the picker view
    [self.view endEditing:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        //scrollview.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        //scrollview.contentSize = CGSizeMake(self.view.frame.size.width, 568);
        [UIView commitAnimations];
    });
    
}

- (void)doneToucheds:(UIBarButtonItem *)sender
{
    
    
    [self.view endEditing:YES];
    
    
    if (TXT_tag==004) {
        if ([pickre_STR isEqualToString:@""]||[pickre_STR isEqualToString:nil] || [pickre_STR isEqual:nil] || [pickre_STR length]==0) {
            
            NSDate *todayDate = [NSDate date]; // get today date
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
            [dateFormatter setDateFormat:@"YYYY-MM-dd"]; //Here we can set the format which we need
            NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];// here convert date in
            
            
            
            
            Frome_TXT.text=convertedDateString;
            
        }
        else
        {
            
            
            Frome_TXT.text=pickre_STR;
        }
        
    }
    else if (TXT_tag==005)
    {
        if ([pickre_STR isEqualToString:@""]||[pickre_STR isEqualToString:nil] || [pickre_STR isEqual:nil] || [pickre_STR length]==0) {
            NSDate *todayDate = [NSDate date]; // get today date
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
            [dateFormatter setDateFormat:@"YYYY-MM-dd"]; //Here we can set the format which we need
            NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];// here convert date in
            
            
            
            To_TXT.text=convertedDateString;
            
        }
        else
        {
            
            
            To_TXT.text=pickre_STR;
        }
        
    }
    
    
    
    [self.view endEditing:YES];
    
}




-(UIImageView *)golble_img_right:(NSInteger )frames
{
    UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenu.frame = CGRectMake(0, frames, 30, 30);
    [btnMenu setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"] forState:UIControlStateNormal];
    [btnMenu setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    [btnMenu.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:12]];
    
    
    UIImageView *img=[[UIImageView alloc]init];
    img.frame=CGRectMake(0, (Select_Group_TXT.frame.size.height-30)/2, 30, 30);
    
    
    [img addSubview:btnMenu];
    
    return img;
}



-(UIImageView *)golble_img:(NSInteger )frames
{
    UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenu.frame = CGRectMake(0, frames-3, 30, 30);
    [btnMenu setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-down"] forState:UIControlStateNormal];
    [btnMenu setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    [btnMenu.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:12]];
    
    
    UIImageView *img=[[UIImageView alloc]init];
    img.frame=CGRectMake(0, (Select_Group_TXT.frame.size.height-30)/2, 30, 30);
    
    
    [img addSubview:btnMenu];
    
    return img;
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



-(void)aMethod_Cancel:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)aMethod_Filter:(UIButton *)sender
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
    [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"] forKey:@"authentication_token"];
    [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
    [dic setValue:Select_Group_TXT.text forKey:@"Description"];

    [dic setValue:Frome_TXT.text forKey:@"from_date"];
    [dic setValue:To_TXT.text forKey:@"to_date"];
    [dic setValue:Notification forKey:@"Mine_Only"];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"Save_Draft_Post"
     object:dic];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}





- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    TXT_tag=textField.tag;
    
    
    if (textField.tag==004 || textField.tag==005) {
        
        return YES;
        
    }
    else
    {
        
        
        if (textField.tag==001) {
            
return YES;
            
        }
        else if (textField.tag==002 && [[dict_Student valueForKey:@"students"]count]!=0)
        {
            
            Selection_list_ViewController *objSelection_list_ViewController=[[Selection_list_ViewController alloc]init];
            objSelection_list_ViewController.values=dict_Student;
            objSelection_list_ViewController.Main_values=@"students";
            objSelection_list_ViewController.Sub_values=@"name";
            [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
            
            
        }
        else if (textField.tag==003)
        {
            Selection_list_ViewController *objSelection_list_ViewController=[[Selection_list_ViewController alloc]init];
            objSelection_list_ViewController.values=dict_Login;
            
            objSelection_list_ViewController.Main_values=@"curriculum_tags";
            objSelection_list_ViewController.Sub_values=@"title";
            
            [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
        }
        
    }
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
