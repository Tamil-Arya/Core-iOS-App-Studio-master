//
//  Login_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 06/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "NSString+HTML.h"
#import "Login_ViewController.h"
#import "Font_Face_Controller.h"
#import "Remember_Me_ViewController.h"
#import "UITextField+Shake.h"
#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "Email_validation.h"
#import "NSString+HTML.h"
#import "UIImage+animatedGIF.h"
#import "ELR_loaders_.h"

#import "Reachability.h"
#import "AppDelegate.h"
#import "LogoutManager.h"
#import "TermOfUseViewController.h"

@interface Login_ViewController ()
{
    NSArray *filtered ;
    TwoFactorLoginView *twoFactorLoginView;
    UIView * transpearentView;
    AppDelegate * appDelegate ;
}

@end

@implementation Login_ViewController



-(void)reachabilityDidChange:(NSNotification *)notification {
    Reachability *reachability = (Reachability *)[notification object];
    
//    if ([reachability isReachable]) {
//        NSLog(@"Reachable");
//    } else {
//        NSLog(@"Unreachable");
//    }
}

#pragma mark - -*********************
#pragma mark ViewDidLoad Method
#pragma mark - -*********************


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GIDSignIn sharedInstance].uiDelegate = self;

    filtered = [[NSArray alloc]init];
    
    languageStringFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"langugae"];
    arrayWithLanguages = [[NSMutableArray alloc]init];
    pickre_index_value = 0;
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
    
//    
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    
    
    //////////////////// Picker Vew Arrays \\\\\\\\\\\\\\

    
    language_ARR=[[NSMutableArray alloc]init];
    Demo_ARR =[[NSMutableArray alloc]init];
    Copy_Of_Demo_ARR = [[NSMutableArray alloc]init];
    Domain_name_ARR=[[NSMutableArray alloc]init];
    copy_Of_Array_Of_Customers =[[NSMutableArray alloc]init];
    arrayForCustomers = [[NSMutableArray alloc]init];
    
    
    canPicker_Array=NO;
  
    searchString =[[NSMutableString alloc]init];

  //////////////////// Screen Back_ground Color \\\\\\\\\\\\\\
    
              self.view.backgroundColor=[UIColor whiteColor];
    
    arrayWithCustomerUrl = [NSArray arrayWithObjects:@"https://presentation.elar.se/quiz_app/getCustomerList",@"https://Elar.se/quiz_app/getCustomerList",@"https://Jensen.elar.se/quiz_app/getCustomerList",@"https://Dev.elar.se/quiz_app/getCustomerList", nil];

    customerListServicecount = 0;
