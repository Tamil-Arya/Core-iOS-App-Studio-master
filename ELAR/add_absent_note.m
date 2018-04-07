//
//  add_absent_note.m
//  SCM
//
//  Created by pnf on 12/21/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//

#import "add_absent_note.h"
#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "NSString+HTML.h"
#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "ELR_loaders_.h"
#import "MFSideMenu.h"
#import "UIImageView+WebCache.h"
#import "profile.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"

@interface add_absent_note ()

@end

@implementation add_absent_note
@synthesize add_check;


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
    
    
    
    // [self rightSideMenuButtonPressed];
    
    
}



-(void)Navigation_bar
{
    
    
    user_pic = [[UIImageView alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"USR_image"]]);
    [user_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"customer_logo"]]]
                placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    
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
//    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent Note" value:@"" table:nil];
    
    
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
    
}

-(void)gotoBack
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self Navigation_bar];
    
    
    allow=@"0";
    button_check=false;
    // create the array of data
    LeaveTypeSelectionDropDownListNameArray = [[NSMutableArray alloc] init];
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]isEqualToString:@"sw"])
    {
        
        [LeaveTypeSelectionDropDownListNameArray addObject:@"Sjukdom"];
        [LeaveTypeSelectionDropDownListNameArray addObject:@"Ledighet"];
        //[LeaveTypeSelectionDropDownListNameArray addObject:@"andra skäl"];
        [LeaveTypeSelectionDropDownListNameArray addObject:@"Andra skäl"];
    }
    else
        {
            
            
            [LeaveTypeSelectionDropDownListNameArray addObject:@"Sickness"];
            [LeaveTypeSelectionDropDownListNameArray addObject:@"Leave"];
            [LeaveTypeSelectionDropDownListNameArray addObject:@"Other reasons"];

        }
    
    
   
    
 
 
    LeaveTypeSelectionDropDownList_selected = @"sick";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    //add Profile heading label
    UILabel *labelRetrieval = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 22.5 ,200, 25)];
    
    
    
    //----------complete screen under header----------//
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [dateFormatter dateFromString: [[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
    
    //background
    UIView *backgroundBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
      [self.view addSubview:backgroundBox];
    
    //add user name header text
    NSString *UserNameHeader = [[NSUserDefaults standardUserDefaults]valueForKey:@"student_name"];
    CGFloat writtenbyvaluenewwidth =  [UserNameHeader sizeWithFont:[Font_Face_Controller opensanssemibold:22]].width;
    UILabel *usernamelabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-writtenbyvaluenewwidth)/2, 10 ,writtenbyvaluenewwidth, 26)];
    usernamelabel.text = UserNameHeader;
    usernamelabel.textColor = [UIColor whiteColor];
    [usernamelabel setFont:[Font_Face_Controller opensanssemibold:22]];
    usernamelabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:usernamelabel];
    
    
    
    //add Date label text
    UILabel *datelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, usernamelabel.frame.origin.y+usernamelabel.frame.size.height+20 ,(self.view.frame.size.width-30)/2, 18)];
    datelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Date" value:@"" table:nil];
    datelabel.textColor = [UIColor whiteColor];
    [datelabel setFont:[Font_Face_Controller opensansLight:16]];
    datelabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:datelabel];
    
    // Date text field START
    datetextfield = [[UITextField alloc] initWithFrame:CGRectMake(10, datelabel.frame.origin.y+datelabel.frame.size.height+5 ,(self.view.frame.size.width-30)/2, 35)];
    [datetextfield setTextColor:[UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0]];
    datetextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YYYY-MM-DD" value:@"" table:nil] attributes:@{NSForegroundColorAttributeName: [Text_color_ Placeholder_Text_Color_code]}];
    
    if([[absentnotedict valueForKey:@"status"]isEqualToString:@"true"]){
        datetextfield.text = [[absentnotedict valueForKey:@"data"]valueForKey:@"sickdate"];
    }else{
        datetextfield.text = date_correct_format;
    }
    datetextfield.font = [Font_Face_Controller opensansLight:16];
    datetextfield.delegate=self;
    datetextfield.backgroundColor = [UIColor whiteColor];
    datetextfield.textColor=[Text_color_ Content_Text_Color_code];

    UIView *paddingViewdate = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    datetextfield.leftView = paddingViewdate;
    datetextfield.leftViewMode = UITextFieldViewModeAlways;
    
    [backgroundBox addSubview:datetextfield];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(datePickerChanged:)
         forControlEvents:UIControlEventValueChanged];
    [datetextfield setInputView:datePicker];
    
    
    //add To label text
    UILabel *tolabel = [[UILabel alloc] initWithFrame:CGRectMake(datelabel.frame.origin.x+datelabel.frame.size.width+10, usernamelabel.frame.origin.y+usernamelabel.frame.size.height+20 ,(self.view.frame.size.width-30)/2, 18)];
    tolabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"To" value:@"" table:nil];
    tolabel.textColor = [UIColor whiteColor];
    [tolabel setFont:[Font_Face_Controller opensansLight:16]];
    tolabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:tolabel];
    
    // To text field START
    totextfield = [[UITextField alloc] initWithFrame:CGRectMake(datelabel.frame.origin.x+datelabel.frame.size.width+10, tolabel.frame.origin.y+tolabel.frame.size.height+5,(self.view.frame.size.width-30)/2, 35)];
    [totextfield setTextColor:[UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0]];
    totextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YYYY-MM-DD" value:@"" table:nil] attributes:@{NSForegroundColorAttributeName: [Text_color_ Placeholder_Text_Color_code]}];
    totextfield.textColor=[Text_color_ Content_Text_Color_code];
    
   
    totextfield.font = [Font_Face_Controller opensansLight:16];
    totextfield.delegate=self;
    totextfield.backgroundColor = [UIColor whiteColor];
    UIView *paddingViewto = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    totextfield.leftView = paddingViewto;
    totextfield.leftViewMode = UITextFieldViewModeAlways;
    [totextfield addTarget:self action:@selector(todatePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [backgroundBox addSubview:totextfield];
    
    UIDatePicker *todatePicker = [[UIDatePicker alloc] init];
    todatePicker.datePickerMode = UIDatePickerModeDate;
    [todatePicker addTarget:self action:@selector(todatePickerChanged:)
         forControlEvents:UIControlEventValueChanged];
    [totextfield setInputView:todatePicker];
    
    
    //-------Leave type selection tab start------------
    
    //Type label text
    UILabel *typelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, datetextfield.frame.origin.y+datetextfield.frame.size.height+20 ,self.view.frame.size.width-20, 18)];
    typelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type" value:@"" table:nil];
    typelabel.textColor = [UIColor whiteColor];
    [typelabel setFont:[Font_Face_Controller opensansLight:16]];
    typelabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:typelabel];
    
    LeaveTypeSelectionDropDownList = [[UITextField alloc] initWithFrame:CGRectMake(10, typelabel.frame.origin.y+typelabel.frame.size.height+7, self.view.frame.size.width-20, 40)];
    [LeaveTypeSelectionDropDownList setTextColor:[UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0]];
    [LeaveTypeSelectionDropDownList setBackgroundColor:[UIColor whiteColor]];
    LeaveTypeSelectionDropDownList.delegate=self;
    LeaveTypeSelectionDropDownList.attributedPlaceholder =  [[NSAttributedString alloc] initWithString:@"Group" attributes:@{NSForegroundColorAttributeName:[Text_color_ Placeholder_Text_Color_code]}];
    LeaveTypeSelectionDropDownList.textColor=[Text_color_ Content_Text_Color_code];
    LeaveTypeSelectionDropDownList.font = [Font_Face_Controller opensansLight:16];
    [backgroundBox addSubview:LeaveTypeSelectionDropDownList];
    
    
    
    // bind yourTextField to DownPicker
    self.downPicker = [[DownPicker alloc] initWithTextField:LeaveTypeSelectionDropDownList withData:LeaveTypeSelectionDropDownListNameArray];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"Select Type"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:114.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:1.0] range:NSMakeRange(0,11)];
    [self.downPicker setAttributedPlaceholder:string];
    [self.downPicker setSelectedIndex:0];
    
    [self.downPicker setTintColor:[UIColor colorWithRed:114.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:1.0] ];
    
    [self.downPicker addTarget:self action:@selector(dp_Selected:) forControlEvents:UIControlEventValueChanged];
    
    //Note label text
    UILabel *notelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, LeaveTypeSelectionDropDownList.frame.origin.y+LeaveTypeSelectionDropDownList.frame.size.height+20 ,self.view.frame.size.width-20, 20)];
    notelabel.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Note:" value:@"" table:nil];
    
    
    
    notelabel.textColor = [UIColor whiteColor];
    [notelabel setFont:[Font_Face_Controller opensansLight:16]];
    notelabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:notelabel];
    
    // Note text field
    Notetextfield = [[UITextView alloc] init];
    Notetextfield.delegate = self;
    if([[absentnotedict valueForKey:@"status"]isEqualToString:@"true"]){
        Notetextfield.text = [[absentnotedict valueForKey:@"data"]valueForKey:@"description"];
        Notetextfield.textColor = [Text_color_ Content_Text_Color_code];
    }else{
        
        
        
        
        Notetextfield.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type extra details here" value:@"" table:nil];
        Notetextfield.textColor = [Text_color_ Placeholder_Text_Color_code];
    }
    
