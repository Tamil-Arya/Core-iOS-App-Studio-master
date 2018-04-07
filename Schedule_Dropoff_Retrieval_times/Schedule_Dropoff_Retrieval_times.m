//
//  Schedule_Dropoff_Retrieval_times.m
//  ELAR
//
//  Created by Bhushan Bawa on 04/03/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Schedule_Dropoff_Retrieval_times.h"
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
#import "ELR_loaders_.h"
#import "Select_Week.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"
@interface Schedule_Dropoff_Retrieval_times ()

@end

@implementation Schedule_Dropoff_Retrieval_times




- (void) receiveTestNotification1:(NSNotification *) notification
{
    [self mStartIndicater];
    
    
    NSLog(@"%@", notification.object);
    Get_id=[[NSMutableArray alloc]init];
    
    [Get_id addObjectsFromArray:notification.object];
    
    if (!(Get_id.count==0)) {
        
        
        if ([[Get_id objectAtIndex:0]isEqualToString:@"all"]) {
            
            
            Select_Group_TXT.placeholder=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"All" value:@"" table:nil];
        }
        else
        {
            
            Select_Group_TXT.text=[NSString stringWithFormat:@"%d %@",Get_id.count,[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Groups" value:@"" table:nil]];
        }
        
    }
    
    
    
    [self performSelector:@selector(CallTheServer_Student_API:) withObject:notification.object afterDelay:0.5];
    
}

- (void) receiveTestNotification2:(NSNotification *) notification
{
    
    NSLog(@"%@", notification.object);
    NSString  *Count=notification.object;
    
    NSLog(@"%@", Count);
    
    
    current_section=[Count intValue];

    Select_Knowledge_Areas_TXT.text=Count;
    
    
    schedule_Dropoff=[[NSMutableDictionary alloc]init];
    
   NSMutableDictionary *schedule_Dropoffss=[[NSMutableDictionary alloc]init];
    
    NSMutableArray *dashhh=[[NSMutableArray alloc]init];

    
    for (int ss=1; ss<=current_section; ss++) {

        NSMutableDictionary *dash;
        NSMutableArray *dash11=[[NSMutableArray alloc]init];
        
    for (int s=0; s<=6; s++) {
        dash=[[NSMutableDictionary alloc]init];
        [dash setValue:@"" forKey:@"std_left_time"];
        [dash setValue:@"" forKey:@"std_retrieval_time"];
        [dash11 addObject:dash];
    }
    [dashhh addObject:dash11];
        
    }
    
    
    [schedule_Dropoff setValue:dashhh forKey:@"time"];
    
    [mtableview reloadData];
    
}

- (void) receiveTestNotification3:(NSNotification *) notification
{
    Get_Student=[[NSMutableArray alloc]init];
    [Get_Student addObjectsFromArray:notification.object];
    
    
    
    if (Get_Student.count==0) {
        
        
        Select_Student_TXT.placeholder=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"All" value:@"" table:nil];
    }
    else
    {
        
        Select_Student_TXT.text=[NSString stringWithFormat:@"%d %@",Get_Student.count,[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Users" value:@"" table:nil]];
    }
    
    
    
    NSLog(@"%@", notification.object);
    
    
    
}


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
//    user_pic = [[UIImageView alloc] init];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"USR_image"]]);
//    [user_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"customer_logo"]]]
//                placeholderImage:[UIImage imageNamed:@"profile9.png"]];
//    
//    user_pic.frame=CGRectMake(50, 0, 30, 30);
//    user_pic.layer.cornerRadius=30*0.5;
//    user_pic.layer.borderColor=[UIColor clearColor].CGColor;
//    user_pic.layer.borderWidth=1;
//    user_pic.clipsToBounds=YES;
//    user_pic.userInteractionEnabled=YES;
//    user_pic.contentMode = UIViewContentModeScaleToFill;
//    user_pic.backgroundColor=[UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
//    UIBarButtonItem *imageButton = [[UIBarButtonItem alloc] initWithCustomView:user_pic];
//    self.navigationItem.rightBarButtonItem = imageButton;
//    
//    UITapGestureRecognizer *tap_action_slider = [[UITapGestureRecognizer alloc]
//                                                 initWithTarget:self
//                                                 action:@selector(Action_slider)];
//    
//    [user_pic addGestureRecognizer:tap_action_slider];
//    
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName:[Font_Face_Controller opensanssemibold:15],
                                                                    NSForegroundColorAttributeName: [UIColor blackColor]
                                                                    };
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule attendance" value:@"" table:nil];
    
    
    self.navigationItem.hidesBackButton = YES;
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
    
    
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    UIButton *Done = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [Done setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Set time" value:@"" table:nil] forState:UIControlStateNormal];
    
    [Done addTarget:self action:@selector(aMethod_Filter) forControlEvents:UIControlEventTouchUpInside];
    Done.frame = CGRectMake(0, 0, 80, 20);
    [Done setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    Done.titleLabel.font = [Font_Face_Controller opensanssemibold:12];
    
    UIBarButtonItem *Done_btn = [[UIBarButtonItem alloc] initWithCustomView:Done];
    self.navigationItem.rightBarButtonItem = Done_btn;

    

}

-(void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    current_section=1;
    
    
  schedule_Dropoff=[[NSMutableDictionary alloc]init];
    
    NSMutableDictionary *dash;
    NSMutableArray *dash11=[[NSMutableArray alloc]init];
    NSMutableArray *dashhh=[[NSMutableArray alloc]init];
    
    for (int s=0; s<=6; s++) {
        dash=[[NSMutableDictionary alloc]init];
        [dash setValue:@"" forKey:@"std_left_time"];
        [dash setValue:@"" forKey:@"std_retrieval_time"];
        [dash11 addObject:dash];
    }
    [dashhh addObject:dash11];
    [schedule_Dropoff setValue:dashhh forKey:@"time"];
    
    
    [self Navigation_bar];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Publish_type"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EDU_Group_List"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EDU_Student_List"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Tages"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    Get_id=[[NSMutableArray alloc]init];
    Get_Student=[[NSMutableArray alloc]init];
    Get_Tages=[[NSMutableArray alloc]init];
    
    
    user_pic = [[UIImageView alloc] init];
   
    
    
    pickre_Tags=@"";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification1:)
                                                 name:@"TestNotification1"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification2:)
                                                 name:@"TestNotification2"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification3:)
                                                 name:@"TestNotification3"
                                               object:nil];
    
    
    
    
    TXT_tag=001;
    
    //////////////////// Screen Back_ground Color \\\\\\\\\\\\\\
    
    self.view.backgroundColor=[Text_color_ Retrieval_Color_code];
    
    
    //////////////////// Hide UInavigation Bar \\\\\\\\\\\\\\
    
    
    
    picker1   = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 210, 320, 216)];
    [picker1 setDatePickerMode:UIDatePickerModeDate];
    picker1.backgroundColor = [UIColor clearColor];
    [picker1 addTarget:self action:@selector(startDateSelected:) forControlEvents:UIControlEventValueChanged];
    picker1.tag=110;
    
    
    picker2   = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 210, 320, 216)];
    [picker2 setDatePickerMode:UIDatePickerModeTime];
    picker2.backgroundColor = [UIColor clearColor];
    [picker2 addTarget:self action:@selector(startDateSelected:) forControlEvents:UIControlEventValueChanged];
    picker2.tag=111;
    
    
    // add a toolbar with Cancel & Done button
   toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneToucheds:)];
