//
//  Single_NEWS_Post_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 11/01/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Single_NEWS_Post_ViewController.h"
#import "Font_Face_Controller.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "Utilities.h"
#import "NSString+HTML.h"
#import "UIImage+FontAwesome.h"
#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "NSString+HTML.h"
#import "UIImageView+WebCache.h"
#import "ELR_loaders_.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"
@interface Single_NEWS_Post_ViewController ()

@end

@implementation Single_NEWS_Post_ViewController
@synthesize array_all_detail;



-(void)Navigation_bar
{
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName:[Font_Face_Controller opensanssemibold:15],
                                                                    NSForegroundColorAttributeName: [UIColor blackColor]
                                                                    };
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"NEWS" value:@"" table:nil];
    
    
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
    [button addTarget:self action:@selector(gotoBack) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    
}

-(void)gotoBack
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    
}



#pragma mark - -*********************
#pragma mark ViewDidLoad Method
#pragma mark - -*********************

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",[[array_all_detail valueForKey:@"object"]valueForKey:@"id"]);
    NSLog(@"%@",[[array_all_detail valueForKey:@"object"]valueForKey:@"type"]);

    
    
    [self Navigation_bar];
    
      //////////////////// Search Bar \\\\\\\\\\\\\\
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    
    //////////////////  Table view  Lable\\\\\\\\\\\\\\
    
//    NSString * tempString = [NSString stringWithFormat:@"%@",array_all_detail];
//    
//    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:nil  message:tempString  preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }]];
//    [self presentViewController:alertController animated:YES completion:nil];

    
      [self mStartIndicater];
    [self performSelector:@selector(CallTheServer_EDU_POST_API) withObject:nil afterDelay:0.5];
    
    
    //
    
}


#pragma mark - -*********************
#pragma mark viewWillAppear Method
#pragma mark - -*********************
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

      // [self.navigationItem setHidesBackButton:YES];
    [self Navigation_bar];
    
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
#pragma mark CallTheServer_Login_API Method
#pragma mark - -*********************


-(void)CallTheServer_EDU_POST_API
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&id=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[array_all_detail valueForKey:@"object"]valueForKey:@"id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@news/view_news",[Utilities API_link_url_subDomain]]];
        

        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            // init table view
            tableViewm = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height-64)) style:UITableViewStylePlain];
            
            tableViewm.delegate = self;
            tableViewm.dataSource = self;
            tableViewm.backgroundColor = [UIColor clearColor];
            tableViewm.showsVerticalScrollIndicator=NO;
            tableViewm.scrollEnabled=NO;
            tableViewm.tableFooterView = [UIView new];
            [self.view addSubview:tableViewm];
            
        }else if([[dict valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict_Login valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        
        
        
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
    }
    
    
    [refreshControl endRefreshing];
    
    [self mStopIndicater];
    
    
}

#pragma mark - -*********************
#pragma mark TableView HeightForHeader Method
#pragma mark - -*********************

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}





