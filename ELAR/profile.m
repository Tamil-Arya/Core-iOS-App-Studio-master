//
//  profile.m
//  SCM
//
//  Created by pnf on 12/24/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//

#import "profile.h"
#import "AppDelegate.h"


#import "add_absent_note.h"
#import "add_retriever_note.h"

#import "UIImageView+WebCache.h"
#import "Utilities.h"
#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "API.h"
#import "JSON.h"
#import "NSString+HTML.h"
#import "UIImageView+WebCache.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "ELR_loaders_.h"
#import "Note_history.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"
@interface profile ()

@end

@implementation profile
@synthesize date_value;
@synthesize color;
@synthesize Dropoff_str;
@synthesize Retrieval_str;



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
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Profile" value:@"" table:nil];
    
    
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
    // Do any additional setup after loading the view.
    
    
    
    datepicker=[[UIDatePicker alloc]init];
    datepicker.datePickerMode=UIDatePickerModeTime;
      
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    
    
    
    
    UIBarButtonItem *Cancel=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedCancel)];
    
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:Cancel,space,doneBtn, nil]];
    

    
    
    
        isShown = true;
    isRetrievalShown = true;
    [self Navigation_bar];

    
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
    [selected_date_btn addTarget:self action:@selector(action_OpenMyaccount) forControlEvents:UIControlEventTouchUpInside];
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
    
    
    
    
    //background
 backgroundBox  = [[UIView alloc] initWithFrame:CGRectMake(0, CalenderSelectionBox.frame.origin.y+CalenderSelectionBox.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-(CalenderSelectionBox.frame.origin.y+CalenderSelectionBox.frame.size.height))];
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
    usernamelabel.numberOfLines=0;
    usernamelabel.textColor = [UIColor whiteColor];
    [usernamelabel setFont:[Font_Face_Controller opensanssemibold:15]];
    usernamelabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:usernamelabel];
    
    
    // user name button
    
    
    //add guardians text
  guardianslabel = [[UILabel alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+10, 39 ,150, 20)];
    guardianslabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Guardians" value:@"" table:nil];
    guardianslabel.textColor = [UIColor whiteColor];
    [guardianslabel setFont:[Font_Face_Controller opensansLight:16]];
    guardianslabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:guardianslabel];
    
    
       //-------------User details box end-----------------//
    
    //-----------Additional info/description/allergies box start-----//
    fullpagescrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  227, self.view.frame.size.width, self.view.frame.size.height-164)];
    fullpagescrollview.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    fullpagescrollview.delegate = self;
    fullpagescrollview.userInteractionEnabled=YES;
    [self.view addSubview:fullpagescrollview];
    
    
    
    
    
    
