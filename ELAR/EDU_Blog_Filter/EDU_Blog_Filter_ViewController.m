//
//  EDU_Blog_Filter_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 27/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "EDU_Blog_Filter_ViewController.h"
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
#import "ImageCustomClass.h"
#import "LogoutManager.h"
@interface EDU_Blog_Filter_ViewController ()


@end

@implementation EDU_Blog_Filter_ViewController


- (void) receiveTestNotification1:(NSNotification *) notification
{
    [self mStartIndicater];

    
    NSLog(@"%@", notification.object);
     Get_id=[[NSMutableArray alloc]init];
    
    [Get_id addObjectsFromArray:notification.object];
    
    if (!Get_id.count==0) {
        
    
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
    
Get_Tages=[[NSMutableArray alloc]init];
[Get_Tages addObjectsFromArray:notification.object];
    
    if (!Get_Tages.count==0) {
        
        
        
        NSPredicate *preda = [NSPredicate predicateWithFormat:
                              @"id beginswith[c] %@",[Get_Tages objectAtIndex:0]];
        
        NSArray *aList = [[dict_Login valueForKey:@"curriculum_tags"] filteredArrayUsingPredicate:preda];

        
        pickre_Tags=[Get_Tages objectAtIndex:0];

        
        
    
          Select_Knowledge_Areas_TXT.text=[[[aList objectAtIndex:0]valueForKey:@"title"] stringByConvertingHTMLToPlainText];
  
    }
    else
    {
        pickre_Tags=@"";
    }
    
       
    NSLog(@"%@", notification.object);
    
    
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
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName:[Font_Face_Controller opensanssemibold:15],
                                                                    NSForegroundColorAttributeName: [UIColor blackColor]
                                                                    };
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Filter" value:@"" table:nil];
    
    
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
    
    
    
    
    UIButton *Done = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [Done setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] forState:UIControlStateNormal];
    
    [Done addTarget:self action:@selector(aMethod_Filter) forControlEvents:UIControlEventTouchUpInside];
    Done.frame = CGRectMake(0, 0, 50, 20);
    [Done setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *Done_btn = [[UIBarButtonItem alloc] initWithCustomView:Done];
    self.navigationItem.rightBarButtonItem = Done_btn;

    
    
    
}

-(void)gotoBack
{
   [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    
    self.view.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    
    
    //////////////////// Hide UInavigation Bar \\\\\\\\\\\\\\
    
   // self.navigationController.navigationBarHidden=YES;
    
    
    
    
    
    
    
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
//    
//    
//    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelToucheds:)];

    
    
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(cancelToucheds:)];
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(doneToucheds:)];
    

    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    

    ////////////////////Select_Group Lable\\\\\\\\\\\\\\

    
    Select_Group_LB=[[UILabel alloc]init];
   // Select_Group_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
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
    
    
     //////////////////// Select_Knowledge_Areas Lable\\\\\\\\\\\\\\


    Select_Knowledge_Areas_LB=[[UILabel alloc]init];
   // Select_Knowledge_Areas_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    Select_Knowledge_Areas_LB.frame=CGRectMake(15,Select_Student_TXT.frame.origin.y+Select_Student_TXT.frame.size.height+20,200, 25);
    Select_Knowledge_Areas_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Knowledge Areas" value:@"" table:nil];
    Select_Knowledge_Areas_LB.textColor=[UIColor whiteColor];
    Select_Knowledge_Areas_LB.font=[Font_Face_Controller opensanssemibold:16];
    Select_Knowledge_Areas_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:Select_Knowledge_Areas_LB];
    
 NSLog(@"%f",Select_Knowledge_Areas_LB.frame.origin.y);
    
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Select_Knowledge_Areas_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Select_Knowledge_Areas_LB.frame.origin.y+Select_Knowledge_Areas_LB.frame.size.height, self.view.frame.size.width-30, 35)];
    
    
    
    Select_Knowledge_Areas_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Knowledge Areas" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];

    
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
    

    
    ////////////////////Frome Lable\\\\\\\\\\\\\\
    
    
    Frome_LB=[[UILabel alloc]init];
    // Select_Group_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    Frome_LB.frame=CGRectMake(15,Select_Knowledge_Areas_TXT.frame.origin.y+Select_Knowledge_Areas_TXT.frame.size.height+10,200, 25);
    Frome_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"From" value:@"" table:nil];
    Frome_LB.textColor=[UIColor whiteColor];
    Frome_LB.font=[Font_Face_Controller opensanssemibold:16];
    Frome_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:Frome_LB];

    
    
    
    ////////////////////To Lable\\\\\\\\\\\\\\
    
    
    To_LB=[[UILabel alloc]init];
    // Select_Group_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    To_LB.frame=CGRectMake((Select_Knowledge_Areas_TXT.frame.size.width+50)/2,Select_Knowledge_Areas_TXT.frame.origin.y+Select_Knowledge_Areas_TXT.frame.size.height+10,200, 25);
    To_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"To" value:@"" table:nil];
    To_LB.textColor=[UIColor whiteColor];
    To_LB.font=[Font_Face_Controller opensanssemibold:16];
    To_LB.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:To_LB];
    

    
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Frome_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Frome_LB.frame.origin.y+Frome_LB.frame.size.height, (Select_Knowledge_Areas_TXT.frame.size.width-20)/2, 35)];
    Frome_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YYYY-MM-DD" value:@"" table:nil]
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
    Frome_TXT.rightView = [self golble_img:(Select_Knowledge_Areas_TXT.frame.size.height-30)/2];
    
    Frome_TXT.inputView  = picker1;
    [self.view addSubview:Frome_TXT];
    Frome_TXT.inputAccessoryView = toolBar;

    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    To_TXT = [[UITextField alloc] initWithFrame:CGRectMake((Select_Knowledge_Areas_TXT.frame.size.width+50)/2, To_LB.frame.origin.y+To_LB.frame.size.height, (Select_Knowledge_Areas_TXT.frame.size.width-20)/2, 35)];
    To_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YYYY-MM-DD" value:@"" table:nil]
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
    To_TXT.rightView = [self golble_img:(Select_Knowledge_Areas_TXT.frame.size.height-30)/2];
    
    
    To_TXT.inputView  = picker1;
   
  
    [self.view addSubview:To_TXT];
  To_TXT.inputAccessoryView = toolBar;
    
    
    
