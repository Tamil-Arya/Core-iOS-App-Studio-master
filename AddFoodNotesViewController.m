//
//  AddFoodNotesViewController.m
//  Smart Classroom Manager
//
//  Created by admin on 1/12/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "AddFoodNotesViewController.h"
#import "ELR_loaders_.h"
#import "Font_Face_Controller.h"
#import "ImageCustomClass.h"

#import "ReachabilityManager.h"

@interface AddFoodNotesViewController ()

@end

@implementation AddFoodNotesViewController

static const NSInteger WEBSERVICE_FOOD_MENU = 1001;
static const NSInteger WEBSERVICE_VIEW_BUTTON = 1002;
static const NSInteger WEBSERVICE_DELETE_BUTTON = 1003;

@synthesize responsesData= _responsesData;
@synthesize dateStringselected= _dateStringselected;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayWithTitleOfEvents = [[NSMutableArray alloc]init];
    arrayWithStartDateOfEvents = [[NSMutableArray alloc]init];
    arrayWithendDateOfEvents = [[NSMutableArray alloc]init];
    arrayWithDictionariesInFoodMenu = [[NSMutableArray alloc]init];
    
    
    
    AddfoodNotesTableView.layer.cornerRadius = 4;
    AddfoodNotesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    api = [[APIWithProtocol alloc]init];
    api.delegateObject = self;

    [self Navigation_bar];
    
    if ([[ReachabilityManager sharedManager]isReachable]) {
        [self webserviceFordate];

    }else{
        [[ReachabilityManager sharedManager]showAlertForNoInternetNotification];
    }

    // Do any additional setup after loading the view.
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


- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) webserviceFordate  {
    
    [self mStartIndicater];
    
    
//    {"securityKey":"H67jdS7wwfh","loginUserID":"44","language":"en"}
    
    NSDictionary * postDict;
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];

    }
    else
    {
    postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];
    }
    _responsesData = [[NSMutableData alloc]init];
    
    NSError * error;
    NSLog(@"postDict %@",postDict);
    
    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/FoodMenuPDF",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
    
    [api CallWebserviceWithDataParametrs:postDict WithURL:url withMsgType:1];

//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:60.0];
    
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
//            if (dictionaryreceived == nil) {
//                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"No food notes available"  preferredStyle:UIAlertControllerStyleAlert];
//                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                    [self dismissViewControllerAnimated:YES completion:nil];
//                }]];
//                [self presentViewController:alertController animated:YES completion:nil];
//            }
//            else
//            {
//            [self ParseArray:dictionaryreceived WithTag:WEBSERVICE_FOOD_MENU];
//            }
//        });
//        
//    }];
//    
//    [postDataTask resume];
    
    
    
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
        if ([dictionaryReceived objectForKey:@"status"]) {
            [self webserviceFordate];
        }
        else
        {
            
        }
    }
    else
    {
        //    arrayWithDatesFromWebService = [[NSMutableArray alloc]init];
        
        arrayWithDictionariesInFoodMenu = [dictionaryReceived objectForKey:@"foodmenu"];
        if (arrayWithDictionariesInFoodMenu.count == 0) {
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"No food notes available"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
//        for (int i = 0; i<[arrayFromMainDictionary count]; i++) {
//            NSDictionary * dictionaryWithFooMenu =[arrayFromMainDictionary objectAtIndex:i];
//            
//            arrayWithDictionariesInFoodMenu =[dictionaryWithFooMenu objectForKey:@"foodmenu"];
            NSLog(@"dictionaryInsideSchema  %@",arrayWithDictionariesInFoodMenu);
//
//            NSDictionary * dictionaryWithEachIndex =[arrayWithDictionariesInFoodMenu objectAtIndex:i];
//            [arrayWithDictionariesInFoodMenu addObject:dictionaryInsideSchema];
//
//            
//            [arrayWithTitleOfEvents addObject:dictionaryWithEachIndex[@"file_name"]];
//            [arrayWithStartDateOfEvents addObject:dictionaryInsideSchema[@"start"]];
//            [arrayWithendDateOfEvents addObject:dictionaryInsideSchema[@"end"]];
            if ([arrayWithDictionariesInFoodMenu count] != 0) {
                [AddfoodNotesTableView reloadData];
            }
        }
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
    
    
    //    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    UIImage *butImage1 = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    //    [button1 setBackgroundImage:butImage1 forState:UIControlStateNormal];
    //    [button1 addTarget:self action:@selector(downloadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    button1.frame = CGRectMake(0, 0, 20, 20);
    //    [button1 setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    //
    //
    //    UIBarButtonItem *backButton1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    //    self.navigationItem.rightBarButtonItem = backButton1;
    //
    //
    //    [[self navigationItem] setBackBarButtonItem:backButton1];
    
    
    
    //    }
    //    else
    //    {
    //        self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule" value:@"" table:nil] ;
    //    }
    
}

