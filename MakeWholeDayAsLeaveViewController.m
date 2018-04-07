//
//  MakeWholeDayAsLeaveViewController.m
//  SampleForKaaylabs
//
//  Created by admin on 2/22/17.
//  Copyright © 2017 Venugopal Devarala. All rights reserved.
//

#import "MakeWholeDayAsLeaveViewController.h"
#import "Font_Face_Controller.h"
#import "ELR_loaders_.h"
#import "ImageCustomClass.h"
@interface MakeWholeDayAsLeaveViewController ()
{
   
}
@end

@implementation MakeWholeDayAsLeaveViewController

static NSInteger  WEBSERVICE_MAKE_WHOLE_DAY_AS_LEAVE_TAG = 301;
static NSInteger  WEBSERVICE_TO_GET_SICK_DETAIL_TAG = 302;


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self Navigation_bar];
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    _enterDescriptionTextField.inputAccessoryView = myToolbar;

    [self changeLanguage];
    [self webserviceToGetWholeSickDayIformation];
    
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view from its nib.
}

-(void)doneButtonClicked
{
    [_enterDescriptionTextField resignFirstResponder];
}

-(void) changeLanguage
{
    _descriptionLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
    _enterDescriptionTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil];
    [_addButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Save Changes" value:@"" table:nil] forState:UIControlStateNormal] ;

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


#pragma mark - UITextView Delegates

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView isEqual: _enterDescriptionTextField]) {
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

-(NSString *) formatDateWithString : (NSString *) dateStringReceived
{
    
    //    03/02/2017 10:00
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    
    NSDate *startDate = [dateFormat dateFromString:dateStringReceived];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *startDateString = [dateFormat stringFromDate:startDate];
    
    return startDateString;
}


-(void) webserviceToMakeWholeDayAsSick  {
    
    [self mStartIndicater];
    
//  {"securityKey":"H67jdS7wwfh","loginUserID":"1","sick_description":"Checking mobile","sickdate": "05/02/2017 10:00","student_id":"1","language":"en","ischecked":""}    
    
    
//    {"securityKey":"H67jdS7wwfh","loginUserID":"1","sick_description":"Checking mobile","sickdate": "05/02/2017 10:00","student_id":"1","language":"en","ischecked":""}
    
    
    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",_enterDescriptionTextField.text,@"sick_description",[self formatDateWithString:_dateStringSelected],@"sickdate",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]objectForKey:@"student_id"],@"student_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",@"",@"ischecked",nil];
    
    
    //    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",_startDateTExtField.text,@"FromDateVacation",_endDateTextField.text,@"ToDateVacation",_descriptionTextView.text,@"ReqDescription",nil];
    
    NSError * error;
    NSLog(@"postDict %@",postDict);
    
    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://dev.elar.se/mobile_api/viewParentUser"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/addwholedaysickforParent",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
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
            [self ParseArray:dictionaryreceived WithTag:WEBSERVICE_MAKE_WHOLE_DAY_AS_LEAVE_TAG];
        });
        
    }];
    
    [postDataTask resume];
    
}

-(void) webserviceToGetWholeSickDayIformation
{
    
//    {"securityKey":"H67jdS7wwfh","student_id":"104","sickdate":"2017-03-03","language":"en"}
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    
    NSDate *startDate = [dateFormat dateFromString:_dateStringSelected];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *startDateString = [dateFormat stringFromDate:startDate];
    
    
      NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",startDateString,@"sickdate",[[NSUserDefaults standardUserDefaults]objectForKey:@"student_id"],@"student_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];
    
    NSString * urlWithOutIP = @"getWholedaySickdetailsforstudent";
    
    [self callWebServiceWithPostDictionary:postDict withUrl:urlWithOutIP withTag:WEBSERVICE_TO_GET_SICK_DETAIL_TAG];
}

-(void) callWebServiceWithPostDictionary : (NSDictionary *) postDictionary withUrl : (NSString *) urlWithOutIP withTag : (int) tagForWebService
{
    [self mStartIndicater];
    
    //  {"securityKey":"H67jdS7wwfh","loginUserID":"1","sick_description":"Checking mobile","sickdate": "05/02/2017 10:00","student_id":"1","language":"en","ischecked":""}
    
   
    
    
    //    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",_startDateTExtField.text,@"FromDateVacation",_endDateTextField.text,@"ToDateVacation",_descriptionTextView.text,@"ReqDescription",nil];
    NSMutableData *responsesData = [[NSMutableData alloc]init];
    
    NSError * error;
    NSLog(@"postDict %@",postDictionary);
    
    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://dev.elar.se/mobile_api/viewParentUser"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"],urlWithOutIP ]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@ "Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDictionary options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //        NSLog(@"data:%@",data);
        id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"dictionaryreceived %@",dictionaryreceived);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ParseArray:dictionaryreceived WithTag:tagForWebService];
        });
        
    }];
    
    [postDataTask resume];
    
}

-(void) ParseArray : (NSDictionary *) dictionaryReceived WithTag : (int) tag
{
     if (tag == WEBSERVICE_MAKE_WHOLE_DAY_AS_LEAVE_TAG)
    {
        if ([dictionaryReceived objectForKey:@"status"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionaryReceived objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            
            
            
            UIAlertAction* OKAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 for (UIViewController *controller in self.navigationController.viewControllers)
                                                                 {
                                                                     if ([controller isKindOfClass:[MainViewController class]])
                                                                     {
                                                                         [self.navigationController popToViewController:controller
                                                                                                               animated:YES];
                                                                         break;
                                                                     }
                                                                 }
                                                                 
                                                             }];
            
            [alertController addAction:OKAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            [self showAlert:[dictionaryReceived objectForKey:@"message"]];
        }
    }
    else if (tag == WEBSERVICE_TO_GET_SICK_DETAIL_TAG)
    {
        
         if ([[dictionaryReceived objectForKey:@"status"] isEqualToString:@"true"]) {
              _enterDescriptionTextField.text = [dictionaryReceived objectForKey:@"msg"];
         }
         else
         {
//             [self showAlert:[dictionaryReceived objectForKey:@"msg"]];
         }
        
    }
    [self mStopIndicater];
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
    
    
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Food Menu" value:@"" table:nil] ;
    
    
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
- (IBAction)backButtonClicked:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

-(void) backButtonPressed: (id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveButtonClicked:(id)sender {
    if ([_enterDescriptionTextField.text isEqualToString:@""] || [_enterDescriptionTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil]])
    {
        [self showAlert:@"Please enter description"];
    }
    else
    {
        [self webserviceToMakeWholeDayAsSick];
    }

}

-(void) tickButtonPressed: (id) sender
{
    if ([_enterDescriptionTextField.text isEqualToString:@""] || [_enterDescriptionTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil]])
    {
        [self showAlert:@"Please enter description"];
    }
    else
    {
        [self webserviceToMakeWholeDayAsSick];
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