//    arrayOfCustomers = [[NSMutableArray alloc]init];


    
//////////////////// Application Logo \\\\\\\\\\\\\\
    
    
    Application_logo=[[UIImageView alloc]init];
    Application_logo.image=[UIImage imageNamed:@"logo.png"];
    
    if (self.view.frame.size.height==480) {
         Application_logo.frame=CGRectMake((self.view.frame.size.width-143)/2, 50, 133, 97);
    }
    else
    {
        Application_logo.frame=CGRectMake((self.view.frame.size.width-143)/2, 100, 143, 107);
    }
    
   
    Application_logo.userInteractionEnabled=YES;
    [self.view addSubview:Application_logo];
    
    
    
    //////////////////// Email  TextField \\\\\\\\\\\\\\
    
    if (self.view.frame.size.height==480) {
        
          email_TXT = [[UITextField alloc] initWithFrame:CGRectMake(30,Application_logo.frame.origin.y+Application_logo.frame.size.height+15,self.view.frame.size.width-60, 40)];
    }
    else
    {
          email_TXT = [[UITextField alloc] initWithFrame:CGRectMake(30,Application_logo.frame.origin.y+Application_logo.frame.size.height+50,self.view.frame.size.width-60, 40)];
    }

  
    email_TXT.borderStyle = UITextBorderStyleNone;
    email_TXT.font = [UIFont systemFontOfSize:15];
    email_TXT.keyboardType = UIKeyboardTypeEmailAddress;
    email_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    email_TXT.delegate = self;
    email_TXT.backgroundColor=[UIColor clearColor];
    email_TXT.textColor=[UIColor blackColor];
    email_TXT.font=[Font_Face_Controller opensansLight:18];
    email_TXT.tag=001;
    email_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
  
    
    
    login_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_icon2.png"]];
    email_TXT.leftView = login_img;
    email_TXT.leftViewMode = UITextFieldViewModeAlways;
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, email_TXT.frame.size.height - borderWidth, email_TXT.frame.size.width, email_TXT.frame.size.height);
    border.borderWidth = borderWidth;
    [email_TXT.layer addSublayer:border];
    email_TXT.layer.masksToBounds = YES;
    
 
    
    [self.view addSubview:email_TXT];
    
    
    
    //////////////////// Password TextField  \\\\\\\\\\\\\\

    
    Passwprd_TXT = [[UITextField alloc] initWithFrame:CGRectMake(30, email_TXT.frame.origin.y+email_TXT.frame.size.height+20, self.view.frame.size.width-60, 40)];
    Passwprd_TXT.borderStyle = UITextBorderStyleNone;
    Passwprd_TXT.font = [UIFont systemFontOfSize:18];
    Passwprd_TXT.secureTextEntry=YES;
    
    
   
    
    Passwprd_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    Passwprd_TXT.keyboardType = UIReturnKeyDefault;
    Passwprd_TXT.clearButtonMode = UITextFieldViewModeWhileEditing;
    Passwprd_TXT.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    Passwprd_TXT.delegate = self;
    Passwprd_TXT.backgroundColor=[UIColor clearColor];
    Passwprd_TXT.textColor=[UIColor blackColor];
    Passwprd_TXT.tag=002;
    Passwprd_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    
    Passwprd_TXT.font=[Font_Face_Controller opensansLight:18];
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 1;
    border1.borderColor = [UIColor lightGrayColor].CGColor;
    border1.frame = CGRectMake(0, email_TXT.frame.size.height - borderWidth1, email_TXT.frame.size.width, email_TXT.frame.size.height);
    border1.borderWidth = borderWidth;
    [Passwprd_TXT.layer addSublayer:border1];
    Passwprd_TXT.layer.masksToBounds = YES;;
    
    Pass_WRD_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock_icon2.png"]];
    Passwprd_TXT.leftView = Pass_WRD_img;
    Passwprd_TXT.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    
    [self.view addSubview:Passwprd_TXT];
    

    
    
    
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Schools_TXT = [[UITextField alloc] initWithFrame:CGRectMake(30, Passwprd_TXT.frame.origin.y+Passwprd_TXT.frame.size.height+20, self.view.frame.size.width-60, 40)];

    Schools_TXT.borderStyle = UITextBorderStyleNone;
    Schools_TXT.font = [UIFont systemFontOfSize:15];
    Schools_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    Schools_TXT.delegate = self;
    Schools_TXT.backgroundColor=[UIColor clearColor];
    Schools_TXT.textColor=[UIColor blackColor];
    Schools_TXT.font=[Font_Face_Controller opensansLight:18];
    Schools_TXT.tag=003;
    Schools_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    
    
    login_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"subdomain.png"]];
    Schools_TXT.leftView = login_img;
    Schools_TXT.leftViewMode = UITextFieldViewModeAlways;
    
    CALayer *border2 = [CALayer layer];
    CGFloat borderWidth2 = 1;
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.frame = CGRectMake(0, Passwprd_TXT.frame.size.height - borderWidth2, Passwprd_TXT.frame.size.width, Passwprd_TXT.frame.size.height);

    border2.borderWidth = borderWidth2;
    [Schools_TXT.layer addSublayer:border2];
    Schools_TXT.layer.masksToBounds = YES;
    
    //Schools_TXT.textAlignment=NSTextAlignmentCenter;
    
    [self.view addSubview:Schools_TXT];

    
    

    //////////////////// Forgot Button\\\\\\\\\\\\\\
    
    
    BTN_Forgot= [UIButton buttonWithType:UIButtonTypeCustom];
    [BTN_Forgot addTarget:self
                   action:@selector(Forgot_PWD:)
         forControlEvents:UIControlEventTouchUpInside];
    [BTN_Forgot setTitleColor:[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    
    
    
    
    [BTN_Forgot.titleLabel setFont:[Font_Face_Controller opensanssemibold:13]];
    BTN_Forgot.frame = CGRectMake(20, Schools_TXT.frame.origin.y+40,160, 33.0);
    [self.view addSubview:BTN_Forgot];

    
    
    
    //////////////////// Language Background lable  \\\\\\\\\\\\\\

    
    background_language=[[UILabel alloc]init];
    background_language.userInteractionEnabled=YES;
    background_language.frame=CGRectMake((self.view.frame.size.width-28)-((Schools_TXT.frame.size.width-50)/2), Schools_TXT.frame.origin.y+38, (Schools_TXT.frame.size.width-50)/2, 33);
    background_language.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:background_language];
    
    
    
    UITapGestureRecognizer *tap_action_Refress = [[UITapGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(chnage_langugae:)];
    
    [background_language addGestureRecognizer:tap_action_Refress];
    

    
    
    //////////////////// Language  Lable  \\\\\\\\\\\\\\

    
    
    language_LB=[[UILabel alloc]init];
    
    language_LB.frame=CGRectMake(background_language.frame.size.width-100, 0, 100, 40);
    
    
    
    
   
    language_LB.textAlignment=NSTextAlignmentRight;
    language_LB.textColor=[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0];
     language_LB.font=[Font_Face_Controller opensanssemibold:13];
    [background_language addSubview:language_LB];
    
    //////////////////// Language  Image  \\\\\\\\\\\\\\
    
    language_img=[[UIImageView alloc]init];
    language_img.frame=CGRectMake(25, 15, 10, 10);
    language_img.image=[UIImage imageNamed:@"globe_icon.png"];
    [language_LB addSubview:language_img];

    
    
    //////////////////// Sign In Button\\\\\\\\\\\\\\
    
    BTN_sign_In = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [BTN_sign_In addTarget:self
                    action:@selector(aMethod:)
          forControlEvents:UIControlEventTouchUpInside];
//    BTN_sign_In.backgroundColor=[UIColor colorWithRed:110.0f/255.0f green:123.0f/255.0f blue:255.0f/255.0f alpha:1.0];
    
    BTN_sign_In.backgroundColor=[UIColor grayColor];
    
       [BTN_sign_In.titleLabel setFont:[Font_Face_Controller opensanssemibold:20]];
    [BTN_sign_In setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    BTN_sign_In.frame = CGRectMake(0,self.view.frame.size.height-50,self.view.frame.size.width, 50);
    BTN_sign_In.enabled = NO;
    [self.view addSubview:BTN_sign_In];
    
    
   
    //Google login button
    BTM_sign_In_GMAIL =[[GIDSignInButton alloc] initWithFrame:CGRectMake(00,Schools_TXT.frame.origin.y+80,self.view.frame.size.width, 50)];
    [self.view addSubview:BTM_sign_In_GMAIL];
    
    
    
//     //------------ back_ground_pickerview view --------------//
//    
//    
//    back_ground_pickerview=[[UIView alloc]init];
//    back_ground_pickerview.frame=CGRectMake(0, self.view.frame.size.height+100, self.view.frame.size.width, 200);
//    back_ground_pickerview.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:back_ground_pickerview];
//    
//    
//    
//    //------------ UIpicker view for show State list --------------//
//    
//    pPickerState=[[UIPickerView alloc] initWithFrame:CGRectMake(0,65, self.view.frame.size.width, 200-65)];
//    
////    pPickerState.showsSelectionIndicator=YES;
//    pPickerState.backgroundColor=[UIColor whiteColor];
//    pPickerState.delegate=self;
//    pPickerState.dataSource=self;
//    pPickerState.userInteractionEnabled=YES;
//    [back_ground_pickerview addSubview:pPickerState];
//    
//    
//    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
//    toolBar.barStyle = UIBarStyleBlackOpaque;
//     toolBar.userInteractionEnabled=YES;
//    
//    search_TXT = [[UITextField alloc]initWithFrame:CGRectMake(0, toolBar.frame.origin.y+toolBar.frame.size.height, toolBar.frame.size.width, 25)];
//    search_TXT.placeholder =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Click here to search for your school" value:@"" table:nil];
//    search_TXT.tag = 123;
//    search_TXT.delegate = self;
//    [back_ground_pickerview addSubview:search_TXT];
//
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneToucheds:)];
//    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelToucheds:)];
    
    
    [self addingNewObjectForPickerView];

    
  
   
   }



