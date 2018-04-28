//
//  Children_LIST.m
//  ELAR
//
//  Created by Bhushan Bawa on 20/02/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Children_LIST.h"
#import "Users_panel_ViewController.h"

#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "NSString+HTML.h"
#import "UIImageView+WebCache.h"
#import "Single_retriever_note_Notifications.h"
#import "Single_absent_note_Notification.h"
#import "ImageCustomClass.h"
#import "SmartNotes_WebViewController.h"
@interface Children_LIST ()

@end

@implementation Children_LIST

#pragma mark -
#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems {
    // self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
    
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
      //  self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
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
-(void)Navigation_bar
{
    user_pic = [[UIImageView alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"USR_image"]]);
    [user_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"customer_logo"]]]
                placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    
  //  user_pic.frame=CGRectMake(50, 0, 30, 30);
    CGSize size = CGSizeMake(30, 30);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11){
        
        [user_pic setImage: [ImageCustomClass image:user_pic.image resize:size]];
        
    } else {
        
        user_pic.frame=CGRectMake(0, 0, size.width, size.height);
        
    }
    user_pic.layer.cornerRadius=size.width*0.5;
    user_pic.layer.borderColor=[UIColor clearColor].CGColor;
    user_pic.layer.borderWidth=1;
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
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Child accounts" value:@"" table:nil];
    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button1 addTarget:self
//                action:@selector(goToSmartNotesWebView)
//      forControlEvents:UIControlEventTouchUpInside];
//    [button1 setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Website" value:@"" table:nil]forState:UIControlStateNormal];
//    button1.font=[Font_Face_Controller opensansLight:15];
//    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    button1.frame = CGRectMake(0,5,100,100);
//    UIBarButtonItem *backButton1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
//    self.navigationItem.leftBarButtonItem = backButton1;
//    [[self navigationItem] setBackBarButtonItem:backButton1];
    
    
}

-(void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
//-(void)goToSmartNotesWebView {
//    SmartNotes_WebViewController   *controller = [[SmartNotes_WebViewController alloc] initWithNibName:@"SmartNotes_WebViewController" bundle:nil];
//    [self.navigationController pushViewController:controller animated:YES];
//}

-(void)Action_slider
{
    [self rightSideMenuButtonPressed];
}

- (void) retriever_note:(NSMutableDictionary *) notification
{
    
    NSLog(@"%@",notification);
    Single_retriever_note_Notifications *objSetting_ViewController=[[Single_retriever_note_Notifications alloc]init];
    objSetting_ViewController.array_all_detail=notification;
    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:objSetting_ViewController];
    
    [self presentViewController:HomeNavController animated:YES completion:nil];
    
    
}

- (void) absent_note:(NSMutableDictionary *) notification
{
    NSLog(@"%@",notification);
    Single_absent_note_Notification *objSetting_ViewController=[[Single_absent_note_Notification alloc]init];
    objSetting_ViewController.array_all_detail=notification;
    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:objSetting_ViewController];
    
    [self presentViewController:HomeNavController animated:YES completion:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self Navigation_bar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(retriever_note:)
                                                 name:@"retriever_note"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(absent_note:)
                                                 name:@"absent_note"
                                               object:nil];
    

    
        self.view.backgroundColor=[UIColor whiteColor];
    
    mtableview = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    mtableview.dataSource = self;
    mtableview.delegate = self;
    
    [self.view addSubview:mtableview];
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    NSArray *views=[cell.contentView subviews];
    for(int i=0;i<[views count];i++)
    {
        UIView *tempView=[views objectAtIndex:i];
        [tempView removeFromSuperview];
        tempView = nil;
    }
    
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    user_pic=[[UIImageView alloc]init];
    user_pic.frame=CGRectMake(15, 15, 50, 50);
    user_pic.layer.cornerRadius=0.5*50;
    user_pic.clipsToBounds=YES;
    
  [user_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"USR_image"]objectAtIndex:indexPath.row]]] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
   [cell.contentView addSubview:user_pic];
    
    
    mUser_name=[[UILabel alloc]init];
    mUser_name.frame=CGRectMake(user_pic.frame.origin.x+user_pic.frame.size.width+15, 15, 250, 50);
    mUser_name.text=[NSString stringWithFormat:@"%@ %@",[[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"USR_FirstName"]objectAtIndex:indexPath.row],[[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"USR_LastName"]objectAtIndex:indexPath.row]];
    [cell.contentView addSubview:mUser_name];
    
    
    
    
    //set checkbox image
    UIImageView *checkboximageView = [[UIImageView alloc]init];
    checkboximageView.frame=CGRectMake(self.view.frame.size.width-30, 30 , 20, 20);
    if(!([[array_list_checked objectAtIndex: indexPath.row] isEqualToString:@"0"])){
        checkboximageView.image=[UIImage imageNamed:@"checkbox_checked.png"];
    }else{
        checkboximageView.image=[UIImage imageNamed:@"checkbox_unchecked.png"];
    }
    
    [cell.contentView addSubview:checkboximageView];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
       
    [[NSUserDefaults standardUserDefaults]setObject:[[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"id"]objectAtIndex:indexPath.row] forKey:@"student_id"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"USR_LastName"]objectAtIndex:indexPath.row];
    
    
    Users_panel_ViewController *objUsers_panel_ViewController=[[Users_panel_ViewController alloc]init];
    objUsers_panel_ViewController.User_name=[NSString stringWithFormat:@"%@ %@",[[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"USR_FirstName"]objectAtIndex:indexPath.row],[[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"USR_LastName"]objectAtIndex:indexPath.row]];
    
    
    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@ %@",[[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"USR_FirstName"]objectAtIndex:indexPath.row],[[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"USR_LastName"]objectAtIndex:indexPath.row]] forKey:@"student_name"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    objUsers_panel_ViewController.indexOfChildSelected = indexPath.row;
    
    
//    objUsers_panel_ViewController.dropOff_time=[[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"retrieval_time"]objectAtIndex:indexPath.row];
    
    
    [self.navigationController pushViewController:objUsers_panel_ViewController animated:YES];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"authentication_token"]objectAtIndex:indexPath.row]forKey:@"authentication_token"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
  //[[NSUserDefaults standardUserDefaults] setObject: forKey:<#(nonnull NSString *)#>]

    
    
      
    
   }


@end
