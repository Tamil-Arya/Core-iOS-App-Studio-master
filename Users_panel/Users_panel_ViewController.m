//
//  Users_panel_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 19/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Users_panel_ViewController.h"
#import "Font_Face_Controller.h"
#import "UIImageView+WebCache.h"
#import "Utilities.h"
#import "EDU_Blog_Home_screen_ViewController.h"
#import "Text_color_.h"
#import "NEWS_Blog_Home_screen_ViewController.h"
#import "ELR_loaders_.h"
#import "Single_Post_ViewController.h"
#import "Single_NEWS_Post_ViewController.h"
#import "retrieval_list_home.h"
#import "Child_Component.h"
#import "add_absent_note.h"
#import "add_retriever_note.h"
#import "Child_Information.h"
#import "retrieval_note.h"
#import "absent_note.h"
#import "NSString+FontAwesome.h"
#import "Child_Information.h"
#import "ViewFoodMenuPdfViewController.h"
#import "ShowWebviewViewController.h"

#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "NSString+HTML.h"
#import "Single_absent_note_Notification.h"
#import "Single_retriever_note_Notifications.h"
#import "AddFoodNotesViewController.h"
#import "ForumWebViewViewController.h"
#import "EduStepPlannerWebViewController.h"
#import "ProgressTableWebViewController.h"
#import "TodaysNoteViewController.h"
#import "EduBlogWebViewController.h"
#import "NewsBlogWebViewController.h"
#import "QuizManagerWebViewController.h"
#import "Message_Manager_WebViewController.h"
#import "Edublog_Statistics_WebViewController.h"
#import "Retrieval_Statistics_WebViewController.h"
#import "Contact_Information_WebViewController.h"
#import "School_Information_WebViewController.h"
#import "PortfolioWebViewController.h"
#import "Evaluation_Matrix_WebViewController.h"
#import "Course_Video_WebViewController.h"
#import "Examination_WebViewController.h"
#import "Quiz_Editor_WebViewController.h"
#import "Survey_Forms_WebViewController.h"
#import "Retrieval_List_WebViewController.h"
#import "Recovery_Notes_WebViewController.h"
#import "TodaysNoteWebViewController.h"
#import "AbsenceNoteWebViewController.h"
#import "WeekListViewController.h"
#import "SmartNotes_WebViewController.h"
#import "LocationWebViewController.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"
@interface Users_panel_ViewController ()


@end

@implementation Users_panel_ViewController
@synthesize dropOff_time;
@synthesize Retival_time;
@synthesize User_name;

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


- (void) REfress_User_panel:(NSNotification *) notification
{
    
    [self Navigation_bar];
    
    dispatch_async(dispatch_get_main_queue(), ^ {
       // [_collectionView reloadData];
        
        
        
        NSLog(@"%@",mutableRetrievedDictionarys);
        
        
        
        if (![[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"drop_off_time"]isEqualToString:@""] && ![[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"retrieval_time"]isEqualToString:@""]) {
            
            if ([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"absent"]isEqualToString:@"true"]) {
                
                
                Show_msg.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent" value:@"" table:nil];
                
                
                
            }
            else
            {
                
                Todays_Dropoff_Time.text=[NSString stringWithFormat:@"%@ : %@",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Drop off" value:@"" table:nil],[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"drop_off_time"]];
                
                
                Todays_Retrival_Time.text=[NSString stringWithFormat:@"%@ : %@",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retrieval" value:@"" table:nil],[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"retrieval_time"]];
                
            }
            
            
        }
        else
        {
            
            
            
            if ([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"current_day"]isEqualToString:@"Sun"]) {
                
                
                
                Show_msg.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Sunday" value:@"" table:nil];
                
            }
            
        }

        
        
        
        [_collectionView reloadItemsAtIndexPaths:[_collectionView indexPathsForVisibleItems]];
        
        
    });
    
}





- (void) Single_NEWS_Post:(NSMutableDictionary *) notification
{
    
    NSLog(@"%@",notification);
    
    
    // NSMutableDictionary *dict = [[notification userInfo]objectForKey:@"object"];
    Single_NEWS_Post_ViewController *objSetting_ViewController=[[Single_NEWS_Post_ViewController alloc]init];
    objSetting_ViewController.array_all_detail=notification;
    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:objSetting_ViewController];
    
    [self presentViewController:HomeNavController animated:YES completion:nil];
}



- (void) Single_Post:(NSMutableDictionary *) notification
{
    
    NSLog(@"%@",notification);
    
    
   // NSMutableDictionary *dict = [[notification userInfo]objectForKey:@"object"];
    Single_Post_ViewController *objSetting_ViewController=[[Single_Post_ViewController alloc]init];
    objSetting_ViewController.array_all_detail=notification;
    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:objSetting_ViewController];
    
    [self presentViewController:HomeNavController animated:YES completion:nil];
}



- (void) Attendance_List:(NSMutableDictionary *) notification
{
    retrieval_list_home *obj_EDU_Blog_Home_screen_ViewController=[[retrieval_list_home alloc]init];
    
    [self.navigationController pushViewController:obj_EDU_Blog_Home_screen_ViewController animated:YES];

    
  }

- (void) retriever_note:(NSMutableDictionary *) notification
{
    
     NSLog(@"%@",notification);
    
    MainViewController *controller = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
//    [self.navigationController pushViewController:controller animated:YES];

//    Single_retriever_note_Notifications *objSetting_ViewController=[[Single_retriever_note_Notifications alloc]init];
//    objSetting_ViewController.array_all_detail=notification;
    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:controller];
    
    [self presentViewController:HomeNavController animated:YES completion:nil];

    
}

- (void) absent_note:(NSMutableDictionary *) notification
{
   NSLog(@"%@",notification);
    
    MainViewController *controller = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];

//    Single_absent_note_Notification *objSetting_ViewController=[[Single_absent_note_Notification alloc]init];
//    objSetting_ViewController.array_all_detail=notification;
    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:controller];
    
    [self presentViewController:HomeNavController animated:YES completion:nil];

}

- (void) forumView:(NSMutableDictionary *) notification
{
    NSLog(@"%@",notification);
    ForumWebViewViewController *objForum_Web_ViewController=[[ForumWebViewViewController alloc]initWithNibName:@"ForumWebViewViewController" bundle:nil];
    objForum_Web_ViewController.dictionaryFromNotification=notification;
    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:objForum_Web_ViewController];
    
    [self presentViewController:HomeNavController animated:YES completion:nil];
//    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:nil  message:[notification objectForKey:@"type"]  preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }]];
//    [self presentViewController:alertController animated:YES completion:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    componet=[[NSMutableDictionary alloc]init];
    
    componentArray = [[NSMutableArray alloc]init];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    Current_Date_STR=@"";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(REfress_User_panel:)
                                                 name:@"REfress_User_panel"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Single_NEWS_Post:)
                                                 name:@"Single_NEWS_Post"
                                               object:nil];
    
