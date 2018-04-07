//
//  AddActivityForParentsViewController.m
//  Smart Classroom Manager
//
//  Created by admin on 2/22/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "AddActivityForParentsViewController.h"
#import "StudentListTableViewCell.h"
#import "Font_Face_Controller.h"
#import "ELR_loaders_.h"
#import "MainViewController.h"
#import "ImageCustomClass.h"
@interface AddActivityForParentsViewController ()

@end

@implementation AddActivityForParentsViewController


static NSInteger  START_DATE_TEXTFIELD_TAG = 201;
static NSInteger  END_DATE_TEXTFIELD_TAG = 202;
static NSInteger  START_TIME_TEXTFIELD_TAG = 203;
static NSInteger  END_TIME_TEXTFIELD_TAG = 204;
static NSInteger  STUDENT_LIST_TABLE_TAG = 205;
static NSInteger  STUDENT_CELL_CHECK_BOX_BUTTON_TAG = 2000;
static NSInteger  WEBSERVICE_GET_STUDENT_LIST_TAG = 301;
static NSInteger  WEBSERVICE_ADD_ACTIVITY_TAG = 302;
static NSInteger  WEBSERVICE_TO_GET_ACTIVITY_INFO_WHILE_EDITING = 303;




- (void)viewDidLoad {
    [super viewDidLoad];
    [self restoreToDefaults];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    [self changeHeightOfScrollViewAndTableView];
   
    

}

#pragma mark - General

-(void) restoreToDefaults
{
    _tableViewForchildrenList.tag = STUDENT_LIST_TABLE_TAG;
    _startDateTExtField.tag = START_DATE_TEXTFIELD_TAG;
    _startTimeTextField.tag = START_TIME_TEXTFIELD_TAG;
    _endDateTextField.tag = END_DATE_TEXTFIELD_TAG;
    _endTimeTextField.tag = END_TIME_TEXTFIELD_TAG;
    
    
    studentList = [[NSMutableArray alloc]init];
    selectedItems = [[NSMutableArray alloc]init];
    
    activityIdReceived = @"";
    
    [self addDatePickerView];
    [self addPickerView];
    [self addTimePickerView];
    [self Navigation_bar];
    [self changeLanguage];
    [self webserviceToGetChildInfo];
    
}

-(void) changeLanguage
{
//    _selectCourseTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Course" value:@"" table:nil];
//    _selectGroupTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select group" value:@"" table:nil];
//    _scheduleTypeTextField.placeholder = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule type" value:@"" table:nil];
//    _aspectLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Aspect" value:@"" table:nil];
//    _examinationTypeLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type" value:@"" table:nil];
//    _studentTypeLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Students" value:@"" table:nil];
    
    _startDateLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start date" value:@"" table:nil];
    _startTimeLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start time" value:@"" table:nil];
    _endDateLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date" value:@"" table:nil];
    _endTimeLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End time" value:@"" table:nil];
    
    _startDateTExtField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start date" value:@"" table:nil];
    _startTimeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start time" value:@"" table:nil];
    _endDateTextField.placeholder = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date" value:@"" table:nil];
    _endTimeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End time" value:@"" table:nil];
    _scheduleTitleLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Title" value:@"" table:nil];
    _scheduleTitleTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule Title" value:@"" table:nil];
    _descriptionLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
    _descriptionTextView.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil];
    
    //    groupSelectionLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Group Selection" value:@"" table:nil];
    //    allergiesLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"USE DRAFT" value:@"" table:nil];
}

-(void) changeHeightOfScrollViewAndTableView
{
    _heightConstraintForChildrenTableView.constant = [studentList count] * 44;
    _mainScrollView.contentSize = CGSizeMake(_mainScrollView.frame.size.width, _heightConstraintForChildrenTableView.constant + 600);
}

-(void) showAlert : (NSString * ) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(NSString *) formatDateWithString : (NSString *) dateStringReceived
{
    
//   2016-11-14
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *startDate = [dateFormat dateFromString:dateStringReceived];
    
    [dateFormat setDateFormat:@"MM/dd/yyyy HH:mm"];
    
    NSString *startDateString = [dateFormat stringFromDate:startDate];
    
    return startDateString;
}