-(void) addingNewObjectForPickerView
{
    
    backgroundViewforLanguagePicker=[[UIView alloc]init];
    backgroundViewforLanguagePicker.frame=CGRectMake(0, self.view.frame.size.height+100, self.view.frame.size.width, 200);
    backgroundViewforLanguagePicker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundViewforLanguagePicker];
    
    
    pickerviewForLanguage=[[UIPickerView alloc] initWithFrame:CGRectMake(0,65, self.view.frame.size.width, 200-65)];
    
    //    pPickerState.showsSelectionIndicator=YES;
    pickerviewForLanguage.backgroundColor=[UIColor whiteColor];
    pickerviewForLanguage.delegate=self;
    pickerviewForLanguage.dataSource=self;
    pickerviewForLanguage.userInteractionEnabled=YES;
    pickerviewForLanguage.tag = 1001;
    [backgroundViewforLanguagePicker addSubview:pickerviewForLanguage];
    
    
    toolBarForLanguiage = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolBarForLanguiage.barStyle = UIBarStyleBlackOpaque;
    toolBarForLanguiage.userInteractionEnabled=YES;
    
    cancelButtonorLanguage=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(cancelTouchedsForLanguage:)];
    
    doneButtonForLanguage=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(donetouchedForLanguagePicker:)];
    
    
    // the middle button is to make the Done button align to right
    [toolBarForLanguiage setItems:[NSArray arrayWithObjects:cancelButtonorLanguage, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButtonForLanguage, nil]];
    
     [backgroundViewforLanguagePicker addSubview:toolBarForLanguiage];
    
   
    //------------ back_ground_pickerview view --------------//
    
    
    backgroundViewforCustomerPicker=[[UIView alloc]init];
    backgroundViewforCustomerPicker.frame=CGRectMake(0, self.view.frame.size.height+100, self.view.frame.size.width, 200);
    backgroundViewforCustomerPicker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundViewforCustomerPicker];
    
    
    
    //------------ UIpicker view for show State list --------------//
    
    pickerViewForCustomers=[[UIPickerView alloc] initWithFrame:CGRectMake(0,65, self.view.frame.size.width, 200-65)];
    
    //    pickerViewForCustomers.showsSelectionIndicator=YES;
    pickerViewForCustomers.backgroundColor=[UIColor whiteColor];
    pickerViewForCustomers.delegate=self;
    pickerViewForCustomers.dataSource=self;
    pickerViewForCustomers.userInteractionEnabled=YES;
    pickerViewForCustomers.tag = 1002;
    [backgroundViewforCustomerPicker addSubview:pickerViewForCustomers];
    
    
    toolBarForCustomers = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolBarForCustomers.barStyle = UIBarStyleBlackOpaque;
    toolBarForCustomers.userInteractionEnabled=YES;
    
    search_TXT = [[UITextField alloc]initWithFrame:CGRectMake(0, toolBarForCustomers.frame.origin.y+toolBarForCustomers.frame.size.height, toolBarForCustomers.frame.size.width, 25)];
    search_TXT.placeholder =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Click here to search for your school" value:@"" table:nil];
    search_TXT.tag = 004;
    search_TXT.delegate = self;
    search_TXT.autocorrectionType= UITextAutocorrectionTypeNo;
    [backgroundViewforCustomerPicker addSubview:search_TXT];

    cancelButtonForCusomer=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(cancelToucheds:)];
    
    doneButtonForCustomer=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(doneToucheds:)];
    
    
    // the middle button is to make the Done button align to right
    [toolBarForCustomers setItems:[NSArray arrayWithObjects:cancelButtonForCusomer, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButtonForCustomer, nil]];
    
    
    
    [backgroundViewforCustomerPicker addSubview:toolBarForCustomers];


}

#pragma mark - -*********************
#pragma mark viewWillAppear Method
#pragma mark - -*********************


-(void) addTransparancyWhenPickerViewappears
{
    if (!transparentView) {
     transparentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-200)];
    transparentView.backgroundColor = [UIColor blackColor];
    transparentView.alpha = 0.6;
    [self.view addSubview:transparentView];
    [self.view bringSubviewToFront:transparentView];
    transparentView.hidden = YES;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    
   
    [super viewWillAppear:YES];

    
    
    //////////////////// Hide UInavigation Bar \\\\\\\\\\\\\\
    
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton = YES;
    

    loader_image=[ELR_loaders_ Start_loader:CGRectMake(([[UIScreen mainScreen]bounds].size.width-85)/2,[[UIScreen mainScreen]bounds].size.height/2,85,85)];
    [self.view addSubview:loader_image];
    [loader_image setHidden:YES];
    
    [self mStartIndicater];
    
    [self Language_array_values];
    
    [self performSelector:@selector(sub_domain) withObject:nil afterDelay:0.5];
    
    
    
    
    
    email_TXT.placeholder = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Username / Email" value:@"" table:nil];
    
    Passwprd_TXT.placeholder=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Password" value:@"" table:nil];
    
    
    
     Schools_TXT.placeholder = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schools" value:@"" table:nil];
    
    search_TXT.placeholder = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Click here to search for your school" value:@"" table:nil];
    
    [BTN_Forgot setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Forgot your password?" value:@"" table:nil] forState:UIControlStateNormal];
    language_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Language" value:@"" table:nil];
    [BTN_sign_In setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Log in" value:@"" table:nil] forState:UIControlStateNormal];
    
    [doneButtonForLanguage setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil]];
    [cancelButtonorLanguage setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil]];

    [doneButtonForCustomer setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil]];

    [cancelButtonForCusomer setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil]];

    [self.view bringSubviewToFront:backgroundViewforLanguagePicker];

    [self addTransparancyWhenPickerViewappears];
    
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TwoFactorLoginPopUPView" owner:self options:nil];
    
//    TwoFacetorLoginPopUPView *view = [[TwoFacetorLoginPopUPView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)]; // or if it exists, MCQView *view = [[MCQView alloc] init];
//    
//    view = (TwoFacetorLoginPopUPView *)[nib objectAtIndex:0]; // or if it exists, (MCQView *)[nib objectAtIndex:0];
//    view.titleLable.text = @"Title";
//    [self.view addSubview:view];
    
}


-(void)viewDidAppear:(BOOL)animated
{    [super viewDidAppear:YES];

    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate removeEventsFromCalendar];
}