////////////////////////   additionalinformationbox Information //////////////////////
    
    
    
    //additionalinformation box uiview
   additionalinformationbox = [[UIView alloc] initWithFrame:CGRectMake(0, 15 ,self.view.frame.size.width, 50)];
   // additionalinformationbox.backgroundColor = [UIColor grayColor];
    [fullpagescrollview addSubview:additionalinformationbox];
    
    //additionalinformation text Label
    UILabel *additionalinformationheading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0 ,180, 20)];
    additionalinformationheading.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Other information" value:@"" table:nil];
    additionalinformationheading.textColor = [UIColor whiteColor];
    [additionalinformationheading setFont:[Font_Face_Controller opensanssemibold:15]];
    additionalinformationheading.textAlignment=NSTextAlignmentLeft;
    [additionalinformationbox addSubview:additionalinformationheading];
    
    //set additional info editImage button
   additionalinfoeditBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [additionalinfoeditBtn setFrame:CGRectMake(additionalinformationheading.frame.origin.x+additionalinformationheading.frame.size.width+10, 0 , 15, 15)];
    [additionalinfoeditBtn setTitle:nil forState: UIControlStateNormal];
    additionalinfoeditBtn.tag=111;
    
    
    UIImage *additionalinfoeditbtnImage = [UIImage imageNamed:@"edit1.png"];
    [additionalinfoeditBtn setImage:additionalinfoeditbtnImage forState:UIControlStateNormal];
    [additionalinfoeditBtn addTarget:self action:@selector(action_OpenUserProfileView:) forControlEvents:UIControlEventTouchUpInside];
    [additionalinformationbox addSubview:additionalinfoeditBtn];
    
    
    //dditionalinformation details text Label
     additionalinformationdetails = [[UILabel alloc] initWithFrame:CGRectMake(10, additionalinformationheading.frame.origin.y+additionalinformationheading.frame.size.height+5 ,self.view.frame.size.width-20, 19)];
  //  additionalinformationdetails.numberOfLines = 0;
    
    additionalinformationdetails.textColor = [UIColor whiteColor];
    [additionalinformationdetails setFont:[Font_Face_Controller opensansLight:15]];
   // [additionalinformationdetails sizeToFit];
    additionalinformationdetails.textAlignment=NSTextAlignmentLeft;
    [additionalinformationbox addSubview:additionalinformationdetails];
    
   // additionalinformationdetails.backgroundColor=[UIColor whiteColor];
    
    //set additionalinformationbox background view height dynamically as per the text added in description
 //additionalinformationbox.frame=CGRectMake(0, 0, self.view.frame.size.width, 37+additionalinformationdetails.frame.size.height);
    
    
    
    
    
    //////////////////////// Contact Information //////////////////////
    
    
    
    
    //description box uiview
    descriptionbox = [[UIView alloc] initWithFrame:CGRectMake(0, additionalinformationbox.frame.origin.y+additionalinformationbox.frame.size.height,self.view.frame.size.width, 50)];
  //  descriptionbox.backgroundColor = [UIColor purpleColor];
    [fullpagescrollview addSubview:descriptionbox];
    
    //description text Label
    UILabel *descriptionheading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0 ,165, 20)];
    
    
    
    descriptionheading.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Contact Information" value:@"" table:nil];
    descriptionheading.textColor = [UIColor whiteColor];
    [descriptionheading setFont:[Font_Face_Controller opensanssemibold:15]];
    descriptionheading.textAlignment=NSTextAlignmentLeft;
    [descriptionbox addSubview:descriptionheading];
    
    //set description editImage button
     descriptioneditBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [descriptioneditBtn setFrame:CGRectMake(descriptionheading.frame.origin.x+descriptionheading.frame.size.width+10, 0 , 15, 15)];
    [descriptioneditBtn setTitle:nil forState: UIControlStateNormal];
     descriptioneditBtn.tag=222;
    
    
    UIImage *descriptioneditbtnImage = [UIImage imageNamed:@"edit1.png"];
    [descriptioneditBtn setImage:descriptioneditbtnImage forState:UIControlStateNormal];
    [descriptioneditBtn addTarget:self action:@selector(action_OpenUserProfileView:) forControlEvents:UIControlEventTouchUpInside];
    [descriptionbox addSubview:descriptioneditBtn];
    
    
    
    
    

    
    //description details text Label
   
   descriptiondetails = [[UITextView alloc] initWithFrame:CGRectMake(10, descriptionheading.frame.origin.y+descriptionheading.frame.size.height+5 ,self.view.frame.size.width-20, 19)];
  //  descriptiondetails.numberOfLines = 0;
  
    descriptiondetails.textColor = [UIColor whiteColor];
    [descriptiondetails setFont:[Font_Face_Controller opensansLight:15]];
   // [descriptiondetails sizeToFit];
    descriptiondetails.textAlignment=NSTextAlignmentLeft;
    [descriptionbox addSubview:descriptiondetails];
  //  descriptiondetails.backgroundColor=[UIColor whiteColor];
    //set additionalinformationbox background view height dynamically as per the text added in description
   // descriptionbox.frame=CGRectMake(0, additionalinformationbox.frame.origin.y+additionalinformationbox.frame.size.height, self.view.frame.size.width, 37+descriptiondetails.frame.size.height);
    descriptiondetails.editable = NO;
    descriptiondetails.dataDetectorTypes = UIDataDetectorTypeAll;
    
    [descriptiondetails setTextContainerInset:UIEdgeInsetsZero];
    descriptiondetails.textContainer.lineFragmentPadding = 0;
    descriptiondetails.backgroundColor = [UIColor clearColor];
    
    
    ////////////////////////  allergiesbox Information //////////////////////
    
    
    
    
    
    //allergies box uiview
    allergiesbox = [[UIView alloc] initWithFrame:CGRectMake(0, descriptionbox.frame.origin.y+descriptionbox.frame.size.height,self.view.frame.size.width, 50)];
   // allergiesbox.backgroundColor = [UIColor blueColor];
    [fullpagescrollview addSubview:allergiesbox];
    
    //allergies text Label
    UILabel *allergiesheading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0 ,80, 20)];
    
    
    
    
    allergiesheading.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Allergies" value:@"" table:nil];
    allergiesheading.textColor = [UIColor whiteColor];
    [allergiesheading setFont:[Font_Face_Controller opensanssemibold:15]];
    allergiesheading.textAlignment=NSTextAlignmentLeft;
    [allergiesbox addSubview:allergiesheading];
    
    //set allergies editImage button
   allergieseditBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [allergieseditBtn setFrame:CGRectMake(allergiesheading.frame.origin.x+allergiesheading.frame.size.width+10, 0 , 15, 15)];
    [allergieseditBtn setTitle:nil forState: UIControlStateNormal];
    allergieseditBtn.tag=333;
    
    UIImage *allergieseditbtnImage = [UIImage imageNamed:@"edit1.png"];
    [allergieseditBtn setImage:allergieseditbtnImage forState:UIControlStateNormal];
    [allergieseditBtn addTarget:self action:@selector(action_OpenUserProfileView:) forControlEvents:UIControlEventTouchUpInside];
    [allergiesbox addSubview:allergieseditBtn];
    
    
    //allergies details text Label
     allergiesdetails = [[UILabel alloc] initWithFrame:CGRectMake(10, allergiesheading.frame.origin.y+allergiesheading.frame.size.height+5 ,self.view.frame.size.width-20, 19)];
  //  allergiesdetails.numberOfLines = 0;
  
    allergiesdetails.textColor = [UIColor whiteColor];
    [allergiesdetails setFont:[Font_Face_Controller opensansLight:15]];
   // [allergiesdetails sizeToFit];
   // allergiesdetails.textAlignment=NSTextAlignmentLeft;
    [allergiesbox addSubview:allergiesdetails];
   // allergiesdetails.backgroundColor=[UIColor whiteColor];
    
    //set allergiesbox background view height dynamically as per the text added in description
    //allergiesbox.frame=CGRectMake(0, descriptionbox.frame.origin.y+descriptionbox.frame.size.height, self.view.frame.size.width, 47+allergiesdetails.frame.size.height);

 
   
    
    //-------------Absence Note/Retriever Note/Note history list button-----------------
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, allergiesbox.frame.origin.y+allergiesbox.frame.size.height, self.view.frame.size.width, 150) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor=[UIColor clearColor];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [tableView setTag:000];
    tableView.scrollEnabled=NO;
    [fullpagescrollview addSubview: tableView];
    
    
    
   
    
    retrievaltimes_background = [[UIView alloc] initWithFrame:CGRectMake(0, tableView.frame.origin.y+tableView.frame.size.height+5 , self.view.frame.size.width, 45)];
     retrievaltimes_background.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
     [fullpagescrollview addSubview:retrievaltimes_background];
     
   //  retrievaltimes text Label
     UILabel *retrievaltimeslabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 ,150, 25)];
    retrievaltimeslabel.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retrieval Times" value:@"" table:nil];
    
     retrievaltimeslabel.textColor = [UIColor whiteColor];
     [retrievaltimeslabel setFont:[Font_Face_Controller opensanssemibold:18]];
     retrievaltimeslabel.textAlignment=NSTextAlignmentLeft;
     [retrievaltimes_background addSubview:retrievaltimeslabel];
     
    // retrievaltimes right corner date label text
     UILabel *retrievaltimes_right_date_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-160, 11 ,120, 22)];
     retrievaltimes_right_date_label.text = date_value;
     retrievaltimes_right_date_label.textColor = [UIColor whiteColor];
     [retrievaltimes_right_date_label setFont:[Font_Face_Controller opensansLight:18]];
     retrievaltimes_right_date_label.textAlignment=NSTextAlignmentRight;
     [retrievaltimes_background addSubview:retrievaltimes_right_date_label];
     
   //  retrievaltimes dropdown arrow button
     UIButton *retrievaltimes_dropdown_arrow_ImgBtn = [UIButton buttonWithType: UIButtonTypeCustom];
     [retrievaltimes_dropdown_arrow_ImgBtn setFrame:CGRectMake((self.view.frame.size.width-30), 14 , 15, 15)];
     UIImage *retrievaltimes_dropdown_arrow_btnImage = [UIImage imageNamed:@"options_down_arrow.png"];
     //[retrievaltimes_dropdown_arrow_ImgBtn setImage:retrievaltimes_dropdown_arrow_btnImage forState:UIControlStateNormal];
     [retrievaltimes_dropdown_arrow_ImgBtn addTarget:self action:@selector(action_OpenUserProfileView) forControlEvents:UIControlEventTouchUpInside];
     [retrievaltimes_background addSubview:retrievaltimes_dropdown_arrow_ImgBtn];
     
   //  Retrieval Times box
    retrievaltimescontent_background = [[UIView alloc] initWithFrame:CGRectMake(0, retrievaltimes_background.frame.origin.y+retrievaltimes_background.frame.size.height , self.view.frame.size.width, 120)];
     retrievaltimescontent_background.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
     [fullpagescrollview addSubview:retrievaltimescontent_background];
     
   //  add Dropoff label text
     UILabel *Dropofflabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5 ,(self.view.frame.size.width-30)/2, 18)];
    Dropofflabel.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Dropoff" value:@"" table:nil];
    
    
   
     Dropofflabel.textColor = [UIColor whiteColor];
     [Dropofflabel setFont:[Font_Face_Controller opensansLight:18]];
     Dropofflabel.textAlignment=NSTextAlignmentLeft;
     [retrievaltimescontent_background addSubview:Dropofflabel];
     
    //  Dropoff text field START
   Dropofftextfield = [[UITextField alloc] initWithFrame:CGRectMake(10, Dropofflabel.frame.origin.y+Dropofflabel.frame.size.height+5 ,(self.view.frame.size.width-30)/2, 35)];
     [Dropofftextfield setTextColor:[UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0]];
      Dropofftextfield.placeholder = @"HH:MM";
    Dropofftextfield.tag=555;
     Dropofftextfield.font = [Font_Face_Controller opensansLight:16];
     Dropofftextfield.delegate=self;
     Dropofftextfield.backgroundColor = [UIColor whiteColor];
     UIView *paddingViewDropofftextfield = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
     Dropofftextfield.leftView = paddingViewDropofftextfield;
     Dropofftextfield.leftViewMode = UITextFieldViewModeAlways;
    
    [Dropofftextfield setInputView:datepicker];
    [Dropofftextfield setInputAccessoryView:toolBar];

    
     [retrievaltimescontent_background addSubview:Dropofftextfield];
     
    // Retrieval label text
     UILabel *Retrievallabel = [[UILabel alloc] initWithFrame:CGRectMake(Dropofflabel.frame.origin.x+Dropofflabel.frame.size.width+5, 5 ,(self.view.frame.size.width-30)/2, 18)];
    Retrievallabel.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retrieval" value:@"" table:nil];
    
    
  
     Retrievallabel.textColor = [UIColor whiteColor];
     [Retrievallabel setFont:[Font_Face_Controller opensansLight:18]];
     Retrievallabel.textAlignment=NSTextAlignmentLeft;
     [retrievaltimescontent_background addSubview:Retrievallabel];
     
    //  Retrieval text field START
    Retrievaltextfield = [[UITextField alloc] initWithFrame:CGRectMake(Dropofflabel.frame.origin.x+Dropofflabel.frame.size.width+10, Retrievallabel.frame.origin.y+Retrievallabel.frame.size.height+5,(self.view.frame.size.width-30)/2, 35)];
     [Retrievaltextfield setTextColor:[UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0]];
     Retrievaltextfield.tag=666;
    Retrievaltextfield.placeholder = @"HH:MM";
     Retrievaltextfield.font = [Font_Face_Controller opensansLight:16];
     Retrievaltextfield.delegate=self;
     Retrievaltextfield.backgroundColor = [UIColor whiteColor];
     UIView *paddingViewRetrievaltext = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
     Retrievaltextfield.leftView = paddingViewRetrievaltext;
     Retrievaltextfield.leftViewMode = UITextFieldViewModeAlways;
    [Retrievaltextfield setInputView:datepicker];
    [Retrievaltextfield setInputAccessoryView:toolBar];
    
     [retrievaltimescontent_background addSubview:Retrievaltextfield];
     
   
    Update_Btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [Update_Btn setFrame:CGRectMake(retrievaltimescontent_background.frame.size.width-120, Retrievaltextfield.frame.origin.y+Retrievaltextfield.frame.size.height+5 , 110, 30)];
    Update_Btn.titleLabel.font=[Font_Face_Controller opensansLight:15];
    Update_Btn.backgroundColor=   [UIColor colorWithRed:210.0f/255.0f green:121.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    
    
    
    
    [Update_Btn setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Update" value:@"" table:nil] forState:UIControlStateNormal];
    Update_Btn.layer.cornerRadius=5;
    Update_Btn.clipsToBounds=YES;
    [Update_Btn addTarget:self action:@selector(action_Update) forControlEvents:UIControlEventTouchUpInside];
    [retrievaltimescontent_background addSubview:Update_Btn];
    


    
    
       
    //Absencedays box
    Absencedays_background = [[UIView alloc] initWithFrame:CGRectMake(0, retrievaltimescontent_background.frame.origin.y+retrievaltimescontent_background.frame.size.height+5 , self.view.frame.size.width, 45)];
    Absencedays_background.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
    [fullpagescrollview addSubview:Absencedays_background];
    
    //Absencedays text Label
    UILabel *Absencedayslabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 ,140, 25)];
    
    
    
    Absencedayslabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absence Days" value:@"" table:nil];
    Absencedayslabel.textColor = [UIColor whiteColor];
    [Absencedayslabel setFont:[Font_Face_Controller opensanssemibold:18]];
    Absencedayslabel.textAlignment=NSTextAlignmentLeft;
    [Absencedays_background addSubview:Absencedayslabel];
    
    //Absencedays plus arrow button
    UIButton *Absencedays_plus_ImgBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [Absencedays_plus_ImgBtn setFrame:CGRectMake(Absencedayslabel.frame.origin.x+Absencedayslabel.frame.size.width, 15 , 15, 15)];
    UIImage *Absencedays_plus_btnImage = [UIImage imageNamed:@"plus1.png"];
    [Absencedays_plus_ImgBtn setImage:Absencedays_plus_btnImage forState:UIControlStateNormal];
    [Absencedays_plus_ImgBtn addTarget:self action:@selector(action_OpenUserProfileView) forControlEvents:UIControlEventTouchUpInside];
    [Absencedays_background addSubview:Absencedays_plus_ImgBtn];
    
    
    //Absencedays dropdown arrow button
    Absencedays_dropdown_arrow_ImgBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [Absencedays_dropdown_arrow_ImgBtn setFrame:CGRectMake((self.view.frame.size.width-40), 0 , 40, 40)];
    Absencedays_dropdown_arrow_btnImage = [UIImage imageNamed:@"top_arrow_white.png"];
    [Absencedays_dropdown_arrow_ImgBtn setImage:Absencedays_dropdown_arrow_btnImage forState:UIControlStateNormal];
    [Absencedays_dropdown_arrow_ImgBtn addTarget:self action:@selector(OptionsbtnToggleClick) forControlEvents:UIControlEventTouchUpInside];
    [Absencedays_background addSubview:Absencedays_dropdown_arrow_ImgBtn];
    
    
    
  
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Profile_detail_API) withObject:nil afterDelay:0.5];
    
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [Utilities API_link_url_IMG], @""]] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    
    
    Mfake_view=[[UIView alloc]init];
    
    Mfake_view.frame=CGRectMake(0,1000, self.view.frame.size.width, 105);
    Mfake_view.backgroundColor=[UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
    Mfake_view.layer.borderWidth=1;
    Mfake_view.layer.borderColor=[UIColor colorWithWhite:255.0f/255.0f alpha:0.3].CGColor;
    Mfake_view.userInteractionEnabled=YES;
    [self.view addSubview:Mfake_view];
    
    
    Mtextfeild= [[UITextField alloc] initWithFrame:CGRectMake(10, 10, Mfake_view.frame.size.width-20, 40)];
   // Mtextfeild.borderStyle = UITextBorderStyleRoundedRect;
    Mtextfeild.font = [UIFont systemFontOfSize:15];
    Mtextfeild.autocorrectionType = UITextAutocorrectionTypeNo;
    Mtextfeild.keyboardType = UIKeyboardTypeDefault;
    Mtextfeild.returnKeyType = UIReturnKeyDone;
    Mtextfeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    Mtextfeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    Mtextfeild.delegate = self;
     Mtextfeild.backgroundColor=[UIColor whiteColor];
    [Mfake_view addSubview:Mtextfeild];
    
//    Mtextfeild=[[UITextField alloc]init];
//    Mtextfeild.text
//    Mtextfeild.delegate=self;
//    Mtextfeild.backgroundColor=[UIColor whiteColor];
//    Mtextfeild.frame=CGRectMake(10, 10, Mfake_view.frame.size.width-20, 40);
//    Mtextfeild.userInteractionEnabled=YES;
//    [Mfake_view addSubview:Mtextfeild];
    
    
    
    Msave=[UIButton buttonWithType:UIButtonTypeCustom];
    
    
    Msave.titleLabel.font = [Font_Face_Controller opensansLight:15];
    Msave.tintColor = [UIColor purpleColor];
    [Msave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Msave setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Save" value:@"" table:nil] forState:UIControlStateNormal];
    Msave.frame=CGRectMake(Mfake_view.frame.size.width-85, Mtextfeild.frame.origin.y+Mtextfeild.frame.size.height+7, 75, 35);
    Msave.layer.cornerRadius=5;
    Msave.clipsToBounds=YES;
    [Msave addTarget:self action:@selector(Save_action:) forControlEvents:UIControlEventTouchUpInside];
    Msave.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:161.0f/255.0f blue:70.0f/255.0f alpha:1.0];
    
    [Mfake_view addSubview:Msave];
    
    
    mcancel=[UIButton buttonWithType:UIButtonTypeCustom];
    [mcancel addTarget:self action:@selector(Cancel_action:) forControlEvents:UIControlEventTouchUpInside];
    mcancel.layer.cornerRadius=5;
    mcancel.clipsToBounds=YES;
    mcancel.frame=CGRectMake(Msave.frame.origin.x-80, Mtextfeild.frame.origin.y+Mtextfeild.frame.size.height+7, 75, 35);
    mcancel.titleLabel.font = [Font_Face_Controller opensansLight:15];
    mcancel.tintColor = [UIColor purpleColor];
    [mcancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mcancel setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] forState:UIControlStateNormal];
    
    
    mcancel.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:161.0f/255.0f blue:70.0f/255.0f alpha:1.0];
    
    [Mfake_view addSubview:mcancel];
    
}