#pragma mark - Webservice

-(void) webserviceToGetChildInfo  {
    
    [self mStartIndicater];
    
    
    //    {"securityKey":"H67jdS7wwfh","loginUserID":"44","FromDateVacation":"2016-11-14","ToDateVacation":"2016-11-19","ReqDescription":"Added for teacher"}
//    {"securityKey":"H67jdS7wwfh","loginUserID":"257","language":"en"}
    
    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];

    
//    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"],@"loginUserID",@"en",@"language",_startDateTExtField.text,@"FromDateVacation",_endDateTextField.text,@"ToDateVacation",_descriptionTextView.text,@"ReqDescription",nil];
    responsesData = [[NSMutableData alloc]init];
    
    NSError * error;
//    NSLog(@"postDict %@",postDict);
    NSLog(@"postDict %@",postDict);
    
    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    
//     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://dev.elar.se/mobile_api/viewParentUser"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/viewParentUser",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]  ]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@ "Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //        NSLog(@"data:%@",data);
        id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"dictionaryreceived %@",dictionaryreceived);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (dictionaryreceived == nil) {
//                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"No food notes available"  preferredStyle:UIAlertControllerStyleAlert];
//                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                    [self dismissViewControllerAnimated:YES completion:nil];
//                }]];
//                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
            [self ParseArray:dictionaryreceived WithTag:WEBSERVICE_GET_STUDENT_LIST_TAG];
            }
        });
        
    }];
    
    [postDataTask resume];
    
}

-(void) webserviceToAddActivity  {
    
    [self mStartIndicater];
    
    //scheduleType:own_booking
    //childrenlist:array()
    //fromdate:03/02/2017 10:00
    //todate:03/02/2017 11:00
    //title:just
    //description:chcking
    //    id:
    //loginuserid:
    //securitykey:
    
    
    //    {"securityKey":"H67jdS7wwfh","loginUserID":"44","FromDateVacation":"2016-11-14","ToDateVacation":"2016-11-19","ReqDescription":"Added for teacher"}
    //    {"securityKey":"H67jdS7wwfh","loginUserID":"257","language":"en"}
    
    NSString * fromDateString = [self formatDateWithString: [NSString stringWithFormat:@"%@ %@",_startDateTExtField.text,_startTimeTextField.text] ];
    NSString * toDateString = [self formatDateWithString: [NSString stringWithFormat:@"%@ %@",_endDateTextField.text,_endTimeTextField.text] ];

    
    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",@"own_booking",@"scheduleType",selectedItems,@"childrenlist",fromDateString,@"fromdate",toDateString,@"todate",_scheduleTitleTextField.text,@"title",_descriptionTextView.text,@"description",activityIdReceived,@"id",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];
    
    
    //    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"],@"loginUserID",@"en",@"language",_startDateTExtField.text,@"FromDateVacation",_endDateTextField.text,@"ToDateVacation",_descriptionTextView.text,@"ReqDescription",nil];
    responsesData = [[NSMutableData alloc]init];
    
    NSError * error;
    NSLog(@"postDict %@",postDict);
    
    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://dev.elar.se/mobile_api/viewParentUser"]];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/addactivityforParent",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@ "Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //        NSLog(@"data:%@",data);
        id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"dictionaryreceived %@",dictionaryreceived);
        dispatch_async(dispatch_get_main_queue(), ^{
                        [self ParseArray:dictionaryreceived WithTag:WEBSERVICE_ADD_ACTIVITY_TAG];
        });
        
    }];
    
    [postDataTask resume];
    
}

-(void) webserviceToGetActivityInfoWhileEditing  {
    
    [self mStartIndicater];
    
    //   {"securityKey":"H67jdS7wwfh","loginUserID":"1","schema_id":"1022","language":"en"}
    
    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",self.schemaIdReceived,@"schema_id",nil];
    responsesData = [[NSMutableData alloc]init];
    
    NSError * error;
    NSLog(@"postDict %@",postDict);
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSLog(@"[NSUserDefaults standardUserDefaults]valueForKey:@sub_domain] %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]);
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@mobile_api/getSchemadetailsforstudent",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
                //                [self ParseArray:responseObject withTag:WEBSERVICE_TO_GET_ACTIVITY_INFO_WHILE_EDITING];
                [self ParseArray:responseObject WithTag:WEBSERVICE_TO_GET_ACTIVITY_INFO_WHILE_EDITING];
                
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
        [self mStopIndicater];
    }] resume];
    
    
    
}



