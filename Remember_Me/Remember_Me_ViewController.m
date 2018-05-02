//
//  Remember_Me_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 17/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Remember_Me_ViewController.h"
#import "Font_Face_Controller.h"
#import "Users_panel_ViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "Right_slider_ViewController.h"
#import "TermOfUseViewController.h"
#import "ELR_loaders_.h"



#define TERM_OF_CONDITION_URL @"https://dev.elar.se/mobile_api/get_userterms_formobile"
#import "AppDelegate.h"

@interface Remember_Me_ViewController ()<NSURLSessionDelegate>
{
    AppDelegate *appDelegate;
}
@property (nonatomic) UIImageView *loader_image;

@end

@implementation Remember_Me_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //////////////////// Screen Back_ground Color \\\\\\\\\\\\\\
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    //////////////////// Hide UInavigation Bar \\\\\\\\\\\\\\
    
    self.navigationController.navigationBarHidden=YES;

    
    //////////////////// Application Logo \\\\\\\\\\\\\\
    
    
    Application_logo=[[UIImageView alloc]init];
    Application_logo.image=[UIImage imageNamed:@"logo.png"];
    Application_logo.frame=CGRectMake((self.view.frame.size.width-143)/2, 100, 143, 107);
    Application_logo.userInteractionEnabled=YES;
    [self.view addSubview:Application_logo];
    
    //////////////////// Language  Lable  \\\\\\\\\\\\\\
    
    
    
    Remember_LB=[[UILabel alloc]init];
    
    
    Remember_LB.frame=CGRectMake(0,(self.view.frame.size.height-40)/2, self.view.frame.size.width, 40);
    Remember_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Remember me?" value:@"" table:nil];
    Remember_LB.textAlignment=NSTextAlignmentCenter;
    Remember_LB.textColor=[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0];
    Remember_LB.font=[Font_Face_Controller opensanssemibold:30];
    [self.view addSubview:Remember_LB];

    
    //////////////////// Remember No Button\\\\\\\\\\\\\\
    
    BTN_No = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [BTN_No addTarget:self
               action:@selector(aMethod_NO:)
     forControlEvents:UIControlEventTouchUpInside];
    BTN_No.backgroundColor=[UIColor colorWithRed:143.0f/255.0f green:142.0f/255.0f blue:143.0f/255.0f alpha:1.0];
    [BTN_No setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"NO" value:@"" table:nil] forState:UIControlStateNormal];
    [BTN_No.titleLabel setFont:[Font_Face_Controller opensanssemibold:20]];
    [BTN_No setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    BTN_No.frame = CGRectMake(0,self.view.frame.size.height-70,self.view.frame.size.width/2, 70);
    [self.view addSubview:BTN_No];
    
    
    //////////////////// Remember YES Button\\\\\\\\\\\\\\
    
    BTN_YeS = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [BTN_YeS addTarget:self
                    action:@selector(aMethod_YES:)
          forControlEvents:UIControlEventTouchUpInside];
    BTN_YeS.backgroundColor=[UIColor colorWithRed:110.0f/255.0f green:123.0f/255.0f blue:255.0f/255.0f alpha:1.0];
    [BTN_YeS setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YES" value:@"" table:nil] forState:UIControlStateNormal];
    [BTN_YeS.titleLabel setFont:[Font_Face_Controller opensanssemibold:20]];
    [BTN_YeS setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    BTN_YeS.frame = CGRectMake(self.view.frame.size.width/2,self.view.frame.size.height-70,self.view.frame.size.width/2, 70);
    [self.view addSubview:BTN_YeS];
    
 
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    //////////////////// Hide UInavigation Bar \\\\\\\\\\\\\\
    
    self.navigationController.navigationBarHidden=YES;

}

-(void)aMethod_YES:(UIButton *)sender
{
    [self mStartIndicater];
    [[NSUserDefaults standardUserDefaults]setValue:@"YES" forKey:@"Session"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self webServiceCallForTermsOfConditions];
}


-(void)aMethod_NO:(UIButton *)sender
{
    [self mStartIndicater];

    [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"Session"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self webServiceCallForTermsOfConditions];
}




-(void)webServiceCallForTermsOfConditions {
    
    
    NSMutableDictionary *dicdddd=[[NSMutableDictionary alloc]init];
    [dicdddd setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
    [dicdddd setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"] forKey:@"loginUserID"];
    [dicdddd setValue:@"ios" forKey:@"platform"];
    NSError * error;
    
    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",TERM_OF_CONDITION_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@ "Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dicdddd options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //        NSLog(@"data:%@",data);
        if (data != nil || data == NULL) {
            id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
                dispatch_async(dispatch_get_main_queue(), ^{
                if(dictionaryreceived != nil){
                    
                    NSInteger isTrue =[[dictionaryreceived objectForKey:@"status"] integerValue];
                    [self mStopIndicater];
                    if (isTrue) {
                        
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TermOfUseViewController" bundle:nil];
                        TermOfUseViewController *myNewVC = (TermOfUseViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TermOfUseViewController"];
                        [self presentViewController:myNewVC animated:YES completion:nil];
                    }else {
                        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        [appDelegate LOg_in];
                    }
                }
                
            });
        }
    }];
    
    [postDataTask resume];
    
}

#pragma mark - -*********************
#pragma mark Activity Indicater
#pragma mark - -*********************

-(void)mStartIndicater
{
    
    self.loader_image=[ELR_loaders_ Start_loader:CGRectMake(([[UIScreen mainScreen]bounds].size.width-85)/2,[[UIScreen mainScreen]bounds].size.height/2,85,85)];
    [self.view addSubview:self.loader_image];
    
    [self.loader_image setHidden:NO];
    
    
}

#pragma mark - -*********************
#pragma mark Stop Indicater
#pragma mark - -*********************

-(void)mStopIndicater
{
    [self.loader_image setHidden:YES];
    //    [loader_image removeFromSuperview];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