#pragma mark - UIButton Actions

- (IBAction)viewButtonclicked:(id)sender {
//    [self mStartIndicater];
    
    UIButton * buttonClikced = (UIButton *)sender;
    
//    View Url : baseUrl + "cus_customers/viewFoodMenuPdfMobile/" + foodmenuEntity.getId() + "?authentication_token=" + auth_token
    
    
    NSString * idAtIndex = [[arrayWithDictionariesInFoodMenu objectAtIndex:buttonClikced.tag - WEBSERVICE_VIEW_BUTTON]objectForKey:@"id"];
    
    _responsesData = [[NSMutableData alloc]init];
    
    NSError * error;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@cus_customers/viewFoodMenuPdfMobile/%@?authentication_token=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"],idAtIndex,[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"] ]];
    
    NSLog(@"url %@",url);
    
    
    ViewFoodMenuWebViewViewController *pdfViewController = [[ViewFoodMenuWebViewViewController alloc]init];
    
    pdfViewController.foodMenuUrlReceived = url;
    
    [self.navigationController pushViewController:pdfViewController animated:YES ];

    
}

- (IBAction)deleteButtonClicked:(id)sender {
    
    [self mStartIndicater];
    
    UIButton * buttonClikced = (UIButton *)sender;
    
    
    NSString * idAtIndex = [[arrayWithDictionariesInFoodMenu objectAtIndex:buttonClikced.tag- WEBSERVICE_DELETE_BUTTON]objectForKey:@"id"] ;
    
    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",idAtIndex,@"id",nil];
    _responsesData = [[NSMutableData alloc]init];
    
    NSError * error;
    NSLog(@"postDict %@",postDict);
    
    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/deleteFoodMenu",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
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
            [self ParseArray:dictionaryreceived WithTag:WEBSERVICE_DELETE_BUTTON];
        });
        
    }];
    
    [postDataTask resume];
    
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
    
    AddFoodNotesTableViewCell *cell;
    cell= [tableView dequeueReusableCellWithIdentifier: @"addfoodNotesIconCell"];
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddfoodNotesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    cell.viewButton.tag = WEBSERVICE_VIEW_BUTTON + indexPath.row;
    cell.closeButton.tag = WEBSERVICE_DELETE_BUTTON + indexPath.row;
    
     if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"teacher"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"lärare"])
     {
         cell.closeButton.hidden = NO;
     }
    else
    {
        cell.closeButton.hidden = YES;
    }
    cell.nameLabel.text = [[arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row] objectForKey:@"file_name"];
    cell.startDateLabel.text = [NSString stringWithFormat:@"Start date : %@", [self formatDateWithString:[[arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row] objectForKey:@"start_date"] ] ];
    cell.endDateLabel.text = [NSString stringWithFormat:@"End date : %@", [self formatDateWithString:[[arrayWithDictionariesInFoodMenu objectAtIndex:indexPath.row] objectForKey:@"end_date"]] ];
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 127;
}

-(NSString *) formatDateWithString : (NSString *) dateStringReceived
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    
    NSDate *startDate = [dateFormat dateFromString:dateStringReceived];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *startDateString = [dateFormat stringFromDate:startDate];
    
    return startDateString;
}

#pragma mark - API Protocol service

-(void)dataIsReceived:(id)dataReceived withMsgType:(int)msgType
{
        [self mStopIndicater];
                if (dataReceived == nil) {
                    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"No food notes available"  preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else
                {
                [self ParseArray:dataReceived WithTag:WEBSERVICE_FOOD_MENU];
                }

}

-(void)errorOccured:(NSString *)errorString withMsgType:(int)msgType
{
    [self mStopIndicater];

    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@""  message:errorString  preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
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