//    Notetextfield.frame=CGRectMake(10, notelabel.frame.origin.y+notelabel.frame.size.height+5 ,self.view.frame.size.width-20, 50);
    
      Notetextfield.frame=CGRectMake(10, notelabel.frame.origin.y+notelabel.frame.size.height+5 ,self.view.frame.size.width-20, ((self.view.frame.size.height-120)-(notelabel.frame.origin.y+notelabel.frame.size.height))-30);
    
    
    Notetextfield.font = [Font_Face_Controller opensansLight:16];
    Notetextfield.backgroundColor = [UIColor whiteColor];
    [backgroundBox addSubview:Notetextfield];
    
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    Notetextfield.inputAccessoryView = myToolbar;

    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"teacher"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"lärare"]) {
        
        // Cancel Button
        mcheck = [UIButton buttonWithType: UIButtonTypeCustom];
        [mcheck setFrame:CGRectMake(10,Notetextfield.frame.origin.y+Notetextfield.frame.size.height+5, 20, 20)];
        mcheck.backgroundColor=[UIColor clearColor];
        mcheck.hidden=YES;
        mcheck.layer.cornerRadius=5;
        [mcheck addTarget:nil action:@selector(mcheck:) forControlEvents:UIControlEventTouchUpInside];
        mcheck.clipsToBounds=YES;
        
        mcheck.layer.borderColor=[UIColor whiteColor].CGColor;
        mcheck.layer.borderWidth=1;
        
        //fa-check-square
        [mcheck setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backgroundBox addSubview:mcheck];
        
        
        //Note label text
        check_lable = [[UILabel alloc] initWithFrame:CGRectMake(mcheck.frame.origin.x+mcheck.frame.size.width+5, Notetextfield.frame.origin.y+Notetextfield.frame.size.height+5 ,self.view.frame.size.width-70, 20)];
        check_lable.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Mark as absent" value:@"" table:nil];
        check_lable.textColor = [UIColor whiteColor];
        [check_lable setFont:[Font_Face_Controller opensansLight:13]];
        check_lable.textAlignment=NSTextAlignmentLeft;
        check_lable.backgroundColor=[UIColor clearColor];
        check_lable.hidden=YES;
        
        [backgroundBox addSubview:check_lable];

        
    }
    
    
    // Cancel Button
    UIButton *CancelButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [CancelButton setFrame:CGRectMake(0, self.view.frame.size.height-50, (self.view.frame.size.width-10)/2, 50)];
    [CancelButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] forState: UIControlStateNormal];
   
    [CancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [CancelButton.titleLabel setFont:[Font_Face_Controller opensanssemibold:15]];
    [CancelButton addTarget:self action:@selector(action_Cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CancelButton];
    
    
    // Save Button
    UIButton *SaveButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [SaveButton setFrame:CGRectMake(CancelButton.frame.origin.x+CancelButton.frame.size.width+10, self.view.frame.size.height-50, (self.view.frame.size.width-10)/2, 50)];
    [SaveButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] forState: UIControlStateNormal];
   
    [SaveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [SaveButton.titleLabel setFont:[Font_Face_Controller opensanssemibold:15]];
    [SaveButton addTarget:self action:@selector(action_Save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SaveButton];
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_authentication_token"];
    
        
        [CancelButton setBackgroundColor:[UIColor colorWithRed:235.0f/255.0f green:116.0f/255.0f blue:133.0f/255.0f alpha:1.0]];
        [SaveButton setBackgroundColor:[UIColor colorWithRed:235.0f/255.0f green:116.0f/255.0f blue:133.0f/255.0f alpha:1.0]];
        
        backgroundBox.backgroundColor = [Text_color_ Absence_note_Color_code];

    
    }
    else
    {
        
        [CancelButton setBackgroundColor:[UIColor colorWithRed:249.0f/255.0f green:174.0f/255.0f blue:99.0f/255.0f alpha:1.0]];
        [SaveButton setBackgroundColor:[UIColor colorWithRed:249.0f/255.0f green:174.0f/255.0f blue:99.0f/255.0f alpha:1.0]];
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"];
        
        backgroundBox.backgroundColor = [Text_color_ Retrieval_Color_code];

    }
    

    
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_add_absent_note_API) withObject:nil afterDelay:0.5];

    
}

