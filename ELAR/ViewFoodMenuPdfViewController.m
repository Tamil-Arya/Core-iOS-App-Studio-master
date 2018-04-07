//
//  ViewFoodMenuPdfViewController.m
//  Smart Classroom Manager
//
//  Created by Developer on 14/09/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "ViewFoodMenuPdfViewController.h"
#import "MFSideMenu.h"
#import "NSString+FontAwesome.h"
#import "Font_Face_Controller.h"
#import "UIImageView+WebCache.h"
#import "AddActivityViewController.h"
#import "MainViewController.h"
#import "Utilities.h"
#import "ImageCustomClass.h"
@interface ViewFoodMenuPdfViewController ()

@end

@implementation ViewFoodMenuPdfViewController

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
    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - Changes In UI


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
     Demo_ARR =[[NSMutableArray alloc]init];
    for (int i = 0; i< 5; i++) {
    [Demo_ARR addObject:[NSString stringWithFormat:@"Food Menu %d", i+1 ]];
    }
    [self addPickerView];
    [self addUIElements];
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
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    [self foodmenuButtonClicked];
}
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
    
    
    
    
    
    
//    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
    
        
        self.navigationItem.hidesBackButton = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  //      UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    CGSize size1;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=11){
        size1 = CGSizeMake(20, 20);
    } else {
        size1 = CGSizeMake(30, 30);
    }
    
    UIImage *butImage = [ImageCustomClass image:[UIImage imageNamed:@"back-2"] resize:size1];
    

        [button setBackgroundImage:butImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(gotoBack) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 20, 20);
        [button setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = backButton;
        
        
        [[self navigationItem] setBackBarButtonItem:backButton];
        
   
        self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Food Menu" value:@"" table:nil] ;
        
        
//    }
//    else
//    {
//        self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule" value:@"" table:nil] ;
//    }
    
}

-(void) addPickerView
{
    //------------ back_ground_pickerview view --------------//
    
    
    back_ground_pickerview=[[UIView alloc]init];
    back_ground_pickerview.frame=CGRectMake(0, self.view.frame.size.height+100, self.view.frame.size.width, 200);
    back_ground_pickerview.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:236.0f/255.0f blue:236.0f/255.0f alpha:1.0f];
    
    [self.view addSubview:back_ground_pickerview];
    
    
    
    //------------ UIpicker view for show State list --------------//
    
    pPickerState=[[UIPickerView alloc] initWithFrame:CGRectMake(0,65, self.view.frame.size.width, 200-65)];
    
    //    pPickerState.showsSelectionIndicator=YES;
    pPickerState.backgroundColor=[UIColor whiteColor];
    pPickerState.delegate=self;
    pPickerState.dataSource=self;
    pPickerState.userInteractionEnabled=YES;
    [back_ground_pickerview addSubview:pPickerState];
    
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    toolBar.userInteractionEnabled=YES;
    
//    search_TXT = [[UITextField alloc]initWithFrame:CGRectMake(0, toolBar.frame.origin.y+toolBar.frame.size.height, toolBar.frame.size.width, 25)];
//    search_TXT.placeholder =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Click here to search for your school" value:@"" table:nil];
//    search_TXT.tag = 123;
//    search_TXT.delegate = self;
//    [back_ground_pickerview addSubview:search_TXT];
    
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(cancelToucheds:)];
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(doneToucheds:)];
    
    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    
    [back_ground_pickerview addSubview:toolBar];


}
-(void) addUIElements
{
    UIButton * BTN_Food_Menu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [BTN_Food_Menu addTarget:self
                    action:@selector(foodmenuButtonClicked)
          forControlEvents:UIControlEventTouchUpInside];
    BTN_Food_Menu.backgroundColor=[Text_color_ Food_Schedule_Color_code];
    [BTN_Food_Menu setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Open food menus" value:@"" table:nil] forState:UIControlStateNormal];
    
    
    [BTN_Food_Menu.titleLabel setFont:[Font_Face_Controller opensanssemibold:20]];
    [BTN_Food_Menu setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    BTN_Food_Menu.frame = CGRectMake(0,50,self.view.frame.size.width, 50);
    [self.view addSubview:BTN_Food_Menu];

}

#pragma mark - -*********************
#pragma mark UIButton Actions
#pragma mark - -*********************
-(void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void) foodmenuButtonClicked
{
//    MainViewController *controller = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:controller animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        back_ground_pickerview.frame=CGRectMake(0,self.view.frame.size.height-200, self.view.frame.size.width, 200);
        
        
        [UIView commitAnimations];
    });

}

#pragma mark - -*********************
#pragma mark Activity PickerView
#pragma mark - -*********************

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

{
    return Demo_ARR.count;
}

-(NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [Demo_ARR objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
//    NSArray * arrayForPickerString = [[Demo_ARR objectAtIndex:row] componentsSeparatedByString:@"  "];
    
    pickre_STR=[Demo_ARR objectAtIndex:row];
//    pickre_index_value=row;
    
}

#pragma mark - -*********************
#pragma mark Activity Cancel Button
#pragma mark - -*********************

- (void)cancelToucheds:(UIBarButtonItem *)sender
{
    
    pickre_STR=nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        back_ground_pickerview.frame=CGRectMake(0,self.view.frame.size.height+200, self.view.frame.size.width, self.view.frame.size.height);
        [search_TXT resignFirstResponder];
        [UIView commitAnimations];
    });
    
}


#pragma mark - -*********************
#pragma mark Activity Done Button
#pragma mark - -*********************
- (void)doneToucheds:(UIBarButtonItem *)sender
{
    
    ViewFoodMenuWebViewViewController * viewFoofdMenuWebView = [[ViewFoodMenuWebViewViewController alloc]init];
//    viewFoofdMenuWebView.foodMenuUrlString =@"http://maven.apache.org/maven-1.x/maven.pdf";
    [self.navigationController pushViewController:viewFoofdMenuWebView animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        back_ground_pickerview.frame=CGRectMake(0,self.view.frame.size.height+200, self.view.frame.size.width, self.view.frame.size.height);
//        [search_TXT resignFirstResponder];
        [UIView commitAnimations];
    });


    
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