-(void)chnage_langugae:(UITapGestureRecognizer *) sender
{
    
//    [pPickerState selectRow:0 inComponent:0 animated:YES];

//    canPicker_Array=NO;
//    pickre_STR=nil;
    [self Language_array_values];
    
    [pickerviewForLanguage reloadAllComponents];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
         backgroundViewforLanguagePicker.frame=CGRectMake(0,self.view.frame.size.height-200, self.view.frame.size.width, 200);
//         search_TXT.hidden = YES;
        
        [UIView commitAnimations];
    });
    


   
}

-(void)Language_array_values
{
    [arrayWithLanguages removeAllObjects];
//    [arrayForCustomers removeAllObjects];
    [Demo_ARR removeAllObjects];
    [Copy_Of_Demo_ARR removeAllObjects];
//    [copy_Of_Array_Of_Customers removeAllObjects];
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]isEqualToString:@"sw"]) {
        [language_ARR addObject:@"Engelska"];
        [language_ARR addObject:@"Svenska"];
        [arrayWithLanguages addObject:@"Engelska"];
        [arrayWithLanguages addObject:@"Svenska"];
    }
    else
    {
        [language_ARR addObject:@"English"];
        [language_ARR addObject:@"Swedish"];
        [arrayWithLanguages addObject:@"English"];
        [arrayWithLanguages addObject:@"Swedish"];
    }
    
    
//    [self sub_domain];
   
//    [Demo_ARR addObjectsFromArray:language_ARR];
   // [Copy_Of_Demo_ARR addObjectsFromArray:language_ARR];
    [pickerviewForLanguage reloadAllComponents];
}


#pragma mark - -*********************
#pragma mark Activity Cancel Button
#pragma mark - -*********************

- (void)cancelTouchedsForLanguage:(UIBarButtonItem *)sender
{
    
    [pPickerState setHidden:NO];
//    pickre_STR=nil;
    search_TXT.text = @"";
    searchString = [[NSMutableString alloc]init];
     [search_TXT resignFirstResponder];
//    NSArray * arrayForCopyOfDemoArray = [Copy_Of_Demo_ARR mutableCopy];
//     NSArray * arrayForCopyOfCustomerArray = [copy_Of_Array_Of_Customers mutableCopy];
    
    
//    Demo_ARR = [NSMutableArray arrayWithArray:arrayForCopyOfDemoArray];
//    arrayOfCustomers = [NSMutableArray arrayWithArray:arrayForCopyOfCustomerArray];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        backgroundViewforCustomerPicker.frame=CGRectMake(0,self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        backgroundViewforLanguagePicker.frame=CGRectMake(0,self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        [search_TXT resignFirstResponder];
        [UIView commitAnimations];
    });
    
    NSArray * sampleArray = [copy_Of_Array_Of_Customers mutableCopy];
    arrayForCustomers = [NSMutableArray arrayWithArray:sampleArray];
    
    
    NSLog(@"arrayForCustomers cancel%lu",(unsigned long)[arrayForCustomers count]);
    NSLog(@"copyarrayForCustomers cancel%lu",(unsigned long)[copy_Of_Array_Of_Customers count]);

}

- (void)cancelToucheds:(UIBarButtonItem *)sender
{
    transparentView.hidden = YES;
    [pPickerState setHidden:NO];
    //    pickre_STR=nil;
    search_TXT.text = @"";
    searchString = [[NSMutableString alloc]init];
    [search_TXT resignFirstResponder];
    //    NSArray * arrayForCopyOfDemoArray = [Copy_Of_Demo_ARR mutableCopy];
    //     NSArray * arrayForCopyOfCustomerArray = [copy_Of_Array_Of_Customers mutableCopy];
    
    
    //    Demo_ARR = [NSMutableArray arrayWithArray:arrayForCopyOfDemoArray];
    //    arrayOfCustomers = [NSMutableArray arrayWithArray:arrayForCopyOfCustomerArray];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        backgroundViewforCustomerPicker.frame=CGRectMake(0,self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        backgroundViewforLanguagePicker.frame=CGRectMake(0,self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        [search_TXT resignFirstResponder];
        [UIView commitAnimations];
    });
    
    NSArray * sampleArray = [copy_Of_Array_Of_Customers mutableCopy];
    arrayForCustomers = [NSMutableArray arrayWithArray:sampleArray];

    NSLog(@"arrayForCustomers cancel%lu",(unsigned long)[arrayForCustomers count]);
    NSLog(@"copyarrayForCustomers cancel%lu",(unsigned long)[copy_Of_Array_Of_Customers count]);
    
}

#pragma mark - -*********************
#pragma mark Activity Done Button
#pragma mark - -*********************