-(void)ShowSelectedCancel
{
    [Dropofftextfield resignFirstResponder];
     [Retrievaltextfield resignFirstResponder];
    
}
-(void)ShowSelectedDate
{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    // [formatter setDateFormat:@"dd/MMM/YYYY"];
    
    
    if ([tag_value isEqualToString:@"555"]) {
        
        
        Dropofftextfield.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datepicker.date]];

        
    }
    else if ([tag_value isEqualToString:@"666"])
    {
        Retrievaltextfield.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datepicker.date]];

    }
    
    [Dropofftextfield resignFirstResponder];
    [Retrievaltextfield resignFirstResponder];

    
    
//    [self mStartIndicater];
//    
//    [self performSelector:@selector(CallTheServer_Child_Component_Next_date_API) withObject:nil afterDelay:0.5];
    
}


-(NSString *)changeformate_string12hr:(NSString *)date
{
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    
    [df setTimeZone:[NSTimeZone systemTimeZone]];
    
    [df setDateFormat:@"hh:mm a"];
    NSDate* wakeTime = [df dateFromString:date];
    
    
    [df setDateFormat:@"HH:mm"];
    
    
    return [df stringFromDate:wakeTime];
    
}


-(void)action_Update
{
       [self mStartIndicater];

       [self performSelector:@selector(CallTheServer_Dropoff_Update_API) withObject:nil afterDelay:0.5];

}