-(void) ParseArray : (NSDictionary *) dictionaryReceived WithTag : (int) tag
{
    [self mStopIndicater];
     if (tag == WEBSERVICE_GET_STUDENT_LIST_TAG)
     {
        studentList =[dictionaryReceived objectForKey:@"children"];
//         NSDictionary * childrenDictionary =
         [_tableViewForchildrenList reloadData];
         [self changeHeightOfScrollViewAndTableView];
         if (_isEditActivity) {
             [self webserviceToGetActivityInfoWhileEditing];
         }
     }
    else if (tag == WEBSERVICE_ADD_ACTIVITY_TAG)
    {
        if ([dictionaryReceived objectForKey:@"status"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionaryReceived objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            

            
            UIAlertAction* OKAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
//                                                                      for (UIViewController *controller in self.navigationController.viewControllers)
//                                                                      {
//                                                                          if ([controller isKindOfClass:[MainViewController class]])
//                                                                          {
//                                                                              [self.navigationController popToViewController:controller
//                                                                                                                    animated:YES];
//                                                                              break;
//                                                                          }
//                                                                      }
//                                                                      [self.navigationController popViewControllerAnimated:YES];
                                                                      
                                                                      UIViewController *View = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-4];
                                                                      [self.navigationController popToViewController:View animated:YES];
                                                                  }];
            
            [alertController addAction:OKAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            [self showAlert:[dictionaryReceived objectForKey:@"msg"]];
        }
    }
    else if(tag == WEBSERVICE_TO_GET_ACTIVITY_INFO_WHILE_EDITING)
    {
        NSLog(@"%@",dictionaryReceived);
        //        NSDictionary * dictionaryFrmMainDictionary = [dictionaryReceived objectForKey:@"data"];
        NSDictionary * schemaDictionary  = [dictionaryReceived objectForKey:@"Schema"];
        NSString * startDAteAndTimeReceived = [schemaDictionary objectForKey:@"start"];
        
        NSArray * arrayBySplittingTheStartDate = [startDAteAndTimeReceived componentsSeparatedByString:@" "];
        _startDateTExtField.text = [arrayBySplittingTheStartDate objectAtIndex:0];
        _startTimeTextField.text = [arrayBySplittingTheStartDate objectAtIndex:1];
        
        NSString * endDAteAndTimeReceived = [schemaDictionary objectForKey:@"end"];
        
        NSArray * arrayBySplittingTheEndDate = [endDAteAndTimeReceived componentsSeparatedByString:@" "];
        _endDateTextField.text = [arrayBySplittingTheEndDate objectAtIndex:0];
        _endTimeTextField.text = [arrayBySplittingTheEndDate objectAtIndex:1];
        
        _scheduleTitleTextField.text = [schemaDictionary objectForKey:@"title"];
        
        _descriptionTextView.text = [[schemaDictionary objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        
        [selectedItems addObject:[NSString stringWithFormat:@"%@",[schemaDictionary objectForKey:@"user_id"]]];
        
        activityIdReceived =[schemaDictionary objectForKey:@"id"];

        
        
        [_tableViewForchildrenList reloadData];
    }

    
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

#pragma mark - Navigation Bar


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
    //    user_pic.layer.borderWidth=0;
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
    
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName:[Font_Face_Controller opensanssemibold:15],
                                                                    NSForegroundColorAttributeName: [UIColor blackColor]
                                                                    };
    
    
    
    
    
    
    //    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
    
    
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
    [button addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Activity" value:@"" table:nil] ;
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *butImage1 = [[UIImage imageNamed:@"tickForHeader"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    //        [button1 setBackgroundImage:butImage1 forState:UIControlStateNormal];
    [button1 setImage:butImage1 forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(tickButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(0, 0, 20, 20);
    [button1 setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    UIBarButtonItem *backButton1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem = backButton1;
    
    
    //  [[self navigationItem] setBackBarButtonItem:backButton1];
    
    
    
    //    }
    //    else
    //    {
    //        self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule" value:@"" table:nil] ;
    //    }
    
}

-(void) backButtonPressed: (id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) tickButtonPressed: (id) sender
{
    if ([selectedItems count] == 0)
    {
        [self showAlert:@"Please select students"];
    }
        else if ([_startDateTExtField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start date" value:@"" table:nil]] && !_startDateTExtField.isHidden)
        {
            [self showAlert:@"Please select Start date"];
        }
        else if ([_startTimeTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start time" value:@"" table:nil]]  && !_startTimeTextField.isHidden)
        {
            [self showAlert:@"Please select Start time"];
        }
        else if ([_endDateTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date" value:@"" table:nil]])
        {
            [self showAlert:@"Please select End date"];
        }
        else if ([_endTimeTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End time" value:@"" table:nil]])
        {
            [self showAlert:@"Please select End time"];
        }
    
    else if ([_scheduleTitleTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule Title" value:@"" table:nil]])
    {
        [self showAlert:@"Please enter title"];
    }
    else if ([_descriptionTextView.text isEqualToString:@""] || [_descriptionTextView.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil]])
    {
        [self showAlert:@"Please enter description"];
    }
    else
    {
        [self webserviceToAddActivity];
    }

}
#pragma mark - Picker & Date Picker

-(void)addPickerView
{
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    [pickerView setDataSource: self];
    [pickerView setDelegate: self];
    pickerView.showsSelectionIndicator = YES;
    _selectCourseTextField.inputView = pickerView;
    _selectGroupTextField.inputView = _tableViewForGroup;
    _scheduleTypeTextField.inputView = pickerView;
    
    
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
     UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonClicked)];
    
//    UIBarButtonItem *doneButton =
//    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                  target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    _selectCourseTextField.inputAccessoryView = myToolbar;
    _selectGroupTextField.inputAccessoryView = myToolbar;
    _scheduleTypeTextField.inputAccessoryView = myToolbar;
}


-(void)addDatePickerView
{
    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0,10, 150)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    datePicker.hidden=NO;
    if (_selectedDate != nil)
    {
        [datePicker setDate:_selectedDate animated:NO];
    }
    
    [datePicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
    //    [self.view addSubview:datePicker];
    
    
    _startDateTExtField.inputView = datePicker;
    _endDateTextField.inputView = datePicker;
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    
     UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonClicked)];
    
//    UIBarButtonItem *doneButton =
//    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                  target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    _startDateTExtField.inputAccessoryView = myToolbar;
    _endDateTextField.inputAccessoryView = myToolbar;
}

-(void)addTimePickerView
{
    timePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0,10, 150)];
    timePicker.datePickerMode=UIDatePickerModeTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    timePicker.hidden=NO;
    timePicker.date=[NSDate date];
    
    [timePicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
    //    [self.view addSubview:datePicker];
    
    
    _startTimeTextField.inputView = timePicker;
    _endTimeTextField.inputView = timePicker;
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    
     UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonClicked)];
    
//    UIBarButtonItem *doneButton =
//    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                  target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    
    
    _startTimeTextField.inputAccessoryView = myToolbar;
    _endTimeTextField.inputAccessoryView = myToolbar;
    _descriptionTextView.inputAccessoryView = myToolbar;
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:30];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setYear:-30];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    //    [datePicker setMaximumDate:maxDate];
    [datePicker setMinimumDate:minDate];
    //    [timePicker setMinimumDate:minDate];
}

#pragma mark - UIButtonActions

- (IBAction)addActivityViewCellCheckBoxButtonclicked:(id)sender {
    
    UIButton * buttonClicked = (UIButton *) sender;
    
    if (![selectedItems containsObject:[[studentList objectAtIndex:buttonClicked.tag - STUDENT_CELL_CHECK_BOX_BUTTON_TAG]objectForKey:@"id" ]]) {
        [selectedItems addObject:[[studentList objectAtIndex:buttonClicked.tag - STUDENT_CELL_CHECK_BOX_BUTTON_TAG]objectForKey:@"id" ]];
    }
    else
    {
        [selectedItems removeObject:[[studentList objectAtIndex:buttonClicked.tag - STUDENT_CELL_CHECK_BOX_BUTTON_TAG]objectForKey:@"id" ]];
    }
    [_tableViewForchildrenList reloadData];
}


-(void)doneButtonClicked
{
    [_selectGroupTextField resignFirstResponder];
    [_selectCourseTextField resignFirstResponder];
    [_scheduleTypeTextField resignFirstResponder];
    [_startDateTExtField resignFirstResponder];
    [_endDateTextField resignFirstResponder];
    [_startTimeTextField resignFirstResponder];
    [_endTimeTextField resignFirstResponder];
    [_descriptionTextView resignFirstResponder];
}
-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    
    if (datePicker.tag == START_DATE_TEXTFIELD_TAG) {
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        _startDateTExtField.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
    }
    else if(datePicker.tag == END_DATE_TEXTFIELD_TAG)
    {
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        _endDateTextField.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
        
    }
    else if(timePicker.tag == START_TIME_TEXTFIELD_TAG)
    {
        [dateFormat setDateFormat:@"HH:mm:ss"];
        _startTimeTextField.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:timePicker.date]];
        
    }
    else
    {
        [dateFormat setDateFormat:@"HH:mm:ss"];
        _endTimeTextField.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:timePicker.date]];
        
    }
    //assign text to label
}



#pragma mark - TableView Delegates & Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section
{
    if (tableView.tag == STUDENT_LIST_TABLE_TAG) {
        return [studentList count];
    }
    else
    {
        return 4;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView.tag == STUDENT_LIST_TABLE_TAG) {
        
     
        StudentListTableViewCell *studentCell;
        studentCell= [tableView dequeueReusableCellWithIdentifier: @"StudentListTableViewCell"];
        if (studentCell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StudentListTableViewCell" owner:self options:nil];
            studentCell = [nib objectAtIndex:0];
            
        }
//        NSDictionary * aspectdictionaryAtEachIndex = [aspectListArray objectAtIndex:indexPath.row];
//        NSDictionary * aspectdictionary = [aspectdictionaryAtEachIndex objectForKey:@"Aspect"];
        studentCell.studentNameLabel.text = [NSString stringWithFormat:@"%@ %@", [[studentList objectAtIndex:indexPath.row] objectForKey:@"USR_FirstName"],[[studentList objectAtIndex:indexPath.row] objectForKey:@"USR_LastName"] ];
        studentCell.checkBoxForStudentCell.tag = STUDENT_CELL_CHECK_BOX_BUTTON_TAG + indexPath.row;
       if ([selectedItems containsObject:[studentList [indexPath.row] objectForKey:@"id"]]) {
            [studentCell.checkBoxForStudentCell setImage:[UIImage imageNamed: @"click" ] forState:UIControlStateNormal];
        }
        else
        {
            [studentCell.checkBoxForStudentCell setImage:[UIImage imageNamed: @"nonclick" ] forState:UIControlStateNormal];
        }
        
        studentCell.selectionStyle = UITableViewCellSelectionStyleDefault;
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor clearColor];
        [studentCell setSelectedBackgroundView:bgColorView];
        
        
        return studentCell;
    }
    else
    {
        
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor clearColor];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView.tag == GROUP_TABLE_TAG) {
//        if (indexPath.row < groupArray.count - 2) {
//            selectedGroupString = @"";
//            if ([selectedItems indexOfObject:[[groupArray objectAtIndex:indexPath.row]objectForKey:@"id"]] != NSNotFound) {
//                [selectedItems removeObject:[[groupArray objectAtIndex:indexPath.row]objectForKey:@"id"]];
//            } else {
//                [selectedItems addObject:[[groupArray objectAtIndex:indexPath.row]objectForKey:@"id"]];
//            }
//        }
//        else
//        {
//            [selectedItems removeAllObjects];
//            selectedGroupString = [groupArray objectAtIndex:indexPath.row];
//        }
//        [tableView reloadData];
//    }
    // NSNumber *row = [NSNumber numberWithInt:indexPath.row];
    //    NSUInteger index = [selectedItems indexOfObject:indexPath.row];
    //    if (index != NSNotFound) {
    //        [selectedItems removeObjectAtIndex:index];
    //        [(UITableViewCell *) setAccessoryType:UITableViewCellAccessoryNone];
    //    } else {
    //        [selectedItems addObject:row];
    //        [(UITableViewCell *)(recognizer.view) setAccessoryType:UITableViewCellAccessoryCheckmark];
    //    }
    //
    //    NSString *cityString = [addedTocityArray objectAtIndex:indexPath.row];
    //    NSUserDefaults * cityDefault=[NSUserDefaults standardUserDefaults];
    //    [cityDefault setObject:cityString forKey:@"city"];
    //    NSString *cityIdString = [addedToCityIdArray objectAtIndex:indexPath.row];
    //    NSUserDefaults *cityIdDefault=[NSUserDefaults standardUserDefaults];
    //    [cityIdDefault setObject:cityIdString forKey:@"cityid"];
    //    [self dismissViewControllerAnimated:YES completion:nil];
    //[self performSegueWithIdentifier:@"CityToSignUp" sender:nil];
}


