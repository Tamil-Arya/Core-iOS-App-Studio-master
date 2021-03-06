//
//  Edit_select_Tag_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 22/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Edit_select_Tag_ViewController.h"
#import "Font_Face_Controller.h"
#import "NSString+HTML.h"

#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "Curriculum_Deatil_ViewController.h"
#import "UIImageView+WebCache.h"
#import "ELR_loaders_.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"
@interface Edit_select_Tag_ViewController ()


@end

@implementation Edit_select_Tag_ViewController

@synthesize dict;

@synthesize values;
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

- (void)YourSelector:(NSNotification *)notification
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]valueForKey:@"Profile_Pic"]]
                 placeholderImage:[UIImage imageNamed:@"user_pic.png"]];
    
}

- (void)doneEditing {
    
    Main_alll_value_DICT=[[NSMutableArray alloc]init];
    Main_alll_value=[[NSMutableArray alloc]init];
    
    [[NSUserDefaults standardUserDefaults]setValue:SUB_Id_alll_value forKey:@"Tages"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Tages"]);
    
    
    
    for (int i=0; i<CHIL_alll_value.count; i++) {
        
        [Main_alll_value addObject:[SUB_Id_alll_value objectAtIndex:i]];
        [Main_alll_value addObject:[CHIL_alll_value objectAtIndex:i]];
        [Main_alll_value addObject:[PAR_alll_value objectAtIndex:i]];
        
        
        
        NSLog(@"Main_alll_value %@",Main_alll_value);
        
    }
    [[NSNotificationCenter defaultCenter]
     postNotificationName:_notifications  object:Main_alll_value];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



-(void)Navigation_bar
{
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                                                target:self
//                                                                                action:@selector(doneEditing)];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneEditing)];

    
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
    
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName:[Font_Face_Controller opensanssemibold:15],
                                                                    NSForegroundColorAttributeName: [UIColor blackColor]
                                                                    };
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Curriculum Tags" value:@"" table:nil];
    
    
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
    [button addTarget:self action:@selector(gotoBack) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    
}

-(void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",values);
    
    
    _cellSelected=[[NSMutableArray alloc]init];
    
    
    SUB_Id_alll_value=[[NSMutableArray alloc]init];
    CHIL_alll_value=[[NSMutableArray alloc]init];
    PAR_alll_value=[[NSMutableArray alloc]init];
    
    
    
    
    
    [self Navigation_bar];
    
    self.navigationController.navigationBarHidden=NO;
    
    
    
    
    //    imageView = [[UIImageView alloc] init];
    //    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Profile_Pic"]);
    //    [imageView sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]valueForKey:@"Profile_Pic"]]
    //                 placeholderImage:[UIImage imageNamed:@"user_pic.png"]];
    //
    //    imageView.frame=CGRectMake(50, 0, 25, 25);
    //    imageView.layer.cornerRadius=25*0.5;
    //    imageView.layer.borderColor=[UIColor colorWithRed:180.0f/255.0f green:180.0f/255.0f blue:179.0f/255.0f alpha:1.0].CGColor;
    //    imageView.layer.borderWidth=1;
    //    imageView.clipsToBounds=YES;
    //    imageView.userInteractionEnabled=YES;
    //    imageView.contentMode = UIViewContentModeScaleToFill;
    //    UIBarButtonItem *imageButton = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    //    self.navigationItem.rightBarButtonItem = imageButton;
    //
    //    UITapGestureRecognizer *tap_action_slider = [[UITapGestureRecognizer alloc]
    //                                                 initWithTarget:self
    //                                                 action:@selector(Action_slider)];
    //
    //    [imageView addGestureRecognizer:tap_action_slider];
    
    
    
    
    // init table view
    tableViewm = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height)) style:UITableViewStylePlain];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    tableViewm.delegate = self;
    tableViewm.dataSource = self;
    
    tableViewm.backgroundColor = [UIColor clearColor];
    tableViewm.showsVerticalScrollIndicator=NO;
    
    // add to canvas
    [self.view addSubview:tableViewm];
    
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Tages_API) withObject:nil afterDelay:0.5];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
}

-(void)Action_slider
{
    
    
    
    [self rightSideMenuButtonPressed];
    
    
}