//    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelToucheds:)];

    
    
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(cancelToucheds:)];
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(doneToucheds:)];

    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    
    
    
    
    ////////////////////Select_Group Lable\\\\\\\\\\\\\\
    
    
    Select_Group_LB=[[UILabel alloc]init];
    Select_Group_LB.frame=CGRectMake(15,70,200, 25);
    Select_Group_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Group" value:@"" table:nil];
    Select_Group_LB.textColor=[UIColor whiteColor];
    Select_Group_LB.font=[Font_Face_Controller opensanssemibold:16];
    Select_Group_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:Select_Group_LB];
    
    
    
    
    
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Select_Group_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Select_Group_LB.frame.origin.y+Select_Group_LB.frame.size.height, self.view.frame.size.width-30, 35)];
    
    
    Select_Group_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Multiple Groups" value:@"" table:nil]
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
    Select_Group_TXT.textAlignment=NSTextAlignmentCenter;
    
    
    Select_Group_TXT.rightViewMode = UITextFieldViewModeAlways;
    Select_Group_TXT.rightView = [self golble_img_right:(Select_Group_TXT.frame.size.height-30)/2];
    [self.view addSubview:Select_Group_TXT];
    
    
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"teacher"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"lärare"]) {
        
        
        //////////////////// Select_Student Lable\\\\\\\\\\\\\\
        
        
        
        Select_Student_LB=[[UILabel alloc]init];
        // Select_Student_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
        Select_Student_LB.frame=CGRectMake(15,Select_Group_TXT.frame.origin.y+Select_Group_TXT.frame.size.height+20,200, 25);
        Select_Student_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Students" value:@"" table:nil];
        Select_Student_LB.textColor=[UIColor whiteColor];
        Select_Student_LB.font=[Font_Face_Controller opensanssemibold:16];
        Select_Student_LB.textAlignment=NSTextAlignmentLeft;
        [self.view addSubview:Select_Student_LB];
        
        
        
        
        //////////////////// Schools  TextField \\\\\\\\\\\\\\
        
        Select_Student_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Select_Student_LB.frame.origin.y+Select_Student_LB.frame.size.height, self.view.frame.size.width-30, 35)];
        
        Select_Student_TXT.attributedPlaceholder =
        [[NSAttributedString alloc]
         initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"All" value:@"" table:nil]
         attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
        
        
        Select_Student_TXT.borderStyle = UITextBorderStyleNone;
        Select_Student_TXT.font = [UIFont systemFontOfSize:15];
        Select_Student_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
        Select_Student_TXT.delegate = self;
        Select_Student_TXT.backgroundColor=[UIColor whiteColor];
        Select_Student_TXT.textColor=[UIColor blackColor];
        Select_Student_TXT.font=[Font_Face_Controller opensansLight:13];
        Select_Student_TXT.tag=002;
        Select_Student_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        Select_Student_TXT.layer.masksToBounds = YES;
        Select_Student_TXT.textAlignment=NSTextAlignmentCenter;
        
        
        Select_Student_TXT.rightViewMode = UITextFieldViewModeAlways;
        Select_Student_TXT.rightView = [self golble_img_right:(Select_Student_TXT.frame.size.height-30)/2];
        [self.view addSubview:Select_Student_TXT];
        
    }
    
    else
    {
        
        Select_Student_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Select_Group_LB.frame.origin.y+Select_Group_LB.frame.size.height, self.view.frame.size.width-30, 0)];
        
        
        Select_Student_TXT.frame= CGRectMake(15,Select_Group_TXT.frame.origin.y+Select_Group_TXT.frame.size.height-20,self.view.frame.size.width-30, 0);
        
    }
    
    
    NSLog(@"%f",Select_Student_TXT.frame.origin.y);
    
    
    
    
    ////////////////////Frome Lable\\\\\\\\\\\\\\
    
    
    Frome_LB=[[UILabel alloc]init];
    // Select_Group_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    Frome_LB.frame=CGRectMake(15,Select_Student_TXT.frame.origin.y+Select_Student_TXT.frame.size.height+10,200, 25);
    Frome_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"From" value:@"" table:nil];
    Frome_LB.textColor=[UIColor whiteColor];
    Frome_LB.font=[Font_Face_Controller opensanssemibold:16];
    Frome_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:Frome_LB];
    
    
    
    
    ////////////////////To Lable\\\\\\\\\\\\\\
    
    
    To_LB=[[UILabel alloc]init];
    // Select_Group_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    To_LB.frame=CGRectMake((Select_Student_TXT.frame.size.width+50)/2,Select_Student_TXT.frame.origin.y+Select_Student_TXT.frame.size.height+10,200, 25);
    To_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"To" value:@"" table:nil];
    To_LB.textColor=[UIColor whiteColor];
    To_LB.font=[Font_Face_Controller opensanssemibold:16];
    To_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:To_LB];
    
     
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Frome_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Frome_LB.frame.origin.y+Frome_LB.frame.size.height, (Select_Student_TXT.frame.size.width-20)/2, 35)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [dateFormatter dateFromString: [[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString

    [[NSUserDefaults standardUserDefaults]setObject:date_correct_format forKey:@"CalenderDate_Selected"];
    
    Frome_TXT.text =[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
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
    Frome_TXT.rightView = [self golble_img:(Select_Student_TXT.frame.size.height-30)/2];
    
    Frome_TXT.inputView  = picker1;
    [self.view addSubview:Frome_TXT];
    Frome_TXT.inputAccessoryView = toolBar;
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    To_TXT = [[UITextField alloc] initWithFrame:CGRectMake((Select_Student_TXT.frame.size.width+50)/2, To_LB.frame.origin.y+To_LB.frame.size.height, (Select_Student_TXT.frame.size.width-20)/2, 35)];
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
    To_TXT.rightView = [self golble_img:(Select_Student_TXT.frame.size.height-30)/2];
    
    
    To_TXT.inputView  = picker1;
    
    
    [self.view addSubview:To_TXT];
    To_TXT.inputAccessoryView = toolBar;
    
    
    
    
    
    //////////////////// Select_Knowledge_Areas Lable\\\\\\\\\\\\\\
    
    
    Select_Knowledge_Areas_LB=[[UILabel alloc]init];
    // Select_Knowledge_Areas_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    Select_Knowledge_Areas_LB.frame=CGRectMake(15,To_TXT.frame.origin.y+To_TXT.frame.size.height+20,200, 25);
    Select_Knowledge_Areas_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Intervall" value:@"" table:nil];
    Select_Knowledge_Areas_LB.textColor=[UIColor whiteColor];
    Select_Knowledge_Areas_LB.font=[Font_Face_Controller opensanssemibold:16];
    Select_Knowledge_Areas_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:Select_Knowledge_Areas_LB];
    
    NSLog(@"%f",Select_Knowledge_Areas_LB.frame.origin.y);
    
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Select_Knowledge_Areas_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Select_Knowledge_Areas_LB.frame.origin.y+Select_Knowledge_Areas_LB.frame.size.height, self.view.frame.size.width-30, 35)];
 
    
    Select_Knowledge_Areas_TXT.text =
    @"1";
    
    
    
    Select_Knowledge_Areas_TXT.borderStyle = UITextBorderStyleNone;
    Select_Knowledge_Areas_TXT.font = [UIFont systemFontOfSize:15];
    Select_Knowledge_Areas_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    Select_Knowledge_Areas_TXT.delegate = self;
    Select_Knowledge_Areas_TXT.backgroundColor=[UIColor whiteColor];
    Select_Knowledge_Areas_TXT.textColor=[UIColor blackColor];
    Select_Knowledge_Areas_TXT.font=[Font_Face_Controller opensansLight:13];
    Select_Knowledge_Areas_TXT.tag=003;
    Select_Knowledge_Areas_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    Select_Knowledge_Areas_TXT.layer.masksToBounds = YES;
    Select_Knowledge_Areas_TXT.textAlignment=NSTextAlignmentCenter;
    Select_Knowledge_Areas_TXT.rightViewMode = UITextFieldViewModeAlways;
    Select_Knowledge_Areas_TXT.rightView = [self golble_img_right:(Select_Knowledge_Areas_TXT.frame.size.height-30)/2];
    [self.view addSubview:Select_Knowledge_Areas_TXT];
    

    
    //////////////////  Table view  Lable\\\\\\\\\\\\\\
    // init table view
    mtableview = [[UITableView alloc] initWithFrame:CGRectMake(0, (Select_Knowledge_Areas_TXT.frame.origin.y+Select_Knowledge_Areas_TXT.frame.size.height), self.view.frame.size.width, (self.view.frame.size.height)-(Select_Knowledge_Areas_TXT.frame.origin.y+Select_Knowledge_Areas_TXT.frame.size.height)) style:UITableViewStylePlain];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    mtableview.delegate = self;
    mtableview.dataSource = self;
    
    mtableview.backgroundColor = [UIColor clearColor];
    mtableview.showsVerticalScrollIndicator=NO;
  
    // add to canvas
    [self.view addSubview:mtableview];

    
    
//    
//    //////////////////// Remember No Button\\\\\\\\\\\\\\
//    
//    BTN_Cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [BTN_Cancel addTarget:self
//                   action:@selector(aMethod_Cancel:)
//         forControlEvents:UIControlEventTouchUpInside];
//    BTN_Cancel.backgroundColor=[UIColor colorWithRed:245.0f/255.0f green:186.0f/255.0f blue:213.0f/255.0f alpha:1.0];
//    [BTN_Cancel setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] forState:UIControlStateNormal];
//    [BTN_Cancel.titleLabel setFont:[Font_Face_Controller opensansregular:20]];
//    [BTN_Cancel setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
//    BTN_Cancel.frame = CGRectMake(0,self.view.frame.size.height-50,(self.view.frame.size.width/2)-5, 50);
//    [self.view addSubview:BTN_Cancel];
//    
//    [BTN_Cancel setBackgroundColor:[UIColor colorWithRed:249.0f/255.0f green:174.0f/255.0f blue:99.0f/255.0f alpha:1.0]];
//
//    
//    
//    
//    //////////////////// Remember YES Button\\\\\\\\\\\\\\
//    
//    BTN_Filter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [BTN_Filter addTarget:self
//                   action:@selector(aMethod_Filter:)
//         forControlEvents:UIControlEventTouchUpInside];
//    BTN_Filter.backgroundColor=[UIColor colorWithRed:245.0f/255.0f green:186.0f/255.0f blue:213.0f/255.0f alpha:1.0];
//    [BTN_Filter setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Set time" value:@"" table:nil] forState:UIControlStateNormal];
//    [BTN_Filter.titleLabel setFont:[Font_Face_Controller opensansregular:20]];
//    [BTN_Filter setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
//    BTN_Filter.frame = CGRectMake((self.view.frame.size.width/2)+5,self.view.frame.size.height-50,(self.view.frame.size.width/2)-5, 50);
//    [self.view addSubview:BTN_Filter];
//    
//    
//    [BTN_Filter setBackgroundColor:[UIColor colorWithRed:249.0f/255.0f green:174.0f/255.0f blue:99.0f/255.0f alpha:1.0]];
  
    
    
    [self mStartIndicater];
    
    
    [self performSelector:@selector(CallTheServer_Group_API) withObject:nil afterDelay:0.5];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

   }



