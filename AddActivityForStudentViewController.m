//
//  AddActivityForStudentViewController.m
//  SampleForKaaylabs
//
//  Created by BALACHANDAR on 03/03/17.
//  Copyright © 2017 Venugopal Devarala. All rights reserved.
//

#import "AddActivityForStudentViewController.h"
#import "Font_Face_Controller.h"
#import "MainViewController.h"
#import "ELR_loaders_.h"
#import "ImageCustomClass.h"
@interface AddActivityForStudentViewController ()

@end

@implementation AddActivityForStudentViewController


static NSInteger  START_DATE_TEXTFIELD_TAG = 201;
static NSInteger  END_DATE_TEXTFIELD_TAG = 202;
static NSInteger  START_TIME_TEXTFIELD_TAG = 203;
static NSInteger  END_TIME_TEXTFIELD_TAG = 204;
static NSInteger  STUDENT_LIST_TABLE_TAG = 205;
static NSInteger  WEBSERVICE_ADD_ACTIVITY_TAG = 302;
static NSInteger  WEBSERVICE_TO_GET_ACTIVITY_INFO_WHILE_EDITING = 303;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self restoreToDefaults];
    if (_isEditActivity) {
        [self webserviceToGetActivityInfoWhileEditing];
    }
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - General

-(void) restoreToDefaults
{
    _startDateTextField.tag = START_DATE_TEXTFIELD_TAG;
    _startTimeTextField.tag = START_TIME_TEXTFIELD_TAG;
    _endDateTextField.tag = END_DATE_TEXTFIELD_TAG;
    _endTimeTextfield.tag = END_TIME_TEXTFIELD_TAG;

    activityIdReceived= @"";
    
    [self addDatePickerView];
    [self addTimePickerView];
    [self Navigation_bar];
    [self changeLanguage];
//    [self webserviceToGetChildInfo];
}

-(void) showAlert : (NSString * ) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Navigation Bar


-(void)Navigation_bar
{
    
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName:[Font_Face_Controller opensanssemibold:15],
                                                                    NSForegroundColorAttributeName: [UIColor blackColor]
                                                                    };
    
    
    
    
    
    //    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
    
    
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
    
    
   
}

-(void) backButtonPressed: (id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) tickButtonPressed: (id) sender
{
    if ([_startDateTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start date" value:@"" table:nil]] && !_startDateTextField.isHidden)
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
    else if ([_endTimeTextfield.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End time" value:@"" table:nil]])
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

-(NSString *) formatDateWithString : (NSString *) dateStringReceived
{
    
    //    03/02/2017 10:00
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *startDate = [dateFormat dateFromString:dateStringReceived];
    
    [dateFormat setDateFormat:@"MM/dd/yyyy HH:mm"];
    
    NSString *startDateString = [dateFormat stringFromDate:startDate];
    
    return startDateString;
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
    
    _startDateTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start date" value:@"" table:nil];
    _startTimeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start time" value:@"" table:nil];
    _endDateTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date" value:@"" table:nil];
    _endTimeTextfield.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End time" value:@"" table:nil];
    _scheduleTitleLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Title" value:@"" table:nil];
    _scheduleTitleTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule Title" value:@"" table:nil];
    _descriptionLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
    _descriptionTextView.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil];
    
    //    groupSelectionLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Group Selection" value:@"" table:nil];
    //    allergiesLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"USE DRAFT" value:@"" table:nil];
}

#pragma mark - Web service

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
    
    
//   {"securityKey":"H67jdS7wwfh","loginUserID":"1","description":"Checking mobile app","fromdate": "03/02/2017 10:00","todate":"03/02/2017 11:00","scheduleType":"own_booking","title":"titlemobileapp","language":"en"}
    
    NSString * fromDateString = [self formatDateWithString: [NSString stringWithFormat:@"%@ %@",_startDateTextField.text,_startTimeTextField.text] ];
    NSString * toDateString = [self formatDateWithString: [NSString stringWithFormat:@"%@ %@",_endDateTextField.text,_endTimeTextfield.text] ];
    
    NSLog(@"postDict %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]);

    
    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",@"own_booking",@"scheduleType",fromDateString,@"fromdate",toDateString,@"todate",_scheduleTitleTextField.text,@"title",activityIdReceived,@"id",_descriptionTextView.text,@"description",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];
    
    
    //    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"],@"loginUserID",@"en",@"language",_startDateTExtField.text,@"FromDateVacation",_endDateTextField.text,@"ToDateVacation",_descriptionTextView.text,@"ReqDescription",nil];
    responsesData = [[NSMutableData alloc]init];
    
    NSError * error;
    NSLog(@"postDict %@",postDict);
    
    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://dev.elar.se/mobile_api/viewParentUser"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/addactivityforStudent",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
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
    
     NSLog(@"postDict %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]);
    
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
    if (tag == WEBSERVICE_ADD_ACTIVITY_TAG) {
           if ([dictionaryReceived objectForKey:@"status"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionaryReceived objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            
            
            
            UIAlertAction* OKAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
//                                                                 for (UIViewController *controller in self.navigationController.viewControllers)
//                                                                 {
//                                                                     if ([controller isKindOfClass:[MainViewController class]])
//                                                                     {
//                                                                         [self.navigationController popToViewController:controller
//                                                                                                               animated:YES];
//                                                                         break;
//                                                                     }
//                                                                 }
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
        _startDateTextField.text = [arrayBySplittingTheStartDate objectAtIndex:0];
        _startTimeTextField.text = [arrayBySplittingTheStartDate objectAtIndex:1];
        
        NSString * endDAteAndTimeReceived = [schemaDictionary objectForKey:@"end"];
        
        NSArray * arrayBySplittingTheEndDate = [endDAteAndTimeReceived componentsSeparatedByString:@" "];
        _endDateTextField.text = [arrayBySplittingTheEndDate objectAtIndex:0];
        _endTimeTextfield.text = [arrayBySplittingTheEndDate objectAtIndex:1];
        
        _scheduleTitleTextField.text = [schemaDictionary objectForKey:@"title"];
        
        _descriptionTextView.text = [[schemaDictionary objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];

        activityIdReceived = [schemaDictionary objectForKey:@"id"];
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



#pragma mark - Picker & Date Picker



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
    
    
    _startDateTextField.inputView = datePicker;
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
    _startDateTextField.inputAccessoryView = myToolbar;
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
    _endTimeTextfield.inputView = timePicker;
    
    
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
    _endTimeTextfield.inputAccessoryView = myToolbar;
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


-(void)doneButtonClicked
{
   
    [_startDateTextField resignFirstResponder];
    [_endDateTextField resignFirstResponder];
    [_startTimeTextField resignFirstResponder];
    [_endTimeTextfield resignFirstResponder];
    [_descriptionTextView resignFirstResponder];
}
-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    
    if (datePicker.tag == START_DATE_TEXTFIELD_TAG) {
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        _startDateTextField.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
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
        _endTimeTextfield.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:timePicker.date]];
        
    }
    //assign text to label
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
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
        //        _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 800);
//        CGPoint bottomOffset = CGPointMake(0, self.mainScrollView.contentSize.height - self.mainScrollView.bounds.size.height - 80);
//        [self.mainScrollView setContentOffset:bottomOffset animated:YES];
        if ([textView.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil]]) {
            textView.text = @"";
        }
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    //    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600);
    CGPoint bottomOffset = CGPointMake(0, self.mainScrollView.contentSize.height - self.mainScrollView.bounds.size.height);
//    [self.mainScrollView setContentOffset:bottomOffset animated:YES];
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