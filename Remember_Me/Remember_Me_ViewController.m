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


#import "AppDelegate.h"

@interface Remember_Me_ViewController ()
{
    AppDelegate *appDelegate;
}

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
    [[NSUserDefaults standardUserDefaults]setValue:@"YES" forKey:@"Session"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate LOg_in];
    
}

-(void)aMethod_NO:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"Session"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     [appDelegate LOg_in];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