- (void)startDateSelected:(id)sender
{
    
    UIDatePicker *datess=sender;
    
    if (datess.tag==110) {
        
        
        
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
    else
    {
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"HH:mm"];
        // [formatter setDateFormat:@"dd/MMM/YYYY"];
        
        pickre_STR=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datess.date]];
        
      
    }
    
}



- (void)cancelToucheds:(UIBarButtonItem *)sender
{
    
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
    
    
    if (TXT_tag==4) {
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
    else if (TXT_tag==5)
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
    
  if(TXT_tag==4 || TXT_tag==5)
  {
      
      
      NSString *start = Frome_TXT.text;
      NSString *end = To_TXT.text;
      
      NSDateFormatter *f = [[NSDateFormatter alloc] init];
      [f setDateFormat:@"yyyy-MM-dd"];
      NSDate *startDate = [f dateFromString:start];
      NSDate *endDate = [f dateFromString:end];
      
      NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
      NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                          fromDate:startDate
                                                            toDate:endDate
                                                           options:NSCalendarWrapComponents];
      
      
      schedule_Dropoff=[[NSMutableDictionary alloc]init];
      
      NSMutableDictionary *dash;
      NSMutableArray *dash11=[[NSMutableArray alloc]init];
      NSMutableArray *dashhh=[[NSMutableArray alloc]init];
      
      for (int s=0; s<=6; s++) {
          dash=[[NSMutableDictionary alloc]init];
          [dash setValue:@"" forKey:@"std_left_time"];
          [dash setValue:@"" forKey:@"std_retrieval_time"];
          [dash11 addObject:dash];
      }
      [dashhh addObject:dash11];
      [schedule_Dropoff setValue:dashhh forKey:@"time"];
      current_section=1;
      
      
      NSInteger intvalue=[components day]/7;
      
      
      if (intvalue<=0) {
          
           Select_Knowledge_Areas_TXT.text=@"1";
          
      }
      else
      {
          
          if(intvalue>=8)
          {
              Select_Knowledge_Areas_TXT.text=@"8";

          }
          else
          {
              Select_Knowledge_Areas_TXT.text=[NSString stringWithFormat:@"%ld",(long)intvalue];

          }
          
                }
      
     
      
      
      
     
  }
    else
    {
        
        if ([pickre_STR isEqualToString:@""]||[pickre_STR isEqualToString:nil] || [pickre_STR isEqual:nil] || [pickre_STR length]==0) {
            
            // get current date/time
            NSDate *today = [NSDate date];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"HH:mm";
            NSDate *date = [dateFormatter dateFromString:[dateFormatter stringFromDate:today]];
            
            dateFormatter.dateFormat = @"HH:mm";
            DEmotrival_TXT.text = [dateFormatter stringFromDate:date];
            
            
        }
        else
        {
            
            
            DEmotrival_TXT.text=pickre_STR;
        }

        
        NSString *tag_value=[NSString stringWithFormat:@"%ld",(long)DEmotrival_TXT.tag];
        
        
        
        NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[tag_value length]];
        
        for (int i=0; i < [tag_value length]; i++) {
            NSString *ichar  = [NSString stringWithFormat:@"%c", [tag_value characterAtIndex:i]];
            [characters addObject:ichar];
        }
        NSInteger section_value=[[characters objectAtIndex:1]intValue];
        ;
        NSInteger row_value=[[characters lastObject]intValue];
        
        
        if ([[characters objectAtIndex:0]isEqualToString:@"2"]) {
            [[[[schedule_Dropoff valueForKey:@"time"]objectAtIndex:section_value]objectAtIndex:row_value]removeObjectForKey:@"std_left_time"];
            
            [[[[schedule_Dropoff valueForKey:@"time"]objectAtIndex:section_value]objectAtIndex:row_value] setValue:DEmotrival_TXT.text forKey:@"std_left_time"];
        }
        else
        {
            [[[[schedule_Dropoff valueForKey:@"time"]objectAtIndex:section_value]objectAtIndex:row_value]removeObjectForKey:@"std_retrieval_time"];
            
            
            [[[[schedule_Dropoff valueForKey:@"time"]objectAtIndex:section_value]objectAtIndex:row_value] setValue:DEmotrival_TXT.text forKey:@"std_retrieval_time"];
            [mtableview reloadData];
        }
        
        

    }
    
       
    [mtableview reloadData];
    
    
    pickre_STR=@"";
    
    [self.view endEditing:YES];
    
      
}