-(void)doneButtonClicked
{
    if ([Notetextfield.text isEqualToString:@""]) {
        Notetextfield.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type extra details here" value:@"" table:nil];
        Notetextfield.textColor = [Text_color_ Placeholder_Text_Color_code];
    }
    [Notetextfield resignFirstResponder];
}


-(void)mcheck:(UIButton *)sender
{
    if (button_check==false) {
        
        [mcheck setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-check"] forState:UIControlStateNormal];
        [mcheck.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:15]];
        
     
        allow=@"1";
        
        button_check=true;
        
    }
    else
    {
        
        [mcheck setTitle:@"" forState:UIControlStateNormal];
        [mcheck.titleLabel setFont:[UIFont fontWithName:@"" size:15]];


        button_check=false;
        allow=@"0";
        
    }
}

#pragma mark - -*********************
#pragma mark Call get_drafts_API Method
#pragma mark - -*********************


-(void)CallTheServer_add_absent_note_API
{
    if ([API connectedToInternet]==YES) {
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [dateFormatter dateFromString: [[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],date_correct_format]:[NSString stringWithFormat:@"%@retrivals/get_absence_note",[Utilities API_link_url_subDomain]]];
        
        
        NSLog(@"%@",[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],date_correct_format]);
        
        NSDictionary *responseDict = [responseString JSONValue];
        
        
        absentnotedict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        NSLog(@"%@",absentnotedict);
        if ([[absentnotedict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            
            if (![[[absentnotedict valueForKey:@"data"]valueForKey:@"approved"]isEqualToString:@"1"]) {
                
                if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"teacher"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"lärare"]) {
                    
                    mcheck.hidden=NO;
                    check_lable.hidden=NO;
                    
                }
                
                
            }
            
            
            self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Edit Absent Note" value:@"" table:nil];

            
            
            
            if(![[[absentnotedict valueForKey:@"data"]valueForKey:@"description"]isEqualToString:@""]){
               
                Notetextfield.textColor = [Text_color_ Content_Text_Color_code];
            }else{
                
                
                Notetextfield.textColor = [Text_color_ Placeholder_Text_Color_code];
            }

            
            
            Notetextfield.text=[[[absentnotedict valueForKey:@"data"]valueForKey:@"description"]stringByConvertingHTMLToPlainText];
            
           totextfield.text=[[[absentnotedict valueForKey:@"data"]valueForKey:@"created"]stringByConvertingHTMLToPlainText];
           
            
            
            
            
            
        }
        
        else
        {
            
            mcheck.hidden=NO;
            check_lable.hidden=NO;

            
              self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent Note" value:@"" table:nil];
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

-(void)action_Save
{
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Absent_note_Update_API) withObject:nil afterDelay:0.5];

}


