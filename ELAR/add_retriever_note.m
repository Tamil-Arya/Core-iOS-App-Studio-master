//
//  add_retriever_note.m
//  SCM
//
//  Created by pnf on 12/20/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//

#import "add_retriever_note.h"
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
#import "ImageCustomClass.h"
#import "profile.h"
#import "LogoutManager.h"

@interface add_retriever_note ()

@end

@implementation add_retriever_note
@synthesize add_check;


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
    
 //   user_pic.frame=CGRectMake(50, 0, 30, 30);
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
    user_pic.layer.masksToBounds = YES;
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
//    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retrieval note" value:@"" table:nil];
    
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size1;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=11){
        size1 = CGSizeMake(20, 20);
    } else {
        size1 = CGSizeMake(30, 30);
    }
    
    UIImage *butImage = [ImageCustomClass image:[UIImage imageNamed:@"back-2"] resize:size1];
    

//    UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
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
self.view.backgroundColor = [UIColor whiteColor];
    //----------complete screen under header----------//
    //background
    UIView *backgroundBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
 
    backgroundBox.userInteractionEnabled=YES;
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
    [datelabel setFont:[Font_Face_Controller opensansLight:18]];
    datelabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:datelabel];
    
    // Date text field START
    datetextfield = [[UITextField alloc] initWithFrame:CGRectMake(10, datelabel.frame.origin.y+datelabel.frame.size.height+5 ,(self.view.frame.size.width-30)/2, 35)];
    
    
    
    datetextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YYYY-MM-DD" value:@"" table:nil] attributes:@{NSForegroundColorAttributeName: [Text_color_ Placeholder_Text_Color_code]}];
    datetextfield.textColor=[Text_color_ Content_Text_Color_code];
    
    
    datetextfield.font = [Font_Face_Controller opensansLight:16];
    datetextfield.delegate=self;
    datetextfield.backgroundColor = [UIColor whiteColor];
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
    [tolabel setFont:[Font_Face_Controller opensansLight:18]];
    tolabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:tolabel];
    
    // To text field START
    totextfield = [[UITextField alloc] initWithFrame:CGRectMake(datelabel.frame.origin.x+datelabel.frame.size.width+10, tolabel.frame.origin.y+tolabel.frame.size.height+5,(self.view.frame.size.width-30)/2, 35)];
    
    totextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YYYY-MM-DD" value:@"" table:nil] attributes:@{NSForegroundColorAttributeName: [Text_color_ Placeholder_Text_Color_code]}];
    totextfield.textColor=[Text_color_ Content_Text_Color_code];
    
    totextfield.font = [Font_Face_Controller opensansLight:16];
    totextfield.delegate=self;
    totextfield.backgroundColor = [UIColor whiteColor];
    UIView *paddingViewto = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    totextfield.leftView = paddingViewto;
    totextfield.leftViewMode = UITextFieldViewModeAlways;
    [backgroundBox addSubview:totextfield];
    
    UIDatePicker *todatePicker = [[UIDatePicker alloc] init];
    todatePicker.datePickerMode = UIDatePickerModeDate;
    [todatePicker addTarget:self action:@selector(todatePickerChanged:)
           forControlEvents:UIControlEventValueChanged];
    [totextfield setInputView:todatePicker];
    
    
    //Retriever Name label text
    UILabel *retrievernamelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, datetextfield.frame.origin.y+datetextfield.frame.size.height+10 ,self.view.frame.size.width-144, 18)];
    retrievernamelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retriever Name" value:@"" table:nil];
    retrievernamelabel.textColor = [UIColor whiteColor];
    [retrievernamelabel setFont:[Font_Face_Controller opensansLight:18]];
    retrievernamelabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:retrievernamelabel];
    
    // Retriever Name text field START
    retrievernametextfield = [[UITextField alloc] initWithFrame:CGRectMake(10, retrievernamelabel.frame.origin.y+retrievernamelabel.frame.size.height+5 ,self.view.frame.size.width-144, 35)];
    
    retrievernametextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Name" value:@"" table:nil] attributes:@{NSForegroundColorAttributeName: [Text_color_ Placeholder_Text_Color_code]}];
    retrievernametextfield.textColor=[Text_color_ Content_Text_Color_code];

       retrievernametextfield.font = [Font_Face_Controller opensansLight:16];
    retrievernametextfield.delegate=self;
    retrievernametextfield.backgroundColor = [UIColor whiteColor];
    UIView *paddingViewretriever = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    retrievernametextfield.leftView = paddingViewretriever;
    retrievernametextfield.leftViewMode = UITextFieldViewModeAlways;
    [backgroundBox addSubview:retrievernametextfield];
    
    //Contactdetails label text
    UILabel *Contactdetailslabel = [[UILabel alloc] initWithFrame:CGRectMake(10, retrievernametextfield.frame.origin.y+retrievernametextfield.frame.size.height+10 ,self.view.frame.size.width-144, 20)];
    Contactdetailslabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Contact details" value:@"" table:nil];
    Contactdetailslabel.textColor = [UIColor whiteColor];
    [Contactdetailslabel setFont:[Font_Face_Controller opensansLight:16]];
    Contactdetailslabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:Contactdetailslabel];
    
    // Contactdetails text field
    Contactdetailstextfield = [[UITextField alloc] initWithFrame:CGRectMake(10, Contactdetailslabel.frame.origin.y+Contactdetailslabel.frame.size.height+5 ,self.view.frame.size.width-144, 35)];
    
    Contactdetailstextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Phonenumber" value:@"" table:nil] attributes:@{NSForegroundColorAttributeName: [Text_color_ Placeholder_Text_Color_code]}];
    Contactdetailstextfield.textColor=[Text_color_ Content_Text_Color_code];

   
       Contactdetailstextfield.font = [Font_Face_Controller opensansLight:16];
    Contactdetailstextfield.delegate=self;
    Contactdetailstextfield.backgroundColor = [UIColor whiteColor];
    UIView *paddingViewcontactdetails = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    Contactdetailstextfield.leftView = paddingViewcontactdetails;
    Contactdetailstextfield.leftViewMode = UITextFieldViewModeAlways;
    [backgroundBox addSubview:Contactdetailstextfield];
    
    
    //Retriever Portrait label text
    UILabel *retrieverportraitlabel = [[UILabel alloc] initWithFrame:CGRectMake(retrievernamelabel.frame.origin.x+retrievernamelabel.frame.size.width+10, totextfield.frame.origin.y+totextfield.frame.size.height+10 ,114, 18)];
    retrieverportraitlabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Portrait:" value:@"" table:nil];
    retrieverportraitlabel.textColor = [UIColor whiteColor];
    [retrieverportraitlabel setFont:[Font_Face_Controller opensansLight:16]];
    retrieverportraitlabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:retrieverportraitlabel];
    
    
    //Retriever User Image box
    retrieveruserimage_background = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-124, retrieverportraitlabel.frame.origin.y+retrieverportraitlabel.frame.size.height+5 , 114, 114)];
    retrieveruserimage_background.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:121.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    retrieveruserimage_background.userInteractionEnabled=YES;
    
    backgroundBox.userInteractionEnabled=YES;
    
    [backgroundBox addSubview:retrieveruserimage_background];
    
    UITapGestureRecognizer * Edit_IMG_URL = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector( Edit_IMG_action:)];
    
    
    [retrieveruserimage_background addGestureRecognizer: Edit_IMG_URL];

    
    
    //set User profile Image button
    retrieverimageView = [[UIImageView alloc]init];
    [retrieverimageView setFrame:CGRectMake(14, 14 , 106, 106)];
   // retrieverimageView.backgroundColor=color;
    [backgroundBox addSubview:retrieverimageView];

    
