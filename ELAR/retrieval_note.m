//
//  retrieval_note.m
//  SCM
//
//  Created by pnf on 12/20/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//

#import "retrieval_note.h"
#import "AppDelegate.h"
#import "JSON.h"
#import "Utilities.h"
#import "Font_Face_Controller.h"
#import "UIImageView+WebCache.h"
#import "Text_color_.h"
#import "API.h"
#import "NSString+HTML.h"
#import "UIImageView+WebCache.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "ELR_loaders_.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"

@interface retrieval_note ()

@end

@implementation retrieval_note
@synthesize datepicker;
@synthesize color;
@synthesize date_value;


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
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retrieval note" value:@"" table:nil];
    
    
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
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        
        
        
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_authentication_token"];        }
    else
    {
        
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"];
    }

    
    
    // Do any additional setup after loading the view.
    [self Navigation_bar];

    
    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%d",0] forKey:@"index"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
   // self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //-------Calendar selection tab start------------
    
    UIView *previousdayBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 50, 50)];
    previousdayBox.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:232.0f/255.0f blue:232.0f/255.0f alpha:1.0];
    [self.view addSubview:previousdayBox];
    //set previous day button image
    UIButton *previousdayBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [previousdayBtn setFrame:CGRectMake((previousdayBox.frame.size.width-40)/2, (previousdayBox.frame.size.height-40)/2 , 40, 40)];
    [previousdayBtn setTitle:nil forState: UIControlStateNormal];
    UIImage *previousdayImage = [UIImage imageNamed:@"previous_day.png"];
    [previousdayBtn setImage:previousdayImage forState:UIControlStateNormal];
    [previousdayBtn addTarget:self action:@selector(dateChangedPrevious) forControlEvents:UIControlEventTouchUpInside];
    [previousdayBox addSubview:previousdayBtn];
    
    UIView *CalenderSelectionBox  = [[UIView alloc] initWithFrame:CGRectMake(previousdayBox.frame.origin.x+previousdayBox.frame.size.width, 64, self.view.frame.size.width-100, 50)];
    CalenderSelectionBox.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:232.0f/255.0f blue:232.0f/255.0f alpha:1.0];
    
    //set left right border to calendar selection box
    CGSize mainViewSize = CalenderSelectionBox.bounds.size;
    CGFloat borderWidth = 1;
    UIColor *borderColor = [UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1.0];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, borderWidth, mainViewSize.height)];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(mainViewSize.width - borderWidth, 0, borderWidth, mainViewSize.height)];
    leftView.opaque = YES;
    rightView.opaque = YES;
    leftView.backgroundColor = borderColor;
    rightView.backgroundColor = borderColor;
    leftView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    rightView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    [CalenderSelectionBox addSubview:leftView];
    [CalenderSelectionBox addSubview:rightView];
    
    [self.view addSubview:CalenderSelectionBox];
    
    //add Date label button
    selected_date_btn = [UIButton buttonWithType: UIButtonTypeCustom];
    [selected_date_btn setFrame:CGRectMake((CalenderSelectionBox.frame.size.width-110)/2, (CalenderSelectionBox.frame.size.height-18)/2, 110, 18)];
    [selected_date_btn setTitle:date_value forState: UIControlStateNormal];
    [selected_date_btn setTitleColor:[UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    [selected_date_btn.titleLabel setFont:[Font_Face_Controller opensansLight:18]];
    //to set action on click of SHOWS button
    [selected_date_btn addTarget:self action:@selector(createDateFormatter) forControlEvents:UIControlEventTouchUpInside];
    [CalenderSelectionBox addSubview:selected_date_btn];
    
    
    UIView *nextdayBox  = [[UIView alloc] initWithFrame:CGRectMake(CalenderSelectionBox.frame.origin.x+CalenderSelectionBox.frame.size.width, 64, 50, 50)];
    nextdayBox.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:232.0f/255.0f blue:232.0f/255.0f alpha:1.0];
    [self.view addSubview:nextdayBox];
    //set next day button image
    UIButton *nextdayBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [nextdayBtn setFrame:CGRectMake((nextdayBox.frame.size.width-40)/2, (nextdayBox.frame.size.height-40)/2 , 40, 40)];
    [nextdayBtn setTitle:nil forState: UIControlStateNormal];
    UIImage *nextdayImage = [UIImage imageNamed:@"next_day.png"];
    [nextdayBtn setImage:nextdayImage forState:UIControlStateNormal];
    [nextdayBtn addTarget:self action:@selector(dateChangedNext) forControlEvents:UIControlEventTouchUpInside];
    [nextdayBox addSubview:nextdayBtn];
    
    
    
    
    
    
   
        
    //----------User details box start------------//
     result = [[UIScreen mainScreen] bounds].size;
    //background
 backgroundBox  = [[UIView alloc] initWithFrame:CGRectMake(0, CalenderSelectionBox.frame.origin.y+CalenderSelectionBox.frame.size.height, self.view.frame.size.width, 1000)];
    backgroundBox.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    [self.view addSubview:backgroundBox];
    
    //Userdetails box
    UIView *userdetailsBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    userdetailsBox.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
    [backgroundBox addSubview:userdetailsBox];
    
   userimage_background = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 , 100, 100)];
    userimage_background.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:121.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    [backgroundBox addSubview:userimage_background];
    
    //set User profile Image button
    imageView = [[UIImageView alloc]init];
    [imageView setFrame:CGRectMake(14, 14 , 92, 92)];
    imageView.backgroundColor=color;
    [backgroundBox addSubview:imageView];
    
    //add user name text
    usernamelabel = [[UILabel alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+10, 10 ,self.view.frame.size.width-115, 25)];
   
    usernamelabel.textColor = [UIColor whiteColor];
    [usernamelabel setFont:[Font_Face_Controller opensanssemibold:20]];
    usernamelabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:usernamelabel];
    
    //add guardians text
   guardianslabel = [[UILabel alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+10, 39 ,150, 20)];
    guardianslabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Guardians" value:@"" table:nil];
    
    guardianslabel.textColor = [UIColor whiteColor];
    [guardianslabel setFont:[Font_Face_Controller opensansLight:16]];
    guardianslabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:guardianslabel];
    
       //-------------User details box end-----------------//
    
    
    
    //--------------retrievalnote details box start--------//
    
    fullpagescrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  227, self.view.frame.size.width, self.view.frame.size.height-164)];    fullpagescrollview.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    fullpagescrollview.delegate = self;
    [self.view addSubview:fullpagescrollview];
    //retrievalnote box background view
   retrievalnotedetailsBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 100)];
    retrievalnotedetailsBox.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
    [fullpagescrollview addSubview:retrievalnotedetailsBox];
    
    //retrievalnote text Label
    retrievalnotelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 ,170, 25)];
    
    
    
    retrievalnotelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retriever note" value:@"" table:nil];
    
    retrievalnotelabel.textColor = [UIColor whiteColor];
    [retrievalnotelabel setFont:[Font_Face_Controller opensanssemibold:16]];
    retrievalnotelabel.textAlignment=NSTextAlignmentLeft;
    [retrievalnotedetailsBox addSubview:retrievalnotelabel];
    
    
    //retrievalname text Label
    retrievalnamelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, retrievalnotelabel.frame.origin.y+retrievalnotelabel.frame.size.height+15 ,100, 20)];
    
    
    retrievalnamelabel.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retriever" value:@"" table:nil];
    retrievalnamelabel.textColor = [UIColor whiteColor];
    [retrievalnamelabel setFont:[Font_Face_Controller opensanssemibold:16]];
    retrievalnamelabel.textAlignment=NSTextAlignmentLeft;
    [retrievalnotedetailsBox addSubview:retrievalnamelabel];
    
    
    //retrievalnamevalue text Label
    retrievalnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(10, retrievalnamelabel.frame.origin.y+retrievalnamelabel.frame.size.height+5 ,150, 20)];
   
    retrievalnamevalue.textColor = [UIColor whiteColor];
    retrievalnamevalue.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
    [retrievalnamevalue setFont:[Font_Face_Controller opensansLight:16]];
    retrievalnamevalue.textAlignment=NSTextAlignmentLeft;
    [retrievalnotedetailsBox addSubview:retrievalnamevalue];
    
    
    //contactdetails text Label
    contactdetailslabel = [[UILabel alloc] initWithFrame:CGRectMake(10, retrievalnamevalue.frame.origin.y+retrievalnamevalue.frame.size.height+10 ,150, 20)];
    
    contactdetailslabel.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Contact details" value:@"" table:nil];
    contactdetailslabel.textColor = [UIColor whiteColor];
    [contactdetailslabel setFont:[Font_Face_Controller opensanssemibold:16]];
    contactdetailslabel.textAlignment=NSTextAlignmentLeft;
    [retrievalnotedetailsBox addSubview:contactdetailslabel];
    
    
    //contactdetailsvalue text Label
    contactdetailsvalue = [[UILabel alloc] initWithFrame:CGRectMake(10, contactdetailslabel.frame.origin.y+contactdetailslabel.frame.size.height+5 ,150, 20)];
       contactdetailsvalue.textColor = [UIColor whiteColor];
     contactdetailsvalue.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
    [contactdetailsvalue setFont:[Font_Face_Controller opensansLight:16]];
    contactdetailsvalue.textAlignment=NSTextAlignmentLeft;
    [retrievalnotedetailsBox addSubview:contactdetailsvalue];
    
    //Retriever User Image box
   retrieveruserimage_background = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-110, 10 , 100, 100)];
    retrieveruserimage_background.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:121.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    [retrievalnotedetailsBox addSubview:retrieveruserimage_background];
    
    //set retriever User profile Image button
    retrieverimageView = [[UIImageView alloc]init];
    [retrieverimageView setFrame:CGRectMake(self.view.frame.size.width-106, 14 , 92, 92)];
   retrieverimageView.backgroundColor=color;
    [retrievalnotedetailsBox addSubview:retrieverimageView];
    
    
    
    //descriptionheading text Label
  descriptionheading = [[UILabel alloc] initWithFrame:CGRectMake(10, contactdetailsvalue.frame.origin.y+contactdetailsvalue.frame.size.height+10 ,100, 20)];
    
    descriptionheading.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
    descriptionheading.textColor = [UIColor whiteColor];
    [descriptionheading setFont:[Font_Face_Controller opensanssemibold:16]];
    descriptionheading.textAlignment=NSTextAlignmentLeft;
    [retrievalnotedetailsBox addSubview:descriptionheading];
    
    //writtenby text Label
    writtenbylabel = [[UILabel alloc] initWithFrame:CGRectMake(10, descriptionheading.frame.origin.y+descriptionheading.frame.size.height+5 ,[[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Written by:" value:@"" table:nil] sizeWithFont:[Font_Face_Controller opensansLight:16]].width, 20)];
    
    writtenbylabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Written by:" value:@"" table:nil];
    
    writtenbylabel.textColor = [UIColor whiteColor];
    [writtenbylabel setFont:[Font_Face_Controller opensansLight:16]];
    writtenbylabel.textAlignment=NSTextAlignmentLeft;
    writtenbylabel.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
    [retrievalnotedetailsBox addSubview:writtenbylabel];
    
    
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    [retrieverimageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    

    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_retriver_note_API) withObject:nil afterDelay:0.5];
    
}


- (void)createDateFormatter {
    
    datepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 200)];
    datepicker.backgroundColor = [UIColor whiteColor];
    datepicker.datePickerMode = UIDatePickerModeDate;
    [datepicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datepicker];
    
}