[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Single_Post:)
                                                 name:@"Single_Post"
                                               object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Attendance_List:)
                                                 name:@"Attendance_List"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(retriever_note:)
                                                 name:@"retriever_note"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(absent_note:)
                                                 name:@"absent_note"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(forumView:)
                                                 name:@"Forum_Notification"
                                               object:nil];

    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        
        
     

        //-------Calendar selection tab start------------
        
        previousdayBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 50, 50)];
        previousdayBox.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:232.0f/255.0f blue:232.0f/255.0f alpha:1.0];
        [self.view addSubview:previousdayBox];
        //set previous day button image
        previousdayBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [previousdayBtn setFrame:CGRectMake((previousdayBox.frame.size.width-40)/2, (previousdayBox.frame.size.height-40)/2 , 40, 40)];
        [previousdayBtn setTitle:nil forState: UIControlStateNormal];
        UIImage *previousdayImage = [UIImage imageNamed:@"previous_day.png"];
        [previousdayBtn setImage:previousdayImage forState:UIControlStateNormal];
        [previousdayBtn addTarget:self action:@selector(dateChangedPrevious) forControlEvents:UIControlEventTouchUpInside];
        [previousdayBox addSubview:previousdayBtn];
        
        CalenderSelectionBox  = [[UIView alloc] initWithFrame:CGRectMake(previousdayBox.frame.origin.x+previousdayBox.frame.size.width, 64, self.view.frame.size.width-100, 50)];
        CalenderSelectionBox.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:232.0f/255.0f blue:232.0f/255.0f alpha:1.0];
        
        //set left right border to calendar selection box
        CGSize mainViewSize = CalenderSelectionBox.bounds.size;
        CGFloat borderWidth = 1;
        UIColor *borderColor = [UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1.0];
        leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, borderWidth, mainViewSize.height)];
        rightView = [[UIView alloc] initWithFrame:CGRectMake(mainViewSize.width - borderWidth, 0, borderWidth, mainViewSize.height)];
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
        //selected_date_btn.backgroundColor=[UIColor whiteColor];
        [selected_date_btn setFrame:CGRectMake((CalenderSelectionBox.frame.size.width-110)/2, 5, 110, 18)];
        selected_date_btn.textColor=[UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0];
        
        selected_date_btn.font=[Font_Face_Controller opensanssemibold:18] ;
        [CalenderSelectionBox addSubview:selected_date_btn];
        
        
        
        datepicker=[[UIDatePicker alloc]init];
        datepicker.datePickerMode=UIDatePickerModeDate;
        [selected_date_btn setInputView:datepicker];
        
        toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        [toolBar setTintColor:[UIColor grayColor]];
        
        
        
        
        UIBarButtonItem *Cancel=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedCancel)];
        
        UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate)];
        UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBar setItems:[NSArray arrayWithObjects:Cancel,space,doneBtn, nil]];
        [selected_date_btn setInputAccessoryView:toolBar];
        
       nextdayBox  = [[UIView alloc] initWithFrame:CGRectMake(CalenderSelectionBox.frame.origin.x+CalenderSelectionBox.frame.size.width, 64, 50, 50)];
        nextdayBox.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:232.0f/255.0f blue:232.0f/255.0f alpha:1.0];
        [self.view addSubview:nextdayBox];
        //set next day button image
   nextdayBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [nextdayBtn setFrame:CGRectMake((nextdayBox.frame.size.width-40)/2, (nextdayBox.frame.size.height-40)/2 , 40, 40)];
        [nextdayBtn setTitle:nil forState: UIControlStateNormal];
        UIImage *nextdayImage = [UIImage imageNamed:@"next_day.png"];
        [nextdayBtn setImage:nextdayImage forState:UIControlStateNormal];
        [nextdayBtn addTarget:self action:@selector(dateChangedNext) forControlEvents:UIControlEventTouchUpInside];
        [nextdayBox addSubview:nextdayBtn];
        

        Show_msg=[[UILabel alloc]initWithFrame:CGRectMake(0, (selected_date_btn.frame.origin.y+selected_date_btn.frame.size.height), CalenderSelectionBox.frame.size.width,20)];
        Show_msg.textColor=[UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0];
        Show_msg.font=[Font_Face_Controller opensansregular:10];
        Show_msg.textAlignment=NSTextAlignmentCenter;
        [CalenderSelectionBox addSubview:Show_msg];
        
        
        
        
        Todays_Dropoff_Time=[[UILabel alloc]initWithFrame:CGRectMake(5, (selected_date_btn.frame.origin.y+selected_date_btn.frame.size.height)+5, (CalenderSelectionBox.frame.size.width-5)/2,20)];
        Todays_Dropoff_Time.textColor=[UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0];
        Todays_Dropoff_Time.font=[Font_Face_Controller opensansregular:10];
        Todays_Dropoff_Time.textAlignment=NSTextAlignmentLeft;
        [CalenderSelectionBox addSubview:Todays_Dropoff_Time];
        
        
        Todays_Retrival_Time=[[UILabel alloc]initWithFrame:CGRectMake((CalenderSelectionBox.frame.size.width-5)/2, (selected_date_btn.frame.origin.y+selected_date_btn.frame.size.height)+5, (CalenderSelectionBox.frame.size.width-5)/2,20)];
        Todays_Retrival_Time.textColor=[UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0];
        Todays_Retrival_Time.font=[Font_Face_Controller opensansregular:10];
        Todays_Retrival_Time.textAlignment=NSTextAlignmentRight;
        [CalenderSelectionBox addSubview:Todays_Retrival_Time];
        
        
        absent_note_IMG = [UIButton buttonWithType:UIButtonTypeCustom];
        [absent_note_IMG addTarget:self action:@selector(absent_note_IMG) forControlEvents:UIControlEventTouchUpInside];
        absent_note_IMG.frame=CGRectMake(CalenderSelectionBox.frame.size.width-30, 5 , 20, 20);
        [CalenderSelectionBox addSubview:absent_note_IMG];
        
        retrival_note_IMG = [UIButton buttonWithType:UIButtonTypeCustom];
        [retrival_note_IMG addTarget:self action:@selector(retrival_note_IMG) forControlEvents:UIControlEventTouchUpInside];
        retrival_note_IMG.frame=CGRectMake(CalenderSelectionBox.frame.size.width-60, 5 , 20, 20);
      
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, CalenderSelectionBox.frame.size.height+64, [[UIScreen mainScreen]bounds].size.width-10, [[UIScreen mainScreen]bounds].size.height-(CalenderSelectionBox.frame.size.height+64)) collectionViewLayout:flowLayout];
        
        [CalenderSelectionBox addSubview:retrival_note_IMG];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        _collectionView.backgroundColor=[UIColor clearColor];
        [self.view addSubview:_collectionView];

        
         _collectionView.hidden = YES;
        
        [self mStartIndicater];
        [self performSelector:@selector(CallTheServer_Child_Component_API) withObject:nil afterDelay:0.5];
    }
    else
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 10, [[UIScreen mainScreen]bounds].size.width-10, [[UIScreen mainScreen]bounds].size.height-10) collectionViewLayout:flowLayout];
        
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        _collectionView.backgroundColor=[UIColor clearColor];
        [self.view addSubview:_collectionView];


        
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ComComponent"]);
        
        
        
        mutableRetrievedDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ComComponent"] mutableCopy];
        
        NSLog(@"%@",mutableRetrievedDictionary);
        
        
        
        
        [[NSUserDefaults standardUserDefaults]setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"eduBlog_count"] forKey:@"eduBlog_count"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"User"]valueForKey:@"news_count"] forKey:@"news_count"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        
        
        if (mutableRetrievedDictionary.count==0) {
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Connect to admin for component" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
            
        }
        
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(openNextPage)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed: @"TrackBus" ] forState:UIControlStateNormal];
//    [button setBackgroundColor:[Text_color_ EDU_Blog_Color_code]];
    button.frame = CGRectMake(self.view.frame.size.width - 100,self.view.frame.size.height - 100,100,100);
    
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
//    [self.view addSubview:button];
 //   [self mStartIndicater];
// [self webserviceForLogin];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FooterView"];
    
}