//    //set retriever User profile Image button
//    retrieverimageView = [UIButton buttonWithType: UIButtonTypeCustom];
//    [retrieverimageView setFrame:CGRectMake(4, 4 , 106, 106)];
//    UIImage *retrieverUserpicImage;
//    
//    
//    [retrieverimageView setBackgroundImage:retrieverUserpicImage forState:UIControlStateNormal];
//    [retrieverimageView addTarget:self action:@selector(action_opengallery) forControlEvents:UIControlEventTouchUpInside];
//    [retrieveruserimage_background addSubview:retrieverimageView];
    
    //Note label text
    UILabel *notelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, Contactdetailstextfield.frame.origin.y+Contactdetailstextfield.frame.size.height+10 ,self.view.frame.size.width-20, 20)];
    notelabel.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Note:" value:@"" table:nil];
    notelabel.textColor = [UIColor whiteColor];
    [notelabel setFont:[Font_Face_Controller opensansLight:16]];
    notelabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:notelabel];
    
    // Note text field
    Notetextfield = [[UITextView alloc] init];
    Notetextfield.delegate = self;
//    if([[retrievernotedict valueForKey:@"status"]isEqualToString:@"true"]){
//        Notetextfield.text = [[retrievernotedict valueForKey:@"data"]valueForKey:@"description"];
//        Notetextfield.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0];
//    }else{
//        
//        
//        
//        
//        Notetextfield.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type extra details here" value:@"" table:nil];
//        Notetextfield.textColor = [UIColor colorWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:1.0];
//    }
    
    //    Notetextfield.frame=CGRectMake(10, notelabel.frame.origin.y+notelabel.frame.size.height+5 ,self.view.frame.size.width-20, 50);
    
    Notetextfield.frame=CGRectMake(10, notelabel.frame.origin.y+notelabel.frame.size.height+5 ,self.view.frame.size.width-20, (self.view.frame.size.height-120)-(notelabel.frame.origin.y+notelabel.frame.size.height));
        Notetextfield.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type extra details here" value:@"" table:nil];
       Notetextfield.textColor=[Text_color_ Content_Text_Color_code];
    
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