#pragma mark - -*********************
#pragma mark Call API Dropoff_Update Method
#pragma mark - -*********************
-(void)CallTheServer_Dropoff_Update_API
{
    if ([API connectedToInternet]==YES) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [dateFormatter dateFromString: date_value];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_correct_format = [dateFormatter stringFromDate:date];
        

        
        //------------ Call API for signup With Post Method --------------//
        
        
                responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&date=%@&retrieve_time=%@&dropoff_time=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults] valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults] valueForKey:@"student_id"],date_correct_format,Retrievaltextfield.text,Dropofftextfield.text]:[NSString stringWithFormat:@"%@retrivals/update_dropoff_and_retrieve_time",[Utilities API_link_url_subDomain]]];
            
        
        NSDictionary *responseDict = [responseString JSONValue];
        Dropoff_Update = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[Dropoff_Update valueForKey:@"status"] isEqualToString:@"true"]) {
            
            Dropofftextfield.text=[Dropoff_Update valueForKey:@"dropoff_time"];
            
            Retrievaltextfield.text=[Dropoff_Update valueForKey:@"retrieve_time"];
            

            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"REfress_List_retrieval"
             object:nil];

            
            
            
        }else if([[Dropoff_Update valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[Dropoff_Update valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
    }
    Mtextfeild.text=@"";
    
    [self mStopIndicater];
    
}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)action_OpenUserProfileView
{
    
}

- (void)setView:(UIView*)view hidden:(BOOL)hidden {
    [UIView transitionWithView:view duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        [view setHidden:hidden];
    } completion:nil];
}

-(void)action_OpenUserProfileView:(UIButton *)sender
{
    [Mtextfeild becomeFirstResponder];
    additionalinfoeditBtn.userInteractionEnabled=NO ;
    descriptioneditBtn.userInteractionEnabled=NO;
    allergieseditBtn.userInteractionEnabled=NO;

    Mfake_view.frame=CGRectMake(0,1000, self.view.frame.size.width, 105);

    [UIView animateWithDuration:0.35 animations:^{
        Mfake_view.frame=CGRectMake(0,(self.view.frame.size.height-115)/2, self.view.frame.size.width, 110);
    }];
    
    if (sender.tag==111) {
        
      Mtextfeild.text=additionalinformationdetails.text;
      update_type=@"update_additional_info";
        
    }
    else if (sender.tag==222)
    {
        update_type=@"update_contact";
        Mtextfeild.text=descriptiondetails.text;
           }
    else if (sender.tag==333)
    {
        update_type=@"update_allergies";
        Mtextfeild.text=allergiesdetails.text;

    }
    else
    {
        
    }
}
-(void)guardianPhoneButton:(UIButton *)sender{
    NSLog(@"contact=>%@",[[[userprofile valueForKey:@"parent"] valueForKey:@"User" ] valueForKey:@"contact_number"]);
    //        if (![[[[[userprofile valueForKey:@"parent"] valueForKey:@"User" ] valueForKey:@"contact_number"]stringByConvertingHTMLToPlainText]isEqualToString:@""]) {
    UIButton *selectedButton = (UIButton *)sender;
    NSLog(@"Selected button tag is %ld", (long)selectedButton.tag);
    long tag = selectedButton.tag - 200;
         if ([[[[userprofile valueForKey:@"parent"] valueForKey:@"User" ] valueForKey:@"contact_number"]count]!=0){
            
            NSString *phNo =[[[[userprofile valueForKey:@"parent"] valueForKey:@"User"] valueForKey:@"contact_number"]objectAtIndex:tag];
            
            // NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"tel:+1%@",phNo]];
            
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Make a phone call" message:[NSString stringWithFormat:@"Do you want to call %@ %@with the registered number:%@",[[[[userprofile valueForKey:@"parent"] objectAtIndex:tag] valueForKey:@"User" ] valueForKey:@"USR_FirstName"],[[[[userprofile valueForKey:@"parent"]objectAtIndex:tag] valueForKey:@"User" ] valueForKey:@"USR_LastName"],phNo] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
            al.tag=100;
            [al show];
            //            if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            //                [[UIApplication sharedApplication] openURL:phoneUrl];
            //            } else
            //            {
            //                UIAlertView    *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            //                [calert show];
            //            }
            
        }
        
    

}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            NSString *phNo =[[[[userprofile valueForKey:@"parent"] valueForKey:@"User"] valueForKey:@"contact_number"]objectAtIndex:0];
//             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"tel:+1%@",phNo]]];
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString  stringWithFormat:@"tel:+1%@",phNo]]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"tel:+1%@",phNo]]];
            } else
          {
            UIAlertView    *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [calert show];
                        }

  
    }
        
    }
    
    
}

-(void)Save_action:(UIButton *)sender
{
     [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_update_Profile_detail_API) withObject:nil afterDelay:0.5];

    
    [UIView animateWithDuration:0.35 animations:^{
         Mfake_view.frame=CGRectMake(0,1000, self.view.frame.size.width, 105);
    }];
    
    additionalinfoeditBtn.userInteractionEnabled=YES ;
    descriptioneditBtn.userInteractionEnabled=YES;
    allergieseditBtn.userInteractionEnabled=YES;
    
     [Mtextfeild resignFirstResponder];
    
    
    
}

-(void)Cancel_action:(UIButton *)sender
{
    [UIView animateWithDuration:0.35 animations:^{
        Mfake_view.frame=CGRectMake(0,1000, self.view.frame.size.width, 105);
    }];

    [Mtextfeild resignFirstResponder];
    
    Mtextfeild.text=@"";
    
    additionalinfoeditBtn.userInteractionEnabled=YES ;
    descriptioneditBtn.userInteractionEnabled=YES;
    allergieseditBtn.userInteractionEnabled=YES;
    
}

#pragma mark - -*********************
#pragma mark Call API Update_Profile_detail Method
#pragma mark - -*********************