-(void)openNextPage
{
    ShowWebviewViewController * showWebViewController = [[ShowWebviewViewController alloc]init];
    [self presentViewController:showWebViewController animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

       [self Navigation_bar];
    self.navigationItem.hidesBackButton = YES;

    
    
    //////////////////// Hide UInavigation Bar \\\\\\\\\\\\\\
    
    self.navigationController.navigationBarHidden=NO;
    
    
       Error_Check=false;
    self.view.backgroundColor=[UIColor whiteColor];
    
   [self.navigationItem setHidesBackButton:YES animated:YES];
    
      [_collectionView reloadData];
   
   // [self mStartIndicater];
  //  [self webserviceForLogin];
   
   
    }

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    
//     NSLog(@"Retrievallist=>%@ News=>%@ Edu_Blog=>%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Retrieval_List"],[[NSUserDefaults standardUserDefaults]valueForKey:@"News"],[[NSUserDefaults standardUserDefaults]valueForKey:@"Edu_Blog"]);

//    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
//
//    
//    }
}
//
//-(void) webserviceForLogin  {
//    
//    NSString *requestString = [NSString stringWithFormat:@"securityKey=%@&username=%@&password=%@&device_token_app=%@&user_type_app=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"emailid"],[[NSUserDefaults standardUserDefaults]valueForKey:@"password"],[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]];
//    
//    
//    NSLog(@"Reply JSON===>: %@", requestString);
//    NSLog(@"Reply JSON: %@", [NSString stringWithFormat:@"%@users/login",[Utilities API_link_url_subDomain]]);
//    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
//    NSError *error;
//    
//    NSData *postData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
//    //        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestString options:0 error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSLog(@"[NSUserDefaults standardUserDefaults]valueForKey:@sub_domain] %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]);
//    
//    
//    
//    //    [NSString stringWithFormat:@"%@users/login",[Utilities API_link_url_subDomain]]
//    
//    
//    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@users/login",[Utilities API_link_url_subDomain]] parameters:nil error:nil];
//    
//    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
//    //        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    //        [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
//    
//    [req setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        [self mStopIndicater];
//        if (!error) {
//            NSLog(@"Reply JSON: %@", responseObject);
//            
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                //blah blah
//                //                    [self ];
//                [self CallTheServer_Login_API:responseObject];
//            }
//        } else {
//            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
//        }
//        [self mStopIndicater];
//    }] resume];
//
//    
//}
//
//-(void)CallTheServer_Login_API : (NSDictionary *) responseDict
//{
//    if ([API connectedToInternet]==YES) {
//        
//        //------------ Call API for signup With Post Method --------------//
//        
//        
//        //        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&username=%@&password=%@&device_token_app=%@&user_type_app=%@&language=%@",@"H67jdS7wwfh",email_TXT.text,Passwprd_TXT.text,[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@users/login",[Utilities API_link_url_subDomain]]];
//        //
//        //
//        //        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
//        //        NSLog(@"%@",[NSString stringWithFormat:@"%@users/login",[[NSUserDefaults standardUserDefaults]objectForKey:@"sub_domain"]]);
//        //         NSLog(@"%@",[NSString stringWithFormat:@"securityKey=%@&username=%@&password=%@&device_token_app=%@&user_type_app=%@&language=%@",@"H67jdS7wwfh",email_TXT.text,Passwprd_TXT.text,[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type_app"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]);
//        //        NSDictionary *responseDict = [responseString JSONValue];
//        dict_Login = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
//        NSLog(@"dict=>%@",dict_Login);
//        
//        if ([[dict_Login valueForKey:@"status"] isEqualToString:@"true"]) {
//            
//            NSMutableArray * arrayWithNoteList = [responseDict objectForKey:@"ComComponent"];
//            for (int i = 0; i<[arrayWithNoteList count]; i++) {
//                NSDictionary * dictionaryWithEachIndex =[arrayWithNoteList objectAtIndex:i];
//            //    NSLog(@"dictionaryInsideSchema==>  %@",dictionaryWithEachIndex);
//                [componentArray addObject:dictionaryWithEachIndex];
//                
//        }
//      
//        }
//        
//        else
//        {
//            
//            
//            
//            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict_Login valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
//            [alert show];
//            
//        }
//        
//        
//        
//    }
//    
//    else
//    {
//        
//        
//        
//        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
//        [alert show];
//    }
//    
//    [self mStopIndicater];
//    
//    
//}

-(void)Navigation_bar
{
    
    user_pic = [[UIImageView alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"USR_image"]]);
    [user_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"customer_logo"]]]
                placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    
    CGSize size = CGSizeMake(30, 30);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11){
        
        
        [user_pic setImage: [ImageCustomClass image:user_pic.image resize:size]];
        
        
//        UIAlertView *alertt = [[UIAlertView alloc] initWithTitle:@"Test Message"
//                                                        message:@"This is a sample"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alertt show];
    //    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Test Message" message: [NSString stringWithFormat:@"%f*%@",user_pic.image.size.width,user_pic.image.size.height] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
      //  UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 30, 30)];
        
//        NSString *loc = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:user_pic]];
//        UIImage *img = [[UIImage alloc] initWithContentsOfFile:loc];
//        [image setImage:img];
//        
//        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
//            [Alert setValue:image forKey:@"accessoryView"];
//        }else{
//            [Alert addSubview:image];
//        }
        
//        [Alert show];
        
    } else {
        
        user_pic.frame=CGRectMake(0, 0, size.width, size.height);
        
    }

    
  //  user_pic.frame=CGRectMake(50, 0, 30, 30);
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
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
    
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
        
         self.navigationItem.title = User_name;
        
        
    }
    else
    {
//        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button1 addTarget:self
//                    action:@selector(goToSmartNotesWebView)
//          forControlEvents:UIControlEventTouchUpInside];
//        [button1 setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Website" value:@"" table:nil] forState:UIControlStateNormal];
//        button1.font=[Font_Face_Controller opensansLight:15];
//        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        button1.frame = CGRectMake(0,5,100,100);
//        UIBarButtonItem *backButton1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
//        self.navigationItem.leftBarButtonItem = backButton1;
//
//        [[self navigationItem] setBackBarButtonItem:backButton1];
         self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"My Account" value:@"" table:nil];
    }
    
   

}