#pragma mark - UITextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    pickerView.tag = textField.tag;
    datePicker.tag = textField.tag;
    timePicker.tag = textField.tag;
    
//    if (textField.tag == SELECT_COURSE_TEXTFIELD_TAG) {
//        _selectCourseTextField.text=[[courseArray objectAtIndex:selectedIndexOfCourse] objectForKey:@"COU_Name"];
//    }
//    if (textField.tag == SCHEDULE_TYPE_TEXTFIELD_TAG) {
//        textField.text =  [typeArray objectAtIndex:selectedIndexOfScheduleType];
//    }
    
    if (textField.tag == START_DATE_TEXTFIELD_TAG || textField.tag == START_TIME_TEXTFIELD_TAG || textField.tag == END_DATE_TEXTFIELD_TAG || textField.tag == END_TIME_TEXTFIELD_TAG) {
        [self LabelTitle:nil];
    }
    
    if ([textField isEqual: _descriptionTextView]) {
        _mainScrollView.contentOffset = CGPointMake(0, 200);
    }
    else if ([textField isEqual:_scheduleTitleTextField])
    {
//        _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 650);
        if ([_scheduleTitleTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule Title" value:@"" table:nil]]) {
            _scheduleTitleTextField.text = @"";
            
        }
        CGPoint bottomOffset = CGPointMake(0, self.mainScrollView.contentSize.height - self.mainScrollView.bounds.size.height);
        [self.mainScrollView setContentOffset:bottomOffset animated:YES];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:_scheduleTitleTextField])
    {
        
        if ([_scheduleTitleTextField.text isEqualToString:@""]) {
            _scheduleTitleTextField.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule Title" value:@"" table:nil];
           
            
        }
         _mainScrollView.contentOffset = CGPointMake(0, 0);
//        _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600);
    }
    
    [textField resignFirstResponder];
    //      _mainScrollView.contentOffset = CGPointMake(0, 0);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


#pragma mark - UITextView Delegates

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView isEqual: _descriptionTextView]) {
        //        _mainScrollView.contentOffset = CGPointMake(0, 200);
        _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width,  900);
        CGPoint bottomOffset = CGPointMake(0, self.mainScrollView.contentSize.height - self.mainScrollView.bounds.size.height - 80);
        [self.mainScrollView setContentOffset:bottomOffset animated:YES];
        if ([textView.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil]]) {
            textView.text = @"";
        }
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
//    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600);
    CGPoint bottomOffset = CGPointMake(0, 0);
    [self.mainScrollView setContentOffset:bottomOffset animated:YES];
    if ([textView.text isEqualToString:@""]) {
        textView.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil];
    }
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
