//
//  retrieval_list_home.m
//  SCM
//
//  Created by pnf on 12/11/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//

#import "retrieval_list_home.h"
#import "AppDelegate.h"

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

#import "profile.h"
#import "absent_note.h"
#import "retrieval_note.h"
#import "Attendance_overview.h"
  #import "Schedule_Dropoff_Retrieval_times.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"
@interface retrieval_list_home ()

@end

@implementation retrieval_list_home
@synthesize datepicker;
bool isShown = false;

#pragma mark -
#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems {
    // self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
    
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        //self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
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
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Attendance list" value:@"" table:nil];
    
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGSize size1;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=11){
        size1 = CGSizeMake(20, 20);
    } else {
        size1 = CGSizeMake(30, 30);
    }
    
    UIImage *butImage = [ImageCustomClass image:[UIImage imageNamed:@"back-2"] resize:size1];

    
 //   UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
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


- (void) REfress_retrieval_list:(NSNotification *) notification
{
    
    [self Navigation_bar];
    
    
    
}

- (void) REfress_List_retrieval:(NSNotification *) notification
{
    
    
    [self performSelectorInBackground:@selector(CallTheServer_get_attendance_list_API) withObject:nil];
    
    
  //  [self performSelector:@selector(CallTheServer_get_attendance_list_API) withObject:nil afterDelay:0.1];
    
    
    }



#pragma mark - -*********************
#pragma mark Search Bar Method
#pragma mark - -*********************


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_attendance_list_API) withObject:nil afterDelay:0.5];
    
    
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
    
    //  [searchBar setShowsCancelButton:NO animated:YES];
    
    
}




- (void)dismissKeyboard
{
    // hide the keyboard
    [search resignFirstResponder];
    // remove the overlay button
    
    search.text=@"";
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(REfress_retrieval_list:)
                                                 name:@"REfress_retrieval_list"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(REfress_List_retrieval:)
                                                 name:@"REfress_List_retrieval"
                                               object:nil];
    
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSObject * object = [prefs objectForKey:@"id_group"];
    if(object != nil){
        
        
          Group_id=[[NSUserDefaults standardUserDefaults]valueForKey:@"id_group"];
        
    }
    else
    {
        Group_id=@"-1";
    }

    
    
    
    
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
    selected_date_btn = [[UITextField alloc]init];
    selected_date_btn.tag=999;
    [selected_date_btn setFrame:CGRectMake((CalenderSelectionBox.frame.size.width-110)/2, (CalenderSelectionBox.frame.size.height-18)/2, 110, 18)];
    selected_date_btn.textColor=[UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0];
    
    selected_date_btn.font=[Font_Face_Controller opensanssemibold:18] ;
    [CalenderSelectionBox addSubview:selected_date_btn];
    
    
    
    datepicker=[[UIDatePicker alloc]init];
    datepicker.datePickerMode=UIDatePickerModeDate;
    [selected_date_btn setInputView:datepicker];
    
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    
    
    
    
    UIBarButtonItem *Cancel=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedCancel)];
    
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:Cancel,space,doneBtn, nil]];
    [selected_date_btn setInputAccessoryView:toolBar];

    
    
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
    
    
    //-------Group selection tab start------------
    
    GroupSelectionDropDownList = [[UITextField alloc] initWithFrame:CGRectMake(0, previousdayBox.frame.origin.y+previousdayBox.frame.size.height, self.view.frame.size.width-5, 40)];
    [GroupSelectionDropDownList setTextColor:[UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0]];
    GroupSelectionDropDownList.delegate=self;
    GroupSelectionDropDownList.attributedPlaceholder =  [[NSAttributedString alloc] initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Groups" value:@"" table:nil] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:114.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:1.0]}];
    GroupSelectionDropDownList.font = [Font_Face_Controller opensansregular:18];
    GroupSelectionDropDownList.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:GroupSelectionDropDownList];
    
    
    [self performSelectorInBackground:@selector(CallTheServer_all_groups_API) withObject:nil];
    
    //-------Option selection tab start------------
    OptionsBox  = [[UIView alloc] initWithFrame:CGRectMake(0,GroupSelectionDropDownList.frame.origin.y+GroupSelectionDropDownList.frame.size.height, self.view.frame.size.width, 40)];
    OptionsBox.userInteractionEnabled=YES;
    OptionsBox.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    [self.view addSubview:OptionsBox];
    
    UILabel *OptionsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    
    
    
    OptionsLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Options" value:@"" table:nil];
    
    OptionsLabel.textColor = [UIColor colorWithRed:251.0f/255.0f green:231.0f/255.0f blue:215.0f/255.0f alpha:1.0];
    OptionsLabel.font = [Font_Face_Controller opensansLight:18];
    [OptionsBox addSubview:OptionsLabel];
    
    //set Options Box
    OptionsBoximageView = [UIButton buttonWithType: UIButtonTypeCustom];
    [OptionsBoximageView setFrame:CGRectMake(self.view.frame.size.width-42, 0 , 40, 40)];
    [OptionsBoximageView setTitle:nil forState: UIControlStateNormal];
    OptionsbtnImage = [UIImage imageNamed:@"options_down_arrow.png"];
    [OptionsBoximageView setImage:OptionsbtnImage forState:UIControlStateNormal];
    [OptionsBoximageView addTarget:self action:@selector(OptionsbtnToggleClick) forControlEvents:UIControlEventTouchUpInside];
    [OptionsBox addSubview:OptionsBoximageView];
    
    //-------------Schedule Dropoff/Atendance Overview list button-----------------
    
    OptionsListBox  = [[UIView alloc] initWithFrame:CGRectMake(0,OptionsBox.frame.origin.y+OptionsBox.frame.size.height, 0, 0)];
    OptionsListBox.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    OptionsListBox.userInteractionEnabled=YES;
    //OptionsListBox.backgroundColor = [UIColor grayColor];
    [self.view addSubview:OptionsListBox];
    
    mtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 88) style:UITableViewStylePlain];
    mtableView.delegate = self;
    mtableView.dataSource = self;
    mtableView.backgroundColor = [UIColor clearColor];
    mtableView.separatorColor=[UIColor clearColor];
    mtableView.contentInset = UIEdgeInsetsMake(-2, 0, 0, 0);
    [mtableView setTag:444];
    //[tableView setUserInteractionEnabled:NO];
    [OptionsListBox addSubview: mtableView];
    
    
    search = [[UISearchBar alloc] init];
    search.frame = CGRectMake(0,0, self.view.frame.size.width,0);
    search.placeholder=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Search" value:@"" table:nil];
    search.delegate = self;
    search.text=@"";
    search.layer.borderColor=[UIColor clearColor].CGColor;
    
   search.barTintColor = [UIColor colorWithRed:251.0f/255.0f green:231.0f/255.0f blue:215.0f/255.0f alpha:1.0]; // Are these the same effect?
  [search setTintColor:[UIColor colorWithRed:251.0f/255.0f green:231.0f/255.0f blue:215.0f/255.0f alpha:1.0]];
    
 [search setBackgroundColor:[UIColor colorWithRed:251.0f/255.0f green:231.0f/255.0f blue:215.0f/255.0f alpha:1.0]];
    [search setBackgroundImage:[UIImage new]];
    [search setTranslucent:YES];
    search.hidden=YES;
    
    [OptionsListBox addSubview:search];
    
    //////////////////// dismissKeyboard\\\\\\\\\\\\\\
    
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:tap];

    
    
    
    
    //-------Children heading tab start------------
    
    ChildrensBox  = [[UIView alloc] initWithFrame:CGRectMake(0,OptionsListBox.frame.origin.y+OptionsListBox.frame.size.height, self.view.frame.size.width, 40)];
    ChildrensBox.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:192.0f/255.0f blue:133.0f/255.0f alpha:1.0];
    [self.view addSubview:ChildrensBox];
    
   ChildrensBoxOverlay  = [[UIView alloc] initWithFrame:CGRectMake(0,1, self.view.frame.size.width-70, 38)];
    ChildrensBoxOverlay.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:129.0f/255.0f blue:29.0f/255.0f alpha:1.0];
    [ChildrensBox addSubview:ChildrensBoxOverlay];
    
    
    UILabel *ChildrensLabel = [[UILabel alloc]initWithFrame:CGRectMake(7, 10, 150, 20)];
    
    
    
    ChildrensLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"CHILDREN" value:@"" table:nil];
    ChildrensLabel.textAlignment=NSTextAlignmentLeft;
    ChildrensLabel.textColor = [UIColor whiteColor];
    ChildrensLabel.font = [Font_Face_Controller opensanssemibold:15];
  //  ChildrensLabel.backgroundColor=[UIColor grayColor];
    [ChildrensBox addSubview:ChildrensLabel];
    
    
    
    
    Updated_time  = [[UILabel alloc]initWithFrame:CGRectMake((ChildrensLabel.frame.origin.x+ChildrensLabel.frame.size.width)-40, 10, ChildrensBox.frame.size.width-ChildrensLabel.frame.size.width, 20)];
    
    Updated_time.textColor = [UIColor whiteColor];
    Updated_time.font = [Font_Face_Controller opensansLight:14];
  //  Updated_time.backgroundColor=[UIColor redColor];
    [ChildrensBox addSubview:Updated_time];

    
    
    //total icon and count
  totallabel = [[UILabel alloc] initWithFrame:CGRectMake(ChildrensBoxOverlay.frame.origin.x+ChildrensBoxOverlay.frame.size.width+1, OptionsListBox.frame.origin.y+OptionsListBox.frame.size.height+1 ,69, 38)];
    totallabel.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:129.0f/255.0f blue:29.0f/255.0f alpha:1.0];
    [self.view addSubview:totallabel];
    
        //set total Image button
        totalimageView = [UIButton buttonWithType: UIButtonTypeCustom];
        [totalimageView setFrame:CGRectMake(totallabel.frame.origin.x+10, totallabel.frame.origin.y+10 , 23, 23)];
        [totalimageView setTitle:nil forState: UIControlStateNormal];
        UIImage *totalbtnImage = [UIImage imageNamed:@"children_tab_total.png"];
     //   [totalimageView setImage:totalbtnImage forState:UIControlStateNormal];
        //[totalimageView addTarget:self action:@selector(action_OpenUserProfileView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:totalimageView];
    
        //add time below tick text
       tickbelowtimelabel = [[UILabel alloc] initWithFrame:CGRectMake(totalimageView.frame.origin.x+totalimageView.frame.size.width+5, totallabel.frame.origin.y+10 ,20, 20)];
               tickbelowtimelabel.textColor = [UIColor whiteColor];
        [tickbelowtimelabel setFont:[Font_Face_Controller opensansLight:15]];
        tickbelowtimelabel.textAlignment=NSTextAlignmentLeft;
        [self.view addSubview:tickbelowtimelabel];
    
    //-------Children heading tab end------------

    
    //-------Children selection tab start------------
    
     tableView_options = [[UITableView alloc] initWithFrame:CGRectMake(0, ChildrensBox.frame.origin.y+ChildrensBox.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-(ChildrensBox.frame.origin.y+ChildrensBox.frame.size.height)) style:UITableViewStylePlain];
    tableView_options.delegate = self;
    tableView_options.dataSource = self;
    [tableView_options setTag:111];
    tableView_options.userInteractionEnabled = YES;
    tableView_options.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:195.0f/255.0f blue:144.0f/255.0f alpha:1.0];
    tableView_options.separatorColor=[UIColor clearColor];
    tableView_options.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.view addSubview: tableView_options];
    
    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]init];
