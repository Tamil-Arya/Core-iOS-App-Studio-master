//
//  note_history.m
//  SCM
//
//  Created by pnf on 12/28/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//

#import "note_history.h"
#import "AppDelegate.h"
#import "JSON.h"

#import "Utilities.h"
#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "API.h"
#import "JSON.h"
#import "NSString+HTML.h"
#import "UIImageView+WebCache.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "ELR_loaders_.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"
@interface note_history ()

@end

@implementation note_history
@synthesize color;
@synthesize note_history_table_view_height_single;


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
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Note History" value:@"" table:nil];
    
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size1;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=11){
        size1 = CGSizeMake(20, 20);
    } else {
        size1 = CGSizeMake(30, 30);
    }
    
    UIImage *butImage = [ImageCustomClass image:[UIImage imageNamed:@"back-2"] resize:size1];
    

//    UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
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
    
    
    [self Navigation_bar];
    
    
    // Do any additional setup after loading the view.
    
       self.view.backgroundColor = [UIColor whiteColor];
    
    note_history_table_view_height_single = 50;
    
    //background
    backgroundBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundBox.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    [self.view addSubview:backgroundBox];
    
    //Userdetails box
    UIView *userdetailsBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    userdetailsBox.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
    [backgroundBox addSubview:userdetailsBox];
    
    UILabel *userimage_background = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 , 100, 100)];
    userimage_background.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:121.0f/255.0f blue:31.0f/255.0f alpha:1.0];
    [backgroundBox addSubview:userimage_background];
    
    //set User profile Image button
   imageView = [[UIImageView alloc]init];
    [imageView setFrame:CGRectMake(14, 14 , 92, 92)];
    imageView.image = [UIImage imageNamed:@"profile9.png"];
   
    //[imageView addTarget:self action:@selector(action_OpenUserProfileView) forControlEvents:UIControlEventTouchUpInside];
    [backgroundBox addSubview:imageView];
    
    //add user name text
    usernamelabel = [[UILabel alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+10, 10 ,self.view.frame.size.width-115, 25)];
   // usernamelabel.text = @"Simone Axelsson";
    usernamelabel.textColor = [UIColor whiteColor];
    [usernamelabel setFont:[Font_Face_Controller opensansregular:16]];
    usernamelabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:usernamelabel];
    
    //add guardians text
    UILabel *guardianslabel = [[UILabel alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+10, 39 ,150, 20)];
    guardianslabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Guardians" value:@"" table:nil];
    guardianslabel.textColor = [UIColor whiteColor];
    [guardianslabel setFont:[Font_Face_Controller opensansregular:16]];
    guardianslabel.textAlignment=NSTextAlignmentLeft;
    [backgroundBox addSubview:guardianslabel];
    
    //guardian1 details box
    UIView *guardian1detailsBox  = [[UIView alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+5, 61, self.view.frame.size.width-120, 22)];
    guardian1detailsBox.backgroundColor = [UIColor colorWithRed:216.0f/255.0f green:121.0f/255.0f blue:26.0f/255.0f alpha:1.0];
    [backgroundBox addSubview:guardian1detailsBox];
    
