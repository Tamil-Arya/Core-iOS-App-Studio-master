//
//  AbsenceNoteWebViewController.m
//  Smart Classroom Manager
//
//  Created by admin on 10/9/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "AbsenceNoteWebViewController.h"
#import "ELR_loaders_.h"
#import "Font_Face_Controller.h"
#import "UIImageView+WebCache.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "ImageCustomClass.h"
#import "ReachabilityManager.h"

@interface AbsenceNoteWebViewController ()
{
    APIWithProtocol * api;
}
@end

@implementation AbsenceNoteWebViewController
static NSInteger WEBSERVICE_TO_GET_Absence_Note_URL_TAG = 201;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Navigation_bar];
    NSLog(@"%@",_dictionaryFromNotification);
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        loginUserId=[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"];
        NSLog(@"token=>%@",loginUserId);
    }
    else
    {
        loginUserId=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
    }
    
    if ([[ReachabilityManager sharedManager]isReachable]) {
        [self webserviceToGetWebViewURL];
        
    }else{
        [[ReachabilityManager sharedManager]showAlertForNoInternetNotification];
    }
    // Do any additional setup after loading the view from its nib.
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


-(void) showAlertWithMessgae : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void) webserviceToGetWebViewURL  {
    
    [self mStartIndicater];
    
    //  {"securityKey":"H67jdS7wwfh","loginUserID":"44","language":"en"}
    
    api = [[APIWithProtocol alloc]init];
    api.delegateObject = self;
    
    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"absence_noteP",@"componenet_name",@"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];
    

    
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://dev.elar.se/mobile_api/viewParentUser"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@mobile_api/getAuthenticationTokenforSCM",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
    
    NSLog(@"URL=>%@",url);
    [api CallWebserviceWithDataParametrs:postDict WithURL:url withMsgType:WEBSERVICE_TO_GET_Absence_Note_URL_TAG];
}

-(void) displayWebViewWithKey : (NSString *) key
{
    //    http://dev.elar.se/authentication_token_SCM=2509477382991463
    NSString *urlString;
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
   urlString  = [NSString stringWithFormat:@"%@?authentication_token_SCM=%@&component_name=absence_noteP&stud_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"],key,[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"]];
    NSLog(@"url=====>%@",urlString);
    } else {
        urlString  = [NSString stringWithFormat:@"%@?authentication_token_SCM=%@&component_name=absence_noteP",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"],key];
    }
    [self.absenceNotesWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    
}


#pragma mark - Navigation Bar


-(void)Navigation_bar
{
    
    user_pic = [[UIImageView alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"USR_image"]]);
    [user_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"customer_logo"]]]
                placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    
 //   user_pic.frame=CGRectMake(50, 0, 30, 30);
    CGSize size = CGSizeMake(30, 30);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11){
        
        [user_pic setImage: [ImageCustomClass image:user_pic.image resize:size]];
        
    } else {
        
        user_pic.frame=CGRectMake(0, 0, size.width, size.height);
        
    }
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
    [button addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absence Note" value:@"" table:nil] ;
    
    
}

- (IBAction)backButtonClicked:(id)sender {
    if ([self.absenceNotesWebView canGoBack]) {
        [self.absenceNotesWebView goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
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

#pragma mark - UIWebView Delegates

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self mStartIndicater];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self mStopIndicater];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self mStopIndicater];
}

#pragma mark - API Protocol service

-(void)dataIsReceived:(id)dataReceived withMsgType:(int)msgType
{
    if (msgType == WEBSERVICE_TO_GET_Absence_Note_URL_TAG) {
        [self mStopIndicater];
        NSLog(@"data received===> %@",dataReceived);
        [self displayWebViewWithKey:dataReceived[@"Authentication_number_SCM"]];
    }
}

-(void)errorOccured:(NSString *)errorString withMsgType:(int)msgType
{
    [self showAlertWithMessgae:errorString];
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
