//
//  NoteIconViewController.m
//  XIBTest
//
//  Created by jeff ayan on 02/01/17.
//  Copyright © 2017 jeff ayan. All rights reserved.
//

#import "NoteIconViewController.h"
#import "ELR_loaders_.h"
#import "Font_Face_Controller.h"
#import "add_retriever_note.h"
#import "ImageCustomClass.h"
@interface NoteIconViewController ()
{
    NSArray *TableViewDemoData;
}

@end

@implementation NoteIconViewController

static const NSInteger WEBSERVICE_FOOD_MENU = 1001;
static const NSInteger WEBSERVICE_VIEW_BUTTON = 1002;
static const NSInteger WEBSERVICE_DELETE_BUTTON = 1003;
static const NSInteger WEBSERVICE_GROUPS = 1004;

@synthesize responsesData= _responsesData;
@synthesize dateStringselected= _dateStringselected;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    pickerView = [[UIPickerView alloc] initWithFrame:[self RectMake:CGRectMake(0, 784, 320, 200) ]];
    [pickerView setBackgroundColor:[UIColor grayColor]];
    pickerView .delegate = self;
    pickerView.dataSource = self;
    myToolbar = [[UIToolbar alloc] initWithFrame:
                 [self RectMake:CGRectMake(0, 740, 320, 44)]];
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonClicked:)];

    
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked:)];
    [myToolbar setItems:[NSArray arrayWithObject:doneButton] animated:YES];
    [self.view addSubview:pickerView];
    [self.view addSubview:myToolbar];
    
    api = [[APIWithProtocol alloc]init];
    api.delegateObject = self;

   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    
    self.navigationController.navigationBarHidden = NO;
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    arrayWithTitleOfEvents = [[NSMutableArray alloc]init];
    arrayWithStartDateOfEvents = [[NSMutableArray alloc]init];
    arrayWithendDateOfEvents = [[NSMutableArray alloc]init];
    arrayWithDictionariesInFoodMenu = [[NSMutableArray alloc]init];
    
    
    
    NoteIconTableView.layer.cornerRadius = 4;
    NoteIconTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self Navigation_bar];
    
    
    
    NSLog(@"_dateStringselected %@",_dateStringselected);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [dateFormatter dateFromString:_dateStringselected];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
    
    [[NSUserDefaults standardUserDefaults]setValue:date_correct_format forKey:@"CalenderDate_Selected"];

     [self webserviceFordate:_dateStringselected];
}

- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) webserviceFordate : (NSString *) dtaeString  {
    
    [self mStartIndicater];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [dateFormatter dateFromString: _dateStringselected];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
    
    NSDictionary * postDict;
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
    
     postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",date_correct_format,@"date",nil];
    }
    else
    {
    postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",date_correct_format,@"date",nil];
    }
    _responsesData = [[NSMutableData alloc]init];
    
    NSError * error;
    NSLog(@"postDict %@",postDict);
    
    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/schemaDetailsForCurrentDay",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
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
        if (data != nil || data == NULL) {
            id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //        NSLog(@"dictionaryreceived %@",str);
            NSLog(@"dictionaryreceived %@",dictionaryreceived);
            dispatch_async(dispatch_get_main_queue(), ^{
                if(dictionaryreceived == nil)
                {
                    
                }
                else
                {
                    [self ParseArray:dictionaryreceived WithTag:WEBSERVICE_GROUPS];
                }
                
            });
        }
    }];
    
    [postDataTask resume];
    
    
    
}