//    //add guardian1 text
//    guardian1namelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 1 ,130, 20)];
//    guardian1namelabel.text = @"Axelsson";
//    guardian1namelabel.textColor = [UIColor whiteColor];
//    [guardian1namelabel setFont:[Font_Face_Controller opensansregular:16]];
//    guardian1namelabel.textAlignment=NSTextAlignmentLeft;
//    [guardian1detailsBox addSubview:guardian1namelabel];
//    
//    //add guardian1 phone text
//    guardian1phonelabel = [[UILabel alloc] initWithFrame:CGRectMake(guardian1detailsBox.frame.size.width-115, 1 ,110, 20)];
//    guardian1phonelabel.text = @"0780020034";
//    guardian1phonelabel.textColor = [UIColor whiteColor];
//    [guardian1phonelabel setFont:[Font_Face_Controller opensansregular:16]];
//    guardian1phonelabel.textAlignment=NSTextAlignmentRight;
//    [guardian1detailsBox addSubview:guardian1phonelabel];
//    
//    
//    //guardian2 details box
//    UIView *guardian2detailsBox  = [[UIView alloc] initWithFrame:CGRectMake(userimage_background.frame.origin.x+userimage_background.frame.size.width+5, 88, self.view.frame.size.width-120, 22)];
//    guardian2detailsBox.backgroundColor = [UIColor colorWithRed:216.0f/255.0f green:121.0f/255.0f blue:26.0f/255.0f alpha:1.0];
//    [backgroundBox addSubview:guardian2detailsBox];
//    
//    //add guardian2 text
//    guardian2namelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 1 ,130, 20)];
//    guardian2namelabel.text = @"Axelsson";
//    guardian2namelabel.textColor = [UIColor whiteColor];
//    [guardian2namelabel setFont:[Font_Face_Controller opensansregular:16]];
//    guardian2namelabel.textAlignment=NSTextAlignmentLeft;
//    [guardian2detailsBox addSubview:guardian2namelabel];
//    
//    //add guardian2 phone text
//    guardian2phonelabel = [[UILabel alloc] initWithFrame:CGRectMake(guardian2detailsBox.frame.size.width-115, 1 ,110, 20)];
//    guardian2phonelabel.text = @"0790010023";
//    guardian2phonelabel.textColor = [UIColor whiteColor];
//    [guardian2phonelabel setFont:[Font_Face_Controller opensansregular:16]];
//    guardian2phonelabel.textAlignment=NSTextAlignmentRight;
//    [guardian2detailsBox addSubview:guardian2phonelabel];
//    //-------------User details box end-----------------//
//    
//
    
    //-------------Absence/Retriever Note history-----------------
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, userdetailsBox.frame.origin.y+userdetailsBox.frame.size.height, self.view.frame.size.width, (self.view.frame.size.height-(userdetailsBox.frame.origin.y+userdetailsBox.frame.size.height))-58) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor=[UIColor clearColor];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [tableView setTag:000];
    [backgroundBox addSubview: tableView];
    
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Note_history_API) withObject:nil afterDelay:0.5];

    
    //retrivals/note_history
}