#pragma mark - -*********************
#pragma mark TableView DataSource Method
#pragma mark - -*********************


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIView *sectionHeader = [[UIView alloc] init];
    sectionHeader.frame=CGRectMake(0, 0,tableViewm.frame.size.width, 35);
    sectionHeader.backgroundColor=[Text_color_ News_Color_code];
    
    UILabel *Student_name = [[UILabel alloc] initWithFrame:CGRectMake(7, 0,tableViewm.frame.size.width-90, 20)];
    Student_name.backgroundColor = [Text_color_ News_Color_code];
    Student_name.font = [Font_Face_Controller opensanssemibold:13];
    Student_name.tag=section-1;
    
    
    NSLog(@"%@",[[[dict valueForKey:@"response"]objectAtIndex:section]valueForKey:@"category"]);
    Student_name.text = [NSString stringWithFormat:@"%@",[[[dict valueForKey:@"response"]objectAtIndex:section]valueForKey:@"title"]];
    Student_name.textAlignment = NSTextAlignmentLeft;
    Student_name.textColor=[UIColor whiteColor];
    [sectionHeader addSubview:Student_name];
    
    
    UILabel *Tearch_name = [[UILabel alloc] initWithFrame:CGRectMake(7, Student_name.frame.origin.y+Student_name.frame.size.height-2, tableViewm.frame.size.width-100, 15)];
    Tearch_name.backgroundColor = [Text_color_ News_Color_code];
    Tearch_name.font = [Font_Face_Controller opensansregular:10];
    
    
    if ([[[[[[dict valueForKey:@"response"]objectAtIndex:section]valueForKey:@"groups"]objectAtIndex:0]valueForKey:@"name"]isEqual:[NSNull null]]) {
        
        Tearch_name.text = [NSString stringWithFormat:@"%@, %@, %@",[[[dict valueForKey:@"response"]objectAtIndex:section]valueForKey:@"teacher_name"],@"#PreSchool",[[[dict valueForKey:@"response"]objectAtIndex:section]valueForKey:@"created"]];
        
        
    }
    else
    {
        Tearch_name.text = [NSString stringWithFormat:@"%@, %@, %@",[[[dict valueForKey:@"response"]objectAtIndex:section]valueForKey:@"teacher_name"],[[[[[dict valueForKey:@"response"]objectAtIndex:section]valueForKey:@"groups"]objectAtIndex:0]valueForKey:@"name"],[[[dict valueForKey:@"response"]objectAtIndex:section]valueForKey:@"created"]];
        
    }
    
    
    
    
    Tearch_name.textAlignment = NSTextAlignmentLeft;
    Tearch_name.textColor=[UIColor whiteColor];
    [sectionHeader addSubview:Tearch_name];
    
    
    
    
    
    //////////////////  Edit_IMG Image  Lable\\\\\\\\\\\\\\
    
    
    btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenu.frame = CGRectMake(tableViewm.frame.size.width-35,(sectionHeader.frame.size.height-35)/2,35, 35);
    [btnMenu setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-volume-up"] forState:UIControlStateNormal];
    [btnMenu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnMenu addTarget:nil action:@selector(cap_IMG_action:) forControlEvents:UIControlEventTouchUpInside];
    btnMenu.tag=section;
    [btnMenu.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:25]];
    
    [sectionHeader addSubview:btnMenu];
    
    
    
//    if (([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"teacher"] ||[[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"lärare"]) && [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"]isEqualToString:[[[dict valueForKey:@"response"]objectAtIndex:section]valueForKey:@"user_id"]]) {
//        
//        UIImageView *Edit_IMG=[[UIImageView alloc]init];
//        Edit_IMG.image=[UIImage imageNamed:@"pen.png"];
//        Edit_IMG.frame=CGRectMake(tableViewm.frame.size.width-35,(sectionHeader.frame.size.height-25)/2,25, 25);
//        Edit_IMG.userInteractionEnabled=YES;
//        Edit_IMG.tag=section;
//        
//        [sectionHeader addSubview:Edit_IMG];
//        
//        
//        UITapGestureRecognizer * Edit_IMG_URL = [[UITapGestureRecognizer alloc]
//                                                 initWithTarget:self
//                                                 action:@selector( Edit_IMG_action:)];
//        
//        
//        [Edit_IMG addGestureRecognizer: Edit_IMG_URL];
//        
//        
//    }
//    else
//    {
//        btnMenu.frame=CGRectMake(tableViewm.frame.size.width-35,(sectionHeader.frame.size.height-25)/2,25, 25);
//    }
    
    
    
    return sectionHeader;
    
    
}


- (void) Edit_IMG_action: (UITapGestureRecognizer *)recognizer
{
    
//    UIView *view = recognizer.view; //cast pointer to the derived class if needed
//    NSLog(@"%d", view.tag);
//    
//    
//    NSLog(@"%@",[[[dict valueForKey:@"response"]objectAtIndex:view.tag]valueForKey:@"id"]);
//    
//    
//    
//    NEWS_EDIT_POST_ViewController *obj_Edit_Post=[[NEWS_EDIT_POST_ViewController alloc]init];
//    obj_Edit_Post.post_id=[[[dict valueForKey:@"response"]objectAtIndex:view.tag]valueForKey:@"id"];
//    
//    [self.navigationController pushViewController:obj_Edit_Post animated:YES];
    
    
}