- (NSInteger)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
    
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    
    
    
    return [components day]+1;
    
}


-(UIImageView *)golble_img_right:(NSInteger )frames
{
    UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenu.frame = CGRectMake(0, frames, 30, 30);
    [btnMenu setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"] forState:UIControlStateNormal];
    [btnMenu setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    [btnMenu.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:12]];
    
    
    UIImageView *img=[[UIImageView alloc]init];
    img.frame=CGRectMake(0, (Select_Knowledge_Areas_TXT.frame.size.height-30)/2, 30, 30);
    
    
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
    img.frame=CGRectMake(0, (Select_Knowledge_Areas_TXT.frame.size.height-30)/2, 30, 30);
    
    
    [img addSubview:btnMenu];
    
    return img;
}


#pragma mark - -*********************
#pragma mark Call Student_API Method
#pragma mark - -*********************


-(void)CallTheServer_Student_API:(NSMutableArray *)get_id_group
{
    if ([API connectedToInternet]==YES) {
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"] forKey:@"authentication_token"];
        
        [dic setValue:get_id_group forKey:@"group_ids"];
        
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
        
        
        NSString *responseString = [API makeCallPostData_ALLs:dic:[NSString stringWithFormat:@"%@picture_diary/get_group_students",[Utilities API_link_url_subDomain]]];
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict_Student = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        Get_Student=[[NSMutableArray alloc]init];
        
        
        if ([[dict_Student valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            [Get_Student removeAllObjects];
            
            
        }else if([[dict_Student valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict_Student valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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
#pragma mark Call API Group Method
#pragma mark - -*********************


-(void)CallTheServer_Group_API
{
    if ([API connectedToInternet]==YES) {
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@picture_diary/filter_view",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict_Login = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[dict_Login valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
        }else if([[dict_Login valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict_Login valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)aMethod_Filter
{
    
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Publish_Updated_Draft) withObject:nil afterDelay:0.5];

    
}


#pragma mark - -*********************
#pragma mark Call publish_updated_draft_API Method
#pragma mark - -*********************


-(void)CallTheServer_Publish_Updated_Draft
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"] forKey:@"authentication_token"];
        [dic setValue:Get_id forKey:@"group_id"];
        [dic setValue:Get_Student forKey:@"student_id"];
        
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
        
        [dic setValue:Frome_TXT.text forKey:@"from_date"];
        [dic setValue:To_TXT.text forKey:@"to_date"];
        
        [dic setValue:[schedule_Dropoff valueForKey:@"time"] forKey:@"intervals"];
        
        [dic setValue:Select_Knowledge_Areas_TXT.text forKey:@"interval"];

        NSLog(@"dic %@",dic);

NSString *responseString = [API makeCallPostData_ALLs:dic:[NSString stringWithFormat:@"%@retrivals/schedule_attendence",[Utilities API_link_url_subDomain]]];

NSDictionary *responseDict = [responseString JSONValue];
dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];



if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    
    
    DEmotrival_TXT=textField;
    
    
    
    TXT_tag=textField.tag;
    
    
    if (textField.tag==004 || textField.tag==005) {
        
        return YES;
        
    }
    
    
      else  if (textField.tag==001) {
            
            Selection_list_ViewController *objSelection_list_ViewController=[[Selection_list_ViewController alloc]init];
            objSelection_list_ViewController.values=dict_Login;
            objSelection_list_ViewController.Main_values=@"groups";
            objSelection_list_ViewController.Sub_values=@"name";
            
            objSelection_list_ViewController.notification=@"TestNotification1";
            objSelection_list_ViewController.post_type=@"POST";
            
            
            [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
            
            
            
        }
        else if (textField.tag==002 && [[dict_Student valueForKey:@"students"]count]!=0)
        {
            
            Selection_list_ViewController *objSelection_list_ViewController=[[Selection_list_ViewController alloc]init];
            objSelection_list_ViewController.values=dict_Student;
            objSelection_list_ViewController.Main_values=@"students";
            objSelection_list_ViewController.Sub_values=@"name";
            
            objSelection_list_ViewController.notification=@"TestNotification3";
            objSelection_list_ViewController.post_type=@"POST";
            
            
            [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
            
            
        }
        else if (textField.tag==003)
      {
          
          
          Select_Week *objSelection_list_ViewController=[[Select_Week alloc]init];
          objSelection_list_ViewController.Main_values=Select_Knowledge_Areas_TXT.text;
          objSelection_list_ViewController.notification=@"TestNotification2";
          
    [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];

          
          
          
        }
    else
    {
        return YES;
    }
        
    
    

    
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 50.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(5,0,tableView.frame.size.width-10,50)];
    headerView.backgroundColor=[Text_color_ Retrieval_Color_code];
    
    
    UILabel *WeekLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10,100,30)];
    WeekLabel.textAlignment = NSTextAlignmentLeft;
    WeekLabel.text =[NSString stringWithFormat:@"%@ %ld",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Week" value:@"" table:nil],(long)section+1];
    WeekLabel.font=[Font_Face_Controller opensanssemibold:15];
    WeekLabel.textColor=[UIColor whiteColor];
    [headerView addSubview:WeekLabel];
    
    
    
    UILabel *DROPOFFLabel = [[UILabel alloc] initWithFrame:CGRectMake(WeekLabel.frame.size.width, 10,headerView.frame.size.width/3,35)];
    DROPOFFLabel.textAlignment = NSTextAlignmentLeft;
    DROPOFFLabel.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Drop off" value:@"" table:nil];
    DROPOFFLabel.font=[Font_Face_Controller opensanssemibold:15];
    DROPOFFLabel.textColor=[UIColor whiteColor];

    [headerView addSubview:DROPOFFLabel];

    
    UILabel *RETRIEVALLabel = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width-(headerView.frame.size.width/3), 10,headerView.frame.size.width/3,30)];
    RETRIEVALLabel.textAlignment = NSTextAlignmentLeft;
    RETRIEVALLabel.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retrieval" value:@"" table:nil];
    RETRIEVALLabel.font=[Font_Face_Controller opensanssemibold:15];
    RETRIEVALLabel.textColor=[UIColor whiteColor];
    [headerView addSubview:RETRIEVALLabel];
    
    
    return headerView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return current_section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        return 7;
  }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    
    NSLog(@"%@",[[[[schedule_Dropoff valueForKey:@"time"]objectAtIndex:indexPath.section]valueForKey:@"std_left_time"]objectAtIndex:indexPath.row]);
    
    
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Dropff_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, (Select_Student_TXT.frame.size.width-20)/2, 30)];
    Dropff_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"HH:MM" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    
    Dropff_TXT.text=[[[[schedule_Dropoff valueForKey:@"time"]objectAtIndex:indexPath.section]valueForKey:@"std_left_time"]objectAtIndex:indexPath.row];
    
    Dropff_TXT.borderStyle = UITextBorderStyleNone;
    Dropff_TXT.font = [UIFont systemFontOfSize:15];
    Dropff_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    Dropff_TXT.delegate = self;
    Dropff_TXT.backgroundColor=[UIColor whiteColor];
    Dropff_TXT.textColor=[UIColor blackColor];
    Dropff_TXT.font=[Font_Face_Controller opensansLight:13];
    Dropff_TXT.tag=[[NSString stringWithFormat:@"%d%ld%ld",2,(long)indexPath.section,(long)indexPath.row]integerValue];
    Dropff_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    Dropff_TXT.layer.masksToBounds = YES;
    Dropff_TXT.textAlignment=NSTextAlignmentCenter;
    Dropff_TXT.rightViewMode = UITextFieldViewModeAlways;
    Dropff_TXT.rightView = [self golble_img:(Select_Student_TXT.frame.size.height-30)/2];
    
    Dropff_TXT.inputView  = picker2;
    [cell.contentView addSubview:Dropff_TXT];
    Dropff_TXT.inputAccessoryView = toolBar;
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Retrival_TXT = [[UITextField alloc] initWithFrame:CGRectMake((Select_Student_TXT.frame.size.width+50)/2, 10, (Select_Student_TXT.frame.size.width-20)/2, 30)];
    Retrival_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"HH:MM" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    Retrival_TXT.text=[[[[schedule_Dropoff valueForKey:@"time"]objectAtIndex:indexPath.section]valueForKey:@"std_retrieval_time"]objectAtIndex:indexPath.row];
    Retrival_TXT.borderStyle = UITextBorderStyleNone;
    Retrival_TXT.font = [UIFont systemFontOfSize:15];
    Retrival_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    Retrival_TXT.delegate = self;
    Retrival_TXT.backgroundColor=[UIColor whiteColor];
    Retrival_TXT.textColor=[UIColor blackColor];
    Retrival_TXT.font=[Font_Face_Controller opensansLight:13];
    Retrival_TXT.tag=[[NSString stringWithFormat:@"%d%ld%ld",3,(long)indexPath.section,(long)indexPath.row]integerValue];
    Retrival_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    Retrival_TXT.layer.masksToBounds = YES;
    Retrival_TXT.textAlignment=NSTextAlignmentCenter;
    Retrival_TXT.rightViewMode = UITextFieldViewModeAlways;
    Retrival_TXT.rightView = [self golble_img:(Select_Student_TXT.frame.size.height-30)/2];
    
    
    Retrival_TXT.inputView  = picker2;
    
    
    [cell.contentView  addSubview:Retrival_TXT];
    Retrival_TXT.inputAccessoryView = toolBar;
    

    
    
    
//    if (indexPath.section==0) {
//       
//        cell.textLabel.text = @"1";
//    }
//    else {
//             cell.textLabel.text = @"2";
//    }
//    
    
    cell.backgroundColor=[Text_color_ Retrieval_Color_code];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