//    //////////////////// Remember No Button\\\\\\\\\\\\\\
//    
//    BTN_Cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [BTN_Cancel addTarget:self
//               action:@selector(aMethod_Cancel:)
//     forControlEvents:UIControlEventTouchUpInside];
//    BTN_Cancel.backgroundColor=[UIColor colorWithRed:245.0f/255.0f green:186.0f/255.0f blue:213.0f/255.0f alpha:1.0];
//    [BTN_Cancel setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] forState:UIControlStateNormal];
//    [BTN_Cancel.titleLabel setFont:[Font_Face_Controller opensansregular:20]];
//    [BTN_Cancel setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
//    BTN_Cancel.frame = CGRectMake(0,self.view.frame.size.height-50,(self.view.frame.size.width/2)-5, 50);
//    [self.view addSubview:BTN_Cancel];
//    
//    
//    
//    
//    
//    //////////////////// Remember YES Button\\\\\\\\\\\\\\
//    
//    BTN_Filter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [BTN_Filter addTarget:self
//                action:@selector(aMethod_Filter:)
//      forControlEvents:UIControlEventTouchUpInside];
//    BTN_Filter.backgroundColor=[UIColor colorWithRed:245.0f/255.0f green:186.0f/255.0f blue:213.0f/255.0f alpha:1.0];
//    [BTN_Filter setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Filter" value:@"" table:nil] forState:UIControlStateNormal];
//    [BTN_Filter.titleLabel setFont:[Font_Face_Controller opensansregular:20]];
//    [BTN_Filter setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
//    BTN_Filter.frame = CGRectMake((self.view.frame.size.width/2)+5,self.view.frame.size.height-50,(self.view.frame.size.width/2)-5, 50);
//    [self.view addSubview:BTN_Filter];
    
    
    [self mStartIndicater];

    
    [self performSelector:@selector(CallTheServer_Group_API) withObject:nil afterDelay:0.5];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

   // self.navigationController.navigationBarHidden=YES;
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
            
            
        }else if([[dict_Student valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
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
            
            
        }else if([[dict_Login valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
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
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)aMethod_Filter
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
    [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"] forKey:@"authentication_token"];
    
    [dic setValue:Get_id forKey:@"group_ids"];
    [dic setValue:pickre_Tags forKey:@"curriculum_tag_ids"];
    [dic setValue:Get_Student forKey:@"student_ids"];
    
    [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
    
    [dic setValue:Frome_TXT.text forKey:@"from_date"];
    [dic setValue:To_TXT.text forKey:@"to_date"];

    
    NSLog(@" dic %@",dic);
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"Filter_Post"
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
        Selection_list_ViewController *objSelection_list_ViewController=[[Selection_list_ViewController alloc]init];
        objSelection_list_ViewController.values=dict_Login;
        
        objSelection_list_ViewController.Main_values=@"curriculum_tags";
        objSelection_list_ViewController.Sub_values=@"title";
        
        objSelection_list_ViewController.notification=@"TestNotification2";
        objSelection_list_ViewController.post_type=@"POST";
        


        [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
    }
    
    }
    
    return NO;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