-(void)CallTheServer_Tages_API
{
    if ([API connectedToInternet]==YES) {
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@picture_diary/get_curriculum_tags",[Utilities API_link_url_subDomain]]];
        
        NSLog(@"%@",[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]);
        
        NSLog(@"%@",[Utilities API_link_url_subDomain]);
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        NSLog(@"dict %@",dict);
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            //curriculum_tags
            if([[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:0]valueForKey:@"children"] count] == 0 )
            {
                
            }
            else
            {
              

//            NSLog(@"%u",[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:0]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]count]);
//            
//            
//            
//            NSLog(@"%u",[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:0]valueForKey:@"children"]objectAtIndex:0]count]);
                 [tableViewm reloadData];
            }
           
            
            
            
        }else if([[dict valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        
        
        
    }
    
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
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


#pragma mark - -*********************
#pragma mark TableView HeightForHeader Method
#pragma mark - -*********************

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

#pragma mark - -*********************
#pragma mark TableView DataSource Method
#pragma mark - -*********************


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeader = [[UIView alloc] init];
    sectionHeader.frame=CGRectMake(0, 0,tableViewm.frame.size.width, 50);
    sectionHeader.backgroundColor=[UIColor whiteColor];
    
    UILabel *curriculum_tags = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,tableViewm.frame.size.width, 35)];
    curriculum_tags.backgroundColor = [Text_color_ EDU_Blog_Color_code];
    curriculum_tags.font = [Font_Face_Controller opensanssemibold:13];
    curriculum_tags.tag=section;
    curriculum_tags.text=[NSString stringWithFormat:@"  %@",[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:section]valueForKey:@"title"]];
    curriculum_tags.userInteractionEnabled=YES;
    
    
    curriculum_tags.textAlignment = NSTextAlignmentLeft;
    curriculum_tags.textColor=[UIColor whiteColor];
    
    [sectionHeader addSubview:curriculum_tags];
    
    
    UITapGestureRecognizer *tap_curriculum_tags = [[UITapGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(Header_action:)];
    
    [curriculum_tags addGestureRecognizer:tap_curriculum_tags];
    
    
    
    
    UILabel *children = [[UILabel alloc] initWithFrame:CGRectMake(10, curriculum_tags.frame.origin.y+curriculum_tags.frame.size.height, tableViewm.frame.size.width-20, 20)];
    children.backgroundColor = [UIColor whiteColor];
    children.font = [Font_Face_Controller opensansregular:12];

    if ([[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:section]valueForKey:@"children"] count] !=0) {

    children.text = [[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"title"];
    }
    
    children.textAlignment = NSTextAlignmentLeft;
    children.textColor=[UIColor blackColor];
    children.userInteractionEnabled=YES;
    children.tag=section;
    [sectionHeader addSubview:children];
    
    
    UITapGestureRecognizer *children_TAB = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(children_action:)];
    
    [children addGestureRecognizer:children_TAB];
    
    
    return sectionHeader;
    
}



- (void) children_action: (UITapGestureRecognizer *)recognizer
{
    Curriculum_Deatil_ViewController *objSetting_ViewController=[[Curriculum_Deatil_ViewController alloc]init];
    // objSetting_ViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    objSetting_ViewController.title=[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:recognizer.view.tag]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"title"];
    objSetting_ViewController.Detail=[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:recognizer.view.tag]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"description"];
    
    
    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:objSetting_ViewController];
    
    [self presentViewController:HomeNavController animated:YES completion:nil];
    
    
}