- (void) dateChanged:(id)sender{
    // handle date changes
    UIDatePicker *picker = (UIDatePicker *)sender;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    date_value = [dateFormatter stringFromDate:[picker date]];
    
    
       [selected_date_btn setTitle:date_value forState: UIControlStateNormal];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_retriver_note_API) withObject:nil afterDelay:0.5];

}

- (void) dateChangedNext{
    // handle next date changes
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date_to_be_incremented = [dateFormatter dateFromString:date_value];
    
    int daysToAdd = 1;
    NSDate *updated_date = [date_to_be_incremented dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    date_value = [dateFormatter stringFromDate:updated_date];
    
    [selected_date_btn setTitle:date_value forState: UIControlStateNormal];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_retriver_note_API) withObject:nil afterDelay:0.5];

}
- (void) dateChangedPrevious{
    // handle previous date changes
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date_to_be_incremented = [dateFormatter dateFromString:date_value];
    
    int daysToAdd = -1;
    NSDate *updated_date = [date_to_be_incremented dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    date_value= [dateFormatter stringFromDate:updated_date];
   
    [selected_date_btn setTitle:date_value forState: UIControlStateNormal];
    
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_retriver_note_API) withObject:nil afterDelay:0.5];

    
   
}



-(void)datePickerView
{
    [datepicker removeFromSuperview];
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
#pragma mark Call get_retriver_note Method
#pragma mark - -*********************


-(void)CallTheServer_get_retriver_note_API
{
    if ([API connectedToInternet]==YES) {
        
        
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [dateFormatter dateFromString: date_value];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_correct_format = [dateFormatter stringFromDate:date];
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&date=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],date_correct_format]:[NSString stringWithFormat:@"%@retrivals/get_retriver_note",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [Utilities API_link_url_IMG], [[[dict valueForKey:@"data"]valueForKey:@"student"]valueForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
            
            
              usernamelabel.text = [[[dict valueForKey:@"data"]valueForKey:@"student"]valueForKey:@"student_name"];
            
            for (int a=0; a<([[[dict valueForKey:@"data"]valueForKey:@"parents"] count]); a++) {
                
                if(a==2){
                    break;
                }
                UIView *guardiandetailsBox;
                if(a==0){
                    //guardian1 details box
                    guardiandetailsBox  = [[UIView alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+10, 61, self.view.frame.size.width-130, 22)];
                }else{
                    guardiandetailsBox  = [[UIView alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+10, 88, self.view.frame.size.width-130, 22)];
                }
                guardiandetailsBox.backgroundColor = [UIColor colorWithRed:216.0f/255.0f green:121.0f/255.0f blue:26.0f/255.0f alpha:1.0];
                [backgroundBox addSubview:guardiandetailsBox];
                
                UILabel *guardiannamelabel;
                if(a==0){
                    //add guardian1 text
                    guardiannamelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 1 ,130, 20)];
                }else{
                    guardiannamelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 1 ,130, 20)];
                }
                guardiannamelabel.text = [NSString stringWithFormat:@"%@ %@",[[[[dict valueForKey:@"data"]valueForKey:@"parents"][a] valueForKey:@"USR_FirstName"]stringByConvertingHTMLToPlainText],[[[[dict valueForKey:@"data"]valueForKey:@"parents"][a] valueForKey:@"USR_LastName"]stringByConvertingHTMLToPlainText]];
                guardiannamelabel.textColor = [UIColor whiteColor];
                if(result.width<=320){
                    [guardiannamelabel setFont:[Font_Face_Controller opensansLight:12]];
                }else{
                    [guardiannamelabel setFont:[Font_Face_Controller opensansLight:16]];
                }
                guardiannamelabel.textAlignment=NSTextAlignmentLeft;
                [guardiandetailsBox addSubview:guardiannamelabel];
                
                UILabel *guardianphonelabel;
                if(a==0){
                    //add guardian1 phone text
                    guardianphonelabel = [[UILabel alloc] initWithFrame:CGRectMake(guardiandetailsBox.frame.size.width-115, 1 ,110, 20)];
                }else{
                    guardianphonelabel = [[UILabel alloc] initWithFrame:CGRectMake(guardiandetailsBox.frame.size.width-115, 1 ,110, 20)];
                }
                
                if (![[[[dict valueForKey:@"data"]valueForKey:@"parents"][a] valueForKey:@"contact_number"] isKindOfClass:[NSNull class]] && [[[dict valueForKey:@"data"]valueForKey:@"parents"][a] valueForKey:@"contact_number"] && [[[dict valueForKey:@"data"]valueForKey:@"parents"][a] valueForKey:@"contact_number"] != NULL)
                
               {
                    
                       guardianphonelabel.text = [[[[dict valueForKey:@"data"]valueForKey:@"parents"][a] valueForKey:@"contact_number"]stringByConvertingHTMLToPlainText];
                }
                
             
                guardianphonelabel.textColor = [UIColor whiteColor];
                if(result.width<=320){
                    [guardianphonelabel setFont:[Font_Face_Controller opensansLight:12]];
                }else{
                    [guardianphonelabel setFont:[Font_Face_Controller opensansLight:16]];
                }
                guardianphonelabel.textAlignment=NSTextAlignmentRight;
                [guardiandetailsBox addSubview:guardianphonelabel];
            }
            
            
            if (![[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"retriever_name"] && [[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"retriever_name"] && [[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"retriever_name"] != NULL)
                
            {

            
            
            retrievalnamevalue.text = [[[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"retriever_name"]stringByConvertingHTMLToPlainText];
            }
            
            
            if (![[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"contact_number"] && [[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"contact_number"] && [[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"contact_number"] != NULL)
                
            {

            
            contactdetailsvalue.text = [[[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"contact_number"]stringByConvertingHTMLToPlainText];
            }

            
         [retrieverimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [Utilities API_link_url_IMG], [[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"retriever_image"]]] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
            
            //writtenbyvalue text  Label
            writtenbyvaluelabel = [[UILabel alloc] initWithFrame:CGRectMake(writtenbylabel.frame.origin.x+writtenbylabel.frame.size.width+5, descriptionheading.frame.origin.y+descriptionheading.frame.size.height+5  ,[[[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"written_by"] sizeWithFont:[Font_Face_Controller opensansLight:16]].width, 20)];
            writtenbyvaluelabel.text = [[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"written_by"];
            writtenbyvaluelabel.textColor = [UIColor whiteColor];
            [writtenbyvaluelabel setFont:[Font_Face_Controller opensansLight:16]];
            writtenbyvaluelabel.textAlignment=NSTextAlignmentLeft;
            writtenbyvaluelabel.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
            [retrievalnotedetailsBox addSubview:writtenbyvaluelabel];
            
            //writtenbydate text  Label
            writtenbydatelabel = [[UILabel alloc] initWithFrame:CGRectMake(writtenbyvaluelabel.frame.origin.x+writtenbyvaluelabel.frame.size.width+5, descriptionheading.frame.origin.y+descriptionheading.frame.size.height+5  ,[[[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"created"] sizeWithFont:[Font_Face_Controller opensansLight:16]].width, 20)];
            writtenbydatelabel.text = [[[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"created"]stringByConvertingHTMLToPlainText];
            writtenbydatelabel.textColor = [UIColor whiteColor];
            [writtenbydatelabel setFont:[Font_Face_Controller opensansLight:16]];
            writtenbydatelabel.textAlignment=NSTextAlignmentLeft;
              writtenbydatelabel.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
            [retrievalnotedetailsBox addSubview:writtenbydatelabel];
            
            //retrievalnotedescription text Label
            NSString *descriptionretrievalnote = [[[[dict valueForKey:@"data"]valueForKey:@"Retriever"] valueForKey:@"description"]stringByConvertingHTMLToPlainText];
            retrievalnotedescriptionlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, writtenbylabel.frame.origin.y+writtenbylabel.frame.size.height+5 ,self.view.frame.size.width-20, 20)];
            retrievalnotedescriptionlabel.numberOfLines = 0;
            retrievalnotedescriptionlabel.text = descriptionretrievalnote;
            retrievalnotedescriptionlabel.textColor = [UIColor whiteColor];
            [retrievalnotedescriptionlabel setFont:[Font_Face_Controller opensansLight:16]];
            [retrievalnotedescriptionlabel sizeToFit];
            retrievalnotedescriptionlabel.textAlignment=NSTextAlignmentLeft;
             writtenbydatelabel.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
            [retrievalnotedetailsBox addSubview:retrievalnotedescriptionlabel];
            //set retrievalnote background view height dynamically as per the text added in description
            retrievalnotedetailsBox.frame=CGRectMake(0, 10, self.view.frame.size.width, ( retrievalnotedescriptionlabel.frame.origin.y+retrievalnotedescriptionlabel.frame.size.height)+10);
            fullpagescrollview.contentSize = CGSizeMake(self.view.frame.size.width, retrievalnotedescriptionlabel.frame.origin.y+retrievalnotedescriptionlabel.frame.size.height+80);
            

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


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [datepicker removeFromSuperview];
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [datepicker removeFromSuperview];
    [textField resignFirstResponder];
}

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