//    //Note label text
//    UILabel *notelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, Contactdetailstextfield.frame.origin.y+Contactdetailstextfield.frame.size.height+20 ,self.view.frame.size.width-20, 18)];
//    notelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Note:" value:@"" table:nil];
//    notelabel.textColor = [UIColor whiteColor];
//    [notelabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
//    notelabel.textAlignment=NSTextAlignmentLeft;
//    [backgroundBox addSubview:notelabel];
//    
//    // Note text field
//    Notetextfield = [[UITextView alloc] init];
//    Notetextfield.delegate = self;
//      Notetextfield.frame=CGRectMake(10, notelabel.frame.origin.y+notelabel.frame.size.height+5 ,self.view.frame.size.width-20, 140);
//    Notetextfield.font = [UIFont fontWithName:@"Helvetica" size:16];
//    Notetextfield.backgroundColor = [UIColor whiteColor];
//    [backgroundBox addSubview:Notetextfield];
    
    
    // Cancel Button
     CancelButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [CancelButton setFrame:CGRectMake(0, self.view.frame.size.height-50, (self.view.frame.size.width-10)/2, 50)];
    [CancelButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] value:@"" table:nil] forState: UIControlStateNormal];
    [CancelButton setBackgroundColor:[UIColor colorWithRed:249.0f/255.0f green:174.0f/255.0f blue:99.0f/255.0f alpha:1.0]];
    [CancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [CancelButton.titleLabel setFont:[Font_Face_Controller opensanssemibold:15]];
    [CancelButton addTarget:self action:@selector(action_Cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CancelButton];
    
    
    // Save Button
    SaveButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [SaveButton setFrame:CGRectMake(CancelButton.frame.origin.x+CancelButton.frame.size.width+10, self.view.frame.size.height-50, (self.view.frame.size.width-10)/2, 50)];
    [SaveButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Save" value:@"" table:nil] value:@"" table:nil] forState: UIControlStateNormal];
    [SaveButton setBackgroundColor:[UIColor colorWithRed:249.0f/255.0f green:174.0f/255.0f blue:99.0f/255.0f alpha:1.0]];
    [SaveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [SaveButton.titleLabel setFont:[Font_Face_Controller opensanssemibold:15]];
    [SaveButton addTarget:self action:@selector(action_Save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SaveButton];
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        
        
        [CancelButton setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:134.0f/255.0f blue:185.0f/255.0f alpha:1.0]];
        [SaveButton setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:134.0f/255.0f blue:185.0f/255.0f alpha:1.0]];
        retrieveruserimage_background.backgroundColor = [UIColor colorWithRed:234.0f/255.0f green:134.0f/255.0f blue:185.0f/255.0f alpha:1.0];

        
           backgroundBox.backgroundColor = [Text_color_ EDU_Blog_Color_code];
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_authentication_token"];        }
    else
    {
           backgroundBox.backgroundColor = [Text_color_ Retrieval_Color_code];
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"];
    }
    

    
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_retriver_note_API) withObject:nil afterDelay:0.5];

    
}