#pragma mark - -*********************
#pragma mark Call API Update_Profile_detail Method
#pragma mark - -*********************
-(void)CallTheServer_Note_history_API
{
    if ([API connectedToInternet]==YES) {
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
    
            responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&date=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults] valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults] valueForKey:@"student_id"],@""]:[NSString stringWithFormat:@"%@retrivals/note_history",[Utilities API_link_url_subDomain]]];
            
        
        
        NSDictionary *responseDict = [responseString JSONValue];
        note_history_dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[note_history_dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
          
            
          
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [Utilities API_link_url_IMG], [[note_history_dict valueForKey:@"student"]valueForKey:@"USR_image"]]] placeholderImage:[UIImage imageNamed:@"profile9.png"]];
            
            
            
            if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color1"]){
                imageView.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color2"]){
                imageView.backgroundColor = [UIColor colorWithRed:90.0f/255.0f green:187.0f/255.0f blue:94.0f/255.0f alpha:1.0];
            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color3"]){
                imageView.backgroundColor = [UIColor colorWithRed:47.0f/255.0f green:188.0f/255.0f blue:208.0f/255.0f alpha:1.0];
            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color4"]){
                imageView.backgroundColor = [UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color5"]){
                imageView.backgroundColor = [UIColor colorWithRed:136.0f/255.0f green:99.0f/255.0f blue:169.0f/255.0f alpha:1.0];
            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color6"]){
                imageView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:116.0f/255.0f blue:169.0f/255.0f alpha:1.0];
            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color7"]){
                imageView.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:90.0f/255.0f blue:107.0f/255.0f alpha:1.0];
            }
            
            
            
            
            
            usernamelabel.text = [NSString stringWithFormat:@"%@ %@", [[[[note_history_dict valueForKey:@"student"]valueForKey:@"USR_FirstName"]capitalizedString]stringByConvertingHTMLToPlainText], [[[note_history_dict valueForKey:@"student"]valueForKey:@"USR_LastName"]stringByConvertingHTMLToPlainText]];
            
            CGSize result = [[UIScreen mainScreen] bounds].size;
            
            for (int a=0; a<([[note_history_dict valueForKey:@"parent"] count]); a++) {
                
                if(a==2){
                    break;
                }
                UIView *guardiandetailsBox;
                if(a==0){
                    //guardian1 details box
                    guardiandetailsBox  = [[UIView alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, 61, self.view.frame.size.width-130, 22)];
                }else{
                    guardiandetailsBox  = [[UIView alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, 88, self.view.frame.size.width-130, 22)];
                }
                guardiandetailsBox.backgroundColor = [UIColor colorWithRed:216.0f/255.0f green:121.0f/255.0f blue:26.0f/255.0f alpha:1.0];
                [backgroundBox addSubview:guardiandetailsBox];
                
                UILabel *guardiannamelabel;
                if(a==0){
                    //add guardian1 text
                    guardiannamelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 1 ,130, 20)];
                }else{
                    guardiannamelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 1 ,130, 20)];
                }
                guardiannamelabel.text = [NSString stringWithFormat:@"%@ %@",[[[[[note_history_dict valueForKey:@"parent"][a] valueForKey:@"User" ] valueForKey:@"USR_FirstName"]stringByConvertingHTMLToPlainText]capitalizedString],[[[[note_history_dict valueForKey:@"parent"][a] valueForKey:@"User" ] valueForKey:@"USR_LastName"]stringByConvertingHTMLToPlainText]];
                guardiannamelabel.textColor = [UIColor whiteColor];
                if(result.width<=320){
                    [guardiannamelabel setFont:[Font_Face_Controller opensansLight:12]];
                }else{
                    [guardiannamelabel setFont:[Font_Face_Controller opensansLight:16]];
                }
                guardiannamelabel.textAlignment=NSTextAlignmentLeft;
                [guardiandetailsBox addSubview:guardiannamelabel];
                
                UILabel *guardianphonelabel;
                if(a==0){
                    //add guardian1 phone text
                    guardianphonelabel = [[UILabel alloc] initWithFrame:CGRectMake(guardiandetailsBox.frame.size.width-115, 1 ,110, 20)];
                }else{
                    guardianphonelabel = [[UILabel alloc] initWithFrame:CGRectMake(guardiandetailsBox.frame.size.width-115, 1 ,110, 20)];
                }
                guardianphonelabel.text = [[[[note_history_dict valueForKey:@"parent"][a] valueForKey:@"User" ] valueForKey:@"contact_number"]stringByConvertingHTMLToPlainText];
                guardianphonelabel.textColor = [UIColor whiteColor];
                if(result.width<=320){
                    [guardianphonelabel setFont:[Font_Face_Controller opensansLight:12]];
                }else{
                    [guardianphonelabel setFont:[Font_Face_Controller opensansLight:16]];
                }
                guardianphonelabel.textAlignment=NSTextAlignmentRight;
                [guardiandetailsBox addSubview:guardianphonelabel];
            }
            
//            usernamelabel.text=[NSString stringWithFormat:@"%@ %@",[[[[note_history_dict valueForKey:@"student"]valueForKey:@"USR_FirstName"]capitalizedString]stringByConvertingHTMLToPlainText],[[[[note_history_dict valueForKey:@"student"]valueForKey:@"USR_LastName"]capitalizedString]stringByConvertingHTMLToPlainText]];
            
