//
//  LunchInformationViewController.m
//  XIBTest
//
//  Created by jeff ayan on 28/12/16.
//  Copyright © 2016 jeff ayan. All rights reserved.
//

#import "LunchInformationViewController.h"
#import "LunchInformationTableViewCell.h"
#import "Constant.h"
#import "ELR_loaders_.h"
#import "Font_Face_Controller.h"
#import "ImageCustomClass.h"
//typedef struct LunchStudentDetails{
//    __unsafe_unretained NSString *firstname;
//    __unsafe_unretained NSString *lastname;
//    __unsafe_unretained NSString *description;
//    
//}detail;


@interface LunchInformationViewController ()
{
    NSMutableArray *firstname;
    NSMutableArray *lastname;
    NSMutableArray *description, * lunchImagesArray , * freeTextArray;
    NSMutableDictionary *postDict;
    NSMutableString *groupSelected;
    NSMutableString *dateSelected ;
    UIActivityIndicatorView *activity;
}


@end

@implementation LunchInformationViewController

    // Calendar Lunch information
    
    NSString * WebUrl;
    NSString *LunchInformationCell = @"LunchInformationTableCell";
    //NSString *Post = @"POST";
    NSString *DateFormat = @"yyyy'-'MM'-'dd";
    NSString *AddFoodNotesCellIdentifier = @"ItemCell";



- (void)viewDidLoad {
    
    [super viewDidLoad];
    WebUrl = [NSString stringWithFormat:@"%@mobile_api/foodNote",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]];
    foodNotesTableView.dataSource = self;
    foodNotesTableView.delegate = self;
//    [self defineActivity];
    [foodNotesTableView registerNib:[UINib nibWithNibName: LunchInformationCell bundle:nil] forCellReuseIdentifier:AddFoodNotesCellIdentifier];
    
    [self loadData];
    [self setDatePicker_Segment];
    
    [self Navigation_bar];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    [self changeLanguage];
//    [self updateViewConstraints];
   
    
}

-(void) addFoodMenuviewToScrollView
{
//    [self.mailScrollView addSubview:_foodMenuView];
    _heightConstraintForTableview.constant = (lunchImagesArray.count * 130);
    self.mailScrollView.contentSize = CGSizeMake(self.view.frame.size.width, lunchImagesArray.count * 120 + 300);
}
//// Define Activity
//-(void) defineActivity{
//    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activity.center = self.view.center;
//    activity.hidesWhenStopped = YES;
//    [self.view addSubview: activity];
//}
//

-(void) changeLanguage
{
    scheduleLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Scheduled" value:@"" table:nil];
    currentLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Currently" value:@"" table:nil];
    startDateTextField.placeholder = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Date" value:@"" table:nil];
    addFoodNotesHeaderLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Food Notes" value:@"" table:nil];
    allergiesLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Allergies" value:@"" table:nil];
    childrenLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Presence" value:@"" table:nil];
    groupSelectionLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Group Selection" value:@"" table:nil];
//    allergiesLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"USE DRAFT" value:@"" table:nil];
    [groupSegmentController setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"All Groups" value:@"" table:nil] forSegmentAtIndex:0];
    [groupSegmentController setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"My Groups" value:@"" table:nil] forSegmentAtIndex:1];

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
    
    
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Food Notes" value:@"" table:nil] ;
    
    
    
}