-(void) donetouchedForLanguagePicker:(UIBarButtonItem *)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        backgroundViewforLanguagePicker.frame=CGRectMake(0,self.view.frame.size.height, self.view.frame.size.width, 200);
//        search_TXT.hidden = YES;
        
        [UIView commitAnimations];
    });

    languageStringFromUserDefaults =  [arrayWithLanguages objectAtIndex:[pickerviewForLanguage selectedRowInComponent:0]];
    
    NSLog(@"-->>>>%@",  [arrayWithLanguages objectAtIndex:[pickerviewForLanguage selectedRowInComponent:0]]);

    
    if ([languageStringFromUserDefaults isEqualToString:@"Engelska"] || [languageStringFromUserDefaults isEqualToString:@"English"]) {
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"en" forKey:@"langugae"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        Language_STR=@"en";
        
        
        
    }
    else
    {
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"sw" forKey:@"langugae"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    

customerListServicecount = 0;
    [arrayForCustomers removeAllObjects];
    [copy_Of_Array_Of_Customers removeAllObjects];
//[self Language_array_values];

[self viewWillAppear:NO];
    
    NSLog(@"arrayForCustomers done%lu",(unsigned long)[arrayForCustomers count]);
    NSLog(@"copyarrayForCustomers done%lu",(unsigned long)[copy_Of_Array_Of_Customers count]);

}
- (void)doneToucheds:(UIBarButtonItem *)sender
{
  //  if ([API connectedToInternet]==YES) {
    transparentView.hidden = YES;
    search_TXT.text = @"";
    searchString = [[NSMutableString alloc]init];
    [search_TXT resignFirstResponder];
    if ([filtered count]== 0) {
        //
    }
    else if(pickerViewForCustomers.isHidden)
    {
        //
    }
//    [pi setHidden:NO];
    else
    {
    Schools_TXT.text = [[filtered objectAtIndex:pickre_index_value] objectForKey:@"name"];
    NSLog(@"%@",[filtered objectAtIndex:pickre_index_value] );
    [[NSUserDefaults standardUserDefaults] setObject:[[filtered objectAtIndex:pickre_index_value] objectForKey:@"domain_name"] forKey:@"sub_domain"];
    
    
    
    [[NSUserDefaults standardUserDefaults]setValue:[[filtered objectAtIndex:pickre_index_value] objectForKey:@"domain_name"] forKey:@"Default_subdomain"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setValue:[[filtered objectAtIndex:pickre_index_value] objectForKey:@"name"] forKey:@"Default_subdomain_name"];

    
//    if (canPicker_Array==NO) {
//        
//    
//    
//        if ([pickre_STR isEqualToString:@""]||[pickre_STR isEqualToString:nil] || [pickre_STR isEqual:nil] || [pickre_STR length]==0) {
//            
//            
//            
//            [[NSUserDefaults standardUserDefaults]setObject:@"en" forKey:@"langugae"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//            
//        }
//        else
//        {
//            
//            
//            if ([pickre_STR isEqualToString:@"engelska"] || [pickre_STR isEqualToString:@"English"]) {
//                
//                
//                
//                [[NSUserDefaults standardUserDefaults]setObject:@"en" forKey:@"langugae"];
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                
//                 Language_STR=@"en";
//                
//
//                
//            }
//            else
//            {
//             
//                
//                [[NSUserDefaults standardUserDefaults]setObject:@"sw" forKey:@"langugae"];
//                [[NSUserDefaults standardUserDefaults]synchronize];
//
//            }
//            
//        }
//
//      
//        [self Language_array_values];
//        
//         [self viewWillAppear:NO];
//    }
//    
//    else
//    {
//        NSArray * arrayForCopyOfDemoArray = [Copy_Of_Demo_ARR mutableCopy];
//        NSArray * arrayForCopyOfCustomerArray = [copy_Of_Array_Of_Customers mutableCopy];
//        
//        
//        Demo_ARR = [NSMutableArray arrayWithArray:arrayForCopyOfDemoArray];
//        arrayOfCustomers = [NSMutableArray arrayWithArray:arrayForCopyOfCustomerArray];

        
//        if ([pickre_STR isEqualToString:@""]||[pickre_STR isEqualToString:nil] || [pickre_STR isEqual:nil] || [pickre_STR length]==0) {
//            
//            Schools_TXT.text=[Demo_ARR objectAtIndex:0];
//            
//            
//            
////            [[NSUserDefaults standardUserDefaults]setValue:[[[dict_School valueForKey:@"customerList"]objectAtIndex:0]valueForKey:@"domain_name"] forKey:@"sub_domain"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//            
//            
//            [[NSUserDefaults standardUserDefaults]setValue:[[[dict_School valueForKey:@"customerList"]objectAtIndex:0]valueForKey:@"domain_name"] forKey:@"Default_subdomain"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//            [[NSUserDefaults standardUserDefaults]setValue:[[[dict_School valueForKey:@"customerList"]objectAtIndex:0]valueForKey:@"name"] forKey:@"Default_subdomain_name"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//
//            
//            
//            
//                   }
//        else
//        {
//            
//             Schools_TXT.text=pickre_STR;
//            
////            [[NSUserDefaults standardUserDefaults]setValue:[[[dict_School valueForKey:@"customerList"]objectAtIndex:pickre_index_value]valueForKey:@"domain_name"] forKey:@"sub_domain"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//            
//            
//            [[NSUserDefaults standardUserDefaults]setValue:[[[dict_School valueForKey:@"customerList"]objectAtIndex:pickre_index_value]valueForKey:@"domain_name"] forKey:@"Default_subdomain"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//
//            [[NSUserDefaults standardUserDefaults]setValue:[[[dict_School valueForKey:@"customerList"]objectAtIndex:pickre_index_value]valueForKey:@"name"] forKey:@"Default_subdomain_name"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//            
//            
//
//
//            
//        }
//        
    
      
//    }
    }
    
    NSArray * sampleArray = [copy_Of_Array_Of_Customers mutableCopy];
    arrayForCustomers = [NSMutableArray arrayWithArray:sampleArray];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        backgroundViewforCustomerPicker.frame=CGRectMake(0,self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        [search_TXT resignFirstResponder];
        
        [UIView commitAnimations];
    });

    [self textFieldDidEndEditing:Schools_TXT];
    
    NSLog(@"arrayForCustomers done%lu",(unsigned long)[arrayForCustomers count]);
    NSLog(@"copyarrayForCustomers done%lu",(unsigned long)[copy_Of_Array_Of_Customers count]);

  //  }
    
}


#pragma mark - -*********************
#pragma mark Activity PickerView
#pragma mark - -*********************

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

{
    if (pickerView.tag == 1001) {
        return arrayWithLanguages.count;
    }
    else
    {
    return filtered.count;
    }
}

-(NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 1001) {
        return [arrayWithLanguages objectAtIndex:row];
    }
    else
    {
        NSLog(@"%@",[[filtered objectAtIndex:row] objectForKey:@"name"]);
        return [[filtered objectAtIndex:row] objectForKey:@"name"];
    }

    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (pickerView.tag == 1001) {
        
        languageStringFromUserDefaults = [arrayWithLanguages objectAtIndex:row];
        
    }
    else
    {
//        NSArray * arrayForPickerString = [[arrayForCustomers objectAtIndex:row] componentsSeparatedByString:@"  "];
//        
//        pickre_STR=[arrayForPickerString objectAtIndex:0];
        pickre_index_value=row;
      
    }
   
    
}

#pragma mark - -*********************
#pragma mark Activity Forgot Password
#pragma mark - -*********************