- (void) Header_action: (UITapGestureRecognizer *)recognizer
{
    
    
    Curriculum_Deatil_ViewController *objSetting_ViewController=[[Curriculum_Deatil_ViewController alloc]init];
    // objSetting_ViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    objSetting_ViewController.title=[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:recognizer.view.tag]valueForKey:@"title"];
    objSetting_ViewController.Detail=[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:recognizer.view.tag]valueForKey:@"description"];
    
    
    UINavigationController *HomeNavController =[[UINavigationController alloc]initWithRootViewController:objSetting_ViewController];
    
    [self presentViewController:HomeNavController animated:YES completion:nil];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize labelHeight;
    if ([[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"] count] !=0) {

    
     labelHeight = [self heigtForCellwithString:[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"title"] withFont:[Font_Face_Controller opensansregular:11]];
    }
    
    return labelHeight.height+10; // the return height + your other view height
}


-(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont *)font{
    
    CGSize constraint = CGSizeMake(tableViewm.frame.size.width,9999); // Replace 300 with your label width
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    
    return rect.size;
    
}





#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return [[dict valueForKey:@"curriculum_tags"]count];
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    
//    NSLog(@"%u",[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]count]);
    
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(tableViewDidLoadRows:) object:theTableView];
    
    // create a perform request to call the didLoadRows method on the next event loop.
    [self performSelector:@selector(tableViewDidLoadRows:) withObject:theTableView afterDelay:0];
    
    if ([[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:section]valueForKey:@"children"] count] !=0) {
         return [[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]count];
    }
    else
    {
            return 0;
    }
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableViewm dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSArray *views=[cell.contentView subviews];
    for(int i=0;i<[views count];i++)
    {
        UIView *tempView=[views objectAtIndex:i];
        [tempView removeFromSuperview];
        tempView = nil;
    }
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    description=[[UILabel alloc]init];
    description.backgroundColor=[UIColor clearColor];
    if ([[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"] count] !=0) {
    description.text=[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"title"];
    }
    description.numberOfLines = 0;
    description.frame=CGRectMake(5, 5, tableViewm.frame.size.width-20, 40);
    
    
    description.textColor=[UIColor blackColor];
    description.font=[Font_Face_Controller opensansLight:11];
    description.textAlignment=NSTextAlignmentLeft;
    [description sizeToFit];
    [cell.contentView addSubview:description];
    
    cell.backgroundColor=[UIColor whiteColor];
    
    
      if (check==false) {
    
    
     if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Tages"]count]!=0) {
         
         
         
         
         for (int tag=0; tag<[[[NSUserDefaults standardUserDefaults]valueForKey:@"Tages"]count]; tag++) {
             
             if ([[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"id"]isEqualToString:[[[NSUserDefaults standardUserDefaults]valueForKey:@"Tages"]objectAtIndex:tag]]) {
                 
                 
                 [_cellSelected addObject:indexPath];

                 cell.accessoryType = UITableViewCellAccessoryCheckmark;
                 
                 [SUB_Id_alll_value addObject:[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"id"]];
                 
                 [CHIL_alll_value addObject:[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"parent_id"]];
                 
                 
                 [PAR_alll_value addObject:[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"root_parent_id"]];

                 
             }
             else
             {
                 
             }
             
         }
         
     }
    else
    {
        
        for (int tag=0; tag<[values count]; tag++) {
            
            if ([[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"id"]isEqualToString:[values objectAtIndex:tag]]) {
                [_cellSelected addObject:indexPath];

                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                [SUB_Id_alll_value addObject:[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"id"]];
                
                [CHIL_alll_value addObject:[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"parent_id"]];
                
                
                [PAR_alll_value addObject:[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"root_parent_id"]];

                
            }
            else
            {
                
            }

  
        
      
        }
    }
   
      }
    else
    {
   
    if ([_cellSelected containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    }
        
    NSLog(@"%d, %d",indexPath.section,indexPath.row);
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    check=true;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_cellSelected containsObject:indexPath])
    {
        [_cellSelected removeObject:indexPath];
        
        NSLog(@"%@",dict);
        [SUB_Id_alll_value removeObjectsInArray:[SUB_Id_alll_value filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"id"]]]];
        
        [CHIL_alll_value removeObjectsInArray:[CHIL_alll_value filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"parent_id"]]]];
        
        [PAR_alll_value removeObjectsInArray:[PAR_alll_value filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"root_parent_id"]]]];
        
    }
    else
    {
        
        [SUB_Id_alll_value addObject:[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"id"]];
        
        [CHIL_alll_value addObject:[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"parent_id"]];
        
        
        [PAR_alll_value addObject:[[[[[[[dict valueForKey:@"curriculum_tags"]objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:0]valueForKey:@"subchildren"]objectAtIndex:indexPath.row]valueForKey:@"root_parent_id"]];
        
        [_cellSelected addObject:indexPath];
    }
    
    NSLog(@"_cellSelected %@",_cellSelected);
    [tableView reloadData];
}

-(void)tableViewDidLoadRows:(UITableView*)tableView{
    // make the cell selected after all rows loaded
    if(!isReloaded)
    {
    NSLog(@"Complete");
       if(_cellSelected.count == 0)
       {
       }
      else
      {
        NSIndexPath * indexOfFirstRow = [_cellSelected objectAtIndex:0];
        
    [self tableView:tableView didSelectRowAtIndexPath:indexOfFirstRow];
    [self tableView:tableView didSelectRowAtIndexPath:indexOfFirstRow];
        isReloaded = YES;
      }
    }
    
   // [tableView reloadData];
//    if(self.selectedObject){
//        NSInteger index = [self.objects indexOfObject:self.selectedObject];
//        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