-(void) ParseArray : (NSDictionary *) dictionaryReceived WithTag : (int) tag
{
    if (tag == WEBSERVICE_VIEW_BUTTON) {
        //        if ([dictionaryReceived objectForKey:@"status"] == 0 ) {
        //            NSDictionary * dictionaryWithEachIndex =[dictionaryReceived objectForKey:@"file"];
        //            NSString * filePath = [dictionaryWithEachIndex objectForKey:@"path"];
        
        ViewFoodMenuWebViewViewController *pdfViewController = [[ViewFoodMenuWebViewViewController alloc]init];
        [self.navigationController pushViewController:pdfViewController animated:YES ];
        
        
        //        }
        
    }
    else if (tag == WEBSERVICE_DELETE_BUTTON) {
        if ([dictionaryReceived objectForKey:@"status"] == 0 ) {
        }
        else
        {
            
        }
    }
    else if (tag == WEBSERVICE_GROUPS) {
        if ([dictionaryReceived objectForKey:@"status"] == 0 ) {
            
        }
        else
        {
            NSArray * userCoursesArray = [dictionaryReceived objectForKey:@"usercourses"];
            
            for (int i = 0; i<userCoursesArray.count; i++) {
                NSLog(@"dictionaryreceived %@",userCoursesArray[i]);
            }
            
            absentNoteCount =[[dictionaryReceived objectForKey:@"absent_note_count"] intValue];
            
             if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
                 if ([[dictionaryReceived objectForKey:@"absent_note_count"] intValue] == 0) {
                     courseArray = [[NSMutableArray alloc]initWithObjects:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Mark sick for whole day" value:@"" table:nil] ,[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Activity" value:@"" table:nil] , nil];
                 }
                 else if ([[dictionaryReceived objectForKey:@"absent_note_count"] intValue] == 1)
                 {
                     courseArray = [[NSMutableArray alloc]initWithObjects:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Mark sick for whole day" value:@"" table:nil] ,[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Activity" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"View Absent note" value:@"" table:nil], nil];
                 }
                 else if ([[dictionaryReceived objectForKey:@"absent_note_count"] intValue] == 2)
                 {
                     courseArray = [[NSMutableArray alloc]initWithObjects:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Mark sick for whole day" value:@"" table:nil] ,[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Activity" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Absent note" value:@"" table:nil], nil];
                 }
                 else
                 {
                     
                 }
                  if ([[dictionaryReceived objectForKey:@"absent_note_count"] intValue] == 0) {
                      
                  }
                 else  if ([[dictionaryReceived objectForKey:@"retriever_note_count"] intValue] == 1) {
                     [courseArray addObject:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"View Retriver note" value:@"" table:nil]];
                 }
                 else  if ([[dictionaryReceived objectForKey:@"retriever_note_count"] intValue] == 2) {
                     [courseArray addObject:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Retrieval Note" value:@"" table:nil]];

                 }
//                 if ([self isGivenDateGreater]) {
//                     [courseArray addObject:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Retrieval Note" value:@"" table:nil]];
//                     [courseArray addObject:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Absent note" value:@"" table:nil]];
//                 }


             }
            else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"elev"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"student"])
            {
                //student
                courseArray = [[NSMutableArray alloc]initWithObjects:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Activity" value:@"" table:nil] , nil];
                if (absentNoteCount == 1) {
                    [courseArray addObject:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"View Absent note" value:@"" table:nil]];
                }
                if ([[dictionaryReceived objectForKey:@"retriever_note_count"] intValue] == 1) {
                    [courseArray addObject:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"View Retriver note" value:@"" table:nil]];
                }
            }
            else
            {
            //teacherß
            if ([[dictionaryReceived objectForKey:@"absent_note_count"] intValue] == 0) {
                courseArray = [[NSMutableArray alloc]initWithObjects:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Vacation" value:@"" table:nil] ,[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Activity" value:@"" table:nil] , nil];
            }
            else if ([[dictionaryReceived objectForKey:@"absent_note_count"] intValue] == 1)
            {
                courseArray = [[NSMutableArray alloc]initWithObjects:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Vacation" value:@"" table:nil] ,[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Activity" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"View Absent note" value:@"" table:nil], nil];
            }
            else if ([[dictionaryReceived objectForKey:@"absent_note_count"] intValue] == 2)
            {
                courseArray = [[NSMutableArray alloc]initWithObjects:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Vacation" value:@"" table:nil] ,[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Activity" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Absent note" value:@"" table:nil], nil];
                
            }
            else
            {
                
            }
            }
            [pickerView reloadAllComponents];
            //    arrayWithDatesFromWebService = [[NSMutableArray alloc]init];
            NSMutableArray * arrayFromMainDictionary = [dictionaryReceived objectForKey:@"schemaCalendar"];
            for (int i = 0; i<[arrayFromMainDictionary count]; i++) {
                NSDictionary * dictionaryWithEachIndex =[arrayFromMainDictionary objectAtIndex:i];
                
                NSDictionary * dictionaryInsideSchema =[dictionaryWithEachIndex objectForKey:@"Schema"];
                NSLog(@"dictionaryInsideSchema  %@",dictionaryInsideSchema);
                [arrayWithDictionariesInFoodMenu addObject:dictionaryInsideSchema];
                
                
                //        [arrayWithTitleOfEvents addObject:dictionaryInsideSchema[@"title"]];
                //        [arrayWithStartDateOfEvents addObject:dictionaryInsideSchema[@"start"]];
                //         [arrayWithendDateOfEvents addObject:dictionaryInsideSchema[@"end"]];
                if ([arrayWithDictionariesInFoodMenu count] != 0) {
                    [NoteIconTableView reloadData];
                }
            }
        }
    }
    [self mStopIndicater];
    
    
}


