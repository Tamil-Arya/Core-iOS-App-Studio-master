//
//  ViewFoodMenuWebViewViewController.m
//  Smart Classroom Manager
//
//  Created by Developer on 06/10/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "ViewFoodMenuWebViewViewController.h"
#import "MFSideMenu.h"
#import "NSString+FontAwesome.h"
#import "Font_Face_Controller.h"
#import "UIImageView+WebCache.h"
#import "ImageCustomClass.h"
#import "Utilities.h"

#import "ELR_loaders_.h"

@interface ViewFoodMenuWebViewViewController ()

@end

@implementation ViewFoodMenuWebViewViewController
@synthesize foodMenuUrlReceived = _foodMenuUrlReceived;


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
    if ([self.fromPage isEqualToString:@"Setting"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
    [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)downloadButtonPressed:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    BOOL isDir = NO;
    NSError *error;
    //You must check if this directory exist every time
    if (! [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDir] && isDir   == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:&error];
    }
     NSURL *myUrl = [NSURL URLWithString:@"http://maven.apache.org/maven-1.x/maven.pdf"];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"someName.pdf"];
    //webView.request.URL contains current URL of UIWebView, don't forget to set outlet for it
    NSData *pdfFile = [NSData dataWithContentsOfURL:myUrl];
    [pdfFile writeToFile:filePath atomically:YES];

//    NSString *path = [[NSBundle mainBundle] pathForResource:@"someName" ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    UIDocumentInteractionController *docController = [[UIDocumentInteractionController alloc] init];
    
    docController = [UIDocumentInteractionController interactionControllerWithURL:url];
    docController.delegate = self;
    
    BOOL isValid = [docController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    [self Navigation_bar];
    self.navigationItem.hidesBackButton = YES;
    
    
    
    //////////////////// Hide UInavigation Bar \\\\\\\\\\\\\\
    
    self.navigationController.navigationBarHidden=NO;
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationItem setHidesBackButton:YES animated:YES];

    [self openWebView];
}


#pragma mark - UIWebView

-(void) openWebView
{
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView commitAnimations];
            UIWebView *myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,40,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
            myWebView.autoresizesSubviews = YES;
            myWebView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
            myWebView.scalesPageToFit = YES;
//            NSURL *myUrl = [NSURL URLWithString:@"http://dev.elar.se/forum/index"];
            NSURLRequest *myRequest = [NSURLRequest requestWithURL:_foodMenuUrlReceived];
    
//            NSURLRequest *myRequest = [NSURLRequest requestWithURL:myUrl];
            myWebView.backgroundColor = [UIColor whiteColor];
            myWebView.delegate = self;
            [myWebView loadRequest:myRequest];
    
            [self.view addSubview: myWebView];
        });

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
    
    if ([self.fromPage isEqualToString:@"Setting"]) {
         self.navigationItem.title = @"";
    }
    else
    {
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Food Menu" value:@"" table:nil] ;
    }
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIWeb View Delegates

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    loader_image=[ELR_loaders_ Start_loader:CGRectMake(([[UIScreen mainScreen]bounds].size.width-85)/2,[[UIScreen mainScreen]bounds].size.height/2,85,85)];
    [self.view addSubview:loader_image];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [loader_image removeFromSuperview];
    

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller
{
    [controller dismissMenuAnimated:YES];
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