- (void) cap_IMG_action: (UIButton *)recognizer
{
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:[[[[dict valueForKey:@"response"]objectAtIndex:0]valueForKey:@"description"] stringByConvertingHTMLToPlainText]];
    
    AVSpeechSynthesizer *syn = [[AVSpeechSynthesizer alloc] init];
    
    [syn speakUtterance:utterance];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize labelHeight = [self heigtForCellwithString:[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"description"] stringByConvertingHTMLToPlainText]    withFont:[Font_Face_Controller opensansregular:11]];
    
    
    //////////////// images and videos and random_files ///////////////////
    
    if (![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && ![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 && ![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        labelHeight.height = labelHeight.height+390;
    }
    
    
    //////////////// images and videos ///////////////////
    
    else if (![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && ![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 &&[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        labelHeight.height = labelHeight.height+350;
        
    }
    
    //////////////// videos and random_files ///////////////////
    
    
    else if ([[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && ![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 && ![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        labelHeight.height = labelHeight.height+240;
        
    }
    
    
    ////////////////  videos ///////////////////
    
    else if ([[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && ![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 &&[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        labelHeight.height = labelHeight.height+185;
        
    }
    
    
    ////////////////  images and  random_files///////////////////
    
    
    else if (![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && [[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 &&![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        labelHeight.height = labelHeight.height+220;
        
    }
    
    
    ////////////////  images ///////////////////
    
    else if (![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && [[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 &&[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        labelHeight.height = labelHeight.height+200;
        
    }
    
    
    else if ([[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && ![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 &&[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        labelHeight.height = labelHeight.height+185;
        
    }
    
    else if ([[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0 && [[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0 &&![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        
        if ([[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==1)
        {
            
            labelHeight.height = labelHeight.height+65;
        }
        else
        {
            labelHeight.height = labelHeight.height+90;
        }
        
    }
    
    
    else if (![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        labelHeight.height = labelHeight.height+350;
        
    }
    
    else if (![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0)
    {
        labelHeight.height = labelHeight.height+175;
        
    }
    
    else if (![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0)
    {
        labelHeight.height = labelHeight.height+175;
        
    }
    else
    {
        labelHeight.height = labelHeight.height+35;
        
    }
    
    
    
    return labelHeight.height; // the return height + your other view height
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
    return [[dict valueForKey:@"response"]count];
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    if (cell == NULL)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    
    
    description=[[UILabel alloc]init];
    description.backgroundColor=[UIColor clearColor];
    description.text=[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"description"] stringByConvertingHTMLToPlainText];
    description.numberOfLines = 0;
    description.frame=CGRectMake(5, 5, tableViewm.frame.size.width-10, 40);
    
    
    description.textColor=[UIColor blackColor];
    description.font=[Font_Face_Controller opensansLight:11];
    description.textAlignment=NSTextAlignmentCenter;
    [description sizeToFit];
    [cell.contentView addSubview:description];
    
    NSLog(@"%lu",[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]);
    
    if (![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]==0)
    {
        
        
        
        
        //create the scrollview with specific frame
        scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, description.frame.origin.y+description.frame.size.height,[[UIScreen mainScreen]bounds].size.width, 150)];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        scrollView.tag=indexPath.row;
        //array for views to add to the scrollview
        scrollView_views = [[NSMutableArray alloc] init];
        scrollView.backgroundColor=[UIColor clearColor];
        //array for colors of views
        
        
        for (int i = 0; i <[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]; i++) {
            
            NSLog(@"%@",[Utilities API_link_url_subDomain_for_IMG_NEWS:[[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]objectAtIndex:i]valueForKey:@"id"]]);
            
            
            
            Demoimg=[[UIImageView alloc]init];
            Demoimg.frame=CGRectMake(0,20,scrollView.frame.size.width, 110);
            Demoimg.contentMode = UIViewContentModeScaleToFill;
            //Demoimg.contentMode=UIViewContentModeScaleAspectFill;
            [Demoimg sd_setImageWithURL:[NSURL URLWithString:[Utilities API_link_url_subDomain_for_IMG_NEWS:[[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]objectAtIndex:i]valueForKey:@"id"]]]
                       placeholderImage:[UIImage imageNamed:@"images.jpeg"]];
            
            Demoimg.tag=i+5;
            
            ;
            
            [scrollView_views addObject:Demoimg];
            
        }
        
        
        //add pages to scrollview
        [scrollView addPages:scrollView_views];
        
        //add scrollview to the view
        [cell.contentView addSubview:scrollView];
        
        
        if ([[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"images"]count]>=2)
        {
            
            [scrollView setHasPageControl:YES];
            
        }
        
        
        
        
        
        
        
    }
    
    else
    {
        scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen]bounds].size.width,10)];
        [cell.contentView addSubview:scrollView];
    }
    
    
    NSLog(@"%f",scrollView.frame.origin.y);
    
    
    
    if (![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]==0)
    {
        
        
        
        
        //create the scrollview with specific frame
        scrollView_Vedio = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, scrollView.frame.origin.y+scrollView.frame.size.height+10,tableViewm.frame.size.width, 150)];
        [scrollView_Vedio setShowsHorizontalScrollIndicator:NO];
        [scrollView_Vedio setShowsVerticalScrollIndicator:NO];
        scrollView_Vedio.userInteractionEnabled=YES;
        scrollView_Vedio.tag=indexPath.row;
        //array for views to add to the scrollview
        scrollView_views__Vedio = [[NSMutableArray alloc] init];
        //scrollView_views__Vedio.backgroundColor=[UIColor clearColor];
        //array for colors of views
        
        NSLog(@"Images Count ====> %lu",[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]);
        
        
        for (int i = 0; i <[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]; i++) {
            
            
            
            
            NSLog(@"Images Name ====> %@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]objectAtIndex:i]valueForKey:@"imagename"]]);
            
            
            
            Demoimg__Vedio=[[UIImageView alloc]init];
            Demoimg__Vedio.userInteractionEnabled=YES;
            Demoimg__Vedio.frame=CGRectMake(0,20,scrollView_Vedio.frame.size.width, 110);
            Demoimg__Vedio.contentMode=UIViewContentModeScaleAspectFill;
            [Demoimg__Vedio sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_NEWS_Thumnail],[[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]objectAtIndex:i]valueForKey:@"imagename"]]]
                              placeholderImage:[UIImage imageNamed:@"images.jpeg"]];
            
            Demoimg__Vedio.tag=[[[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]objectAtIndex:i]valueForKey:@"id"]integerValue];
            
            //   Demoimg__Vedio.tag=i+5;
            
            
            
            [scrollView_views__Vedio addObject:Demoimg__Vedio];
            
            
            
            //////////////////// Save_Draft No Button\\\\\\\\\\\\\\
            
            Play_BTN = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            Play_BTN.tag=[[[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]objectAtIndex:i]valueForKey:@"id"]integerValue];
            Play_BTN.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.4];
            [Play_BTN setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-play"] forState:UIControlStateNormal];
            [Play_BTN.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:18]];
            [Play_BTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            Play_BTN.frame = CGRectMake((scrollView_Vedio.frame.size.width-45)/2,(scrollView_Vedio.frame.size.height-45)/2,45, 45);
            Play_BTN.layer.cornerRadius=45*0.5;
            Play_BTN.clipsToBounds=YES;
            [Demoimg__Vedio addSubview:Play_BTN];
            
            
            UITapGestureRecognizer *videos_URL = [[UITapGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(videos_action:)];
            
            
            [Demoimg__Vedio addGestureRecognizer:videos_URL];
            
            
            
            UITapGestureRecognizer *videos_URLs = [[UITapGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(videos_action:)];
            
            
            [Play_BTN addGestureRecognizer:videos_URLs];
            
            
            
            
        }
        
        
        //add pages to scrollview
        [scrollView_Vedio addPages:scrollView_views__Vedio];
        
        //add scrollview to the view
        [cell.contentView addSubview:scrollView_Vedio];
        
        
        if ([[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"videos"]count]>=2)
        {
            
            [scrollView_Vedio setHasPageControl:YES];
            
        }
        
        
        
        
        
    }
    else
    {
        scrollView_Vedio = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, scrollView.frame.origin.y+scrollView.frame.size.height+10,tableViewm.frame.size.width, 0)];
        
    }
    
    
    
    
    
    if (![[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==0)
    {
        
        NSInteger Sframe=scrollView_Vedio.frame.origin.y+scrollView_Vedio.frame.size.height+10;
        
        
        
        if ([[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]count]==1) {
            
            
            
            download_IMG=[[UIImageView alloc]init];
            download_IMG.frame=CGRectMake(8, Sframe+3, 10, 10);
            download_IMG.image=[UIImage imageNamed:@"down_arrow_grey.png"];
            [cell.contentView addSubview:download_IMG];
            
            number_of_random_files=[[UILabel alloc]init];
            number_of_random_files.frame=CGRectMake(20,Sframe, 300, 15);
            number_of_random_files.tag=indexPath.row;
            number_of_random_files.text=[[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]objectAtIndex:0]valueForKey:@"imagename"];
            
            number_of_random_files.tag=[[[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]objectAtIndex:0]valueForKey:@"id"]integerValue];
            
            number_of_random_files.font=[Font_Face_Controller opensansregular:13];
            number_of_random_files.textColor=[UIColor grayColor];
            
            number_of_random_files.userInteractionEnabled=YES;
            
            
            
            
            [cell.contentView addSubview:number_of_random_files];
            
            UITapGestureRecognizer *random_file = [[UITapGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(random_file_action:)];
            
            
            [number_of_random_files addGestureRecognizer:random_file];
            
            
        }
        else
        {
            
            for (int s=0; s<=1; s++) {
                
                
                download_IMG=[[UIImageView alloc]init];
                download_IMG.frame=CGRectMake(8, Sframe+3, 10, 10);
                download_IMG.image=[UIImage imageNamed:@"down_arrow_grey.png"];
                [cell.contentView addSubview:download_IMG];
                
                
                number_of_random_files=[[UILabel alloc]init];
                number_of_random_files.frame=CGRectMake(20,Sframe, 300, 15);
                number_of_random_files.tag=s;
                number_of_random_files.text=[[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]objectAtIndex:s]valueForKey:@"random_file_name"];
                
                
                number_of_random_files.tag=[[[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]objectAtIndex:s]valueForKey:@"id"]integerValue];
                
                
                number_of_random_files.font=[Font_Face_Controller opensansregular:13];
                number_of_random_files.textColor=[UIColor grayColor];
                number_of_random_files.userInteractionEnabled=YES;
                
                
                NSLog(@"%d",[[[[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"random_files"]objectAtIndex:s]valueForKey:@"id"]integerValue]);
                
                
                
                [cell.contentView addSubview:number_of_random_files];
                
                Sframe=Sframe+20;
                
                
                UITapGestureRecognizer *random_file = [[UITapGestureRecognizer alloc]
                                                       initWithTarget:self
                                                       action:@selector(random_file_action:)];
                
                
                [number_of_random_files addGestureRecognizer:random_file];
                
                
            }
        }
        
        
        
        
    }
    else
    {
        number_of_random_files=[[UILabel alloc]init];
        number_of_random_files.frame=CGRectMake(20,scrollView_Vedio.frame.origin.y+scrollView_Vedio.frame.size.height,300, 0);
    }
    
    
    
    Like=[UIButton buttonWithType:UIButtonTypeCustom];
    Like.frame=CGRectMake(7,number_of_random_files.frame.origin.y+number_of_random_files.frame.size.height+9, 16, 16);
    
    if ([[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"already_liked"] isEqualToString:@"no"]) {
        
        [Like setBackgroundImage:[UIImage imageNamed:@"unlike.png"] forState:UIControlStateNormal];
        
    }
    
    else
    {
        [Like setBackgroundImage:[UIImage imageNamed:@"like-NEWS.png"] forState:UIControlStateNormal];
    }
    
    Like.backgroundColor=[UIColor clearColor];
    Like.tag=indexPath.section;
    [Like addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:Like];
    
    
    number_of_like =[[UILabel alloc]init];
    number_of_like.frame =CGRectMake(Like.frame.origin.x+Like.frame.size.width+5, number_of_random_files.frame.origin.y+number_of_random_files.frame.size.height+12, 16,16);
    
    number_of_like.textAlignment=NSTextAlignmentCenter;
    number_of_like.textColor=[UIColor grayColor];
    
    number_of_like.font = [Font_Face_Controller opensansregular:13];
    number_of_like.text=[[[dict valueForKey:@"response"]objectAtIndex:indexPath.section]valueForKey:@"news_like_count"];
    number_of_like.adjustsFontSizeToFitWidth=YES;
    number_of_like.minimumScaleFactor=0.5;
    [cell.contentView addSubview:number_of_like];
    
    cell.backgroundColor=[UIColor whiteColor];
    
    return cell;
}

- (void) videos_action: (UITapGestureRecognizer *)recognizer
{
    
    UIView *view = recognizer.view; //cast pointer to the derived class if needed
    NSLog(@"%ld", (long)view.tag);
    
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"SELF.id contains[cd] %@", [NSString stringWithFormat:@"%ld",(long)view.tag]];
    NSArray *beginWithB = [[[dict valueForKey:@"response"] valueForKey:@"videos"] filteredArrayUsingPredicate:namePredicate];
    
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.id contains[cd] %@", [NSString stringWithFormat:@"%ld",(long)view.tag]];
    
    NSArray *filtered = [ [beginWithB objectAtIndex:0]
                         filteredArrayUsingPredicate:predicate];
    
    NSLog(@"%@",[filtered valueForKey:@"videoname_mp4"]);
    
    
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[filtered valueForKey:@"videoname_mp4"]objectAtIndex:0]]);
    
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[filtered valueForKey:@"videoname_mp4"]]);
    
    
    
    NSString *uel_STR=[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_NEWS_Video],[[filtered valueForKey:@"videoname_mp4"]objectAtIndex:0]];
    
    
    NSLog(@"%@",uel_STR);
    
    
    
    
    
    NSURL *fileURL = [NSURL URLWithString:uel_STR];
    
    moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    [moviePlayerController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:moviePlayerController.view];
    moviePlayerController.fullscreen = YES;
    [moviePlayerController play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:nil];
    
    
}

-(void)doneButtonClick:(NSNotification*)aNotification{
    
    [moviePlayerController.view removeFromSuperview];
    MPMoviePlayerController *player = [aNotification object];
    
    [player stop];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
}


- (void) movieFinishedCallback:(NSNotification*) aNotification {
    MPMoviePlayerController *player = [aNotification object];
    
    [player stop];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    [moviePlayerController.view removeFromSuperview];
    
    NSLog(@"stopped?");
}


- (void) random_file_action: (UITapGestureRecognizer *)recognizer
{
    
    
//    UIView *view = recognizer.view; //cast pointer to the derived class if needed
//    NSLog(@"%d", view.tag);
//    
//    
//    
//    
//    Open_Random_files_ViewController *objOpen_Random_files_ViewController=[[Open_Random_files_ViewController alloc]init];
//    objOpen_Random_files_ViewController.URL_VALUE=[Utilities API_link_url_subDomain_for_other_files_NEWS:[NSString stringWithFormat:@"%d",view.tag]];
//    [self.navigationController pushViewController:objOpen_Random_files_ViewController animated:YES];
    
    
    
}



#pragma mark - -*********************
#pragma mark Like Button Method
#pragma mark - -*********************



-(void)like:(UIButton *)sender
{
    
    UIButton *btn = (UIButton *)sender;
    //
    //
    indexvalues=sender.tag;
    
    
    if ([API connectedToInternet]==YES) {
        
        
        NSMutableDictionary *cellDict = [[[dict valueForKey:@"response"] objectAtIndex:btn.tag] mutableCopy];
        
        
        NSInteger value=[[[[dict valueForKey:@"response"] objectAtIndex:btn.tag]valueForKey:@"news_like_count"]integerValue];
        
        
        
        
        
        
        if ([[[[dict valueForKey:@"response"] objectAtIndex:btn.tag]valueForKey:@"already_liked"] isEqualToString:@"no"]) {
            
            
            
            [cellDict setObject:[NSString stringWithFormat:@"%ld",value+1] forKey:@"news_like_count"];
            
            [cellDict setObject:@"yes" forKey:@"already_liked"];
            
            [Like setBackgroundImage:[UIImage imageNamed:@"unlike.png"] forState:UIControlStateNormal];
            
            
        }
        
        else
        {
            [cellDict setObject:[NSString stringWithFormat:@"%ld",value-1] forKey:@"news_like_count"];
            
            [cellDict setObject:@"no" forKey:@"already_liked"];
            
            [Like setBackgroundImage:[UIImage imageNamed:@"like-NEWS.png"] forState:UIControlStateNormal];
        }
        
        
        
        [[dict valueForKey:@"response"] replaceObjectAtIndex:btn.tag withObject:cellDict];
        
        // [btn setBackgroundColor:[UIColor greenColor]];
        
        [tableViewm reloadData];
        
        
        [self performSelectorInBackground:@selector(Like_APi_backend:) withObject:[[[dict valueForKey:@"response"] objectAtIndex:btn.tag]valueForKey:@"id"]];
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
    }
    
    
}


-(void)Like_APi_backend :(NSString *)value

{
    
    
    if ([API connectedToInternet]==YES) {
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&news_id=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],value]:[NSString stringWithFormat:@"%@news/like_news",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict_like = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        
        
        
        if ([[dict_like valueForKey:@"status"]isEqualToString:@"true"]) {
            
            
            
        }
        
        
        
        NSLog(@"%@",[[dict_like valueForKey:@"result"]valueForKey:@"message"]);
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
    }
    
    
    
    
    
}




#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
}


@end