-(BOOL) isGivenDateGreater
{
    
    NSTimeZone *inputTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    [dateFormat setTimeZone:inputTimeZone];
    
    NSDate *today = [NSDate date]; // it will give you current date
    NSDate *newDate = [dateFormat dateFromString:_dateStringselected]; // your date
    
    NSComparisonResult result;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
    result = [today compare:newDate]; // comparing two dates
    
    if(result==NSOrderedAscending)
    {
        NSLog(@"today is less");
    return YES;
    }
    else if(result==NSOrderedDescending)
    {
        NSLog(@"newDate is less");
    return NO;
    }
    else
    {
        NSLog(@"Both dates are same");
    return YES;
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
    
    
//    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule" value:@"" table:nil] ;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@", [self formatDateForHeader:_dateStringselected] ];

    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *butImage1 = [[UIImage imageNamed:@"plusImageInNavBar"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    //        [button1 setBackgroundImage:butImage1 forState:UIControlStateNormal];
    [button1 setImage:butImage1 forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(downloadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [courseArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return courseArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

-(void)downloadButtonPressed:(id)sender
{
    [self showPickerView:sender];
}

-(void)doneButtonClicked:(id)sender {
    
    
    NSInteger row = [pickerView selectedRowInComponent:0];
    
     NSLog(@"%@",_dateStringselected);
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *selectedDateInMainVC = [dateFormat dateFromString:_dateStringselected];
    
    NSLog(@"%@",selectedDateInMainVC);
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        if ([[courseArray objectAtIndex:row] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Activity" value:@"" table:nil]]) {
        AddActivityForParentsViewController *addActivityViewController = [[AddActivityForParentsViewController alloc] initWithNibName:@"AddActivityForParentsViewController" bundle:nil];
            addActivityViewController.selectedDate = selectedDateInMainVC;
            //        [self.navigationController setNavigationBarHidden:YES];
            //            addActivityViewController.isEditActivity = NO;
            [self.navigationController pushViewController:addActivityViewController animated:YES];
        }
        else if ([[courseArray objectAtIndex:row] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Mark sick for whole day" value:@"" table:nil]]) {
            MakeWholeDayAsLeaveViewController *makeWholeDayViewController = [[MakeWholeDayAsLeaveViewController alloc] initWithNibName:@"MakeWholeDayAsLeaveViewController" bundle:nil];
            //        [self.navigationController setNavigationBarHidden:YES];
            makeWholeDayViewController.dateStringSelected = _dateStringselected;
            [self.navigationController pushViewController:makeWholeDayViewController animated:YES];
        }
        else if ([[courseArray objectAtIndex:row] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Retrieval Note" value:@"" table:nil]]) {
            add_retriever_note *addActivityViewController = [[add_retriever_note alloc] init];
            //        [self.navigationController setNavigationBarHidden:YES];
            //            addActivityViewController.isEditActivity = NO;
            [self.navigationController pushViewController:addActivityViewController animated:YES];
        }
        else if ([[courseArray objectAtIndex:row] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"View Retriver note" value:@"" table:nil]]) {
            add_retriever_note *addActivityViewController = [[add_retriever_note alloc] init];
            //        [self.navigationController setNavigationBarHidden:YES];
            //            addActivityViewController.isEditActivity = NO;
            [self.navigationController pushViewController:addActivityViewController animated:YES];
        }
        else if ([[courseArray objectAtIndex:row] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Absent note" value:@"" table:nil]]) {
//            if (absentNoteCount == 2)
//            {
                AddAbsentNotesViewController *addAbsentNoteViewController = [[AddAbsentNotesViewController alloc] initWithNibName:@"AddAbsentNoteViewController" bundle:nil];
                [self.navigationController pushViewController:addAbsentNoteViewController animated:YES];
//            }

        }
        else if ([[courseArray objectAtIndex:row] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"View Absent note" value:@"" table:nil]]) {
//            if (absentNoteCount == 1) {
                ViewAbsentNoteViewController *viewAbsentNoteViewController = [[ViewAbsentNoteViewController alloc] initWithNibName:@"ViewAbsentNoteViewController" bundle:nil];
                
                viewAbsentNoteViewController.dateSelected =[NSString stringWithFormat:@"%@",_dateStringselected];
                
                [self.navigationController setNavigationBarHidden:YES];
            [self.navigationController pushViewController:viewAbsentNoteViewController animated:YES];

//                [self presentViewController:viewAbsentNoteViewController animated:YES completion:nil];
//            }

        }
        else
        {
    
        }

    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"elev"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"student"])
    {
        //student
//        courseArray = [[NSMutableArray alloc]initWithObjects:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Activity" value:@"" table:nil] ,[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"View Absent note" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"View Retriver note" value:@"" table:nil] , nil];
        
        if ([[courseArray objectAtIndex:row] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Activity" value:@"" table:nil]]) {
            AddActivityForStudentViewController *addActivityViewController = [[AddActivityForStudentViewController alloc] initWithNibName:@"AddActivityForStudentViewController" bundle:nil];
            addActivityViewController.selectedDate = selectedDateInMainVC;
            //        [self.navigationController setNavigationBarHidden:YES];
            //            addActivityViewController.isEditActivity = NO;
            [self.navigationController pushViewController:addActivityViewController animated:YES];
        }
        else if ([[courseArray objectAtIndex:row] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"View Retriver note" value:@"" table:nil]]) {
            add_retriever_note *addActivityViewController = [[add_retriever_note alloc] init];
            //        [self.navigationController setNavigationBarHidden:YES];
            //            addActivityViewController.isEditActivity = NO;
            [self.navigationController pushViewController:addActivityViewController animated:YES];
        }
        else if ([[courseArray objectAtIndex:row] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"View Absent note" value:@"" table:nil]]) {
            if (absentNoteCount == 1) {
                ViewAbsentNoteViewController *viewAbsentNoteViewController = [[ViewAbsentNoteViewController alloc] initWithNibName:@"ViewAbsentNoteViewController" bundle:nil];
                
                viewAbsentNoteViewController.dateSelected =[NSString stringWithFormat:@"%@",_dateStringselected];
                
                [self.navigationController setNavigationBarHidden:YES];
                
                [self.navigationController pushViewController:viewAbsentNoteViewController animated:YES];
            }
            
        }


    }
    else
    {
        
        if(row == 0)
        {
            AddVacationViewController *addVacationViewController = [[AddVacationViewController alloc] initWithNibName:@"AddVacationViewController" bundle:nil];
            //        [self.navigationController setNavigationBarHidden:YES];
            [self.navigationController pushViewController:addVacationViewController animated:YES];
        }
        else if(row == 1)
        {
            AddActivityViewController *addActivityViewController = [[AddActivityViewController alloc] initWithNibName:@"AddActivityViewController" bundle:nil];
            //        [self.navigationController setNavigationBarHidden:YES];
            addActivityViewController.isEditActivity = NO;
            addActivityViewController.selectedDate = selectedDateInMainVC;
            [self.navigationController pushViewController:addActivityViewController animated:YES];
            
        }
        
        else if(row == 2)
        {
            if (absentNoteCount == 1) {
                ViewAbsentNoteViewController *viewAbsentNoteViewController = [[ViewAbsentNoteViewController alloc] initWithNibName:@"ViewAbsentNoteViewController" bundle:nil];
                
                viewAbsentNoteViewController.dateSelected =[NSString stringWithFormat:@"%@",_dateStringselected];
                
                [self.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:viewAbsentNoteViewController animated:YES];
            }
            else if (absentNoteCount == 2)
            {
                AddAbsentNotesViewController *addAbsentNoteViewController = [[AddAbsentNotesViewController alloc] initWithNibName:@"AddAbsentNoteViewController" bundle:nil];
                [self.navigationController pushViewController:addAbsentNoteViewController animated:YES];
            }
        }
    }
    [self hidePickerView:sender];
    //    [_textField resignFirstResponder];
}

-(void)hidePickerView:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        pickerView.frame = [self RectMake:CGRectMake(0, 784, 320, 200) ];
        myToolbar.frame = [self RectMake:CGRectMake(0, 740, 320, 44)];
    }];
    
}

- (IBAction)showPickerView:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        pickerView.frame = [self RectMake:CGRectMake(0, 404, 320, 200)];
        myToolbar.frame = [self RectMake:CGRectMake(0,360, 320, 44)];
    }];
}

