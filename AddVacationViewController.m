//
//  AddVacationViewController.m
//  SampleForKaaylabs
//
//  Created by admin on 11/8/16.
//  Copyright © 2016 Venugopal Devarala. All rights reserved.
//

#import "AddVacationViewController.h"
#import "ELR_loaders_.h"
#import "Font_Face_Controller.h"
#import "ImageCustomClass.h"
@interface AddVacationViewController ()

@end

@implementation AddVacationViewController

static NSInteger  START_DATE_TEXTFIELD_TAG = 201;
static NSInteger  END_DATE_TEXTFIELD_TAG = 202;
static NSInteger  START_TIME_TEXTFIELD_TAG = 203;
static NSInteger  END_TIME_TEXTFIELD_TAG = 204;
static const NSInteger WEBSERVICE_ADD_VACATION = 1001;


- (void)viewDidLoad {
//    self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];
    [self restoreToDefaults];
    [self addDatePickerView];
    [self addTimePickerView];
    // Do any additional setup after loading the view.
}

#pragma mark - General

-(void) restoreToDefaults
{
    self.navigationController.navigationBarHidden = NO;
    
    api = [[APIWithProtocol alloc]init];
    api.delegateObject = self;

    
    [self changeLanguage];
        [self Navigation_bar];
    
//    courseArray = [[NSMutableArray alloc]initWithObjects:@"iOS",@"Android",@"Php", nil];
//    _selectCourseTextField.tag = SELECT_COURSE_TEXTFIELD_TAG;
//    _selectGroupTextField.tag = SELECT_GROUP_TEXTFIELD_TAG;
//    _scheduleTypeTextField.tag = SCHEDULE_TYPE_TEXTFIELD_TAG;
    _startDateTExtField.tag = START_DATE_TEXTFIELD_TAG;
    _endDateTextField.tag = END_DATE_TEXTFIELD_TAG;
    _startTimeTextField.tag = START_TIME_TEXTFIELD_TAG;
    _endTimeTextField.tag = END_TIME_TEXTFIELD_TAG;
//    selectedItems = [[NSMutableArray alloc]init];
    _mainScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width+100);
}

-(void) changeLanguage
{
    _startDateTExtField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start date" value:@"" table:nil];
    _startTimeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start time" value:@"" table:nil];
    _endDateTextField.placeholder = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date" value:@"" table:nil];
    _endTimeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End time" value:@"" table:nil];
    _descriptionLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
    _descriptionTextView.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil];
//    groupSelectionLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Group Selection" value:@"" table:nil];
    //    allergiesLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"USE DRAFT" value:@"" table:nil];
}


-(BOOL) checkIfStartDateIsGreater
{
    NSString * startDateString = [NSString stringWithFormat:@"%@", _startDateTExtField.text];
    NSString * endDateString = [NSString stringWithFormat:@"%@", _endDateTextField.text];
    NSDate* startdate = [self convertSitingToDate:startDateString];
    NSDate* enddate = [self convertSitingToDate:endDateString];
    NSTimeInterval distanceBetweenDates = [enddate timeIntervalSinceDate:startdate];
    double secondsInMinute = 60;
    NSInteger secondsBetweenDates = distanceBetweenDates / secondsInMinute;
    
    if (secondsBetweenDates == 0)
    return YES;
    else if (secondsBetweenDates < 0)
    return YES;
    else
    return NO;
}

-(NSDate *) convertSitingToDate : (NSString *) dateString
{
    //    NSString *dateStr = @"Tue, 25 May 2010 12:53:58 +0000";
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSDate *date = [dateFormat dateFromString:dateString];
    
    return date;
}

-(void) showAlertWithMessgae : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIButton Actions