//    tap1.numberOfTapsRequired = 1;
//    [tableView_options addGestureRecognizer:tap1];
//    [tap1 addTarget:self action:@selector(datePickerView)];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [tableView_options addSubview:refreshControl];
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_attendance_list_API) withObject:nil afterDelay:0.5];
   
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    
    [dateformate setDateFormat:@"YYYY/MM/dd"];
    [[NSUserDefaults standardUserDefaults]setObject:[dateformate stringFromDate:[NSDate date]] forKey:@"CalenderDate_Selected"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    selected_date_btn.text=[dateformate stringFromDate:[NSDate date]];
    
 // [selected_date_btn setTitle:[dateformate stringFromDate:[NSDate date]] forState: UIControlStateNormal];
    
}
- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;
}

-(void)ShowSelectedCancel
{
    [selected_date_btn resignFirstResponder];

}

-(void)ShowSelectedDate
{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
     [formatter setDateFormat:@"yyyy/MM/dd"];
  // [formatter setDateFormat:@"dd/MMM/YYYY"];
   selected_date_btn.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datepicker.date]];
    
    
    [[NSUserDefaults standardUserDefaults]setObject: selected_date_btn.text forKey:@"CalenderDate_Selected"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    [selected_date_btn resignFirstResponder];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_attendance_list_API) withObject:nil afterDelay:0.5];
    
}
-(void)action_OpenUserProfileView
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
-(void)CallTheServer_all_groups_API
{
    if ([API connectedToInternet]==YES) {
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@retrivals/all_groups",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        GroupsData = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[GroupsData valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            // create the array of data
            NSMutableArray* GroupSelectionDropDownListNameArray = [[NSMutableArray alloc] init];
            GroupSelectionDropDownListIdArray = [[NSMutableArray alloc] init];
            
            
            for(NSArray *string in [GroupsData valueForKey:@"data"]){
                
                [GroupSelectionDropDownListNameArray addObject:[[string valueForKey:@"name"]stringByConvertingHTMLToPlainText]];
                
                [GroupSelectionDropDownListIdArray addObject:[string valueForKey:@"id"]];
                
            }
            
            self.downPicker = [[DownPicker alloc] initWithTextField:GroupSelectionDropDownList withData:GroupSelectionDropDownListNameArray];
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"Select Group"];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:114.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:1.0] range:NSMakeRange(0,12)];
            [self.downPicker setAttributedPlaceholder:string];
            [self.downPicker setSelectedIndex:0];
            
            [self.downPicker setTintColor:[UIColor colorWithRed:114.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:1.0] ];
            
            [self.downPicker addTarget:self action:@selector(dp_Selected:) forControlEvents:UIControlEventValueChanged];
            
            
            
            
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            
            NSObject * object = [prefs objectForKey:@"group_view_selection"];
            if(object != nil){
                

            
            
                dispatch_sync(dispatch_get_main_queue(), ^{
                    GroupSelectionDropDownList.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"group_view_selection"];
                    Group_id=[[NSUserDefaults standardUserDefaults]valueForKey:@"id_group"];                });
                
               
               
               
            }
            
            
            
            
            
            
        }else if([[GroupsData valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[GroupsData valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
    }
    
}

#pragma mark - -*********************
#pragma mark Call API All_Groups Method
#pragma mark - -*********************


-(void)CallTheServer_get_attendance_list_API
{
    if ([API connectedToInternet]==YES) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [dateFormatter dateFromString: [[NSUserDefaults standardUserDefaults] valueForKey:@"CalenderDate_Selected"]];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date_correct_format = [dateFormatter stringFromDate:date];
        
        //here convert date in
        //------------ Call API for signup With Post Method --------------//
        
        
        //-------Option selection tab end------------
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&group_id=%@&date=%@&search=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],Group_id,date_correct_format,search.text]:[NSString stringWithFormat:@"%@retrivals/get_attendance_list",[Utilities API_link_url_subDomain]]];
        
        NSDictionary *responseDict = [responseString JSONValue];
        students_list = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        if ([[GroupsData valueForKey:@"status"] isEqualToString:@"true"]) {
            
            Updated_time.text = [NSString stringWithFormat:@"%@ %@ ",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Updated" value:@"" table:nil],[students_list valueForKey:@"updated_time"]];
            
            tickbelowtimelabel.text = [NSString stringWithFormat:@"%@", [students_list valueForKey:@"totalMarkedStudents"]];

            if([[students_list valueForKey:@"classStatus"]isEqualToString:@"true"]){
                CheckIfShowGroupTitles = TRUE;
            }
            else
            {
                CheckIfShowGroupTitles = FALSE;
            }
            
            [tableView_options setTag:111];
            
            [tableView_options reloadData];

        }else if([[GroupsData valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[GroupsData valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        
    }
    
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
    }
    
    search.text=@"";
    
     [refreshControl endRefreshing];
 [self mStopIndicater];
    
}
- (void) OptionsbtnToggleClick {
    if (!isShown) {
        
        OptionsListBox.frame =  CGRectMake(0,OptionsBox.frame.origin.y+OptionsBox.frame.size.height, self.view.frame.size.width, 0);
        [UIView animateWithDuration:0.25 animations:^{
            
            
            search.hidden=NO;

            
            OptionsListBox.frame =  CGRectMake(0,OptionsBox.frame.origin.y+OptionsBox.frame.size.height, self.view.frame.size.width, 140);
            
            
           
            
            ChildrensBox.frame  = CGRectMake(0,OptionsListBox.frame.origin.y+OptionsListBox.frame.size.height, self.view.frame.size.width, 40);
            
             ChildrensBoxOverlay.frame  = CGRectMake(0,1, self.view.frame.size.width-70, 38);
            totallabel.frame = CGRectMake(ChildrensBoxOverlay.frame.origin.x+ChildrensBoxOverlay.frame.size.width+1, OptionsListBox.frame.origin.y+OptionsListBox.frame.size.height+1 ,69, 38);
            
            [totalimageView setFrame:CGRectMake(totallabel.frame.origin.x+15, totallabel.frame.origin.y+10 , 23, 23)];
            tickbelowtimelabel.frame = CGRectMake(totalimageView.frame.origin.x+totalimageView.frame.size.width+5, totallabel.frame.origin.y+10 ,10, 20);
            
            
            tableView_options.frame= CGRectMake(0, ChildrensBox.frame.origin.y+ChildrensBox.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-(ChildrensBox.frame.origin.y+ChildrensBox.frame.size.height));
            
            
            search.frame = CGRectMake(0,OptionsListBox.frame.size.height-50, self.view.frame.size.width,50);
                                                
           OptionsbtnImage = [UIImage imageNamed:@"top_arrow_white.png"];
            [OptionsBoximageView setImage:OptionsbtnImage forState:UIControlStateNormal];
        }];
        isShown = true;
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            OptionsListBox.frame =  CGRectMake(0,OptionsBox.frame.origin.y+OptionsBox.frame.size.height, self.view.frame.size.width, 0);
            
             search.hidden=NO;
            
            ChildrensBox.frame  = CGRectMake(0,OptionsListBox.frame.origin.y+OptionsListBox.frame.size.height, self.view.frame.size.width, 40);
            ChildrensBoxOverlay.frame  = CGRectMake(0,1, self.view.frame.size.width-70, 38);
            totallabel.frame = CGRectMake(ChildrensBoxOverlay.frame.origin.x+ChildrensBoxOverlay.frame.size.width+1, OptionsListBox.frame.origin.y+OptionsListBox.frame.size.height+1 ,69, 38);
            
            [totalimageView setFrame:CGRectMake(totallabel.frame.origin.x+15, totallabel.frame.origin.y+10 , 23, 23)];
            tickbelowtimelabel.frame = CGRectMake(totalimageView.frame.origin.x+totalimageView.frame.size.width+5, totallabel.frame.origin.y+10 ,10, 20);
            
            tableView_options.frame = CGRectMake(0, ChildrensBox.frame.origin.y+ChildrensBox.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-(ChildrensBox.frame.origin.y+ChildrensBox.frame.size.height));
            
            OptionsbtnImage = [UIImage imageNamed:@"options_down_arrow.png"];
            [OptionsBoximageView setImage:OptionsbtnImage forState:UIControlStateNormal];
            
            
             search.frame = CGRectMake(0,0, self.view.frame.size.width,0);
            
        }];
        isShown = false;
    }
}
- (void)refresh:(UIRefreshControl *)refreshControl {
    
  [self performSelector:@selector(CallTheServer_get_attendance_list_API) withObject:nil afterDelay:0.5];
    
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
    if(tableView.tag==111)
    {
        return 80;
    }
    else
    {
        return 44;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [[students_list valueForKey:@"data"]count];
    if(tableView.tag==111){
        if(CheckIfShowGroupTitles==TRUE)
        {
            return [[[[students_list valueForKey:@"data"]valueForKey:@"list" ]objectAtIndex:section ] count];
        }
        else
        {
            return[[students_list valueForKey:@"data"] count];
        }
        
    }
    else{ return 2; }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag==111){
        
        if(CheckIfShowGroupTitles==TRUE)
        {
            return [[students_list valueForKey:@"data"]count];
        }
        
        else
        {
            return 1;
                
            }
    }
    
    else
    {
        return
        1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView.tag==111){
        
    if(CheckIfShowGroupTitles==TRUE)
    {
        return [[[[students_list valueForKey:@"data"] valueForKey:@"name" ]objectAtIndex:section]stringByConvertingHTMLToPlainText];
    }
    else
    {
        return nil;
    }
    }
    else
    {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
    if(tableView.tag==111){
    // Background color
    view.tintColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    header.textLabel.font = [UIFont boldSystemFontOfSize:14];
        
        
        [groupstudentcountlabel removeFromSuperview];
        
        //add individual class/group count
       groupstudentcountlabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-30, 3 ,20, 20)];
      
         groupstudentcountlabel.textColor = [UIColor whiteColor];
        groupstudentcountlabel.text = [NSString stringWithFormat:@"%@", [[[[students_list valueForKey:@"data"] valueForKey:@"markedStudents"]objectAtIndex:section]stringByConvertingHTMLToPlainText]];
        groupstudentcountlabel.textColor = [UIColor whiteColor];
        [groupstudentcountlabel setFont:[Font_Face_Controller opensansregular:15]];
        groupstudentcountlabel.textAlignment=NSTextAlignmentRight;
        [header addSubview:groupstudentcountlabel];
    //[header]
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSArray *views=[cell.contentView subviews];
    for(int i=0;i<[views count];i++)
    {
        UIView *tempView=[views objectAtIndex:i];
        [tempView removeFromSuperview];
        tempView = nil;
    }
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
  
    
    if(tableView.tag==111){
     if(CheckIfShowGroupTitles==TRUE){
    NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];//first get total rows in that section by current indexPath.
       
    UILabel *label;
    if(indexPath.row == totalRow -1){
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 1 ,self.view.frame.size.width-70, 78)];
    }else{
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 1 ,self.view.frame.size.width-70, 79)];
    }
    
    label.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    [cell.contentView addSubview:label];
    
    
    UILabel *userimage_background = [[UILabel alloc] initWithFrame:CGRectMake(10, label.frame.origin.y+5 , 67, 67)];
   userimage_background.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:121.0f/255.0f blue:31.0f/255.0f alpha:1.0];
         userimage_background.userInteractionEnabled=YES;
         
    [cell.contentView addSubview:userimage_background];
        
    //set User profile Image button
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setFrame:CGRectMake(14, label.frame.origin.y+9 , 59, 59)];
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@", [Utilities API_link_url_IMG], [[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"USR_image"]];
         
         
    [imageView sd_setImageWithURL:[NSURL URLWithString:stringUrl] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
         
         
         
   
        
        
        if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color1"]){
            imageView.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
        }else if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color2"]){
            imageView.backgroundColor = [UIColor colorWithRed:90.0f/255.0f green:187.0f/255.0f blue:94.0f/255.0f alpha:1.0];
        }else if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color3"]){
            imageView.backgroundColor = [UIColor colorWithRed:47.0f/255.0f green:188.0f/255.0f blue:208.0f/255.0f alpha:1.0];
        }else if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color4"]){
            imageView.backgroundColor = [UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
        }else if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color5"]){
            imageView.backgroundColor = [UIColor colorWithRed:136.0f/255.0f green:99.0f/255.0f blue:169.0f/255.0f alpha:1.0];
        }else if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color6"]){
            imageView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:116.0f/255.0f blue:169.0f/255.0f alpha:1.0];
        }else if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color7"]){
            imageView.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:90.0f/255.0f blue:107.0f/255.0f alpha:1.0];
        }
        

    [cell.contentView addSubview:imageView];
    
    UIButton *imageViewbtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [imageViewbtn setFrame:CGRectMake(14, label.frame.origin.y+9 , 59, 59)];
    [imageViewbtn setTitle:nil forState: UIControlStateNormal];
    [imageViewbtn addTarget:self action:@selector(action_OpenUserProfileView) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:imageViewbtn];
    
    
    //add user name text
    UILabel *usernamelabel = [[UILabel alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+15, label.frame.origin.y+15 ,label.frame.size.width-98, 20)];
        NSString *stringUsername = [NSString stringWithFormat:@"%@ %@", [[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"USR_FirstName"]stringByConvertingHTMLToPlainText], [[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"USR_LastName"]stringByConvertingHTMLToPlainText]];
        usernamelabel.text = stringUsername;
    usernamelabel.textColor = [UIColor whiteColor];
    [usernamelabel setFont:[Font_Face_Controller opensanssemibold:18]];
    usernamelabel.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:usernamelabel];
    
    
    
    //add time frame range text
    UILabel *starttimelabel = [[UILabel alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+15, label.frame.origin.y+48 ,38, 20)];
           [starttimelabel setFont:[Font_Face_Controller opensansLight:15]];
         starttimelabel.textAlignment=NSTextAlignmentLeft;
         
         if (![[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"left_status"]isEqualToString:@"3"]) {
             
               starttimelabel.text = [[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"std_left_time"];
             if([[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"std_left_time_red"] isEqualToString:@"true"]){
                 
                 
                 starttimelabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:83.0f/255.0f blue:85.0f/255.0f alpha:1.0];
                 
                 
             }else{
                 starttimelabel.textColor = [UIColor whiteColor];
             }

             
         }
         else
         {
             
             starttimelabel.frame = CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+15, label.frame.origin.y+48 ,100, 20);
             
              starttimelabel.textAlignment=NSTextAlignmentCenter;
             
               [starttimelabel setFont:[Font_Face_Controller opensanssemibold:15]];
             starttimelabel.textColor=[UIColor whiteColor];
               starttimelabel.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent" value:@"" table:nil];
         }
         
     
    
    [cell.contentView addSubview:starttimelabel];
    
    
    //add time frame range text
    UILabel *minustimelabel = [[UILabel alloc] initWithFrame:CGRectMake(starttimelabel.frame.origin.x+starttimelabel.frame.size.width+5, label.frame.origin.y+48 ,5, 20)];
    
    minustimelabel.textColor = [UIColor whiteColor];
    [minustimelabel setFont:[Font_Face_Controller opensansregular:15]];
    minustimelabel.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:minustimelabel];
    
    
    //add time frame range text
    UILabel *endtimelabel = [[UILabel alloc] initWithFrame:CGRectMake(minustimelabel.frame.origin.x+minustimelabel.frame.size.width+5, label.frame.origin.y+48 ,38, 20)];
         
         
          if (![[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"left_status"]isEqualToString:@"3"]) {
         minustimelabel.text = @"-";
         
    endtimelabel.text = [[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"std_retrieval_time"];
         
         
    if([[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row] valueForKey:@"std_retrieve_time_red"] isEqualToString:@"true"]){
        endtimelabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:83.0f/255.0f blue:85.0f/255.0f alpha:1.0];
    }else{
        endtimelabel.textColor = [UIColor whiteColor];
    }
              
          }
         
         else
         {
             minustimelabel.text = @"";
         }
         
    [endtimelabel setFont:[Font_Face_Controller opensansLight:15]];
    endtimelabel.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:endtimelabel];
         
         
         
         
    
    if([[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row] valueForKey:@"absent_desc"] isEqualToString:@"true"]){
    //set Absent Note Image button
    UIButton *absentnoteimageView = [UIButton buttonWithType: UIButtonTypeCustom];
    [absentnoteimageView setFrame:CGRectMake(label.frame.size.width-60, label.frame.origin.y+48 , 20, 20)];
        [absentnoteimageView setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        
        
      

        
        absentnoteimageView.tag=[[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row] valueForKey:@"User"] valueForKey:@"id"]integerValue];
        
        
        [absentnoteimageView setTitle: [[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row] valueForKey:@"User"] valueForKey:@"image_bgcolor"] forState: UIControlStateNormal];
        

            
        UIImage *absentnotebtnImage;
        if([[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row] valueForKey:@"leave_type"]isEqualToString:@"sick"]){
            absentnotebtnImage = [UIImage imageNamed:@"sickleave.png"];
        }else if([[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row] valueForKey:@"leave_type"]isEqualToString:@"leave"]){
            absentnotebtnImage = [UIImage imageNamed:@"vacation.png"];
        }else if([[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row] valueForKey:@"leave_type"]isEqualToString:@"other"]){
            absentnotebtnImage = [UIImage imageNamed:@"retrieval_note.png"];
        }
    
    [absentnoteimageView setImage:absentnotebtnImage forState:UIControlStateNormal];
        [absentnoteimageView addTarget:self action:@selector(action_OpenAbsentNoteView:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:absentnoteimageView];
    }
    
    if([[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row] valueForKey:@"retriever_desc"] isEqualToString:@"true"]){
    //set Retrieval Note Image button
    UIButton *retrievalnoteimageView = [UIButton buttonWithType: UIButtonTypeCustom];
    [retrievalnoteimageView setFrame:CGRectMake(label.frame.size.width-30, label.frame.origin.y+48 , 20, 20)];
        [retrievalnoteimageView setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        
        
        
        retrievalnoteimageView.tag=[[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row] valueForKey:@"User"] valueForKey:@"id"]integerValue];
        
        [retrievalnoteimageView setTitle: [[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"] forState: UIControlStateNormal];
        
        
    UIImage *retrievalnotebtnImage = [UIImage imageNamed:@"vanner.png"];
    [retrievalnoteimageView setImage:retrievalnotebtnImage forState:UIControlStateNormal];
        [retrievalnoteimageView addTarget:self action:@selector(action_OpenRetrieverNoteView:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:retrievalnoteimageView];
    }
    
    
    //------------------------tick area start-------------------///////
    UILabel *ticklabel = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x+label.frame.size.width+1, 1 ,69, 78)];
    ticklabel.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    [cell.contentView addSubview:ticklabel];
        
    
    if([[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row] valueForKey:@"mark"] isEqualToString:@"true"]){
        
    //set Tick Image button
    UIImageView *tickimageView = [[UIImageView alloc]init];
    [tickimageView setFrame:CGRectMake(ticklabel.frame.origin.x+23, ticklabel.frame.origin.y+15 , 23, 23)];
    tickimageView.image = [UIImage imageNamed:@"tick1.png"];
    [cell.contentView addSubview:tickimageView];
        
    //add time below tick text
    UILabel *tickbelowtimelabelss = [[UILabel alloc] initWithFrame:CGRectMake(ticklabel.frame.origin.x+15.5, ticklabel.frame.origin.y+48 ,45, 20)];
    tickbelowtimelabelss.text = [[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"student_retrival_timing"] valueForKey:@"marked_time"];
    tickbelowtimelabelss.textColor = [UIColor whiteColor];
    [tickbelowtimelabelss setFont:[Font_Face_Controller opensansregular:15]];
    tickbelowtimelabelss.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:tickbelowtimelabelss];
    }
         
         
    else
    {
        if (!([[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"student_retrival_timing"]count]==0)) {
            
            //add time below tick text
            UILabel *tickbelowtimelabels = [[UILabel alloc] initWithFrame:CGRectMake(ticklabel.frame.origin.x+15.5, ticklabel.frame.origin.y+48 ,45, 20)];
            tickbelowtimelabels.text = [[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"student_retrival_timing"] valueForKey:@"marked_time"];
            tickbelowtimelabels.textColor = [UIColor whiteColor];
            [tickbelowtimelabels setFont:[Font_Face_Controller opensansregular:15]];
            tickbelowtimelabels.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:tickbelowtimelabels];
        }
        else
        {
            
        }
        
        
        
    }
         
        UIButton *MarkTickbtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [MarkTickbtn setFrame:CGRectMake(label.frame.origin.x+label.frame.size.width+1, 1 ,69, 79)];
        [MarkTickbtn setTitle:[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row] valueForKey:@"mark"] forState: UIControlStateNormal];
        MarkTickbtn.tag =  [[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"id"] integerValue];
        [MarkTickbtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [MarkTickbtn addTarget:self action:@selector(action_TickMarkAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:MarkTickbtn];
        
        
    //------------------------tick area end-------------------///////
         
     }else{
         NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];//first get total rows in that section by current indexPath.
         //NSLog(@"%ld", (long)totalRow);
         UILabel *label;
         if(indexPath.row == totalRow -1){
             label = [[UILabel alloc] initWithFrame:CGRectMake(0, 1 ,self.view.frame.size.width-70, 78)];
         }else{
             label = [[UILabel alloc] initWithFrame:CGRectMake(0, 1 ,self.view.frame.size.width-70, 79)];
         }
         
         
         label.userInteractionEnabled=YES;
         
         label.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
         [cell.contentView addSubview:label];
         
         
         UILabel *userimage_background = [[UILabel alloc] initWithFrame:CGRectMake(10, label.frame.origin.y+5 , 67, 67)];
         userimage_background.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:121.0f/255.0f blue:31.0f/255.0f alpha:1.0];
         
           userimage_background.userInteractionEnabled=YES;
         [cell.contentView addSubview:userimage_background];
         
         //set User profile Image button
         UIImageView *imageView = [[UIImageView alloc]init];
         [imageView setFrame:CGRectMake(14, label.frame.origin.y+9 , 59, 59)];
         NSString *stringUrl = [NSString stringWithFormat:@"%@%@", [Utilities API_link_url_IMG], [[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"USR_image"]];
          imageView.userInteractionEnabled=YES;
         
         [imageView sd_setImageWithURL:[NSURL URLWithString:stringUrl] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
         
         
         if([[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color1"]){
             imageView.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
         }else if([[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color2"]){
             imageView.backgroundColor = [UIColor colorWithRed:90.0f/255.0f green:187.0f/255.0f blue:94.0f/255.0f alpha:1.0];
         }else if([[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color3"]){
             imageView.backgroundColor = [UIColor colorWithRed:47.0f/255.0f green:188.0f/255.0f blue:208.0f/255.0f alpha:1.0];
         }else if([[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color4"]){
             imageView.backgroundColor = [UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
         }else if([[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color5"]){
             imageView.backgroundColor = [UIColor colorWithRed:136.0f/255.0f green:99.0f/255.0f blue:169.0f/255.0f alpha:1.0];
         }else if([[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color6"]){
             imageView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:116.0f/255.0f blue:169.0f/255.0f alpha:1.0];
         }else if([[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color7"]){
             imageView.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:90.0f/255.0f blue:107.0f/255.0f alpha:1.0];
         }
         
         
         [cell.contentView addSubview:imageView];
         
         UIButton *imageViewbtn = [UIButton buttonWithType: UIButtonTypeCustom];
         [imageViewbtn setFrame:CGRectMake(14, label.frame.origin.y+9 , 59, 59)];
         [imageViewbtn setTitle:nil forState: UIControlStateNormal];
         [imageViewbtn addTarget:self action:@selector(action_OpenUserProfileView) forControlEvents:UIControlEventTouchUpInside];
         [cell.contentView addSubview:imageViewbtn];
         
         
         //add user name text
         UILabel *usernamelabel = [[UILabel alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+15, label.frame.origin.y+15 ,label.frame.size.width-98, 20)];
         NSString *stringUsername = [NSString stringWithFormat:@"%@ %@", [[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"USR_FirstName"], [[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"USR_LastName"]];
         usernamelabel.text = stringUsername;
         usernamelabel.textColor = [UIColor whiteColor];
         [usernamelabel setFont:[Font_Face_Controller opensanssemibold:18]];
         usernamelabel.textAlignment=NSTextAlignmentLeft;
         [cell.contentView addSubview:usernamelabel];
         
         
         
         //add time frame range text
         UILabel *starttimelabel = [[UILabel alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+15, label.frame.origin.y+48 ,38, 20)];
         [starttimelabel setFont:[Font_Face_Controller opensansLight:15]];
         starttimelabel.textAlignment=NSTextAlignmentLeft;
          if (![[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"left_status"]isEqualToString:@"3"]) {
         
         starttimelabel.text = [[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"std_left_time"];
         if([[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"std_left_time_red"] isEqualToString:@"true"]){
             
             starttimelabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:83.0f/255.0f blue:85.0f/255.0f alpha:1.0];
         }else{
             starttimelabel.textColor = [UIColor whiteColor];
         }
          }
         else
         {
          
             
              starttimelabel.frame = CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+15, label.frame.origin.y+48 ,100, 20);

             
             starttimelabel.textColor=[UIColor whiteColor];
             starttimelabel.textAlignment=NSTextAlignmentCenter;
             
             [starttimelabel setFont:[Font_Face_Controller opensanssemibold:15]];
             starttimelabel.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent" value:@"" table:nil];
         }
         
         
         
        
         [cell.contentView addSubview:starttimelabel];
         
         
         //add time frame range text
         UILabel *minustimelabel = [[UILabel alloc] initWithFrame:CGRectMake(starttimelabel.frame.origin.x+starttimelabel.frame.size.width+5, label.frame.origin.y+48 ,5, 20)];
         minustimelabel.textColor = [UIColor whiteColor];
         [minustimelabel setFont:[Font_Face_Controller opensansregular:15]];
         minustimelabel.textAlignment=NSTextAlignmentLeft;
         [cell.contentView addSubview:minustimelabel];
         
         
         //add time frame range text
         UILabel *endtimelabel = [[UILabel alloc] initWithFrame:CGRectMake(minustimelabel.frame.origin.x+minustimelabel.frame.size.width+5, label.frame.origin.y+48 ,38, 20)];
         
          if (![[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"left_status"]isEqualToString:@"3"]) {
          minustimelabel.text = @"-";
         
         endtimelabel.text = [[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"std_retrieval_time"];
         if([[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"std_retrieve_time_red"] isEqualToString:@"true"]){
             endtimelabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:83.0f/255.0f blue:85.0f/255.0f alpha:1.0];
         }else{
             endtimelabel.textColor = [UIColor whiteColor];
         }
              
             
              
          }
         else
         {
              minustimelabel.text = @"";
         }
         [endtimelabel setFont:[Font_Face_Controller opensansLight:15]];
         endtimelabel.textAlignment=NSTextAlignmentLeft;
         [cell.contentView addSubview:endtimelabel];
         
         if([[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"absent_desc"] isEqualToString:@"true"]){
             //set Absent Note Image button
             UIButton *absentnoteimageView = [UIButton buttonWithType: UIButtonTypeCustom];
             [absentnoteimageView setFrame:CGRectMake(label.frame.size.width-60, label.frame.origin.y+48 , 20, 20)];
             [absentnoteimageView setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
             
             
             absentnoteimageView.tag=[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"User"] valueForKey:@"id"]integerValue];
             
             [absentnoteimageView setTitle: [[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"User"] valueForKey:@"image_bgcolor"] forState: UIControlStateNormal];

             
             
             UIImage *absentnotebtnImage;
             if([[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"leave_type"]isEqualToString:@"sick"]){
                 absentnotebtnImage = [UIImage imageNamed:@"sickleave.png"];
             }else if([[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"leave_type"]isEqualToString:@"leave"]){
                 absentnotebtnImage = [UIImage imageNamed:@"vacation.png"];
             }else if([[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"leave_type"]isEqualToString:@"other"]){
                 absentnotebtnImage = [UIImage imageNamed:@"retrieval_note.png"];
             }
             
             [absentnoteimageView setImage:absentnotebtnImage forState:UIControlStateNormal];
             [absentnoteimageView addTarget:self action:@selector(action_OpenAbsentNoteView:) forControlEvents:UIControlEventTouchUpInside];
             [cell.contentView addSubview:absentnoteimageView];
         }
         
         if([[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"retriever_desc"] isEqualToString:@"true"]){
             //set Retrieval Note Image button
             UIButton *retrievalnoteimageView = [UIButton buttonWithType: UIButtonTypeCustom];
             [retrievalnoteimageView setFrame:CGRectMake(label.frame.size.width-30, label.frame.origin.y+48 , 20, 20)];
             [retrievalnoteimageView setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
             
             
             
             retrievalnoteimageView.tag=[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"User"] valueForKey:@"id"]integerValue];
             
             [retrievalnoteimageView setTitle: [[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"] forState: UIControlStateNormal];
             
             
            
             UIImage *retrievalnotebtnImage = [UIImage imageNamed:@"vanner.png"];
             [retrievalnoteimageView setImage:retrievalnotebtnImage forState:UIControlStateNormal];
             [retrievalnoteimageView addTarget:self action:@selector(action_OpenRetrieverNoteView:) forControlEvents:UIControlEventTouchUpInside];
             [cell.contentView addSubview:retrievalnoteimageView];
         }
         
         
         //------------------------tick area start-------------------///////
         UILabel *ticklabel = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x+label.frame.size.width+1, 1 ,69, 78)];
         ticklabel.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
         [cell.contentView addSubview:ticklabel];
         
         
         if([[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"mark"] isEqualToString:@"true"]){
             //set Tick Image button
             UIImageView *tickimageView = [[UIImageView alloc]init];
             [tickimageView setFrame:CGRectMake(ticklabel.frame.origin.x+23, ticklabel.frame.origin.y+15 , 23, 23)];
             tickimageView.image = [UIImage imageNamed:@"tick1.png"];
             [cell.contentView addSubview:tickimageView];
             
             //add time below tick text
             UILabel *tickbelowtimelabels = [[UILabel alloc] initWithFrame:CGRectMake(ticklabel.frame.origin.x+15.5, ticklabel.frame.origin.y+48 ,45, 20)];
             tickbelowtimelabels.text = [[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"student_retrival_timing"] valueForKey:@"marked_time"];
             tickbelowtimelabels.textColor = [UIColor whiteColor];
             [tickbelowtimelabels setFont:[Font_Face_Controller opensansregular:15]];
             tickbelowtimelabels.textAlignment=NSTextAlignmentLeft;
             [cell.contentView addSubview:tickbelowtimelabels];
         }
         else
         {
             if (!([[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"student_retrival_timing"]count]==0)) {
           
                 //add time below tick text
                 UILabel *tickbelowtimelabels = [[UILabel alloc] initWithFrame:CGRectMake(ticklabel.frame.origin.x+15.5, ticklabel.frame.origin.y+48 ,45, 20)];
                 tickbelowtimelabels.text = [[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"student_retrival_timing"] valueForKey:@"marked_time"];
                 tickbelowtimelabels.textColor = [UIColor whiteColor];
                 [tickbelowtimelabels setFont:[Font_Face_Controller opensansregular:15]];
                 tickbelowtimelabels.textAlignment=NSTextAlignmentLeft;
                 [cell.contentView addSubview:tickbelowtimelabels];
             }
             else
             {
                 
             }
             
             
             
         }
         UIButton *MarkTickbtn = [UIButton buttonWithType: UIButtonTypeCustom];
         [MarkTickbtn setFrame:CGRectMake(label.frame.origin.x+label.frame.size.width+1, 1 ,69, 79)];
         [MarkTickbtn setTitle:[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"mark"] forState: UIControlStateNormal];
         MarkTickbtn.tag =  [[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"id"] integerValue];
         [MarkTickbtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
         [MarkTickbtn addTarget:self action:@selector(action_TickMarkAction:) forControlEvents:UIControlEventTouchUpInside];
         [cell.contentView addSubview:MarkTickbtn];
         
     }
    }else{
        //add label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2 ,self.view.frame.size.width, 40)];
        label.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
        [cell.contentView addSubview:label];
        
        //set absentnote image
        UIImageView *absentnoteimageView = [[UIImageView alloc]init];
        if(indexPath.row==0){ absentnoteimageView.frame=CGRectMake(15, 13 , 40, 40); }
        else if(indexPath.row==1){ absentnoteimageView.frame=CGRectMake(15, 13 , 40, 40); }
        //else{ absentnoteimageView.frame=CGRectMake(15, 15 , 18, 18); }
        UIImage *absentnotebtnImage;
        if(indexPath.row==0){ absentnotebtnImage = [UIImage imageNamed:@"retrieval_times.png"];
        }else if(indexPath.row==1){ absentnotebtnImage = [UIImage imageNamed:@"Attendance_List.png"]; }
        //else if(indexPath.row==2){ absentnotebtnImage = [UIImage imageNamed:@"notehistory.png"]; }
        [absentnoteimageView setImage:absentnotebtnImage];
        [cell.contentView addSubview:absentnoteimageView];
        
        //add list title text
        UILabel *listtitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(absentnoteimageView.frame.origin.x+absentnoteimageView.frame.size.width+15, 12 ,self.view.frame.size.width-100, 22)];
        if(indexPath.row==0){ listtitlelabel.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule attendance" value:@"" table:nil];
        }else if(indexPath.row==1){ listtitlelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Attendance overview" value:@"" table:nil]; }
        //else if(indexPath.row==2){ listtitlelabel.text = @"Note history"; }
        
        listtitlelabel.textColor = [UIColor whiteColor];
        [listtitlelabel setFont:[Font_Face_Controller opensansregular:18]];
        listtitlelabel.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:listtitlelabel];
        
        //set right arrow image
        UIImageView *rightarrowimageView = [[UIImageView alloc]init];
        rightarrowimageView.frame=CGRectMake(self.view.frame.size.width-32, 14 , 15, 15);
        UIImage *rightarrowbtnImage = [UIImage imageNamed:@"right_arrow_white.png"];
        [rightarrowimageView setImage:rightarrowbtnImage];
        [cell.contentView addSubview:rightarrowimageView];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}





-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
       
    
    if(tableView.tag==111){
        profile *objprofile=[[profile alloc]init];
        
        
        
        if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color1"]){
            objprofile.color = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
        }else if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color2"]){
            objprofile.color  = [UIColor colorWithRed:90.0f/255.0f green:187.0f/255.0f blue:94.0f/255.0f alpha:1.0];
        }else if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color3"]){
           objprofile.color  = [UIColor colorWithRed:47.0f/255.0f green:188.0f/255.0f blue:208.0f/255.0f alpha:1.0];
        }else if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color4"]){
           objprofile.color  = [UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
        }else if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color5"]){
            objprofile.color  = [UIColor colorWithRed:136.0f/255.0f green:99.0f/255.0f blue:169.0f/255.0f alpha:1.0];
        }else if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color6"]){
            objprofile.color  = [UIColor colorWithRed:236.0f/255.0f green:116.0f/255.0f blue:169.0f/255.0f alpha:1.0];
        }else if([[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"image_bgcolor"]isEqualToString:@"color7"]){
            objprofile.color  = [UIColor colorWithRed:241.0f/255.0f green:90.0f/255.0f blue:107.0f/255.0f alpha:1.0];
        }

//     [[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"USR_FirstName"]   
        
        
        objprofile.date_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
        
        
        if(CheckIfShowGroupTitles==TRUE){
            
            
            objprofile.Dropoff_str=[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"std_left_time"]
            ;
            
            objprofile.Retrieval_str=[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"std_retrieval_time"];
            

            
            
            
            
            [[NSUserDefaults standardUserDefaults]setValue:[[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"id"] forKey:@"student_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@ %@", [[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"USR_FirstName"], [[[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.section] valueForKey:@"list"]objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"USR_LastName"]] forKey:@"student_name"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }else{
            
            
            
            objprofile.Dropoff_str=[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"std_left_time"]
            ;
            
            objprofile.Retrieval_str=[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"std_retrieval_time"];

            
            [[NSUserDefaults standardUserDefaults]setValue:[[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"id"] forKey:@"student_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@ %@", [[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"USR_FirstName"], [[[[students_list valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"User"] valueForKey:@"USR_LastName"]] forKey:@"student_name"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        [self.navigationController pushViewController:objprofile animated:YES];
    }
    
    else
    {
        
        if (indexPath.row==0) {
          
            
            Schedule_Dropoff_Retrieval_times *objAttendance_overview=[[Schedule_Dropoff_Retrieval_times alloc]init];
            
           
            [self.navigationController pushViewController:objAttendance_overview animated:YES];
            
        }
        
       else if (indexPath.row==1) {
            
            Attendance_overview *objAttendance_overview=[[Attendance_overview alloc]init];
            
            objAttendance_overview.date_value=selected_date_btn.text;
            [self.navigationController pushViewController:objAttendance_overview animated:YES];

            
        }
        else
        {
            
        }
        
        
        
        
    }
}
- (void) action_TickMarkAction: (UIButton *)sender{
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag] forKey:@"Tag"];
     [dict setValue:sender.currentTitle forKey:@"titile"];
    
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Mark_API:) withObject:dict afterDelay:0.5];
    
}

#pragma mark - -*********************
#pragma mark Call API All_Groups Method
#pragma mark - -*********************

-(void)CallTheServer_Mark_API:(NSMutableDictionary *)Dictvalue
{
    if ([API connectedToInternet]==YES) {
        
             //------------ Call API for signup With Post Method --------------//
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&date=%@&student_id=%@&current_status=%@&group_id=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],selected_date_btn.text,[Dictvalue valueForKey:@"Tag"],[Dictvalue valueForKey:@"titile"],Group_id]:[NSString stringWithFormat:@"%@retrivals/mark_student",[Utilities API_link_url_subDomain]]];
        
        NSDictionary *responseDict = [responseString JSONValue];
        students_list = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        NSLog(@"%@",responseDict);
        
        if ([[students_list valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
                       tickbelowtimelabel.text = [NSString stringWithFormat:@"%@", [students_list valueForKey:@"totalMarkedStudents"]];
                      // [tableView reloadData];

            if([[students_list valueForKey:@"classStatus"]isEqualToString:@"true"]){
                CheckIfShowGroupTitles = TRUE;
            }
            else
            {
                CheckIfShowGroupTitles = FALSE;
            }
            
            [tableView_options setTag:111];
            
            [tableView_options reloadData];

            
        }else if([[students_list valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[GroupsData valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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
    
   // Group_id = [self.downPicker text];
    
   
    NSString *id_value=[GroupSelectionDropDownListIdArray objectAtIndex:[[[NSUserDefaults standardUserDefaults]valueForKey:@"index"]integerValue]];
    
    [[NSUserDefaults standardUserDefaults]setValue:id_value forKey:@"id_group"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
    
    Group_id=id_value;
    
//    [[NSUserDefaults standardUserDefaults] setValue:id_value forKey:@"GroupSelectionDropDownListArray_Selected"];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_attendance_list_API) withObject:nil afterDelay:0.5];
}

- (void)createDateFormatter {
    
  //    datepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 200)];
//    datepicker.backgroundColor = [UIColor whiteColor];
//    datepicker.datePickerMode = UIDatePickerModeDate;
//    
//    [datepicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:datepicker];
    
}
- (void) dateChanged:(id)sender{
    // handle date changes
    UIDatePicker *picker = (UIDatePicker *)sender;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *date_correct_format = [dateFormatter stringFromDate:[picker date]];
     [[NSUserDefaults standardUserDefaults] setValue:date_correct_format forKey:@"CalenderDate_Selected"];
    
    
    selected_date_btn.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
   // [selected_date_btn setTitle:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"] forState: UIControlStateNormal];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_attendance_list_API) withObject:nil afterDelay:0.5];
}
- (void) dateChangedNext{
    // handle next date changes
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date_to_be_incremented = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]];
    
    int daysToAdd = 1;
    NSDate *updated_date = [date_to_be_incremented dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    NSString *date_correct_format = [dateFormatter stringFromDate:updated_date];
    [[NSUserDefaults standardUserDefaults] setValue:date_correct_format forKey:@"CalenderDate_Selected"];
    
    
     selected_date_btn.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
    //[selected_date_btn setTitle:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"] forState: UIControlStateNormal];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_attendance_list_API) withObject:nil afterDelay:0.5];
}
- (void) dateChangedPrevious{
    // handle previous date changes
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date_to_be_incremented = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]];
    
    int daysToAdd = -1;
    NSDate *updated_date = [date_to_be_incremented dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    NSString *date_correct_format = [dateFormatter stringFromDate:updated_date];
    [[NSUserDefaults standardUserDefaults] setValue:date_correct_format forKey:@"CalenderDate_Selected"];
    
    
     selected_date_btn.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
   // [selected_date_btn setTitle:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"] forState: UIControlStateNormal];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_get_attendance_list_API) withObject:nil afterDelay:0.5];
}


-(void) action_OpenAbsentNoteView: (UIButton *)sender{
    
  
    
   [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag]forKey:@"student_id"];
    absent_note *objabsent_note = [[absent_note alloc]init];
    objabsent_note.date_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
   [self.navigationController pushViewController:objabsent_note animated:YES];
        
    if([sender.currentTitle isEqualToString:@"color1"]){
        
        objabsent_note.color = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    }else if([sender.currentTitle isEqualToString:@"color2"]){
        
        objabsent_note.color = [UIColor colorWithRed:90.0f/255.0f green:187.0f/255.0f blue:94.0f/255.0f alpha:1.0];
    }else if([sender.currentTitle isEqualToString:@"color3"]){
        
        objabsent_note.color= [UIColor colorWithRed:47.0f/255.0f green:188.0f/255.0f blue:208.0f/255.0f alpha:1.0];
    }else if([sender.currentTitle isEqualToString:@"color4"]){
        
        objabsent_note.color = [UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
    }else if([sender.currentTitle isEqualToString:@"color5"]){
        
        objabsent_note.color = [UIColor colorWithRed:136.0f/255.0f green:99.0f/255.0f blue:169.0f/255.0f alpha:1.0];
    }else if([sender.currentTitle isEqualToString:@"color6"]){
        
        objabsent_note.color = [UIColor colorWithRed:236.0f/255.0f green:116.0f/255.0f blue:169.0f/255.0f alpha:1.0];
    }else if([sender.currentTitle isEqualToString:@"color7"]){
        
        objabsent_note.color = [UIColor colorWithRed:241.0f/255.0f green:90.0f/255.0f blue:107.0f/255.0f alpha:1.0];
    }

    
    
    
}

-(void) action_OpenRetrieverNoteView: (UIButton *)sender{
      retrieval_note *objretriever_note = [[retrieval_note alloc]init];
    
     [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag] forKey:@"student_id"];
    
    objretriever_note.date_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
    
    
    if([sender.currentTitle isEqualToString:@"color1"]){
        
        objretriever_note.color = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    }else if([sender.currentTitle isEqualToString:@"color2"]){
        
        objretriever_note.color = [UIColor colorWithRed:90.0f/255.0f green:187.0f/255.0f blue:94.0f/255.0f alpha:1.0];
    }else if([sender.currentTitle isEqualToString:@"color3"]){
        
        objretriever_note.color= [UIColor colorWithRed:47.0f/255.0f green:188.0f/255.0f blue:208.0f/255.0f alpha:1.0];
    }else if([sender.currentTitle isEqualToString:@"color4"]){
        
        objretriever_note.color = [UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
    }else if([sender.currentTitle isEqualToString:@"color5"]){
        
        objretriever_note.color = [UIColor colorWithRed:136.0f/255.0f green:99.0f/255.0f blue:169.0f/255.0f alpha:1.0];
    }else if([sender.currentTitle isEqualToString:@"color6"]){
        
       objretriever_note.color = [UIColor colorWithRed:236.0f/255.0f green:116.0f/255.0f blue:169.0f/255.0f alpha:1.0];
    }else if([sender.currentTitle isEqualToString:@"color7"]){
        
        objretriever_note.color = [UIColor colorWithRed:241.0f/255.0f green:90.0f/255.0f blue:107.0f/255.0f alpha:1.0];
    }
  
        [self.navigationController pushViewController:objretriever_note animated:YES];
}


-(void)datePickerView
{
     [datepicker removeFromSuperview];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [datepicker removeFromSuperview];
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
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

@end