-(void) backButtonPressed: (id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayWithDictionariesInFoodMenu.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NoteIconTableViewCell *cell;
    cell= [tableView dequeueReusableCellWithIdentifier: @"noteIconCell"];
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NoteIconTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    cell.nameLabel.text = [[arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.startDateTableView.text = [NSString stringWithFormat:@"%@ : %@", [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start date" value:@"" table:nil],[self formatDateWithString:[[arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row] objectForKey:@"start"] ] ];
    cell.endDateTableView.text = [NSString stringWithFormat:@"%@ : %@",[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date" value:@"" table:nil], [self formatDateWithString:[[arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row] objectForKey:@"end"]] ];
  
//    cell.startDateTableView.text = [NSString stringWithFormat:@"Start : %@", [[arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row] objectForKey:@"start"]];
//
//    cell.endDateTableView.text = [NSString stringWithFormat:@"End : %@", [[arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row] objectForKey:@"end"]];
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        AddActivityForParentsViewController *addActivityViewController = [[AddActivityForParentsViewController alloc] initWithNibName:@"AddActivityForParentsViewController" bundle:nil];
        //        [self.navigationController setNavigationBarHidden:YES];
        //        addActivityViewController.dictionaryReceived =  [arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row];
        addActivityViewController.schemaIdReceived =  [[arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row] objectForKey:@"id"];
        addActivityViewController.isEditActivity = YES;
        [self.navigationController pushViewController:addActivityViewController animated:YES];
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"elev"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"student"])
    {
        AddActivityForStudentViewController *addActivityViewController = [[AddActivityForStudentViewController alloc] initWithNibName:@"AddActivityForStudentViewController" bundle:nil];
        //        [self.navigationController setNavigationBarHidden:YES];
//        addActivityViewController.dictionaryReceived =  [arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row];
        addActivityViewController.schemaIdReceived =  [[arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row] objectForKey:@"id"];
        addActivityViewController.isEditActivity = YES;
        [self.navigationController pushViewController:addActivityViewController animated:YES];
    }
    else
    {
    AddActivityViewController *addActivityViewController = [[AddActivityViewController alloc] initWithNibName:@"AddActivityViewController" bundle:nil];
    //        [self.navigationController setNavigationBarHidden:YES];
    addActivityViewController.schemaIdReceived =  [[arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row] objectForKey:@"id"];
    addActivityViewController.isEditActivity = YES;
    [self.navigationController pushViewController:addActivityViewController animated:YES];
    }
    
}

-(NSString *) formatDateWithString : (NSString *) dateStringReceived
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *startDate = [dateFormat dateFromString:dateStringReceived];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *startDateString = [dateFormat stringFromDate:startDate];
    
    return startDateString;
}

-(NSString *) formatDateForHeader : (NSString *) dateStringReceived
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    
    NSDate *startDate = [dateFormat dateFromString:dateStringReceived];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *startDateString = [dateFormat stringFromDate:startDate];
    
    return startDateString;
}


-(CGRect)RectMake:(CGRect)rect
{
    CGRect rect1;
    CGRect scrSize = [[UIScreen mainScreen] bounds];
    float xFactor = scrSize.size.width / 320.0f;
    float yFactor = scrSize.size.height / 568.0f;
    
    rect1.origin.x = rect.origin.x * xFactor;
    rect1.origin.y = rect.origin.y * yFactor;
    rect1.size.width = rect.size.width * xFactor;
    rect1.size.height = rect.size.height *yFactor;
    
    return rect1;
}
@end