-(void) backButtonPressed : (id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)tickButtonClicke:(id)sender {
    
    if ([_startDateTExtField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start date" value:@"" table:nil]])
    {
        [self showAlertWithMessgae:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Please select start date" value:@"" table:nil]];
    }
    else if ([_endDateTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date" value:@"" table:nil]])
    {
        [self showAlertWithMessgae:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Please select end date" value:@"" table:nil]];
    }
    else if ([_descriptionTextView.text isEqualToString:@""] || [_descriptionTextView.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil]])
    {
        [self showAlertWithMessgae:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Please enter description" value:@"" table:nil]];
    }
    else if ([self checkIfStartDateIsGreater])
    {
        [self showAlertWithMessgae:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date should be recent" value:@"" table:nil]];
    }
    else
    {
        NSLog(@"Success");
        [self webserviceFordate];
    }

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
    
    
    _startDateTExtField.inputView = datePicker;
    _endDateTextField.inputView = datePicker;
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    _startDateTExtField.inputAccessoryView = myToolbar;
    _endDateTextField.inputAccessoryView = myToolbar;
    _descriptionTextView.inputAccessoryView = myToolbar;
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
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    _startTimeTextField.inputAccessoryView = myToolbar;
    _endTimeTextField.inputAccessoryView = myToolbar;
}


-(void)doneButtonClicked
{
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
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
        _startDateTExtField.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
    }
    else if(datePicker.tag == END_DATE_TEXTFIELD_TAG)
    {
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString *) formatDateWithString : (NSString *) dateStringReceived
{
    
    //    03/02/2017 10:00
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    
    NSDate *startDate = [dateFormat dateFromString:dateStringReceived];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *startDateString = [dateFormat stringFromDate:startDate];
    
    return startDateString;
}

-(void) webserviceFordate  {
    
    [self mStartIndicater];
    
    
//    {"securityKey":"H67jdS7wwfh","loginUserID":"44","FromDateVacation":"2016-11-14","ToDateVacation":"2016-11-19","ReqDescription":"Added for teacher"}

    NSString * fromDateString = [self formatDateWithString:_startDateTExtField.text];
    NSString * toDateString = [self formatDateWithString:_endDateTextField.text];
    
    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",fromDateString,@"FromDateVacation",toDateString,@"ToDateVacation",_descriptionTextView.text,@"ReqDescription",nil];
    _responsesData = [[NSMutableData alloc]init];
    
    NSLog(@"postDict %@",postDict);
    
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/addVacationForTeacher",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
    
    [api CallWebserviceWithDataParametrs:postDict WithURL:url withMsgType:1];

    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/addVacationForTeacher",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:60.0];
//    
//    [request addValue:@"application/json" forHTTPHeaderField:@ "Content-Type"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    
//    [request setHTTPMethod:@"POST"];
//    
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
//    [request setHTTPBody:postData];
//    
//    
//    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        //        NSLog(@"data:%@",data);
//        id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"dictionaryreceived %@",dictionaryreceived);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self ParseArray:dictionaryreceived WithTag:WEBSERVICE_ADD_VACATION];
//        });
//        
//    }];
//    
//    [postDataTask resume];
    
}

-(void) ParseArray : (NSDictionary *) dictionaryReceived WithTag : (int) tag
{
    
    if ([[dictionaryReceived objectForKey:@"message"] isEqualToString:@"Added successfully"]) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:[dictionaryReceived objectForKey:@"message"]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                [self.navigationController popViewControllerAnimated:YES];
                             }];
        [alert addAction:ok]; // add action to uialertcontroller
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Failed to add Vacation" value:@"" table:nil]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [self.navigationController popViewControllerAnimated:YES];
                             }];
        [alert addAction:ok]; // add action to uialertcontroller

    }
//    if (tag == WEBSERVICE_VIEW_BUTTON) {
//        //        if ([dictionaryReceived objectForKey:@"status"] == 0 ) {
//        //            NSDictionary * dictionaryWithEachIndex =[dictionaryReceived objectForKey:@"file"];
//        //            NSString * filePath = [dictionaryWithEachIndex objectForKey:@"path"];
//        
//        ViewFoodMenuWebViewViewController *pdfViewController = [[ViewFoodMenuWebViewViewController alloc]init];
//        [self.navigationController pushViewController:pdfViewController animated:YES ];
//        
//        
//        //        }
//        
//    }
//    else if (tag == WEBSERVICE_DELETE_BUTTON) {
//        if ([dictionaryReceived objectForKey:@"status"] == 0 ) {
//        }
//        else
//        {
//            
//        }
//    }
//    else
//    {
//        //    arrayWithDatesFromWebService = [[NSMutableArray alloc]init];
//        NSMutableArray * arrayFromMainDictionary = [dictionaryReceived objectForKey:@"schemaCalendar"];
//        for (int i = 0; i<[arrayFromMainDictionary count]; i++) {
//            NSDictionary * dictionaryWithEachIndex =[arrayFromMainDictionary objectAtIndex:i];
//            
//            NSDictionary * dictionaryInsideSchema =[dictionaryWithEachIndex objectForKey:@"Schema"];
//            NSLog(@"dictionaryInsideSchema  %@",dictionaryInsideSchema);
//            [arrayWithDictionariesInFoodMenu addObject:dictionaryInsideSchema];
//            
//            
//            [arrayWithTitleOfEvents addObject:dictionaryInsideSchema[@"title"]];
//            [arrayWithStartDateOfEvents addObject:dictionaryInsideSchema[@"start"]];
//            [arrayWithendDateOfEvents addObject:dictionaryInsideSchema[@"end"]];
//            if ([arrayWithTitleOfEvents count] != 0) {
//                [AddfoodNotesTableView reloadData];
//            }
//        }
//    }
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
    
    
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Vacation" value:@"" table:nil] ;
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *butImage1 = [[UIImage imageNamed:@"tickForHeader"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    //        [button1 setBackgroundImage:butImage1 forState:UIControlStateNormal];
    [button1 setImage:butImage1 forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(tickButtonClicke:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - UITextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    pickerView.tag = textField.tag;
    datePicker.tag = textField.tag;
    timePicker.tag = textField.tag;
    
    [self LabelTitle:textField];
    
    if ([textField isEqual: _descriptionTextView]) {
        _mainScrollView.contentOffset = CGPointMake(0, 200);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    _mainScrollView.contentOffset = CGPointMake(0, 0);
}


#pragma mark - UITextView Delegates

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView isEqual: _descriptionTextView]) {
//        _mainScrollView.contentOffset = CGPointMake(0, 170);
        if ([textView.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil]]) {
            textView.text = @"";
        }
    }
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil];
    }
//    _mainScrollView.contentOffset = CGPointMake(0, 0);
}


#pragma mark - API Protocol service

-(void)dataIsReceived:(id)dataReceived withMsgType:(int)msgType
{
        [self mStopIndicater];
        NSLog(@"data received %@",dataReceived);
        [self ParseArray:dataReceived WithTag:WEBSERVICE_ADD_VACATION];}

-(void)errorOccured:(NSString *)errorString withMsgType:(int)msgType
{
    [self showAlertWithMessgae:errorString];
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