-(void)Forgot_PWD:(UIButton *)sender
{
    
    
//    TwoFactorLoginPopUpViewController *controller = [[TwoFactorLoginPopUpViewController alloc] initWithNibName:@"TwoFactorLoginPopUPView" bundle:nil];
//    
//    [self.navigationController pushViewController:controller animated:YES];
    
    
    
    //------------ Show AlertView For enter Email_id for retrive new password in your email_id--------------//
    
    alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Alert" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Please enter the Email for your account." value:@"" table:nil] delegate:self cancelButtonTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
    
    
    //------------ Show TextField in Alert view--------------//
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
   // }

}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        mEmail_id =  [alertView textFieldAtIndex: 0];
        
        NSLog(@"%@",mEmail_id.text);
        
            //------------ Fetch Data From  AlertView textfield (Email_ID)--------------//
        
        
       if(![Email_validation validateEmail:[mEmail_id text]]) {
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter a valid email address." value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
            [self mStopIndicater];
        }
        
   
        
        else
        {
            [self performSelector:@selector(forgot_password)withObject:nil afterDelay:0.2];
        }
        
    }
    
}


-(void)forgot_password
{
    
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&email=%@&language=%@",@"H67jdS7wwfh",mEmail_id.text,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@users/forgot_password",[Utilities API_link_url_subDomain]]];
        
      
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict_forgot = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        if ([[dict_forgot valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Alert" value:@"" table:nil] message:[dict_forgot valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];

            
        }else if([[dict_forgot valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict_forgot valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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
#pragma mark Activity Login Button
#pragma mark - -*********************

-(void)aMethod:(UIButton *)sender
{
    
    if ([[email_TXT.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || [[Passwprd_TXT.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || [[Schools_TXT.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        
        
        if ([[email_TXT.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            
            
            
            [email_TXT shake:10
                   withDelta:5.0
                    andSpeed:0.04
              shakeDirection:ShakeDirectionHorizontal];
            
            
            
        }
        
        if ([[Passwprd_TXT.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            
            
            
            [Passwprd_TXT shake:10
                      withDelta:5.0
                       andSpeed:0.04
                 shakeDirection:ShakeDirectionHorizontal];
        }
        
        if ([[Schools_TXT.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            
            
            
            [Schools_TXT shake:10
                   withDelta:5.0
                    andSpeed:0.04
              shakeDirection:ShakeDirectionHorizontal];
            
            
            
        }
        

        
    }
    else
    {
        [self mStartIndicater];
        
        [self performSelector:@selector(webserviceForLogin:withGoogleResponseDic:) withObject:nil afterDelay:0.5];
        

    }

    
    
    
//    Remember_Me_ViewController *objRemember_Me_ViewController=[[Remember_Me_ViewController alloc]init];
//    [self.navigationController pushViewController:objRemember_Me_ViewController animated:YES];
    
}

-(void) displayCustomViewToVerifyOTPWithMessageString : (NSString *) messageString
{
    totalSeconds = 120;
    twoMinTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                   target:self
                                                 selector:@selector(timer)
                                                 userInfo:nil
                                                  repeats:YES];
    
     transpearentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    transpearentView.backgroundColor = [UIColor blackColor];
    transpearentView.alpha = 0.4;
    [self.view addSubview:transpearentView];
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"TwoFactorLoginPopUPView" owner:self options:nil];
    twoFactorLoginView = (TwoFactorLoginView *)[subviewArray objectAtIndex:0];
    twoFactorLoginView.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width - 280)/2, 120, 280, 220);
    twoFactorLoginView.titleLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Two factor login" value:@"" table:nil];
    [twoFactorLoginView.okButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Log in" value:@"" table:nil] forState:UIControlStateNormal];
    [twoFactorLoginView.cancelButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] forState:UIControlStateNormal];
    twoFactorLoginView.contentLabel.text = messageString;
    [self.view addSubview:twoFactorLoginView];

}

- (void)timer {
    totalSeconds--;
//    timerLabel.text = [self timeFormatted:totalSeconds];
    if ( totalSeconds == 0 ) {
        [twoMinTimer invalidate];
        
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Code became invalid. Please login again"  message:nil  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [transpearentView removeFromSuperview];
            [twoFactorLoginView removeFromSuperview];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

- (IBAction)verifyOTPButton:(id)sender {
    if ([twoFactorLoginView.enterCodeTextField.text isEqualToString:receivedCodeForTwoFactorLogin]) {
        NSLog(@"Success");
    Remember_Me_ViewController *objRemember_Me_ViewController=[[Remember_Me_ViewController alloc]init];
    [self.navigationController pushViewController:objRemember_Me_ViewController animated:YES];
    }
    else
    {
         NSLog(@"Failure");
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter valid Authentication Number" value:@"" table:nil] message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
        //error
    }
}

- (IBAction)cancelButtonclicked:(id)sender {
    [transpearentView removeFromSuperview];
    [twoFactorLoginView removeFromSuperview];
}


#pragma mark - -*********************
#pragma mark CallTheServer_Login_API Method
#pragma mark - -*********************

-(void) webserviceForLogin :(BOOL)isGoogleLogin withGoogleResponseDic:(NSMutableDictionary *)loginResponseDic {
    
    NSString *requestString;
    
    if(isGoogleLogin){
        
            requestString = [NSString stringWithFormat:@"securityKey=%@&username=%@&password=%@&device_token_app=%@&user_type_app=%@&language=%@&login_access_by_google=1",@"H67jdS7wwfh",[loginResponseDic valueForKey:@"username"],[loginResponseDic valueForKey:@"password"],[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]];
            [[NSUserDefaults standardUserDefaults]setObject:[loginResponseDic valueForKey:@"username"] forKey:@"emailid"];
            [[NSUserDefaults standardUserDefaults]setObject:[loginResponseDic valueForKey:@"password"] forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        
    }else{
        requestString = [NSString stringWithFormat:@"securityKey=%@&username=%@&password=%@&device_token_app=%@&user_type_app=%@&language=%@",@"H67jdS7wwfh",email_TXT.text,Passwprd_TXT.text,[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]];
        [[NSUserDefaults standardUserDefaults]setObject:email_TXT.text forKey:@"emailid"];
        [[NSUserDefaults standardUserDefaults]setObject:Passwprd_TXT.text forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
 //   NSLog(@"email===>%@ password===> %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"emailid"],[[NSUserDefaults standardUserDefaults]valueForKey:@"password"]);
    
     NSLog(@"Reply JSON: %@", requestString);
    NSLog(@"Reply JSON: %@", [NSString stringWithFormat:@"%@users/login",[Utilities API_link_url_subDomain]]);
        //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
        NSError *error;
   
     NSData *postData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestString options:0 error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSLog(@"[NSUserDefaults standardUserDefaults]valueForKey:@sub_domain] %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]);
    
    
    
//    [NSString stringWithFormat:@"%@users/login",[Utilities API_link_url_subDomain]]
    
    
        NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@users/login",[Utilities API_link_url_subDomain]] parameters:nil error:nil];
        
        req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
//        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    
    [req setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            [self mStopIndicater];
            if (!error) {
                            NSLog(@"Reply JSON: %@", responseObject);
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    //blah blah
//                    [self ];
                    [self CallTheServer_Login_API:responseObject];
                }
            } else {
                NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            }
            [self mStopIndicater];
        }] resume];
    
    
 
}


-(void)CallTheServer_Login_API : (NSDictionary *) responseDict
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
//        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&username=%@&password=%@&device_token_app=%@&user_type_app=%@&language=%@",@"H67jdS7wwfh",email_TXT.text,Passwprd_TXT.text,[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@users/login",[Utilities API_link_url_subDomain]]];
//        
//        
//        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
//        NSLog(@"%@",[NSString stringWithFormat:@"%@users/login",[[NSUserDefaults standardUserDefaults]objectForKey:@"sub_domain"]]);
//         NSLog(@"%@",[NSString stringWithFormat:@"securityKey=%@&username=%@&password=%@&device_token_app=%@&user_type_app=%@&language=%@",@"H67jdS7wwfh",email_TXT.text,Passwprd_TXT.text,[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]);
//        NSDictionary *responseDict = [responseString JSONValue];
        dict_Login = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        NSLog(@"dict=>%@",dict_Login);
        
        if ([[dict_Login valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"LoginStatues"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[dict_Login valueForKey:@"authentication_token"] forKey:@"authentication_token"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[dict_Login valueForKey:@"ComComponent"] forKey:@"ComComponent"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[dict_Login valueForKey:@"User"]forKey:@"User"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[dict_Login valueForKey:@"User"]valueForKey:@"customer_logo"] forKey:@"customer_logo"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[dict_Login valueForKey:@"User"]valueForKey:@"USR_image"] forKey:@"USR_image"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            


            
            [[NSUserDefaults standardUserDefaults]setObject:[[dict_Login valueForKey:@"User"]valueForKey:@"id"] forKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[dict_Login valueForKey:@"User"]valueForKey:@"user_table_id"] forKey:@"user_table_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];

            
            
        
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:[dict_Login valueForKey:@"other_accounts"]] forKey:@"other_accounts"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[[[dict_Login valueForKey:@"User"]valueForKey:@"user_type"]stringByConvertingHTMLToPlainText]lowercaseString] forKey:@"user_type"];
            [[NSUserDefaults standardUserDefaults]synchronize];

            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
                
                [[NSUserDefaults standardUserDefaults]setObject:[dict_Login valueForKey:@"children"]forKey:@"children"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                [[NSUserDefaults standardUserDefaults]setObject:[[dict_Login valueForKey:@"User"]valueForKey:@"id"]forKey:@"parent_id"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                [[NSUserDefaults standardUserDefaults]setObject:[[dict_Login valueForKey:@"User"]valueForKey:@"authentication_token"]forKey:@"parent_authentication_token"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
                [[NSUserDefaults standardUserDefaults]setObject:[[dict_Login valueForKey:@"User"]valueForKey:@"authentication_token"]forKey:@"authentication_token"];
                [[NSUserDefaults standardUserDefaults]synchronize];



            
            }
            else
            {
            
                
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"parent_id"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            
            if ([[dict_Login objectForKey:@"Twofactor"] isEqualToString:@"true"]) {
                NSString * stringForContentLabel = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"The user" value:@"" table:nil],[dict_Login[@"User"] objectForKey:@"USR_FirstName"],[dict_Login[@"User"] objectForKey:@"USR_Lastname"],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"requires two factor login and a code has been sent to" value:@"" table:nil],[dict_Login[@"User"] objectForKey:@"USR_Email"]];
                
                receivedCodeForTwoFactorLogin = [NSString stringWithFormat:@"%@",[dict_Login objectForKey:@"randomnumber"] ];
                [self displayCustomViewToVerifyOTPWithMessageString:stringForContentLabel];
                }
            else
            {
                Remember_Me_ViewController *objRemember_Me_ViewController=[[Remember_Me_ViewController alloc]init];
                [self.navigationController pushViewController:objRemember_Me_ViewController animated:YES];

            }
            
        }else if([[dict valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
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
#pragma mark Getschool  Domain Method
#pragma mark - -*********************

-(void)sub_domain
{
    if (customerListServicecount == 4) {
        if ([arrayForCustomers count] == 0) {
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict_School valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
                    [alert show];
        }
        else
        {
          [self responseFromSub_domain];
        customerListServicecount = 0;
        }
        [self mStopIndicater];
    }
    else
    {
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
       
        NSError * error;
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        NSURL *url = [NSURL URLWithString:[arrayWithCustomerUrl objectAtIndex:customerListServicecount]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:30.0];
        
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [request setHTTPMethod:@"POST"];
            NSDictionary *dict1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"sfA786ula4",@"securityKey",
                                     nil];
        NSData *postData = [NSJSONSerialization dataWithJSONObject:dict1 options:0 error:&error];
        [request setHTTPBody:postData];
        
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *errorInResponse)
                                              {
                                                          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&errorInResponse];
                                                          NSLog(@"%@", json);
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      customerListServicecount = customerListServicecount +1;
                                                      NSLog(@"customerList %@",[json objectForKey:@"customerList"]);
                                                      
                                                      [arrayForCustomers addObjectsFromArray:[json objectForKey:@"customerList"]];
                                                      NSLog(@"customerListCount %lu",(unsigned long)[arrayForCustomers count]);
                                                      [self sub_domain];
                                                    
                                                      
                                                  });
                                                  
                                              }];
        
        [postDataTask resume];

        
        
//        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"{\"securityKey\":\"H67jdS7wwfh\"}"]:[NSString stringWithFormat:@"%@getCustomerList",[Utilities API_link_url]]];
//
////        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@",@"H67jdS7wwfh"]:[NSString stringWithFormat:@"%@users/get_schools",[Utilities API_link_url]]];
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
    }
    
}

}

-(void) responseFromSub_domain
{

        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Default_subdomain"]isEqualToString:@"http://elar.se/"]) {
            
            [[NSUserDefaults standardUserDefaults]setValue:@"http://elar.se/" forKey:@"Default_subdomain"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setValue:@"Elar" forKey:@"Default_subdomain_name"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
//            [[NSUserDefaults standardUserDefaults]setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Default_subdomain"] forKey:@"sub_domain"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
//            Schools_TXT.text=@"Elar";
            
        }
        else
        {
//            [[NSUserDefaults standardUserDefaults]setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Default_subdomain"] forKey:@"sub_domain"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
//            Schools_TXT.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"Default_subdomain_name"];
            
        }
        
        [pickerViewForCustomers reloadAllComponents];
        

//    }
    
    
    

}

-(void)sub_domains_open_picker
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@",@"H67jdS7wwfh"]:[NSString stringWithFormat:@"%@users/get_schools",[Utilities API_link_url]]];
        NSDictionary *responseDict = [responseString JSONValue];
        dict_School = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        if ([[dict_School valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Default_subdomain"]isEqualToString:@"http://elar.se/"]) {
                
                
                [[NSUserDefaults standardUserDefaults]setValue:@"http://elar.se/" forKey:@"Default_subdomain"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
                [[NSUserDefaults standardUserDefaults]setValue:@"Elar" forKey:@"Default_subdomain_name"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
//                [[NSUserDefaults standardUserDefaults]setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Default_subdomain"] forKey:@"sub_domain"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
//                Schools_TXT.text=@"Elar";
                
            }
            else
            {
//                [[NSUserDefaults standardUserDefaults]setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Default_subdomain"] forKey:@"sub_domain"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
//                Schools_TXT.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"Default_subdomain_name"];
                
            }            
        }else if([[dict_School valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        else
        {
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict_School valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
//                        alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//                       [alert show];
            
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
    [loader_image setHidden:NO];
}

#pragma mark - -*********************
#pragma mark Stop Indicater
#pragma mark - -*********************

-(void)mStopIndicater
{
     [loader_image setHidden:YES];
    
}

#pragma mark - -*********************
#pragma mark TextField Delegate
#pragma mark - -*********************

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (email_TXT .text.length != 0) {
        if (Passwprd_TXT.text.length != 0) {
            if (Schools_TXT.text.length != 0) {
                NSLog(@"Success %@",Schools_TXT.text);
                BTN_sign_In.enabled = YES;
                BTN_sign_In.backgroundColor=[UIColor colorWithRed:110.0f/255.0f green:123.0f/255.0f blue:255.0f/255.0f alpha:1.0];
//                login
            }
            else
            {
                BTN_sign_In.enabled = NO;
                BTN_sign_In.backgroundColor=[UIColor grayColor];
                //                login

            }

        }
        else
        {
            BTN_sign_In.enabled = NO;
            BTN_sign_In.backgroundColor=[UIColor grayColor];
            //                login

        }

    }
    else
    {
        BTN_sign_In.enabled = NO;
        BTN_sign_In.backgroundColor=[UIColor grayColor];
        //                login

    }
       if (textField.tag == 004) {
           if ([arrayForCustomers count] == 0) {
               NSArray * sampleArray = [copy_Of_Array_Of_Customers mutableCopy];
               arrayForCustomers = [NSMutableArray arrayWithArray:sampleArray];
           }

        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            backgroundViewforCustomerPicker.frame=CGRectMake(0,self.view.frame.size.height-200, self.view.frame.size.width, 200);
            
            
            [UIView commitAnimations];
        });

    }
    if (textField.tag == 001 || textField.tag == 002) {
        [textField resignFirstResponder];
    }
    if (textField.tag == 003) {
        transparentView.hidden = YES;
    }

}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 003) {
        
        [textField resignFirstResponder];
        [Passwprd_TXT resignFirstResponder];
        [email_TXT resignFirstResponder];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
        if (textField.tag==003) { // school text
        transparentView.hidden = NO;
        [textField resignFirstResponder];
        [Passwprd_TXT resignFirstResponder];
        [email_TXT resignFirstResponder];

        NSArray * sampleArray = [arrayForCustomers mutableCopy];
        copy_Of_Array_Of_Customers = [NSMutableArray arrayWithArray:sampleArray];
        [arrayForCustomers removeAllObjects];
        
        [self.view bringSubviewToFront:backgroundViewforCustomerPicker];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            backgroundViewforCustomerPicker.frame=CGRectMake(0,self.view.frame.size.height-200, self.view.frame.size.width, 200);
            [pickerViewForCustomers setHidden:YES];
            
            [UIView commitAnimations];
        });
        return NO;
    
    }
    else if (textField.tag == 004) // Search text
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            backgroundViewforCustomerPicker.frame=CGRectMake(0,self.view.frame.size.height-440, self.view.frame.size.width, 200);
            
            
            [UIView commitAnimations];
        });

        return YES;
        
    }
    else if (textField.tag == 123) // Search text
    {
        back_ground_pickerview.frame=CGRectMake(0,self.view.frame.size.height-440, self.view.frame.size.width, 200);
        return YES;

    }
    else
    {
         back_ground_pickerview.frame=CGRectMake(0,self.view.frame.size.height+200, self.view.frame.size.width, self.view.frame.size.height);
         return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.tag == 123)
    {
        textField.text = @"";
        back_ground_pickerview.frame=CGRectMake(0,self.view.frame.size.height-200, self.view.frame.size.width, 200);
        return YES;
        
    }

    return true;
    
}

- (BOOL)containsString:(NSString *)Sting withSubString : (NSString *) subString
{
    NSRange range = [Sting rangeOfString : subString];
    BOOL found = ( range.location != NSNotFound );
    return found;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

        if (textField.tag == 004) {
        if (range.length == 1) {
            [searchString replaceCharactersInRange:NSMakeRange(searchString.length-1, 1) withString:@""];
        }
        else
        {
            [searchString appendString:[NSString stringWithFormat:@"%@",string]];
        }
 
            if (searchString.length > 2) {
            NSIndexSet *indices = [copy_Of_Array_Of_Customers indexesOfObjectsPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
                return [[[obj objectForKey:@"name"] lowercaseString] containsString:[searchString lowercaseString]];
            }];
            filtered = [copy_Of_Array_Of_Customers objectsAtIndexes:indices];
                [pickerViewForCustomers reloadAllComponents];
                [pickerViewForCustomers setHidden:NO];
            }
            else
            {
                [pickerViewForCustomers setHidden:YES];
            }

    }
    return YES;
}


- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
}

//----------------------------------------------------------------------------




@end