-(void) backButtonPressed: (id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Webservice
-(void)webServiceLoad :(NSString*) url dict :(NSDictionary*) posDict {
    
    NSError *error;
   
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: config delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
    
   // NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: url] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: url]];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod: @"POST"];
    
    NSLog(@"posDict %@",posDict);
    
    NSData *posData = [NSJSONSerialization dataWithJSONObject: posDict options:0 error: &error];
    //NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[posData length]];
    
    [request setHTTPBody: posData];
   // [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
           // NSDictionary *json = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingAllowFragments error:nil];
            
//            NSString *arr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSData *objectData = [arr dataUsingEncoding:NSUTF8StringEncoding];
//            NSArray *json = [NSJSONSerialization JSONObjectWithData:objectData                                                               options:NSJSONReadingMutableLeaves                                                                 error:nil];
           
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"json %@",json);
            
             NSArray *arr = [json valueForKey: @"final_students"];
            
            NSLog(@"arr %@",arr);
            if ([json valueForKey: @"student_count_without_absent_dates"] != nil) {
             scheduleLabel.text = [[NSString alloc] initWithFormat:@"Scheduled : %@",[json valueForKey: @"student_count_without_absent_dates"]] ;
            }
            if ([json valueForKey: @"present_student_count"] != nil) {
            currentLabel.text = [[NSString alloc] initWithFormat:@"Currently : %@",[json valueForKey: @"present_student_count"]] ;
            }
             //currentLabel.text = [json valueForKey: @"present_student_count"];
            firstname = [[NSMutableArray alloc] init];
            lastname = [[NSMutableArray alloc] init];
            description = [[NSMutableArray alloc] init];
            lunchImagesArray = [[NSMutableArray alloc]init];
            freeTextArray = [[NSMutableArray alloc]init];
             NSInteger i = 0;
            if ([arr count] == 0) {
                foodNotesTableView.hidden = YES;
                [self showAlert:@"NO allergies available"];
            }
            else
            {
                foodNotesTableView.hidden = NO;
             for (NSDictionary *dict in arr) {
                 if ([dict valueForKey: @"first_name"] == nil){
                     [firstname addObject: @" "];
                 }else {
                     [firstname addObject:[dict valueForKey: @"first_name"]];
                 }
                 if ([dict valueForKey: @"last_name"] == nil){
                     [lastname addObject: @" "];
                 }else {
                     [lastname addObject:[dict valueForKey: @"last_name"]];
                 }
                 if ([dict valueForKey: @"allergy_name"] == nil){
                     [description addObject: @" "];
                 }else {
                    [description addObject:[dict valueForKey: @"allergy_name"]];
                 }
                 if ([dict valueForKey: @"free_text"] == nil){
                     [freeTextArray addObject: @" "];
                 }else {
                     [freeTextArray addObject:[dict valueForKey: @"free_text"]];
                 }
                 if ([dict valueForKey: @"image"] == nil){
                     [lunchImagesArray addObject: @" "];
                 }else {
                     [lunchImagesArray addObject:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"],[dict valueForKey: @"image"] ]];
                 }
                 
                 i++;
             }
            [foodNotesTableView reloadData];
             [self addFoodMenuviewToScrollView];
//            if(activity != nil && activity.isAnimating){
//                [activity stopAnimating];
//            }
            }
            self.view.userInteractionEnabled = YES;
            [self mStopIndicater];
        }else {
            NSLog(@"Error....");
        }
    }];
    [dataTask resume];
    
}



// Action for Date Change
-(void)dateChanged :(id)sender {
    UIDatePicker *datePicker = (UIDatePicker*)startDateTextField.inputView;
    NSString *dateStr = [self formatDate: datePicker.date];
    self->startDateTextField.text = dateStr;
    dateSelected = [[NSMutableString alloc] initWithString:dateStr];

}


// Set DatePicker and Segment selector
-(void) setDatePicker_Segment {
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate: [NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents: UIControlEventValueChanged];
    self->startDateTextField.inputView = datePicker ;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemDone target:self action:@selector(doneClicked)];
    [toolBar setItems: [NSArray arrayWithObject: doneButton] animated:NO];
    self->startDateTextField.inputAccessoryView = toolBar;
    self->startDateTextField.text = [self formatDate:[NSDate date]];
    [groupSegmentController addTarget: self action:@selector(SegmentChanged:) forControlEvents:UIControlEventValueChanged];
    
}

-(void) CallService{
    self.view.userInteractionEnabled = NO;
   // [activity setHidden:NO];
//    [activity startAnimating];
    [self mStartIndicater];
    [self webServiceLoad:WebUrl dict: [self Date:dateSelected Group:groupSelected]];
}

// Action for Segment Change
-(void) SegmentChanged:(id)sender{
    NSString *segValue = [groupSegmentController titleForSegmentAtIndex: groupSegmentController.selectedSegmentIndex];
    NSLog(@"Selected Value is  >> %@",segValue);
    if ([segValue  isEqual: @"My Group"]){
        groupSelected = [[NSMutableString alloc] initWithString:@"my_group"];
    } else{
        groupSelected = [[NSMutableString alloc] initWithString:@"all_group"];
    }
    [self CallService];
}

// Action for DatePicker toolbar Done button onclick
-(void) doneClicked {
    [startDateTextField resignFirstResponder];
    [self CallService];
    }

// Date Formatter
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat: DateFormat];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}


-(void) loadData {
    
    groupSelected = [[NSMutableString alloc] initWithString:@"all_group"];
    NSString  *dat = [self formatDate: [NSDate date]];
    dateSelected = [[NSMutableString alloc] initWithString:dat];
    postDict = [self Date:dat Group: groupSelected];
    [self CallService];
}
- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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


-(void) showAlert : (NSString * ) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    LunchInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: AddFoodNotesCellIdentifier];
    if (firstname != nil && lastname != nil && description != nil) {
        cell.LunchFirstName.text = firstname[indexPath.row];
        cell.LunchLastName.text = lastname[indexPath.row];
        cell.allerrgyTextView.text = description[indexPath.row];
        cell.freeTextLabel.text = freeTextArray[indexPath.row];
        NSLog(@"%@",[lunchImagesArray objectAtIndex:indexPath.row]);
        [cell.LunchImageView setImageWithURL:[NSURL URLWithString:[lunchImagesArray objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder-avatar"]];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (firstname != nil && lastname != nil && description != nil) {
        return firstname.count;
    } else {
       return 0;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  120;
}

-(NSMutableDictionary *) Date:(NSString*) date Group:(NSString*) group {
     NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",date,@"date",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",group,@"groupType",nil];
    return tempDict;
}


@end