-(void)CallTheServer_update_Profile_detail_API
{
    if ([API connectedToInternet]==YES) {
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
        if ( [update_type isEqualToString:@"update_additional_info"]) {
            responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&user_id=%@&information=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults] valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults] valueForKey:@"student_id"],Mtextfeild.text]:[NSString stringWithFormat:@"%@retrivals/update_additional_info",[Utilities API_link_url_subDomain]]];

        }
        else if ([update_type isEqualToString:@"update_contact"])
        {
            responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&user_id=%@&contact=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults] valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults] valueForKey:@"student_id"],Mtextfeild.text]:[NSString stringWithFormat:@"%@retrivals/update_contact",[Utilities API_link_url_subDomain]]];

        }
        else if ([update_type isEqualToString:@"update_allergies"])
        {
            responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&user_id=%@&allergy_name=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults] valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults] valueForKey:@"student_id"],Mtextfeild.text]:[NSString stringWithFormat:@"%@retrivals/update_allergies",[Utilities API_link_url_subDomain]]];

        }
        else
        {
            
        }
        
      
        
        NSDictionary *responseDict = [responseString JSONValue];
        user_profile_update = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[user_profile_update valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            
            
            if ( [update_type isEqualToString:@"update_additional_info"]) {
                additionalinformationdetails.text = Mtextfeild.text;

                
            }
            else if ([update_type isEqualToString:@"update_contact"])
            {
                 descriptiondetails.text = Mtextfeild.text;
                
            }
            else if ([update_type isEqualToString:@"update_allergies"])
            {
                 allergiesdetails.text = Mtextfeild.text;
                
            }
            else
            {
                
            }

            
           
            
            
            
        }else if([[user_profile_update valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[user_profile_update valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
    }
     Mtextfeild.text=@"";
    
    [self mStopIndicater];

}


-(void)action_OpenMyaccount
{
    
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
#pragma mark Call API All_Groups Method
#pragma mark - -*********************


-(void)CallTheServer_Profile_detail_API
{
    if ([API connectedToInternet]==YES) {
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [dateFormatter dateFromString: date_value];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_correct_format = [dateFormatter stringFromDate:date];
        
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&date=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults] valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults] valueForKey:@"student_id"],date_correct_format]:[NSString stringWithFormat:@"%@retrivals/user_profile",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
       userprofile = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        NSLog(@"user profile %@",userprofile);
        if ([[userprofile valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            Dropofftextfield.text=[[[[userprofile valueForKey:@"student"]valueForKey:@"dropoff_time"]capitalizedString]stringByConvertingHTMLToPlainText];
            
            Retrievaltextfield.text=[[[[userprofile valueForKey:@"student"]valueForKey:@"retrieve_time"]capitalizedString]stringByConvertingHTMLToPlainText];
            
            
            
            NSLog(@"USRIMG:---->%@",[NSString stringWithFormat:@"%@%@", [Utilities API_link_url_IMG], [[userprofile valueForKey:@"student"]valueForKey:@"USR_image"]]);
            
            
              [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [Utilities API_link_url_IMG], [[userprofile valueForKey:@"student"]valueForKey:@"USR_image"]]] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
            
            
            
            if([[[userprofile valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color1"]){
                imageView.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
            }else if([[[userprofile valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color2"]){
                imageView.backgroundColor = [UIColor colorWithRed:90.0f/255.0f green:187.0f/255.0f blue:94.0f/255.0f alpha:1.0];
            }else if([[[userprofile valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color3"]){
                imageView.backgroundColor = [UIColor colorWithRed:47.0f/255.0f green:188.0f/255.0f blue:208.0f/255.0f alpha:1.0];
            }else if([[[userprofile valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color4"]){
                imageView.backgroundColor = [UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
            }else if([[[userprofile valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color5"]){
                imageView.backgroundColor = [UIColor colorWithRed:136.0f/255.0f green:99.0f/255.0f blue:169.0f/255.0f alpha:1.0];
            }else if([[[userprofile valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color6"]){
                imageView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:116.0f/255.0f blue:169.0f/255.0f alpha:1.0];
            }else if([[[userprofile valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color7"]){
                imageView.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:90.0f/255.0f blue:107.0f/255.0f alpha:1.0];
            }
            

            
            
            
           usernamelabel.text = [NSString stringWithFormat:@"%@ %@  #%@", [[[[userprofile valueForKey:@"student"]valueForKey:@"USR_FirstName"]capitalizedString]stringByConvertingHTMLToPlainText], [[[userprofile valueForKey:@"student"]valueForKey:@"USR_LastName"]stringByConvertingHTMLToPlainText],[[[userprofile valueForKey:@"student"]valueForKey:@"USR_PersonalCodeNumber"]stringByConvertingHTMLToPlainText]];
            
    
            
            
            CGSize result = [[UIScreen mainScreen] bounds].size;
            
            for (int a=0; a<([[userprofile valueForKey:@"parent"] count]); a++) {
                
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
                guardiannamelabel.text = [NSString stringWithFormat:@"%@ %@",[[[[[userprofile valueForKey:@"parent"][a] valueForKey:@"User" ] valueForKey:@"USR_FirstName"]stringByConvertingHTMLToPlainText]capitalizedString],[[[[userprofile valueForKey:@"parent"][a] valueForKey:@"User" ] valueForKey:@"USR_LastName"]stringByConvertingHTMLToPlainText]];
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
                guardianphonelabel.text = [[[[userprofile valueForKey:@"parent"][a] valueForKey:@"User" ] valueForKey:@"contact_number"]stringByConvertingHTMLToPlainText];
                guardianphonelabel.textColor = [UIColor whiteColor];
                
                guardianphonelabel.tag=a;
                
//                UITapGestureRecognizer *tap_action_slider = [[UITapGestureRecognizer alloc]
//                                                             initWithTarget:self
//                                                             action:@selector(guardianphonelabel_action:)];
//                
//                [guardianphonelabel addGestureRecognizer:tap_action_slider];
                
                guardiansButton = [UIButton buttonWithType:UIButtonTypeCustom];
                guardiansButton = [[UIButton alloc]initWithFrame:CGRectMake(guardiandetailsBox.frame.size.width-115, 1 ,110, 20)];
                [guardiansButton addTarget:self action:@selector(guardianPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
                [guardiansButton setTitle:nil forState: UIControlStateNormal];
                guardiansButton.tag = 200 + a;
                [guardiandetailsBox addSubview:guardiansButton];

                
                if(result.width<=320){
                    [guardianphonelabel setFont:[Font_Face_Controller opensansLight:12]];
                }else{
                    [guardianphonelabel setFont:[Font_Face_Controller opensansLight:16]];
                }
                guardianphonelabel.textAlignment=NSTextAlignmentRight;
                [guardiandetailsBox addSubview:guardianphonelabel];
            }
            
            
            
            if (![[[userprofile valueForKey:@"allergy"] valueForKey:@"information"]isEqual:[NSNull null]]) {
                
                
                additionalinformationdetails.text = [[[userprofile valueForKey:@"allergy"] valueForKey:@"information"]stringByConvertingHTMLToPlainText];
                
                descriptiondetails.text = [[[userprofile valueForKey:@"allergy"] valueForKey:@"contact_info"]stringByConvertingHTMLToPlainText];
                
                allergiesdetails.text = [[[userprofile valueForKey:@"allergy"] valueForKey:@"allergy_name"]stringByConvertingHTMLToPlainText];
                
                
                
                
                
               
//                [additionalinformationbox addSubview:additionalinformationdetails];
//                 [allergiesbox addSubview:allergiesdetails];
//                 [descriptionbox addSubview:descriptiondetails];
            }
            
            
            tableView_absencedays = [[UITableView alloc] initWithFrame:CGRectMake(0, Absencedays_background.frame.origin.y+Absencedays_background.frame.size.height, self.view.frame.size.width, 0) style:UITableViewStylePlain];
            
            //-------------Absence days list button-----------------
            
            
        if([[userprofile valueForKey:@"absent_days"] count]==0){
            
            tableView_absencedays.frame =CGRectMake(0, Absencedays_background.frame.origin.y+Absencedays_background.frame.size.height, self.view.frame.size.width, 40);
        
        }
        
        else  if([[userprofile valueForKey:@"absent_days"] count]>2)
        {
            tableView_absencedays.frame = CGRectMake(0, Absencedays_background.frame.origin.y+Absencedays_background.frame.size.height, self.view.frame.size.width, 200) ;
        }
        else if([[userprofile valueForKey:@"absent_days"] count]<=2)
            
        {
            
        tableView_absencedays.frame =CGRectMake(0, Absencedays_background.frame.origin.y+Absencedays_background.frame.size.height, self.view.frame.size.width, 120);
            
            }
          
            
            tableView_absencedays.delegate = self;
            tableView_absencedays.dataSource = self;
            tableView_absencedays.backgroundColor = [UIColor clearColor];
            tableView_absencedays.separatorColor=[UIColor clearColor];
            tableView_absencedays.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            [tableView_absencedays setTag:111];
            [tableView_absencedays setUserInteractionEnabled:NO];
            [fullpagescrollview addSubview: tableView_absencedays];
            
            
            //retrievalhistory box
            retrievalhistory_background = [[UIView alloc] initWithFrame:CGRectMake(0, tableView_absencedays.frame.origin.y+tableView_absencedays.frame.size.height+10 , self.view.frame.size.width, 45)];
            retrievalhistory_background.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
            [fullpagescrollview addSubview:retrievalhistory_background];
            
            //retrievalhistory text Label
            UILabel *retrievalhistorylabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 ,160, 25)];
            
            
            
            retrievalhistorylabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retrieval History" value:@"" table:nil];
            retrievalhistorylabel.textColor = [UIColor whiteColor];
            [retrievalhistorylabel setFont:[Font_Face_Controller opensanssemibold:18]];
            retrievalhistorylabel.textAlignment=NSTextAlignmentLeft;
            [retrievalhistory_background addSubview:retrievalhistorylabel];
            
            
            //retrievalhistory dropdown arrow button
            retrievalhistory_dropdown_arrow_ImgBtn = [UIButton buttonWithType: UIButtonTypeCustom];
            [retrievalhistory_dropdown_arrow_ImgBtn setFrame:CGRectMake((self.view.frame.size.width-40), 0 , 40, 40)];
            retrievalhistory_dropdown_arrow_btnImage = [UIImage imageNamed:@"options_down_arrow.png"];
            [retrievalhistory_dropdown_arrow_ImgBtn setImage:retrievalhistory_dropdown_arrow_btnImage forState:UIControlStateNormal];
            [retrievalhistory_dropdown_arrow_ImgBtn addTarget:self action:@selector(RetrievalbtnToggleClick) forControlEvents:UIControlEventTouchUpInside];
            [retrievalhistory_background addSubview:retrievalhistory_dropdown_arrow_ImgBtn];
            
            
            //-------------Absence days list button-----------------
            
            tableView_retrievalhistory = [[UITableView alloc] initWithFrame:CGRectMake(0, retrievalhistory_background.frame.origin.y+retrievalhistory_background.frame.size.height, self.view.frame.size.width, 0) style:UITableViewStylePlain];
            
            
             if([[userprofile valueForKey:@"retriever_history"] count]==0){
                 
                tableView_retrievalhistory.frame = CGRectMake(0, retrievalhistory_background.frame.origin.y+retrievalhistory_background.frame.size.height, self.view.frame.size.width, 40);
            }
            
          else  if([[userprofile valueForKey:@"retriever_history"] count]>2){
                tableView_retrievalhistory.frame = CGRectMake(0, retrievalhistory_background.frame.origin.y+retrievalhistory_background.frame.size.height, self.view.frame.size.width, [[userprofile valueForKey:@"retriever_history"] count] * 40);
            }
          
          else if([[userprofile valueForKey:@"retriever_history"] count]<=2){
                tableView_retrievalhistory.frame =CGRectMake(0, retrievalhistory_background.frame.origin.y+retrievalhistory_background.frame.size.height, self.view.frame.size.width, 120);
            }
            

            
            tableView_retrievalhistory.delegate = self;
            tableView_retrievalhistory.dataSource = self;
            tableView_retrievalhistory.backgroundColor = [UIColor clearColor];
            tableView_retrievalhistory.separatorColor=[UIColor clearColor];
            tableView_retrievalhistory.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            [tableView_retrievalhistory setTag:222];
            [tableView_retrievalhistory setUserInteractionEnabled:NO];
            [fullpagescrollview addSubview: tableView_retrievalhistory];
            
                     //-------------Absence days list button-----------------
         
            
            
            
            fullpagescrollview.contentSize = CGSizeMake(self.view.frame.size.width, tableView_retrievalhistory.frame.origin.y+tableView_retrievalhistory.frame.size.height+70);
            
            
            
             [tableView_retrievalhistory reloadData];
             [tableView_absencedays reloadData];

        }else if([[userprofile valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[userprofile valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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

- (void) guardianphonelabel_action: (UITapGestureRecognizer *)recognizer
{
    
    UIView *view = recognizer.view; //cast pointer to the derived class if needed
    NSLog(@"%ld", (long)view.tag);
    
    if (![[[[[userprofile valueForKey:@"parent"][view.tag] valueForKey:@"User"] valueForKey:@"contact_number"]stringByConvertingHTMLToPlainText]isEqualToString:@""]) {
        
   
    
    NSString *phNo =[NSString stringWithFormat:@"+1%@",[[[[userprofile valueForKey:@"parent"][view.tag] valueForKey:@"User"] valueForKey:@"contact_number"]stringByConvertingHTMLToPlainText]];
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
    UIAlertView    *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
    
     }
    
}


- (void) OptionsbtnToggleClick {
//    if (isShown) {
//        tableView_absencedays.frame = CGRectMake(0, Absencedays_background.frame.origin.y+Absencedays_background.frame.size.height, self.view.frame.size.width, 0);
//        [UIView animateWithDuration:0.25 animations:^{
//            tableView_absencedays.frame = CGRectMake(0, Absencedays_background.frame.origin.y+Absencedays_background.frame.size.height, self.view.frame.size.width, 0);
//            Absencedays_dropdown_arrow_btnImage = [UIImage imageNamed:@"options_down_arrow.png"];
//            [Absencedays_dropdown_arrow_ImgBtn setImage:Absencedays_dropdown_arrow_btnImage forState:UIControlStateNormal];
//        }];
//        isShown = false;
//    } else {
//        [UIView animateWithDuration:0.25 animations:^{
//            tableView_absencedays.frame = CGRectMake(0, Absencedays_background.frame.origin.y+Absencedays_background.frame.size.height, self.view.frame.size.width, 200);
//            Absencedays_dropdown_arrow_btnImage = [UIImage imageNamed:@"top_arrow_white.png"];
//            [Absencedays_dropdown_arrow_ImgBtn setImage:Absencedays_dropdown_arrow_btnImage forState:UIControlStateNormal];
//        }];
//        isShown = true;
//    }
}

- (void) RetrievalbtnToggleClick {
//    if (isRetrievalShown) {
//        tableView_retrievalhistory.frame = CGRectMake(0, retrievalhistory_background.frame.origin.y+retrievalhistory_background.frame.size.height, self.view.frame.size.width, 0);
//        [UIView animateWithDuration:0.25 animations:^{
//            tableView_retrievalhistory.frame = CGRectMake(0, retrievalhistory_background.frame.origin.y+retrievalhistory_background.frame.size.height, self.view.frame.size.width, 0);
//            retrievalhistory_dropdown_arrow_btnImage = [UIImage imageNamed:@"options_down_arrow.png"];
//            [retrievalhistory_dropdown_arrow_ImgBtn setImage:retrievalhistory_dropdown_arrow_btnImage forState:UIControlStateNormal];
//        }];
//        isRetrievalShown = false;
//    } else {
//        [UIView animateWithDuration:0.25 animations:^{
//            tableView_retrievalhistory.frame = CGRectMake(0, retrievalhistory_background.frame.origin.y+retrievalhistory_background.frame.size.height, self.view.frame.size.width, 120);
//            retrievalhistory_dropdown_arrow_btnImage = [UIImage imageNamed:@"top_arrow_white.png"];
//            [retrievalhistory_dropdown_arrow_ImgBtn setImage:retrievalhistory_dropdown_arrow_btnImage forState:UIControlStateNormal];
//        }];
//        isRetrievalShown = true;
//    }
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==000){return 50;}
    else if (tableView.tag==111){
        return 40;
    }
    else if (tableView.tag==222){
        return 40;
    }
    else{
        return 10;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==000)
    {
        return 3;
    }
    else if (tableView.tag==111){
        return [[userprofile valueForKey:@"absent_days"] count];
    }
    else if (tableView.tag==222){
        NSLog(@"userprofile %d",[[userprofile valueForKey:@"retriever_history"] count]);
        NSLog(@"%@",[userprofile valueForKey:@"retriever_history"]);
        return [[userprofile valueForKey:@"retriever_history"] count];
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"%lu",[[userprofile valueForKey:@"absent_days"]count]);
    
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if(tableView.tag==000){
    //add label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5 ,self.view.frame.size.width, 40)];

//    if([[[[dict1 valueForKey:@"video_detail"]objectAtIndex:indexPath.row]valueForKey:@"status"] isEqualToString:@"Live"]){
    label.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
    [cell.contentView addSubview:label];

    //set absentnote image
    UIImageView *absentnoteimageView = [[UIImageView alloc]init];
        if(indexPath.row==2){ absentnoteimageView.frame=CGRectMake(18, 18 , 14, 13); }
        else if(indexPath.row==1){ absentnoteimageView.frame=CGRectMake(15, 14 , 18, 18); }else{
            absentnoteimageView.frame=CGRectMake(15, 15 , 18, 18); }
    UIImage *absentnotebtnImage;
    if(indexPath.row==0){ absentnotebtnImage = [UIImage imageNamed:@"absent_note.png"];
    }else if(indexPath.row==1){ absentnotebtnImage = [UIImage imageNamed:@"vanner.png"];
    }else if(indexPath.row==2){ absentnotebtnImage = [UIImage imageNamed:@"notehistory.png"]; }
    [absentnoteimageView setImage:absentnotebtnImage];
    [cell.contentView addSubview:absentnoteimageView];
    
    //add list title text
    UILabel *listtitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(absentnoteimageView.frame.origin.x+absentnoteimageView.frame.size.width+15, 14 ,self.view.frame.size.width-100, 22)];
        
        
        
    if(indexPath.row==0){ listtitlelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absence note" value:@"" table:nil];
    }else if(indexPath.row==1){ listtitlelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retriever note" value:@"" table:nil];
    }else if(indexPath.row==2){ listtitlelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Note history" value:@"" table:nil]; }
    
    listtitlelabel.textColor = [UIColor whiteColor];
    [listtitlelabel setFont:[Font_Face_Controller opensansLight:18]];
    listtitlelabel.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:listtitlelabel];
    
    //set right arrow image
    UIImageView *rightarrowimageView = [[UIImageView alloc]init];
    rightarrowimageView.frame=CGRectMake(self.view.frame.size.width-30, 16 , 15, 15);
    UIImage *rightarrowbtnImage = [UIImage imageNamed:@"right_arrow_white.png"];
    [rightarrowimageView setImage:rightarrowbtnImage];
    [cell.contentView addSubview:rightarrowimageView];
    }
    else if (tableView.tag==111){
        
        //add label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 ,self.view.frame.size.width, 40)];
        
        if(indexPath.row%2==0){
            label.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
        }else{
            label.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:124.0f/255.0f blue:27.0f/255.0f alpha:1.0];
        }
        [cell.contentView addSubview:label];
        
        //add list From column text
        UILabel *Fromlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12 ,(self.view.frame.size.width-35)/4, 16)];
        if(indexPath.row==0){ Fromlabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"From" value:@"" table:nil];
            [Fromlabel setFont:[Font_Face_Controller opensanssemibold:14]];
            
            
            
        }else{ Fromlabel.text = [[[[[userprofile valueForKey:@"absent_days"] objectAtIndex:indexPath.row] valueForKey:@"Retrival"] valueForKey:@"from_date"]stringByConvertingHTMLToPlainText];
            [Fromlabel setFont:[Font_Face_Controller opensansLight:12]];
        }
        Fromlabel.textColor = [UIColor whiteColor];
        Fromlabel.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:Fromlabel];
        
        //add list To column text
        UILabel *Tolabel = [[UILabel alloc] initWithFrame:CGRectMake(Fromlabel.frame.origin.x+Fromlabel.frame.size.width+5, 12 ,(self.view.frame.size.width-35)/4, 16)];
        if(indexPath.row==0){ Tolabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"To" value:@"" table:nil];
            [Tolabel setFont:[Font_Face_Controller opensanssemibold:14]];
        }else{ Tolabel.text = [[[[[userprofile valueForKey:@"absent_days"] objectAtIndex:indexPath.row] valueForKey:@"Retrival"] valueForKey:@"to_date"]stringByConvertingHTMLToPlainText];
            [Tolabel setFont:[Font_Face_Controller opensansLight:12]];
        }
        Tolabel.textColor = [UIColor whiteColor];
        Tolabel.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:Tolabel];
        
        //add list Bywhom column text
        UILabel *Bywhomlabel = [[UILabel alloc] initWithFrame:CGRectMake(Tolabel.frame.origin.x+Tolabel.frame.size.width+5, 12 ,((self.view.frame.size.width-35)/4)+40, 16)];
        
        
        
        
        if(indexPath.row==0){ Bywhomlabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"By whom" value:@"" table:nil];
            [Bywhomlabel setFont:[Font_Face_Controller opensanssemibold:14]];
        }else{ Bywhomlabel.text = [NSString stringWithFormat:@"%@ %@", [[[[[userprofile valueForKey:@"absent_days"] objectAtIndex:indexPath.row] valueForKey:@"User"] valueForKey:@"USR_FirstName"]stringByConvertingHTMLToPlainText], [[[[[userprofile valueForKey:@"absent_days"] objectAtIndex:indexPath.row] valueForKey:@"User"] valueForKey:@"USR_LastName"]stringByConvertingHTMLToPlainText]];
            [Bywhomlabel setFont:[Font_Face_Controller opensansLight:12]];
        }
        Bywhomlabel.textColor = [UIColor whiteColor];
        Bywhomlabel.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:Bywhomlabel];
        if(indexPath.row!=0){
        //set absentdays_edit_icon image
        UIButton *absentdays_edit_iconimageView = [[UIButton alloc]init];
        absentdays_edit_iconimageView.frame=CGRectMake(self.view.frame.size.width-50, 12 , 15, 15);
        UIImage *absentdays_edit_iconbtnImage = [UIImage imageNamed:@"edit1.png"];
            [absentdays_edit_iconimageView setImage:absentdays_edit_iconbtnImage forState:UIControlStateNormal];
            [absentdays_edit_iconimageView addTarget:self action:@selector(action_OpenMyaccount) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:absentdays_edit_iconimageView];
        
        
        //set absentdays_cross_icon image
        UIButton *absentdays_cross_iconimageView = [[UIButton alloc]init];
        absentdays_cross_iconimageView.frame=CGRectMake(self.view.frame.size.width-30, 12 , 15, 15);
        UIImage *absentdays_cross_iconbtnImage = [UIImage imageNamed:@"cross.png"];
            [absentdays_cross_iconimageView setImage:absentdays_cross_iconbtnImage forState:UIControlStateNormal];
            [absentdays_cross_iconimageView addTarget:self action:@selector(action_OpenMyaccount) forControlEvents:UIControlEventTouchUpInside];

        [cell.contentView addSubview:absentdays_cross_iconimageView];
        }
        }
        else if (tableView.tag==222){
            
            NSLog(@"%@",[userprofile valueForKey:@"retriever_history"]);
             NSLog(@"%lu",[[userprofile valueForKey:@"retriever_history"]count]);
               NSLog(@"%@",[[userprofile valueForKey:@"retriever_history"]objectAtIndex:0]);
            
            //add label
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 ,self.view.frame.size.width, 40)];
            
            if(indexPath.row%2==0){
                label.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
            }else{
                label.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:124.0f/255.0f blue:27.0f/255.0f alpha:1.0];
            }
            [cell.contentView addSubview:label];
            
            
            //add list From column text
            UILabel *Fromlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12 ,(self.view.frame.size.width-35)/4, 16)];
            
            
            
            if(indexPath.row==0){ Fromlabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type" value:@"" table:nil];
                [Fromlabel setFont:[Font_Face_Controller opensanssemibold:14]];
            }else{ Fromlabel.text = [[[[userprofile valueForKey:@"retriever_history"] objectAtIndex:indexPath.row] valueForKey:@"type"]stringByConvertingHTMLToPlainText];
                [Fromlabel setFont:[Font_Face_Controller opensansLight:12]];
            }
            Fromlabel.textColor = [UIColor whiteColor];
            Fromlabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:Fromlabel];
            
            //add list To column text
            UILabel *Tolabel = [[UILabel alloc] initWithFrame:CGRectMake(Fromlabel.frame.origin.x+Fromlabel.frame.size.width+5, 12 ,(self.view.frame.size.width-35)/4, 16)];
            
            
            
            if(indexPath.row==0){ Tolabel.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Time" value:@"" table:nil];
                [Tolabel setFont:[Font_Face_Controller opensanssemibold:14]];
            }else{ Tolabel.text = [[[[userprofile valueForKey:@"retriever_history"] objectAtIndex:indexPath.row] valueForKey:@"mark_time"]stringByConvertingHTMLToPlainText];
                [Tolabel setFont:[Font_Face_Controller opensansLight:12]];
            }
            Tolabel.textColor = [UIColor whiteColor];
            Tolabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:Tolabel];
            if(indexPath.row!=0){
                //set retrievaltime_edit_icon image
                UIButton *retrievaltime_edit_iconimageView = [[UIButton alloc]init];
                retrievaltime_edit_iconimageView.frame=CGRectMake(40, 0 , 15, 15);
                UIImage *retrievaltime_edit_iconbtnImage = [UIImage imageNamed:@"edit1.png"];
                [retrievaltime_edit_iconimageView setImage:retrievaltime_edit_iconbtnImage forState:UIControlStateNormal];
                [retrievaltime_edit_iconimageView addTarget:self action:@selector(action_OpenMyaccount) forControlEvents:UIControlEventTouchUpInside];
                [Tolabel addSubview:retrievaltime_edit_iconimageView];
            }
            
            //add list Bywhom column text
            UILabel *Bywhomlabel = [[UILabel alloc] initWithFrame:CGRectMake(Tolabel.frame.origin.x+Tolabel.frame.size.width+5, 12 ,((self.view.frame.size.width-35)/4)+40, 16)];
            
            
            
            if(indexPath.row==0){ Bywhomlabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"By whom" value:@"" table:nil];
                [Bywhomlabel setFont:[Font_Face_Controller opensanssemibold:14]];
            }else{ Bywhomlabel.text = [[[[userprofile valueForKey:@"retriever_history"] objectAtIndex:indexPath.row] valueForKey:@"name"]stringByConvertingHTMLToPlainText];
                [Bywhomlabel setFont:[Font_Face_Controller opensansLight:12]];
            }
            Bywhomlabel.textColor = [UIColor whiteColor];
            Bywhomlabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:Bywhomlabel];
            if(indexPath.row!=0){
                //set retrievaltime_cross_icon image
                UIButton *retrievaltime_cross_iconimageView = [[UIButton alloc]init];
                retrievaltime_cross_iconimageView.frame=CGRectMake(self.view.frame.size.width-30, 13 , 15, 15);
                UIImage *retrievaltime_cross_iconbtnImage = [UIImage imageNamed:@"cross.png"];
                [retrievaltime_cross_iconimageView setImage:retrievaltime_cross_iconbtnImage forState:UIControlStateNormal];
                [retrievaltime_cross_iconimageView addTarget:self action:@selector(action_OpenMyaccount) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:retrievaltime_cross_iconimageView];
                
            }
        
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView.tag==000){
        
        if(indexPath.row==0){
            add_absent_note *objadd_absent_note=[[add_absent_note alloc]init];
            [self.navigationController pushViewController:objadd_absent_note animated:YES];
        }else if(indexPath.row==1){
            add_retriever_note *objadd_retriever_note=[[add_retriever_note alloc]init];
            [self.navigationController pushViewController:objadd_retriever_note animated:YES];
        }
        else
        {
            note_history *objNote_historys=[[note_history alloc]init];
            objNote_historys.color=color;
            [self.navigationController pushViewController:objNote_historys animated:YES];
            
            
        }
    }
    

    
    
    
}


- (void)createDateFormatter {
    
    _datepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 200)];
    _datepicker.backgroundColor = [UIColor whiteColor];
    _datepicker.datePickerMode = UIDatePickerModeDate;
    [_datepicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_datepicker];
    
}


- (void) dateChanged:(id)sender{
    // handle date changes
    UIDatePicker *picker = (UIDatePicker *)sender;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    date_value = [dateFormatter stringFromDate:[picker date]];
 
    [selected_date_btn setTitle:date_value forState: UIControlStateNormal];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Profile_detail_API) withObject:nil afterDelay:0.5];
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
    
    [self performSelector:@selector(CallTheServer_Profile_detail_API) withObject:nil afterDelay:0.5];
}
- (void) dateChangedPrevious{
    // handle previous date changes
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date_to_be_incremented = [dateFormatter dateFromString:date_value];
    
    int daysToAdd = -1;
    NSDate *updated_date = [date_to_be_incremented dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    date_value = [dateFormatter stringFromDate:updated_date];
    //[[NSUserDefaults standardUserDefaults] setValue:date_correct_format forKey:@"CalenderDate_Selected"];
    [selected_date_btn setTitle:date_value forState: UIControlStateNormal];
    
  
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Profile_detail_API) withObject:nil afterDelay:0.5];
    
}

-(void) getupdateprofileview{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
//    NSDate *date = [dateFormatter dateFromString: date_value];
//    dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
//    
//    NSString *responseString2 = [AppDelegate makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&date=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults] valueForKey:@"language"],[[NSUserDefaults standardUserDefaults] valueForKey:@"student_id"],date_correct_format]:@"http://ps.pnf-sites.info/lms_api/retrivals/user_profile"];
//    
//    NSDictionary *responseDict2 = [responseString2 JSONValue];
//    userprofile = [[NSMutableDictionary alloc]initWithDictionary:responseDict2];
    
    
//    if([[students_list valueForKey:@"classStatus"]isEqualToString:@"true"]){
//        CheckIfShowGroupTitles = TRUE; //FALSE
//    }
//    else
//    {
//        CheckIfShowGroupTitles = FALSE; //FALSE
//    }
//    
    
    //[tableView_options reloadData];
}


-(void)datePickerView
{
    [_datepicker removeFromSuperview];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_datepicker removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    tag_value=[NSString stringWithFormat:@"%d",textField.tag];
    
    
   [_datepicker removeFromSuperview];
//    [textField resignFirstResponder];
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