-(void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
//-(void)goToSmartNotesWebView {
//    SmartNotes_WebViewController   *controller = [[SmartNotes_WebViewController alloc] initWithNibName:@"SmartNotes_WebViewController" bundle:nil];
//    [self.navigationController pushViewController:controller animated:YES];
//}
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
#pragma mark CallTheServer_Child_Component_API Method
#pragma mark - -*********************


-(void)CallTheServer_Child_Component_API
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&parent_id=%@&selected_date=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_id"],Current_Date_STR,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@users/get_parent_components",[Utilities API_link_url_subDomain]]];
        
        //
        
        NSLog(@"%@",[Utilities API_link_url_subDomain]);
        
        NSLog(@"%@",[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&parent_id=%@&selected_date=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_id"],Current_Date_STR,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]);
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
   mutableRetrievedDictionarys = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        mutableRetrievedDictionary=[[NSMutableDictionary alloc]init];
        
        
        
        if ([[mutableRetrievedDictionarys valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            if (!([[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"]count]==0)) {
                
                
                selected_date_btn.text=      [[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"date"];
                
                
                [[NSUserDefaults standardUserDefaults]setObject:[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"date"] forKey:@"CalenderDate_Selected"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                if (![[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"drop_off_time"]isEqualToString:@""] && ![[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"retrieval_time"]isEqualToString:@""]) {
                    
                    if ([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"absent"]isEqualToString:@"true"]) {
                        
                       
                        Show_msg.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent" value:@"" table:nil];
                     
                     
                        
                    }
                    else
                    {
                       
                        Todays_Dropoff_Time.text=[NSString stringWithFormat:@"%@ : %@",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Drop off" value:@"" table:nil],[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"drop_off_time"]];
                                              
                      
                        Todays_Retrival_Time.text=[NSString stringWithFormat:@"%@ : %@",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retrieval" value:@"" table:nil],[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"retrieval_time"]];
                     
                    }
                    
                    
                }
                else
                {
                    
                  
                    
                    if ([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"current_day"]isEqualToString:@"Sun"]) {
                        
                        
                      
                        Show_msg.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Sunday" value:@"" table:nil];
                        
                    }
                    
                }
                
                
               
                
                
                if ([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"absent_note_icon"]isEqualToString:@"true"] && [[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"retriever_icon"]isEqualToString:@"true"]) {
                    
                    
              
                    
                    if([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"leave_type"]isEqualToString:@"sick"]){
                        
                        [absent_note_IMG setImage:[UIImage imageNamed:@"plus11.png"] forState:UIControlStateNormal];
                        
                        
                    }else if([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"leave_type"]isEqualToString:@"leave"]){
                        
                       
                        [absent_note_IMG setImage:[UIImage imageNamed:@"brief11.png"] forState:UIControlStateNormal];
                        
                        
                        
                    }else if([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"leave_type"]isEqualToString:@"other"]){
                        
                        [absent_note_IMG setImage:[UIImage imageNamed:@"user11.png"] forState:UIControlStateNormal];
                        
                    }
                    else
                    {
                        [absent_note_IMG setImage:[UIImage imageNamed:@"plus11.png"] forState:UIControlStateNormal];
                    }
                    
                    
                    
                    [retrival_note_IMG setImage:[UIImage imageNamed:@"vanner11.png"] forState:UIControlStateNormal];
                
                }
                else if ([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"absent_note_icon"]isEqualToString:@"true"])
                {
absent_note_IMG.frame=CGRectMake(CalenderSelectionBox.frame.size.width-30,5 , 20, 20);
                    
                    
                    if([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"leave_type"]isEqualToString:@"sick"]){
                        
                        [absent_note_IMG setImage:[UIImage imageNamed:@"plus11.png"] forState:UIControlStateNormal];
                        
                        
                    }else if([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"leave_type"]isEqualToString:@"leave"]){
                        
                        
                        [absent_note_IMG setImage:[UIImage imageNamed:@"brief11.png"] forState:UIControlStateNormal];
                        
                        
                        
                    }else if([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"leave_type"]isEqualToString:@"other"]){
                        
                        [absent_note_IMG setImage:[UIImage imageNamed:@"user11.png"] forState:UIControlStateNormal];
                        
                    }
                    
                    else
                    {
                        [absent_note_IMG setImage:[UIImage imageNamed:@"plus11.png"] forState:UIControlStateNormal];
                    }
                    
                    [CalenderSelectionBox addSubview:absent_note_IMG];
                    
                }
                
                
                
                
                
                else if([[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"retriever_icon"]isEqualToString:@"true"])
                {
                 
                    retrival_note_IMG.frame=CGRectMake(CalenderSelectionBox.frame.size.width-30, 5 , 20, 20);
                    [CalenderSelectionBox addSubview:retrival_note_IMG];
                    
                    [retrival_note_IMG setImage:[UIImage imageNamed:@"vanner11.png"] forState:UIControlStateNormal];
                    
                    
                }
                

                
                
            }
            
           
                    
            
            NSLog(@"%@",mutableRetrievedDictionarys);
            
            [[NSUserDefaults standardUserDefaults]setObject:[[mutableRetrievedDictionarys valueForKey:@"child_attedance_info"] valueForKey:@"date"] forKey:@"CalenderDate_Selected"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
         
            
            [[NSUserDefaults standardUserDefaults]setValue:[mutableRetrievedDictionarys valueForKey:@"eduBlog_count"] forKey:@"eduBlog_count"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setValue:[mutableRetrievedDictionarys valueForKey:@"news_count"] forKey:@"news_count"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            NSLog(@"eduBlog_count----> %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"eduBlog_count"]);
            
            
  NSLog(@"news_count----> %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"news_count"]);
            
           mutableRetrievedDictionary =[mutableRetrievedDictionarys valueForKey:@"ComComponent"];
//
            
            
                       [_collectionView reloadData];
            
            
        }else if([[mutableRetrievedDictionary valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[mutableRetrievedDictionarys valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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
#pragma mark Stop Indicater
#pragma mark - -*********************

-(void)mStopIndicater
{
    
    [loader_image removeFromSuperview];
    _collectionView.hidden = NO;
    
    
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
  //  return  [[dict valueForKey:@"Offer Detail"]count];
//    NSLog(@"mutableRetrievedDictionary %lu,%@",(unsigned long)[mutableRetrievedDictionary count],mutableRetrievedDictionary);
     return  mutableRetrievedDictionary.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL is4sDevice = [[UIScreen mainScreen] bounds].size.width == 320;
    
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    for (UIView *subView in [cell subviews]) {
        [subView removeFromSuperview];
    }
    
    
   // CGSize size = [self getCellSize:mutableRetrievedDictionary];
    
  //  panel_IMG = [[UIImageView alloc]initWithFrame: CGRectMake(0, 0, size.width, size.height)];
    
    
    panel_IMG = [[UIImageView alloc]initWithFrame: CGRectMake((cell.frame.size.width-40)/2, (cell.frame.size.height-40)/2, 40,40)];
    
    [cell addSubview:panel_IMG];
    
    http://presentation.elar.se/img/Schedule.png
    if (mutableRetrievedDictionary.count <= indexPath.row ) {
        [panel_IMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://presentation.elar.se/img/Schedule.png"]]
    placeholderImage:[UIImage imageNamed:@"Placeholding.png"]];
        cell.backgroundColor=[Text_color_ Food_Schedule_Color_code];
        
        Component_name=[[UILabel alloc]initWithFrame:CGRectMake(0, panel_IMG.frame.origin.y+panel_IMG.frame.size.height-(is4sDevice ? 10 : 0) , cell.frame.size.width,40)];
        
        Component_name.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule" value:@"" table:nil] ;
        
        Component_name.textColor=[UIColor whiteColor];
        Component_name.textAlignment=NSTextAlignmentCenter;
        [cell addSubview:Component_name];

    }
    else
    {
//    if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"0"])
//    {
//    
//   
//        
//    }
//    else
//    {
        [panel_IMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[mutableRetrievedDictionary valueForKey:@"img_path"]objectAtIndex:indexPath.row]]]
                     placeholderImage:[UIImage imageNamed:@"Placeholding.png"]];
 //   }
    
     Component_name=[[UILabel alloc]initWithFrame:CGRectMake(0, panel_IMG.frame.origin.y+panel_IMG.frame.size.height-(is4sDevice ? 10 : 0), cell.frame.size.width,40)];
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]isEqualToString:@"sw"])
    {
    Component_name.text=[[mutableRetrievedDictionary valueForKey:@"name_sw"]objectAtIndex:indexPath.row];
    }
    else
    {
    
        Component_name.text=[[mutableRetrievedDictionary valueForKey:@"name"]objectAtIndex:indexPath.row];
    }
    Component_name.textColor=[UIColor whiteColor];
    Component_name.textAlignment=NSTextAlignmentCenter;
    [cell addSubview:Component_name];
    
    
    UNseen_count=[[UITextView alloc]initWithFrame:CGRectMake(cell.frame.size.width-60, 0, 60,60)];
    UNseen_count.userInteractionEnabled=NO;
    UNseen_count.editable=NO;
    UNseen_count.textColor=[UIColor whiteColor];
    UNseen_count.font=[Font_Face_Controller opensanssemibold:15];
    UNseen_count.textAlignment=NSTextAlignmentRight;
    
    
    
     if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"67"])
    {
        
        cell.backgroundColor=[Text_color_ Child_info_Color_code];
        
        Component_name.backgroundColor=[Text_color_ Child_info_Color_code];
        panel_IMG.backgroundColor=[Text_color_ Child_info_Color_code];
        UNseen_count.backgroundColor=[Text_color_ Child_info_Color_code];
    }
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"11"])
        {
            
            cell.backgroundColor=[Text_color_ Forum_Color_code];
            
            Component_name.backgroundColor=[Text_color_ Forum_Color_code];
            panel_IMG.backgroundColor=[Text_color_ Forum_Color_code];
            UNseen_count.backgroundColor=[Text_color_ Forum_Color_code];
        }
       
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"86"])
      {
          
          cell.backgroundColor=[Text_color_ Recovery_Notice_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Recovery_Notice_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Recovery_Notice_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Recovery_Notice_Color_code];
      }

        

      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"100"])
      {
          
          cell.backgroundColor=[Text_color_ Edu_Step_Planner_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Edu_Step_Planner_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Edu_Step_Planner_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Edu_Step_Planner_Color_code];
      }
        
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"78"])
      {
          
          cell.backgroundColor=[Text_color_ Progress_Tables_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Progress_Tables_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Progress_Tables_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Progress_Tables_Color_code];
      }
    
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"101"])
      {
          
          cell.backgroundColor=[Text_color_ Todays_Note_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Todays_Note_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Todays_Note_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Todays_Note_Color_code];
      }
        
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"87"])
      {
          
          cell.backgroundColor=[Text_color_ Quiz_Manager_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Quiz_Manager_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Quiz_Manager_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Quiz_Manager_Color_code];
      }
 
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"85"])
      {
          
          cell.backgroundColor=[Text_color_ Message_Manager_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Message_Manager_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Message_Manager_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Message_Manager_Color_code];
      }
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"83"])
      {
          
          cell.backgroundColor=[Text_color_ Week_List_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Week_List_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Week_List_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Week_List_Color_code];
      }
        
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"73"])
      {
          
          cell.backgroundColor=[Text_color_ Edu_Blog_Statistics_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Edu_Blog_Statistics_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Edu_Blog_Statistics_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Edu_Blog_Statistics_Color_code];
      }
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"62"])
      {
          
          cell.backgroundColor=[Text_color_ Retrieval_Statistics_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Retrieval_Statistics_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Retrieval_Statistics_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Retrieval_Statistics_Color_code];
      }
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"81"])
      {
          
          cell.backgroundColor=[Text_color_ Contact_Information_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Contact_Information_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Contact_Information_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Contact_Information_Color_code];
      }
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"68"])
      {
          
          cell.backgroundColor=[Text_color_ School_Information_Color_code];
          
          Component_name.backgroundColor=[Text_color_ School_Information_Color_code];
          panel_IMG.backgroundColor=[Text_color_ School_Information_Color_code];
          UNseen_count.backgroundColor=[Text_color_ School_Information_Color_code];
      }
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"16"])
      {
          if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]isEqualToString:@"sw"])
          {
              Component_name.text=@"Portfölj";
          }
          else
          {
              
              Component_name.text=[[mutableRetrievedDictionary valueForKey:@"name"]objectAtIndex:indexPath.row];
          }

          
          cell.backgroundColor=[Text_color_ Portfolio_Text_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Portfolio_Text_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Portfolio_Text_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Portfolio_Text_Color_code];
      }
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"103"])
      {
          
          cell.backgroundColor=[Text_color_ Evaluation_Matrix_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Evaluation_Matrix_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Evaluation_Matrix_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Evaluation_Matrix_Color_code];
      }
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"47"])
      {
          
          cell.backgroundColor=[Text_color_ Course_video_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Course_video_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Course_video_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Course_video_Color_code];
      }
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"10"])
      {
          
          cell.backgroundColor=[Text_color_ Examination_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Examination_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Examination_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Examination_Color_code];
      }
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"87Q"])
      {
          
          cell.backgroundColor=[Text_color_ Quiz_editor_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Quiz_editor_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Quiz_editor_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Quiz_editor_Color_code];
      }
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"50"])
      {
          
          cell.backgroundColor=[Text_color_ Survey_forms_Color_code];
          
          Component_name.backgroundColor=[Text_color_ Survey_forms_Color_code];
          panel_IMG.backgroundColor=[Text_color_ Survey_forms_Color_code];
          UNseen_count.backgroundColor=[Text_color_ Survey_forms_Color_code];
      }

      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"latest"])
      {
          
          cell.backgroundColor=[Text_color_ Smart_Notes_Color_Code];
          
          Component_name.backgroundColor=[Text_color_ Smart_Notes_Color_Code];
          panel_IMG.backgroundColor=[Text_color_ Smart_Notes_Color_Code];
          UNseen_count.backgroundColor=[Text_color_ Smart_Notes_Color_Code];
      }
        
      else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"105"])
      {
          
          cell.backgroundColor=[Text_color_ Location_Color_Code];
          
          Component_name.backgroundColor=[Text_color_ Location_Color_Code];
          panel_IMG.backgroundColor=[Text_color_ Location_Color_Code];
          UNseen_count.backgroundColor=[Text_color_ Location_Color_Code];
      }

        
  else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"29"]) {
        
        cell.backgroundColor=[Text_color_ Retrieval_Color_code];
        
        Component_name.backgroundColor=[Text_color_ Retrieval_Color_code];
        panel_IMG.backgroundColor=[Text_color_ Retrieval_Color_code];
             UNseen_count.backgroundColor=[Text_color_ Retrieval_Color_code];
        
    }
  else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"63"]) {
      
      cell.backgroundColor=[Text_color_ Food_Menu_Color_code];
      
      Component_name.backgroundColor=[Text_color_ Food_Menu_Color_code];
      panel_IMG.backgroundColor=[Text_color_ Food_Menu_Color_code];
      UNseen_count.backgroundColor=[Text_color_ Food_Menu_Color_code];
      
  }
  

  else  if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"27"]) {
      
      cell.backgroundColor=[Text_color_ Food_Schedule_Color_code];
      
      Component_name.backgroundColor=[Text_color_ Food_Schedule_Color_code];
      panel_IMG.backgroundColor=[Text_color_ Food_Schedule_Color_code];
      UNseen_count.backgroundColor=[Text_color_ Food_Schedule_Color_code];
      
  }

    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"28"])
    {
        cell.backgroundColor=[Text_color_ EDU_Blog_Color_code];
        
         Component_name.backgroundColor=[Text_color_ EDU_Blog_Color_code];
        panel_IMG.backgroundColor=[Text_color_ EDU_Blog_Color_code];
     UNseen_count.backgroundColor=[Text_color_ EDU_Blog_Color_code];
        
        
        
        
        if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"eduBlog_count"]isEqualToString:@"0"] && ![[[NSUserDefaults standardUserDefaults]valueForKey:@"eduBlog_count"]isEqualToString:@""]) {
            
            
            // Build a triangular path
            UIBezierPath *path = [UIBezierPath new];
            [path moveToPoint:(CGPoint){0, 0}];
            [path addLineToPoint:(CGPoint){60, 60}];
            [path addLineToPoint:(CGPoint){100, 0}];
            [path addLineToPoint:(CGPoint){0, 0}];
            
            
            CAShapeLayer *mask = [CAShapeLayer new];
            mask.frame = UNseen_count.bounds;
            mask.path = path.CGPath;
            UNseen_count.backgroundColor=[UIColor colorWithWhite:0.0f/255.0f alpha:0.2];
            
            
            UNseen_count.layer.mask = mask;

            
            UNseen_count.text= [[NSUserDefaults standardUserDefaults]valueForKey:@"eduBlog_count"];
        [cell addSubview:UNseen_count];

        }
        
       
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"23"])
    {
        cell.backgroundColor=[Text_color_ News_Color_code];
        
         Component_name.backgroundColor=[Text_color_ News_Color_code];
        panel_IMG.backgroundColor=[Text_color_ News_Color_code];
        
   UNseen_count.backgroundColor=[Text_color_ News_Color_code];
      
               
        
        if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"news_count"]isEqualToString:@"0"] && ![[[NSUserDefaults standardUserDefaults]valueForKey:@"news_count"]isEqualToString:@""]) {
            
            // Build a triangular path
            UIBezierPath *path = [UIBezierPath new];
            [path moveToPoint:(CGPoint){0, 0}];
            [path addLineToPoint:(CGPoint){60, 60}];
            [path addLineToPoint:(CGPoint){100, 0}];
            [path addLineToPoint:(CGPoint){0, 0}];
            
            
            CAShapeLayer *mask = [CAShapeLayer new];
            mask.frame = UNseen_count.bounds;
            mask.path = path.CGPath;
            UNseen_count.backgroundColor=[UIColor colorWithWhite:0.0f/255.0f alpha:0.2];
            
            
            UNseen_count.layer.mask = mask;

            
           UNseen_count.text= [[NSUserDefaults standardUserDefaults]valueForKey:@"news_count"];
         [cell addSubview:UNseen_count];
            
        }

    
         
    }
    
    
    ////////////////////
    
    
    
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"1"])
    {
        
        
//        Component_name.frame=CGRectMake(0, panel_IMG.frame.origin.y+panel_IMG.frame.size.height, cell.frame.size.width,40);
        Component_name.textAlignment=NSTextAlignmentCenter;
        
        cell.backgroundColor=[Text_color_ Absence_note_Color_code];
        
        Component_name.backgroundColor=[Text_color_ Absence_note_Color_code];
        panel_IMG.backgroundColor=[Text_color_ Absence_note_Color_code];
        
        
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"2"])
    {
        
//        Component_name.frame=CGRectMake(0, panel_IMG.frame.origin.y+panel_IMG.frame.size.height, cell.frame.size.width,40);
        Component_name.textAlignment=NSTextAlignmentCenter;
        cell.backgroundColor=[Text_color_ retriever_Parent_Color_code];
        
        Component_name.backgroundColor=[Text_color_ retriever_Parent_Color_code];
        
        
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"3"])
    {
        
        
        NSLog(@"%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"img_path"]]]);
        
//        Component_name.frame=CGRectMake(0, panel_IMG.frame.origin.y+panel_IMG.frame.size.height, cell.frame.size.width,40);
        Component_name.textAlignment=NSTextAlignmentCenter;
        cell.backgroundColor=[Text_color_ Child_info_Color_code];
//        [panel_IMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[mutableRetrievedDictionary valueForKey:@"ComComponent"]objectAtIndex:indexPath.row]valueForKey:@"img_path"]]]
//                     placeholderImage:[UIImage imageNamed:@"Placeholding.png"]];
        
        
    }
    }

    cell.clipsToBounds = YES;
    Component_name.numberOfLines = 0;
    Component_name.lineBreakMode = NSLineBreakByWordWrapping;
    Component_name.backgroundColor = [UIColor clearColor];
    Component_name.font=[Font_Face_Controller opensanssemibold: is4sDevice ? 10 : 13];  // Incase of 4s reduced font size
    return cell;
}