#pragma mark - -*********************
#pragma mark Call get_drafts_API Method
#pragma mark - -*********************


-(void)CallTheServer_Absent_note_Update_API
{
    if ([API connectedToInternet]==YES) {
        
        NSString *Leave_type;
        
        
        
        [LeaveTypeSelectionDropDownListNameArray addObject:@"Sjukdom"];
        [LeaveTypeSelectionDropDownListNameArray addObject:@"Ledighet"];
        [LeaveTypeSelectionDropDownListNameArray addObject:@"Andra skäl"];
        [LeaveTypeSelectionDropDownListNameArray addObject:@"Sickness"];
        [LeaveTypeSelectionDropDownListNameArray addObject:@"Leave"];
        [LeaveTypeSelectionDropDownListNameArray addObject:@"Other reasons"];
        
        if ([LeaveTypeSelectionDropDownList.text isEqualToString:@"Sickness"] || [LeaveTypeSelectionDropDownList.text isEqualToString:@"Sjukdom"]) {
            Leave_type=@"sick";
            
        }
        else if ([LeaveTypeSelectionDropDownList.text isEqualToString:@"Leave"] || [LeaveTypeSelectionDropDownList.text isEqualToString:@"Ledighet"])
        {
            Leave_type=@"leave";
        }
        
        else if ([LeaveTypeSelectionDropDownList.text isEqualToString:@"Other reasons"] || [LeaveTypeSelectionDropDownList.text isEqualToString:@"Andra skäl"])
        {
            Leave_type=@"other";
        }
        else
        {
             Leave_type=@"other";
        }
        
        
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@&to_sickdate=%@&sick_description=%@&leave_type=%@&approved=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],datetextfield.text,totextfield.text,Notetextfield.text,Leave_type,allow]:[NSString stringWithFormat:@"%@retrivals/update_absence_note",[Utilities API_link_url_subDomain]]];

        
        
        NSLog(@"stringReq %@",[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@&to_sickdate=%@&sick_description=%@&leave_type=%@&approved=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],datetextfield.text,totextfield.text,Notetextfield.text,Leave_type,allow]);
        
        
        NSDictionary *responseDict = [responseString JSONValue];
        absentnotedict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        if ([[absentnotedict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"REfress_List_retrieval"
             object:nil];
            
//            [self.navigationController popViewControllerAnimated:YES];
            UIViewController *View = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
            [self.navigationController popToViewController:View animated:YES];
            
        }else if([[absentnotedict valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[absentnotedict valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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




//function on click of group selection drop down list
-(void)dp_Selected:(id)dp {
    
    NSString* selectedValue = [self.downPicker text];
   
    if([selectedValue isEqualToString:@"Sickness"] || [selectedValue isEqualToString:@"Sjukdom"]){
        LeaveTypeSelectionDropDownList_selected = @"sick";
    }else if([selectedValue isEqualToString:@"Leave"] || [selectedValue isEqualToString:@"Ledighet"]){
        LeaveTypeSelectionDropDownList_selected = @"leave";
    }else if([selectedValue isEqualToString:@"Other reasons"] || [selectedValue isEqualToString:@"Andra skäl"]){
        LeaveTypeSelectionDropDownList_selected = @"other";
    }
}


-(void)datePickerChanged:(UIDatePicker *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:sender.date];
    datetextfield.text = strDate;
}

-(void)todatePickerChanged:(UIDatePicker *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:sender.date];
    totextfield.text = strDate;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(IBAction)action_Cancel{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//#pragma mark - -*********************
//#pragma mark Activity Indicater
//#pragma mark - -*********************
//
//-(void)mActivityIndicater
//{
//    loader = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-64)/2,[[UIScreen mainScreen]bounds].size.height/2,64,64)];
//    
//    loader.backgroundColor=[UIColor colorWithRed:61.0f/255.0f green:61.0f/255.0f blue:61.0f/255.0f alpha:1.0];
//    loader.layer.cornerRadius=5;
//    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    CGRect frame = spinner.frame;
//    frame.origin.x = loader.frame.size.width / 2 - frame.size.width / 2;
//    frame.origin.y = loader.frame.size.height / 2 - frame.size.height / 2;
//    spinner.frame = frame;
//    [loader addSubview:spinner];
//    [spinner startAnimating];
//    [self.view addSubview:loader];
//}




-(BOOL)validateInput{
    
    BOOL retvalue=YES;
    NSString *throwmessage;
    
    if ([datetextfield.text isEqualToString:@""] || datetextfield.text==nil )
        
    {
        throwmessage=@"Please select a sick date";
        retvalue=NO;
    }
//    else if ([totextfield.text isEqualToString:@""] || totextfield.text==nil )
//        
//    {
//        throwmessage=@"Please select a to sick date";
//        retvalue=NO;
//    }
    else if ([Notetextfield.text isEqualToString:@""] || Notetextfield.text==nil || [Notetextfield.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type extra details here" value:@"" table:nil]])
        
    {
        throwmessage=@"Please enter a note description";
        retvalue=NO;
    }
    
    if (retvalue==NO)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:throwmessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    return  retvalue;
    
}

//-(IBAction)action_Save{
//    BOOL check=[self validateInput];
//    if (check==true) {
//        [self mActivityIndicater];
//        [self performSelector:@selector(action_SaveProcess) withObject:nil afterDelay:0.5];
//    }
//    else
//    {
//        
//    }
//}
//
//
//- (void)action_SaveProcess
//{
//    
//    
//    NSString *responseString2;
//    if([[absentnotedict valueForKey:@"status"]isEqualToString:@"true"]){
//        responseString2 = [AppDelegate makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@&to_sickdate=%@&sick_description=%@&leave_type=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"language"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],datetextfield.text,totextfield.text,Notetextfield.text,LeaveTypeSelectionDropDownList_selected]:@"http://ps.pnf-sites.info/lms_api/retrivals/update_absence_note"];
//    }else{
//        responseString2 = [AppDelegate makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@&to_sickdate=%@&sick_description=%@&leave_type=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"language"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],datetextfield.text,totextfield.text,Notetextfield.text,LeaveTypeSelectionDropDownList_selected]:@"http://ps.pnf-sites.info/lms_api/retrivals/absent_description"];
//    }
//    
//    
//    
//    NSDictionary *responseDict2 = [responseString2 JSONValue];
//    dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict2];
//       
//    
//    if([[dict valueForKey:@"status"]isEqualToString:@"success"])
//    {
//        datetextfield.text = @"";
//        totextfield.text = @"";
//        Notetextfield.text = @"Note description";
//        
//        UIAlertController * alert=   [UIAlertController
//                                      alertControllerWithTitle:nil
//                                      message:[dict valueForKey:@"message"]
//                                      preferredStyle:UIAlertControllerStyleAlert];
//        
//        [self presentViewController:alert animated:YES completion:nil];
//        
//        UIAlertAction* ok = [UIAlertAction
//                             actionWithTitle:@"OK"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 //Do some thing here
//                                 [self dismissViewControllerAnimated:YES completion:nil];
//                                 profile *profileobj = [[profile alloc]init];
//                                 [self.navigationController pushViewController:profileobj animated:YES];
//                             }];
//        [alert addAction:ok]; // add action to uialertcontroller
//
//    }
//    else{
//        
//        UIAlertController * alert=   [UIAlertController
//                                      alertControllerWithTitle:nil
//                                      message:[dict valueForKey:@"message"]
//                                      preferredStyle:UIAlertControllerStyleAlert];
//        
//        [self presentViewController:alert animated:YES completion:nil];
//        
//        UIAlertAction* ok = [UIAlertAction
//                             actionWithTitle:@"OK"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 //Do some thing here
//                                 [self dismissViewControllerAnimated:YES completion:nil];
//                                 
//                             }];
//        [alert addAction:ok]; // add action to uialertcontroller
//        
//    }
//    
//    
//    
//    [loader removeFromSuperview];
//    
//    
//    
//}


// MARK:- Modify for Textfield.
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    //Description_TV.text = @"";
    Notetextfield.textColor = [Text_color_ Content_Text_Color_code];
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(Notetextfield.text.length == 0){
        Notetextfield.textColor = [Text_color_ Placeholder_Text_Color_code];
        // Description_TV.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
        //        [Description_TV resignFirstResponder];
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    
    if(Notetextfield.text.length == 0){
        Notetextfield.textColor = [UIColor lightGrayColor];
        Notetextfield.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
        //        [Description_TV resignFirstResponder];
    }
}


- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
    return YES;
    //    }
    
    //    [txtView resignFirstResponder];
    //    return NO;
}



- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([Notetextfield.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type extra details here" value:@"" table:nil]]) {
        Notetextfield.text = @"";
        Notetextfield.textColor = [Text_color_ Placeholder_Text_Color_code];
    }
    [Notetextfield becomeFirstResponder];
}
//
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    if ([Notetextfield.text isEqualToString:@""]) {
//        Notetextfield.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type extra details here" value:@"" table:nil];
//        Notetextfield.textColor = [Text_color_ Placeholder_Text_Color_code];
//    }
//    [Notetextfield resignFirstResponder];
//}
//
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//
//    [textField resignFirstResponder];
//
//    return YES;
//}
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//
//    if([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//
//    return YES;
//}


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