-(void)doneButtonClicked
{
    if ([Notetextfield.text isEqualToString:@""]) {
        Notetextfield.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type extra details here" value:@"" table:nil];
        Notetextfield.textColor = [Text_color_ Placeholder_Text_Color_code];
    }
    [Notetextfield resignFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"elev"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"student"])
     {
         SaveButton.hidden = YES;
         CancelButton.hidden = YES;
         for (int i = 0; i < [[self.view subviews] count]; i++)
         {
             UIView* view = [[self.view subviews] objectAtIndex: i];
             
             if ([view isKindOfClass:[UIBarButtonItem class]]) {
                 //
             }
             else
             {
                 view.userInteractionEnabled = NO;
             }
             // now either check the tag property of view or however else you know
             // it's the one you want, and then change the userInteractionEnabled property.
         }
     }

}
- (void) Edit_IMG_action: (UITapGestureRecognizer *)recognizer
{
    
    
    
    
    actionSheets = [[UIActionSheet alloc]
                    initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select your Option" value:@"" table:nil]
                    delegate:self
                    cancelButtonTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil]
                    destructiveButtonTitle:nil
                    otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Camera" value:@"" table:nil], [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Photos" value:@"" table:nil],nil];
    actionSheets.tag=202;
    [actionSheets showInView:self.view];
    
    
}    

#pragma mark - -*********************
#pragma mark ActionSheet clickedButton Method
#pragma mark - -*********************

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing=YES;
    if (buttonIndex==0)
    {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes=[NSArray arrayWithObjects:(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage, nil];;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
        else
        {
            
            
            
            UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Message!!" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Camera is not available , Please choose Picture from Library" value:@"" table:nil] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            [alert show];
            
        }
        
    }
    else if (buttonIndex==1)
    {
        
        
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.mediaTypes=[NSArray arrayWithObjects:(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage, nil];
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
    
    
}


#pragma mark - -*********************
#pragma mark Call get_drafts_API Method
#pragma mark - -*********************


-(void)CallTheServer_get_retriver_note_API
{
    if ([API connectedToInternet]==YES) {
        
            //------------ Call API for signup With Post Method --------------//
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [dateFormatter dateFromString: [[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
        
        NSString *responseString;
         if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"elev"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"student"])
         {
         responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&date=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],date_correct_format]:[NSString stringWithFormat:@"%@retrivals/get_retriver_note",[Utilities API_link_url_subDomain]]];
         }
        else
        {
            responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&date=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],date_correct_format]:[NSString stringWithFormat:@"%@retrivals/get_retriver_note",[Utilities API_link_url_subDomain]]];

        }
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        
        
        retrievernotedict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];

        NSLog(@"%@",retrievernotedict);
        if ([[retrievernotedict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Edit retrieval note" value:@"" table:nil];

            
            
            [retrieveruserimage_background sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[retrievernotedict valueForKey:@"Retriever"] valueForKey:@"retriever_image"]]]
                        placeholderImage:[UIImage imageNamed:@"profile9.png"]];
            
            
            if([[retrievernotedict valueForKey:@"status"]isEqualToString:@"true"]){
                Contactdetailstextfield.text = [[[[retrievernotedict valueForKey:@"data"] valueForKey:@"Retriever"]valueForKey:@"contact_number"]stringByConvertingHTMLToPlainText];
            }
            if([[retrievernotedict valueForKey:@"status"]isEqualToString:@"true"]){
//                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"domain"], [[[retrievernotedict valueForKey:@"data"] valueForKey:@"Retriever"]valueForKey:@"retriever_image"]]];
                //NSData *data = [[NSData alloc] initWithContentsOfURL:url];
               // retrieverUserpicImage = [UIImage imageWithData:data];
            }else{
               // retrieverUserpicImage = [UIImage imageNamed:@"user.png"];
            }
            if([[retrievernotedict valueForKey:@"status"]isEqualToString:@"true"]){
                
                Notetextfield.text = [[[[retrievernotedict valueForKey:@"data"] valueForKey:@"Retriever"]valueForKey:@"description"]stringByConvertingHTMLToPlainText];
                Notetextfield.textColor = [Text_color_ Content_Text_Color_code];
            }else{
                Notetextfield.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type extra details here" value:@"" table:nil];
                Notetextfield.textColor = [Text_color_ Placeholder_Text_Color_code];
            }
            
            
            
            
            
            if(![[[[retrievernotedict valueForKey:@"data"] valueForKey:@"Retriever"]valueForKey:@"description"]isEqualToString:@""]){
                
            Notetextfield.textColor = [Text_color_ Content_Text_Color_code];
            }else{
               
                Notetextfield.textColor = [Text_color_ Placeholder_Text_Color_code];
            }


            
            if([[retrievernotedict valueForKey:@"status"]isEqualToString:@"true"]){
                datetextfield.text = [[[retrievernotedict valueForKey:@"data"] valueForKey:@"Retriever"]valueForKey:@"created"];
            }else{
                datetextfield.text = date_correct_format;
            }
            
            
            if([[retrievernotedict valueForKey:@"status"]isEqualToString:@"true"]){
                retrievernametextfield.text = [[[[retrievernotedict valueForKey:@"data"] valueForKey:@"Retriever"]valueForKey:@"retriever_name"]stringByConvertingHTMLToPlainText];
            }
            
            
            
             totextfield.text=[[[[retrievernotedict valueForKey:@"data"]valueForKey:@"Retriever"]valueForKey:@"created"]stringByConvertingHTMLToPlainText];
            
        }
        
        else
        {

            self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retrieval note" value:@"" table:nil];

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
-(void) action_opengallery
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentModalViewController:imagePickerController animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    // Dismiss the image selection, hide the picker and
    
    //show the image view with the picked image
    
      UIImage *newImage = image;
   
    
    
    retrieveruserimage_background.image=image;
    
    //Reconvert UIImage to NSData
    NSData *imageData = UIImageJPEGRepresentation(newImage, 1.0);
    
    //And then apply Base64 encoding to convert it into a base-64 encoded string:
    NSString *encodedString = [self base64forData:imageData];
    
    Portraitimg = encodedString;
    [picker dismissModalViewControllerAnimated:YES];

}