-(void)ShowSelectedCancel
{
    [selected_date_btn resignFirstResponder];
    
}

-(void)ShowSelectedDate
{
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]);
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // [formatter setDateFormat:@"dd/MMM/YYYY"];
    selected_date_btn.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datepicker.date]];
    
    
    [[NSUserDefaults standardUserDefaults]setObject: selected_date_btn.text forKey:@"CalenderDate_Selected"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    Current_Date_STR=selected_date_btn.text;
    
    
    [selected_date_btn resignFirstResponder];
    
    [self mStartIndicater];
    
   
    
    [self performSelector:@selector(CallTheServer_Child_Component_Next_date_API) withObject:nil afterDelay:0.5];
    
}




-(void)dateChangedNext
{
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]);
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date_to_be_incremented = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]];
    
    int daysToAdd = 1;
    NSDate *updated_date = [date_to_be_incremented dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    NSString *date_correct_format = [dateFormatter stringFromDate:updated_date];
    
    
    NSLog(@"%@",date_correct_format);
    
    
    [[NSUserDefaults standardUserDefaults] setValue:date_correct_format forKey:@"CalenderDate_Selected"];
    
    
    
     NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]);
    
    
   selected_date_btn.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
    Current_Date_STR=selected_date_btn.text;
    
    //[selected_date_btn setTitle:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"] forState: UIControlStateNormal];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Child_Component_Next_date_API) withObject:nil afterDelay:0.5];
    
}