//            if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color1"]){
//                user_pic.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
//            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color2"]){
//                user_pic.backgroundColor = [UIColor colorWithRed:90.0f/255.0f green:187.0f/255.0f blue:94.0f/255.0f alpha:1.0];
//            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color3"]){
//                user_pic.backgroundColor = [UIColor colorWithRed:47.0f/255.0f green:188.0f/255.0f blue:208.0f/255.0f alpha:1.0];
//            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color4"]){
//                user_pic.backgroundColor = [UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
//            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color5"]){
//                user_pic.backgroundColor = [UIColor colorWithRed:136.0f/255.0f green:99.0f/255.0f blue:169.0f/255.0f alpha:1.0];
//            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color6"]){
//                user_pic.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:116.0f/255.0f blue:169.0f/255.0f alpha:1.0];
//            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color7"]){
//                user_pic.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:90.0f/255.0f blue:107.0f/255.0f alpha:1.0];
//            }
            

            [tableView reloadData];
            
        }else if([[note_history_dict valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[note_history_dict valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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



-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont *)font{
    
    CGSize constraint = CGSizeMake(tableView.frame.size.width,9999); // Replace 300 with your label width
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    
    
    
    
    
    
    
    
    
    
    
    return rect.size;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize labelHeight = [self heigtForCellwithString:[[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"description"]objectAtIndex:indexPath.row]    withFont:[Font_Face_Controller opensansregular:16]];

    
    
    if ([[[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"type"]objectAtIndex:indexPath.row]isEqualToString:@"absence_note"]) {
        
        return 115+labelHeight.height;
        
    }
    else
    {
        
        
        return 150+labelHeight.height+labelHeight.height;
    }
    
    
    }


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[note_history_dict valueForKey:@"retriever_note"]count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSArray *views=[cell.contentView subviews];
    for(int i=0;i<[views count];i++)
    {
        UIView *tempView=[views objectAtIndex:i];
        [tempView removeFromSuperview];
        tempView = nil;
    }

    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
        if([[[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"type"]objectAtIndex:indexPath.row]isEqualToString:@"absence_note"]){
        //--------------retrievalnote details box start--------//
        
            
            //add base label
            UILabel *absentnotedetailsBox = [[UILabel alloc] initWithFrame:CGRectMake(0, 5 ,self.view.frame.size.width, 30)];
            absentnotedetailsBox.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
            [cell.contentView addSubview:absentnotedetailsBox];
            
            //absentnote text Label
            UILabel *absentnotelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, absentnotedetailsBox.frame.origin.y+10 ,[@"Absence Note" sizeWithFont:[Font_Face_Controller opensanssemibold:18]].width, 25)];
            absentnotelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absence note" value:@"" table:nil];
            absentnotelabel.textColor = [UIColor whiteColor];
            [absentnotelabel setFont:[Font_Face_Controller opensanssemibold:18]];
            absentnotelabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:absentnotelabel];
            
            //absentdate text Label
            UILabel *absentdatelabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-90, absentnotedetailsBox.frame.origin.y+15,85, 20)];
            absentdatelabel.text =[[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"date"]objectAtIndex:indexPath.row];
            absentdatelabel.textColor = [UIColor whiteColor];
            [absentdatelabel setFont:[Font_Face_Controller opensansLight:16]];
            absentdatelabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:absentdatelabel];
            
            //absentnote desc text Label
            UILabel *absentnotedesclabel = [[UILabel alloc] initWithFrame:CGRectMake(10, absentnotelabel.frame.origin.y+absentnotelabel.frame.size.height+10 ,100, 22)];
            absentnotedesclabel.text = @"Description";
            absentnotedesclabel.textColor = [UIColor whiteColor];
            [absentnotedesclabel setFont:[Font_Face_Controller opensanssemibold:18]];
            absentnotedesclabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:absentnotedesclabel];
            
            //writtenby text Label
            
            UILabel *writtenbylabel = [[UILabel alloc] initWithFrame:CGRectMake(10, absentnotedesclabel.frame.origin.y+absentnotedesclabel.frame.size.height+5,150,20)];
            
            writtenbylabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Written by:" value:@"" table:nil];
            writtenbylabel.textColor = [UIColor whiteColor];
            [writtenbylabel setFont:[Font_Face_Controller opensansLight:16]];
            writtenbylabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:writtenbylabel];
            
            //writtenbyvalue text  Label
            UILabel *writtenbyvaluelabel = [[UILabel alloc] initWithFrame:CGRectMake(writtenbylabel.frame.origin.x+writtenbylabel.frame.size.width+5, absentnotedesclabel.frame.origin.y+absentnotedesclabel.frame.size.height+5  ,[[[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"written_by"]objectAtIndex:indexPath.row] sizeWithFont:[Font_Face_Controller opensansLight:16]].width, 20)];
            
            writtenbyvaluelabel.text = [[[[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"written_by"]objectAtIndex:indexPath.row]capitalizedString]stringByConvertingHTMLToPlainText];
            writtenbyvaluelabel.textColor = [UIColor whiteColor];
            [writtenbyvaluelabel setFont:[Font_Face_Controller opensansLight:16]];
            writtenbyvaluelabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:writtenbyvaluelabel];
            
            
            
            
            
            
            //absentnotedescription text Label
            UILabel *absentnotedescriptionlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, writtenbylabel.frame.origin.y+writtenbylabel.frame.size.height+5 ,self.view.frame.size.width-20, 40)];
            absentnotedescriptionlabel.numberOfLines = 0;
            absentnotedescriptionlabel.text = [[[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"description"]objectAtIndex:indexPath.row]stringByConvertingHTMLToPlainText];
            absentnotedescriptionlabel.textColor = [UIColor whiteColor];
            [absentnotedescriptionlabel setFont:[Font_Face_Controller opensansLight:16]];
            [absentnotedescriptionlabel sizeToFit];
            absentnotedescriptionlabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:absentnotedescriptionlabel];
            //set absentnote background view height dynamically as per the text added in description
            absentnotedetailsBox.frame=CGRectMake(0, 10, self.view.frame.size.width, ( absentnotedescriptionlabel.frame.origin.y+absentnotedescriptionlabel.frame.size.height));
            note_history_table_view_height_single = absentnotedetailsBox.frame.size.height+10;
            
        }else {
            //--------------absentnote details box start--------//
            
            
            //add base label
            UILabel *retrievalnotedetailsBox = [[UILabel alloc] initWithFrame:CGRectMake(0, 5 ,self.view.frame.size.width, 30)];
            retrievalnotedetailsBox.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:131.0f/255.0f blue:30.0f/255.0f alpha:1.0];
            [cell.contentView addSubview:retrievalnotedetailsBox];
            
            //retrievalnote text Label
            UILabel *retrievalnotelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, retrievalnotedetailsBox.frame.origin.y+10 ,[@"Retriever note" sizeWithFont:[Font_Face_Controller opensanssemibold:18]].width, 25)];
            retrievalnotelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retriever note" value:@"" table:nil];
            retrievalnotelabel.textColor = [UIColor whiteColor];
            [retrievalnotelabel setFont:[Font_Face_Controller opensanssemibold:18]];
            retrievalnotelabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:retrievalnotelabel];
            
            //retrievalname text Label
            UILabel *retrievalnamelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, retrievalnotelabel.frame.origin.y+retrievalnotelabel.frame.size.height+10,100, 20)];
            retrievalnamelabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Retriever" value:@"" table:nil];
            retrievalnamelabel.textColor = [UIColor whiteColor];
            [retrievalnamelabel setFont:[Font_Face_Controller opensanssemibold:16]];
            retrievalnamelabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:retrievalnamelabel];
            
            
            //retrievalnamevalue text Label
            UILabel *retrievalnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(10, retrievalnamelabel.frame.origin.y+retrievalnamelabel.frame.size.height+5 ,120, 20)];
            retrievalnamevalue.text = [[[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"retriever_name"]objectAtIndex:indexPath.row]stringByConvertingHTMLToPlainText];
            retrievalnamevalue.textColor = [UIColor whiteColor];
            [retrievalnamevalue setFont:[Font_Face_Controller opensansLight:16]];
            retrievalnamevalue.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:retrievalnamevalue];
            
            
            //contactdetails text Label
            UILabel *contactdetailslabel = [[UILabel alloc] initWithFrame:CGRectMake(10, retrievalnamevalue.frame.origin.y+retrievalnamevalue.frame.size.height+10 ,150, 20)];
            contactdetailslabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Contact details" value:@"" table:nil];
            contactdetailslabel.textColor = [UIColor whiteColor];
            [contactdetailslabel setFont:[Font_Face_Controller opensanssemibold:16]];
            contactdetailslabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:contactdetailslabel];
            
            
            //contactdetailsvalue text Label
            UILabel *contactdetailsvalue = [[UILabel alloc] initWithFrame:CGRectMake(10, contactdetailslabel.frame.origin.y+contactdetailslabel.frame.size.height+5 ,100, 20)];
            contactdetailsvalue.text = [[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"phone"]objectAtIndex:indexPath.row];
            contactdetailsvalue.textColor = [UIColor whiteColor];
            [contactdetailsvalue setFont:[Font_Face_Controller opensansLight:16]];
            contactdetailsvalue.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:contactdetailsvalue];
            
            
            //retrievaldate text Label
            UILabel *retrievaldatelabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-90, retrievalnotedetailsBox.frame.origin.y+15,85, 20)];
            retrievaldatelabel.text = [[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"date"]objectAtIndex:indexPath.row];
            retrievaldatelabel.textColor = [UIColor whiteColor];
            [retrievaldatelabel setFont:[Font_Face_Controller opensansLight:16]];
            retrievaldatelabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:retrievaldatelabel];
            
            //Retriever User Image box
            UILabel *retrieveruserimage_background = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-110, retrievalnotelabel.frame.origin.y+retrievalnotelabel.frame.size.height+10 , 100, 100)];
            retrieveruserimage_background.backgroundColor = [UIColor colorWithRed:210.0f/255.0f green:121.0f/255.0f blue:31.0f/255.0f alpha:1.0];
            [cell.contentView addSubview:retrieveruserimage_background];
            
            //set retriever User profile Image button
            UIImageView *retrieverimageView = [[UIImageView alloc]init];
            [retrieverimageView setFrame:CGRectMake(self.view.frame.size.width-106, retrievalnotelabel.frame.origin.y+retrievalnotelabel.frame.size.height+14 , 92, 92)];
            [retrieverimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [Utilities API_link_url_IMG], [[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"image"]objectAtIndex:indexPath.row]]] placeholderImage:[UIImage imageNamed:@"profile9.png"]];

            if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color1"]){
                retrieverimageView.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0];
            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color2"]){
                retrieverimageView.backgroundColor = [UIColor colorWithRed:90.0f/255.0f green:187.0f/255.0f blue:94.0f/255.0f alpha:1.0];
            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color3"]){
                retrieverimageView.backgroundColor = [UIColor colorWithRed:47.0f/255.0f green:188.0f/255.0f blue:208.0f/255.0f alpha:1.0];
            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color4"]){
                retrieverimageView.backgroundColor = [UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color5"]){
                retrieverimageView.backgroundColor = [UIColor colorWithRed:136.0f/255.0f green:99.0f/255.0f blue:169.0f/255.0f alpha:1.0];
            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color6"]){
                retrieverimageView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:116.0f/255.0f blue:169.0f/255.0f alpha:1.0];
            }else if([[[note_history_dict valueForKey:@"student"]valueForKey:@"image_bgcolor"]isEqualToString:@"color7"]){
                retrieverimageView.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:90.0f/255.0f blue:107.0f/255.0f alpha:1.0];
            }

            
                      [cell.contentView addSubview:retrieverimageView];
            
            //descriptionheading text Label
            UILabel *descriptionheading = [[UILabel alloc] initWithFrame:CGRectMake(10, contactdetailsvalue.frame.origin.y+contactdetailsvalue.frame.size.height+10 ,100, 22)];
            descriptionheading.text = @"Description";
            descriptionheading.textColor = [UIColor whiteColor];
            [descriptionheading setFont:[Font_Face_Controller opensansLight:16]];
            descriptionheading.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:descriptionheading];
            
            //writtenby text Label
            UILabel *writtenbylabel = [[UILabel alloc] initWithFrame:CGRectMake(10, descriptionheading.frame.origin.y+descriptionheading.frame.size.height+5 ,[[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Written by:" value:@"" table:nil] sizeWithFont:[Font_Face_Controller opensansLight:16]].width, 20)];
            writtenbylabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Written by:" value:@"" table:nil];
            writtenbylabel.textColor = [UIColor whiteColor];
            [writtenbylabel setFont:[Font_Face_Controller opensansLight:16]];
            writtenbylabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:writtenbylabel];
            
            //writtenbyvalue text  Label
            UILabel *writtenbyvaluelabel = [[UILabel alloc] initWithFrame:CGRectMake(writtenbylabel.frame.origin.x+writtenbylabel.frame.size.width+5, descriptionheading.frame.origin.y+descriptionheading.frame.size.height+5  ,[[[[[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"written_by"]objectAtIndex:indexPath.row]capitalizedString]stringByConvertingHTMLToPlainText] sizeWithFont:[Font_Face_Controller opensansLight:16]].width, 20)];
            writtenbyvaluelabel.text = [[[[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"written_by"]objectAtIndex:indexPath.row]capitalizedString]stringByConvertingHTMLToPlainText];
            writtenbyvaluelabel.textColor = [UIColor whiteColor];
            [writtenbyvaluelabel setFont:[Font_Face_Controller opensansLight:16]];
            writtenbyvaluelabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:writtenbyvaluelabel];
            
            //retrievalnotedescription text Label
            NSString *descriptionretrievalnote = [[[[note_history_dict valueForKey:@"retriever_note"]valueForKey:@"description"]objectAtIndex:indexPath.row]stringByConvertingHTMLToPlainText];
            UILabel *retrievalnotedescriptionlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, writtenbylabel.frame.origin.y+writtenbylabel.frame.size.height+5 ,self.view.frame.size.width-20, 20)];
            retrievalnotedescriptionlabel.numberOfLines = 0;
            retrievalnotedescriptionlabel.text = descriptionretrievalnote;
            retrievalnotedescriptionlabel.textColor = [UIColor whiteColor];
            [retrievalnotedescriptionlabel setFont:[Font_Face_Controller opensansLight:16]];
            [retrievalnotedescriptionlabel sizeToFit];
            retrievalnotedescriptionlabel.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:retrievalnotedescriptionlabel];
            //set retrievalnote background view height dynamically as per the text added in description
            retrievalnotedetailsBox.frame=CGRectMake(0, 10, self.view.frame.size.width, ( retrievalnotedescriptionlabel.frame.origin.y+retrievalnotedescriptionlabel.frame.size.height));
            note_history_table_view_height_single = retrievalnotedetailsBox.frame.size.height+10;
            
            
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    videoplayer *objvideoplayer=[[videoplayer alloc]init];
    //    objvideoplayer.videoId_URl=[[[dict1 valueForKey:@"video_detail"]objectAtIndex:indexPath.row]valueForKey:@"videoUrl"];
    //    [self.navigationController pushViewController:objvideoplayer animated:YES];
    
    
    
    //NSLog(@"%@",[tableData objectAtIndex:indexPath.row]);
    
    
    //detailview *objdetail=[[detailview alloc]init];
    //objdetail.values=[tableData objectAtIndex:indexPath.row];
    
    //[self.navigationController pushViewController:objdetail animated:YES];
    
    
    
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