- (NSString*)base64forData:(NSData*)theData {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
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

-(void)action_Cancel{
    [self.navigationController popViewControllerAnimated:YES];

    
}

-(void)action_Save
{
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_retriver_note_Update_API) withObject:nil afterDelay:0.5];
}






#pragma mark - -*********************
#pragma mark Call get_drafts_API Method
#pragma mark - -*********************


-(void)CallTheServer_get_retriver_note_Update_API
{
    if ([API connectedToInternet]==YES) {
        
        NSData* topImageData = UIImageJPEGRepresentation(retrieveruserimage_background.image, 0.6);
        
        
        NSString *base64_STR=  [topImageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        if([base64_STR isEqualToString:@""])
        {
            base64_STR=@"";
        }

        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [dateFormatter dateFromString: [[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
        [dic setValue:Token_value forKey:@"authentication_token"];
        [dic setValue:totextfield.text forKey:@"to_date"];
        [dic setValue:datetextfield.text forKey:@"from_date"];
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"] forKey:@"student_id"];
        [dic setValue:retrievernametextfield.text forKey:@"retriver_name"];
        [dic setValue:Contactdetailstextfield.text forKey:@"contact_number"];
        [dic setValue:Notetextfield.text forKey:@"note"];
        [dic setValue:base64_STR forKey:@"image"];
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
        
        NSLog(@"%@",dic);
        
        
        NSString *responseString = [API makeCallPostData_ALLs:dic:[NSString stringWithFormat:@"%@retrivals/update_retriver_note",[Utilities API_link_url_subDomain]]];
        
        
        NSLog(@"%@",responseString);
        
        NSDictionary *responseDict = [responseString JSONValue];
        retrievernotedict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        if ([[retrievernotedict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }else if([[retrievernotedict valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
                        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[retrievernotedict valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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







-(BOOL)validateInput{
    
    BOOL retvalue=YES;
    NSString *throwmessage;
    
    if ([datetextfield.text isEqualToString:@""] || datetextfield.text==nil )
        
    {
        throwmessage=@"Please select a start date";
        retvalue=NO;
    }
//    else if ([totextfield.text isEqualToString:@""] || totextfield.text==nil )
//        
//    {
//        throwmessage=@"Please select a to date";
//        retvalue=NO;
//    }
    else if ([retrievernametextfield.text isEqualToString:@""] || retrievernametextfield.text==nil )
        
    {
        throwmessage=@"Please enter the retriever name";
        retvalue=NO;
    }
    else if ([Contactdetailstextfield.text isEqualToString:@""] || Contactdetailstextfield.text==nil )
        
    {
        throwmessage=@"Please enter the retriever contact number";
        retvalue=NO;
    }
    else if ([Portraitimg isEqualToString:@""] || Portraitimg==nil )
        
    {
        throwmessage=@"Please select a portrait image";
        retvalue=NO;
    }
    else if ([Notetextfield.text isEqualToString:@""] || Notetextfield.text==nil || [Notetextfield.text isEqualToString:@"Type extra details here"] || [Notetextfield.text isEqualToString:@"Skriv beskrivning här"])
        
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

//-(IBAction)action_Save{0
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


//- (void)action_SaveProcess
//{
//    NSMutableURLRequest *urlRequest;
////    if([retrieverid isEqualToString:@""]){
////        urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://ps.pnf-sites.info/lms_api/retrivals/retriver_note"]];
////    }else{
//        urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://ps.pnf-sites.info/lms_api/retrivals/update_retriver_note"]];
////    }
//    
//    [dict setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
//    [dict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication_token"] forKey:@"authentication_token"];
//    [dict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"language"] forKey:@"language"];
//    [dict setValue:datetextfield.text forKey:@"from_date"];
//    [dict setValue:totextfield.text forKey:@"to_date"];
//    [dict setValue:retrievernametextfield.text forKey:@"retriver_name"];
//    [dict setValue:Contactdetailstextfield.text forKey:@"contact_number"];
//    [dict setValue:Notetextfield.text forKey:@"note"];
//    [dict setValue:Portraitimg forKey:@"image"];
//    [dict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"student_id"] forKey:@"student_id"];
//    
//    
//    [urlRequest setTimeoutInterval:180];
//    NSString *requestBody = [NSString stringWithFormat:@"jsonData=%@", [dict JSONRepresentation]];
//    [urlRequest setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
//    [urlRequest setHTTPMethod:@"POST"];
//    NSURLResponse *response; NSError *error;
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error] ;
//    
//    
//    NSString *data;
//    if([responseData length]) {
//        data = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//        
//        NSDictionary *responseDict5 = [data JSONValue];
//        NSMutableDictionary *dict5 = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict5];
//        
//        //NSLog(@"%@",dict);
//        
//        
//        if([[dict5 valueForKey:@"status"]isEqualToString:@"true"])
//        {
//            datetextfield.text = @"";
//            totextfield.text = @"";
//            retrievernametextfield.text = @"";
//            Contactdetailstextfield.text = @"";
//            Notetextfield.text = @"Note description";
//            Portraitimg = @"";
//            
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:nil
//                                          message:[dict valueForKey:@"message"]
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            [self presentViewController:alert animated:YES completion:nil];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:@"OK"
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     //Do some thing here
//                                     [self dismissViewControllerAnimated:YES completion:nil];
//                                     profile *profileobj = [[profile alloc]init];
//                                     [self.navigationController pushViewController:profileobj animated:YES];
//                                 }];
//            [alert addAction:ok]; // add action to uialertcontroller
//            
//        }
//        else{
//            
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:nil
//                                          message:[dict valueForKey:@"message"]
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            [self presentViewController:alert animated:YES completion:nil];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:@"OK"
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     //Do some thing here
//                                     [self dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                 }];
//            [alert addAction:ok]; // add action to uialertcontroller
//            
//        }
//    }else{
//        UIAlertController * alert=   [UIAlertController
//                                      alertControllerWithTitle:nil
//                                      message:@"Server not responding! Please try again."
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
//    }
//    
//    
//    
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
        Notetextfield.textColor=[Text_color_ Placeholder_Text_Color_code];
        ;
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