-(void)dateChangedPrevious
{
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]);
    
    //handle previous date changes
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date_to_be_incremented = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"]];
    
    int daysToAdd = -1;
    NSDate *updated_date = [date_to_be_incremented dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    NSString *date_correct_format = [dateFormatter stringFromDate:updated_date];
    [[NSUserDefaults standardUserDefaults] setValue:date_correct_format forKey:@"CalenderDate_Selected"];
    
    
  selected_date_btn.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
    Current_Date_STR=selected_date_btn.text;
    
    // [selected_date_btn setTitle:[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"] forState: UIControlStateNormal];
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Child_Component_Next_date_API) withObject:nil afterDelay:0.5];
}



#pragma mark - -*********************
#pragma mark CallTheServer_Child_Component_Next_date_API Method
#pragma mark - -*********************


-(void)CallTheServer_Child_Component_Next_date_API
{
    if ([API connectedToInternet]==YES) {
    
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:Current_Date_STR];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        Current_Date_STR = [dateFormatter stringFromDate:date];
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSLog(@"%@",[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&parent_id=%@&selected_date=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_id"],Current_Date_STR,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]);
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&parent_id=%@&selected_date=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_id"],Current_Date_STR,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@users/get_parent_components",[Utilities API_link_url_subDomain]]];
        
        
        
      
        
        NSDictionary *responseDict = [responseString JSONValue];
        UpdateRetrievedDictionary = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[UpdateRetrievedDictionary valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            NSLog(@"%@",UpdateRetrievedDictionary);
            
            
               NSLog(@"%@",mutableRetrievedDictionarys);
            
            
            [mutableRetrievedDictionarys removeObjectForKey:@"child_attedance_info"];
            
                 NSLog(@"%@",mutableRetrievedDictionarys);
            
            [mutableRetrievedDictionarys setValue:[UpdateRetrievedDictionary valueForKey:@"child_attedance_info" ] forKey:@"child_attedance_info"];
            
            
                 NSLog(@"%@",mutableRetrievedDictionarys);
            
            [absent_note_IMG setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [retrival_note_IMG setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            absent_note_IMG.userInteractionEnabled=NO;
            retrival_note_IMG.userInteractionEnabled=NO;
            
            selected_date_btn.text=      [[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"date"];
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"date"] forKey:@"CalenderDate_Selected"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            
            
            if (![[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"drop_off_time"]isEqualToString:@""] && ![[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"retrieval_time"]isEqualToString:@""]) {
                
                if ([[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"absent"]isEqualToString:@"true"]) {
                    
                  
                    Todays_Dropoff_Time.text=@"";
                    Todays_Retrival_Time.text=@"";
                    
                    
                    Show_msg.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent" value:@"" table:nil];
                    
                }
                else
                {
                    
                      Show_msg.text=@"";
                    
                    
                    NSLog(@"%@",[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"drop_off_time"]);
                    
                       NSLog(@"%@",[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"retrieval_time"]);
                    
                  
                    Todays_Dropoff_Time.text=[NSString stringWithFormat:@"%@ : %@",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Drop off" value:@"" table:nil],[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"drop_off_time"]];
                    
                                                      Todays_Retrival_Time.text=[NSString stringWithFormat:@"%@ : %@",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retrieval" value:@"" table:nil],[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"retrieval_time"]];
                 
                }
                
                
            }
            else
            {
                
                
                
                if ([[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"current_day"]isEqualToString:@"Sun"]) {
                    
                    Todays_Dropoff_Time.text=@"";
                    Todays_Retrival_Time.text=@"";
                    
                    
                                        Show_msg.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Sunday" value:@"" table:nil];
                    
                    
                    
                }
                
            }
            
            
            
            
            
            if ([[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"absent_note_icon"]isEqualToString:@"true"] && [[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"retriever_icon"]isEqualToString:@"true"]) {
                
                absent_note_IMG.userInteractionEnabled=YES;
                retrival_note_IMG.userInteractionEnabled=YES;
                
                if([[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"leave_type"]isEqualToString:@"sick"]){
                    
                    [absent_note_IMG setImage:[UIImage imageNamed:@"plus11.png"] forState:UIControlStateNormal];
                    
                    
                }else if([[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"leave_type"]isEqualToString:@"leave"]){
                    
                    
                    [absent_note_IMG setImage:[UIImage imageNamed:@"brief11.png"] forState:UIControlStateNormal];
                    
                    
                    
                }else if([[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"leave_type"]isEqualToString:@"other"]){
                    
                    [absent_note_IMG setImage:[UIImage imageNamed:@"user11.png"] forState:UIControlStateNormal];
                    
                }
                else
                {
                    [absent_note_IMG setImage:[UIImage imageNamed:@"plus11.png"] forState:UIControlStateNormal];
                }
                
                
                
                             [retrival_note_IMG setImage:[UIImage imageNamed:@"vanner11.png"] forState:UIControlStateNormal];
               
            }
            else if ([[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"absent_note_icon"]isEqualToString:@"true"])
            {
                
                
                absent_note_IMG.userInteractionEnabled=YES;
                retrival_note_IMG.userInteractionEnabled=NO;
                
                
                if([[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"leave_type"]isEqualToString:@"sick"]){
                    
                    [absent_note_IMG setImage:[UIImage imageNamed:@"plus11.png"] forState:UIControlStateNormal];
                    
                    
                }else if([[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"leave_type"]isEqualToString:@"leave"]){
                    
                    
                    [absent_note_IMG setImage:[UIImage imageNamed:@"brief11.png"] forState:UIControlStateNormal];
                    
                    
                    
                }else if([[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"leave_type"]isEqualToString:@"other"]){
                    
                    [absent_note_IMG setImage:[UIImage imageNamed:@"user11.png"] forState:UIControlStateNormal];
                    
                }
                
                else
                {
                    [absent_note_IMG setImage:[UIImage imageNamed:@"plus11.png"] forState:UIControlStateNormal];
                }
                
              
                
            }
            
            
            
            
            
            else if([[[UpdateRetrievedDictionary valueForKey:@"child_attedance_info"] valueForKey:@"retriever_icon"]isEqualToString:@"true"])
            {
                
                
                absent_note_IMG.userInteractionEnabled=NO;
                retrival_note_IMG.userInteractionEnabled=YES;

                
                [retrival_note_IMG setImage:[UIImage imageNamed:@"vanner11.png"] forState:UIControlStateNormal];
                
                
            }
            else
            {
                
                absent_note_IMG.userInteractionEnabled=NO;
                retrival_note_IMG.userInteractionEnabled=NO;
                
                [absent_note_IMG setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [retrival_note_IMG setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            }
            
            
            
            
      //  }

        
        
        
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



-(void)retrival_note_IMG
{
    retrieval_note *objretriever_note = [[retrieval_note alloc]init];
    
    
    
    objretriever_note.date_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
      [self.navigationController pushViewController:objretriever_note animated:YES];
}



-(void)absent_note_IMG
{
    
    
    absent_note *objabsent_note = [[absent_note alloc]init];
    objabsent_note.date_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"CalenderDate_Selected"];
    
    [self.navigationController pushViewController:objabsent_note animated:YES];
    
}




#pragma mark – UICollectionViewDelegateFlowLayout

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if (kind == UICollectionElementKindSectionFooter) {
//
//        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
//
//        if (reusableview==nil) {
//            reusableview=[[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//        }
//
//        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//        label.text=[NSString stringWithFormat:@"Recipe Group #%li", indexPath.section + 1];
//        [reusableview addSubview:label];
//        return reusableview;
//    }
//    return nil;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    CGSize footerSize = CGSizeMake(collectionView.frame.size.width,44);
//    return footerSize;
//}

- (CGSize)getCellSize:(NSDictionary *) dict{
    
    CGFloat width;
    
    if(dict.count>10){
        
        width = (_collectionView.frame.size.width/3)-10;
        return CGSizeMake(width, width);
        
    }
    
    width = (_collectionView.frame.size.width/2)-10;
    
    return CGSizeMake(width, width);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
      return [self getCellSize:mutableRetrievedDictionary];
    
    
    NSLog(@"%f",[[UIScreen mainScreen] bounds].size.width);
//    
//    if (mutableRetrievedDictionary.count>10) {
//        //
//    }
//    else {
    
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
    
//    }
    
    return retval;
    
    
  
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (mutableRetrievedDictionary.count <= indexPath.row) {
//        ViewFoodMenuPdfViewController *obj_View_Food_Menu_ViewController=[[ViewFoodMenuPdfViewController alloc]init];
//        
//        [self.navigationController pushViewController:obj_View_Food_Menu_ViewController animated:YES];
//
//    }
//    else
//    {
  //   NSDictionary * aspectdictionaryAtEachIndex = [componentArray objectAtIndex:indexPath.row];
    
    
    NSLog(@"Test=>%@",[mutableRetrievedDictionary valueForKey:@"id"]);
    if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"29"]) {
        
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
            
            Child_Component *obj_EDU_Blog_Home_screen_ViewController=[[Child_Component alloc]init];
            
            [self.navigationController pushViewController:obj_EDU_Blog_Home_screen_ViewController animated:YES];
            
        }
        else
        {
            
//            retrieval_list_home *obj_EDU_Blog_Home_screen_ViewController=[[retrieval_list_home alloc]init];
//            
//            [self.navigationController pushViewController:obj_EDU_Blog_Home_screen_ViewController animated:YES];
    }
    }
    
//    NSLog(@"dictionary=>%@",[aspectdictionaryAtEachIndex objectForKey:@"App_Status"]);
    if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"29"]) {
        id appStaus = [[NSUserDefaults standardUserDefaults]valueForKey:@"Retrieval_List"];
        
        UIViewController *nextViewController;
        
        if (appStaus != nil)
        {
            //        ForumViewController *obj_EDU_Blog_Home_screen_ViewController = [[ForumViewController alloc]initWithNibName:@"ForumViewController" bundle:nil];
            
            
            nextViewController = [appStaus isEqualToString:@"0"] ? [[retrieval_list_home alloc]init] : [[Retrieval_List_WebViewController alloc] initWithNibName:@"Retrieval_List_WebViewController" bundle:nil];
            
    } else if ([[[mutableRetrievedDictionary valueForKey:@"App_Status"] objectAtIndex:indexPath.row] isEqualToString:@"0"]){
            
            nextViewController = [[retrieval_list_home alloc]init];
        } else {
            nextViewController = [[Retrieval_List_WebViewController alloc] initWithNibName:@"Retrieval_List_WebViewController" bundle:nil];
        }
        
        [self.navigationController pushViewController:nextViewController animated:YES];

//        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Retrieval_List"]isEqualToString:@"0"]||[[NSUserDefaults standardUserDefaults]valueForKey:@"Retrieval_List"]==nil)
//        {
//            
//            retrieval_list_home *obj_EDU_Blog_Home_screen_ViewController=[[retrieval_list_home alloc]init];
//            
//            [self.navigationController pushViewController:obj_EDU_Blog_Home_screen_ViewController animated:YES];
//        }
//        else  {
//            Retrieval_List_WebViewController  *controller = [[Retrieval_List_WebViewController alloc] initWithNibName:@"Retrieval_List_WebViewController" bundle:nil];
//            [self.navigationController pushViewController:controller animated:YES];
//            
//        }

    }
    
    
    if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"28"]) {
        
        id appStaus = [[NSUserDefaults standardUserDefaults]valueForKey:@"Edu_Blog"];
        
        UIViewController *nextViewController;
        
       if (appStaus != nil)
        {
            //        ForumViewController *obj_EDU_Blog_Home_screen_ViewController = [[ForumViewController alloc]initWithNibName:@"ForumViewController" bundle:nil];
            
            
            nextViewController = [appStaus isEqualToString:@"0"] ? [[EDU_Blog_Home_screen_ViewController alloc]init] : [[EduBlogWebViewController alloc] initWithNibName:@"EduBlogWebViewController" bundle:nil];
            
            
          /*  EDU_Blog_Home_screen_ViewController *obj_EDU_Blog_Home_screen_ViewController = [[EDU_Blog_Home_screen_ViewController alloc]init];
            
            [self.navigationController pushViewController:obj_EDU_Blog_Home_screen_ViewController animated:YES];
            
        } else if ([mutableRetrievedDictionary valueForKey:@"App_Status"]) {
            
        }
       else {
           EduBlogWebViewController  *controller = [[EduBlogWebViewController alloc] initWithNibName:@"EduBlogWebViewController" bundle:nil];
           [self.navigationController pushViewController:controller animated:YES];
           
       } */
        } else if ([[[mutableRetrievedDictionary valueForKey:@"App_Status"] objectAtIndex:indexPath.row] isEqualToString:@"0"]){
            
            nextViewController = [[EDU_Blog_Home_screen_ViewController alloc]init];
        } else {
            nextViewController = [[EduBlogWebViewController alloc] initWithNibName:@"EduBlogWebViewController" bundle:nil];
        }
    
        [self.navigationController pushViewController:nextViewController animated:YES];
        
    }
    
   
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"27"])
    {
        MainViewController *controller = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"23"]) {
//         if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"News"]isEqualToString:@"0"]||[[NSUserDefaults standardUserDefaults]valueForKey:@"News"]==nil)
//        {
//            //        ForumViewController *obj_EDU_Blog_Home_screen_ViewController = [[ForumViewController alloc]initWithNibName:@"ForumViewController" bundle:nil];
//            
//            NEWS_Blog_Home_screen_ViewController *obj_EDU_Blog_Home_screen_ViewController=[[NEWS_Blog_Home_screen_ViewController alloc]init];
//            [self.navigationController pushViewController:obj_EDU_Blog_Home_screen_ViewController animated:YES];
//        }
//         else  {
//             NewsBlogWebViewController  *controller = [[NewsBlogWebViewController alloc] initWithNibName:@"NewsBlogWebViewController" bundle:nil];
//             [self.navigationController pushViewController:controller animated:YES];
//             
//         }
        id appStaus = [[NSUserDefaults standardUserDefaults]valueForKey:@"News"];
        
        UIViewController *nextViewController;
        
        if (appStaus != nil)
        {
            //        ForumViewController *obj_EDU_Blog_Home_screen_ViewController = [[ForumViewController alloc]initWithNibName:@"ForumViewController" bundle:nil];
            
            
            nextViewController = [appStaus isEqualToString:@"0"] ? [[NEWS_Blog_Home_screen_ViewController alloc]init] : [[NewsBlogWebViewController alloc] initWithNibName:@"NewsBlogWebViewController" bundle:nil];
            
            
            /*  EDU_Blog_Home_screen_ViewController *obj_EDU_Blog_Home_screen_ViewController = [[EDU_Blog_Home_screen_ViewController alloc]init];
             
             [self.navigationController pushViewController:obj_EDU_Blog_Home_screen_ViewController animated:YES];
             
             } else if ([mutableRetrievedDictionary valueForKey:@"App_Status"]) {
             
             }
             else {
             EduBlogWebViewController  *controller = [[EduBlogWebViewController alloc] initWithNibName:@"EduBlogWebViewController" bundle:nil];
             [self.navigationController pushViewController:controller animated:YES];
             
             } */
        } else if ([[[mutableRetrievedDictionary valueForKey:@"App_Status"] objectAtIndex:indexPath.row] isEqualToString:@"0"]){
            
            nextViewController = [[NEWS_Blog_Home_screen_ViewController alloc]init];
        } else {
            nextViewController = [[NewsBlogWebViewController alloc] initWithNibName:@"NewsBlogWebViewController" bundle:nil];
        }
        
        [self.navigationController pushViewController:nextViewController animated:YES];

        
    }
    
    if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"86"])
    {
        Recovery_Notes_WebViewController  *controller = [[Recovery_Notes_WebViewController alloc] initWithNibName:@"Recovery_Notes_WebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"67"])
    {
        
        Child_Information *obj_EDU_Blog_Home_screen_ViewController=[[Child_Information alloc]init];
        
        obj_EDU_Blog_Home_screen_ViewController.indexOfChildSelected = self.indexOfChildSelected;
        
        [self.navigationController pushViewController:obj_EDU_Blog_Home_screen_ViewController animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"63"])
    {
        AddFoodNotesViewController  *controller = [[AddFoodNotesViewController alloc] initWithNibName:@"AddFoodNotesViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"11"])
    {
        ForumWebViewViewController  *controller = [[ForumWebViewViewController alloc] initWithNibName:@"ForumWebViewViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"100"])
    {
        EduStepPlannerWebViewController  *controller = [[EduStepPlannerWebViewController alloc] initWithNibName:@"EduStepPlannerWebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"78"])
    {
        ProgressTableWebViewController  *controller = [[ProgressTableWebViewController alloc] initWithNibName:@"ProgressTableWebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"101"])
    {
        TodaysNoteWebViewController  *controller = [[TodaysNoteWebViewController alloc] initWithNibName:@"TodaysNoteWebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"87"])
    {
        QuizManagerWebViewController  *controller = [[QuizManagerWebViewController alloc] initWithNibName:@"QuizManagerWebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"85"])
    {
        Message_Manager_WebViewController  *controller = [[Message_Manager_WebViewController alloc] initWithNibName:@"Message_Manager_WebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"83"])
    {
        WeekListViewController  *controller = [[WeekListViewController alloc] initWithNibName:@"WeekListViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"73"])
    {
        Edublog_Statistics_WebViewController  *controller = [[Edublog_Statistics_WebViewController alloc] initWithNibName:@"Edublog_Statistics_WebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"62"])
    {
        Retrieval_Statistics_WebViewController  *controller = [[Retrieval_Statistics_WebViewController alloc] initWithNibName:@"Retrieval_Statistics_WebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"81"])
    {
        Contact_Information_WebViewController  *controller = [[Contact_Information_WebViewController alloc] initWithNibName:@"Contact_Information_WebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"68"])
    {
        School_Information_WebViewController  *controller = [[School_Information_WebViewController alloc] initWithNibName:@"School_Information_WebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"16"])
    {
        PortfolioWebViewController  *controller = [[PortfolioWebViewController alloc] initWithNibName:@"PortfolioWebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"103"])
    {
        Evaluation_Matrix_WebViewController  *controller = [[Evaluation_Matrix_WebViewController alloc] initWithNibName:@"Evaluation_Matrix_WebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"87Q"])
    {
        Quiz_Editor_WebViewController  *controller = [[Quiz_Editor_WebViewController alloc] initWithNibName:@"Quiz_Editor_WebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"50"])
    {
        Survey_Forms_WebViewController  *controller = [[Survey_Forms_WebViewController alloc] initWithNibName:@"Survey_Forms_WebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"10"])
    {
        Examination_WebViewController  *controller = [[Examination_WebViewController alloc] initWithNibName:@"Examination_WebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"47"])
    {
        Course_Video_WebViewController  *controller = [[Course_Video_WebViewController alloc] initWithNibName:@"Course_Video_WebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"latest"])
    {
        SmartNotes_WebViewController  *controller = [[SmartNotes_WebViewController alloc] initWithNibName:@"SmartNotes_WebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"105"])
    {
        LocationWebViewController  *controller = [[LocationWebViewController alloc] initWithNibName:@"LocationWebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
    
    if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"0"]) {
        
        
        
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"1"])
    {
        AbsenceNoteWebViewController  *controller = [[AbsenceNoteWebViewController alloc] initWithNibName:@"AbsenceNoteWebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];

//        add_absent_note *objadd_absent_note=[[add_absent_note alloc]init];
//        objadd_absent_note.add_check=@"yes";
//        [self.navigationController pushViewController:objadd_absent_note animated:YES];
    }
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"2"])
    {
        
        add_retriever_note *objadd_retriever_note=[[add_retriever_note alloc]init];
        objadd_retriever_note.add_check=@"yes";
        [self.navigationController pushViewController:objadd_retriever_note animated:YES];
    }
    
    else if ([[[mutableRetrievedDictionary valueForKey:@"id"]objectAtIndex:indexPath.row]isEqualToString:@"3"])
    {
        
        Child_Information *obj_EDU_Blog_Home_screen_ViewController=[[Child_Information alloc]init];
        [self.navigationController pushViewController:obj_EDU_Blog_Home_screen_ViewController animated:YES];
    }

    
    
    if (indexPath.row==1) {
      
        
    }
//    }
    
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5,5, 5);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
