//
//  NEWS_EDIT_POST_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 03/01/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "NEWS_EDIT_POST_ViewController.h"
#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "Font_Face_Controller.h"
#import "EDU_Blog_Home_screen_ViewController.h"
#import "Selection_list_ViewController.h"
#import "Post_Curriculum_Tags_ViewController.h"

#import "NSString+HTML.h"

#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"

#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "UIImageView+WebCache.h"
#import "ELR_loaders_.h"
#import "ImageCustomClass.h"
#import "LogoutManager.h"
#define kOFFSET_FOR_KEYBOARD 100.0
@interface NEWS_EDIT_POST_ViewController ()
{
    UIImageView *loader_image;
}

@end

@implementation NEWS_EDIT_POST_ViewController
@synthesize post_id;

- (void) receiveTestNotification1:(NSNotification *) notification
{
    [self mStartIndicater];
    
    
    [Get_Student removeAllObjects];
    [Get_id removeAllObjects];
    
    Select_Student_TXT.text=@"";
    
    Select_Student_TXT.placeholder=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"All" value:@"" table:nil];
    
    
    
    
    [Get_id addObjectsFromArray:notification.object];
    
    if (!Get_id.count==0) {
        
        
        if ([[Get_id objectAtIndex:0]isEqualToString:@"all"] || [[Get_id objectAtIndex:0]isEqualToString:@"alla"]) {
            
            
            Select_Group_TXT.text=@"";
            
            Select_Group_TXT.placeholder=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"All" value:@"" table:nil];
        }
        else
        {
            
            Select_Group_TXT.text=[NSString stringWithFormat:@"%d %@",Get_id.count,[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Groups" value:@"" table:nil]];
        }
        
    }
    
    
    
    [self performSelector:@selector(CallTheServer_Student_API:) withObject:notification.object afterDelay:0.5];
    
}

- (void) receiveTestNotification2:(NSNotification *) notification
{
    
    [Get_Tages removeAllObjects];
    
    
    [Get_Tages addObjectsFromArray:notification.object];
    
    if (!Get_Tages.count==0) {
        
        
        //        NSPredicate *preda = [NSPredicate predicateWithFormat:
        //                              @"id beginswith[c] %@",[Get_Tages objectAtIndex:0]];
        //
        //        NSArray *aList = [[dict_Login valueForKey:@"curriculum_tags"] filteredArrayUsingPredicate:preda];
        //
        //
        //        pickre_Tags=[Get_Tages objectAtIndex:0];
        
        
        
        
        Select_Knowledge_Areas_TXT.text=[NSString stringWithFormat:@"%d Curriculum Tags",Get_Tages.count/3];
        
    }
    else
    {
        pickre_Tags=@"";
    }
    
    
    NSLog(@"%@", notification.object);
    
    
}

- (void) receiveTestNotification3:(NSNotification *) notification
{
    
    
    [Get_Student removeAllObjects];
    
    [Get_Student addObjectsFromArray:notification.object];
    
    
    
    if (Get_Student.count==0) {
        
        
        Select_Student_TXT.placeholder=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"All" value:@"" table:nil];
    }
    else
    {
        
        Select_Student_TXT.text=[NSString stringWithFormat:@"%lu %@",(unsigned long)Get_Student.count,[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Users" value:@"" table:nil]];
    }
    
    
  
    
    NSLog(@"%@", notification.object);
    
    
    
}


-(void)Top_right_background_action
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)Post_data_IMG_action
{
    
    
    actionSheets = [[UIActionSheet alloc]
                    initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select your Option" value:@"" table:nil]
                    delegate:self
                    cancelButtonTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil]
                    destructiveButtonTitle:nil
                    otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Camera" value:@"" table:nil], [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Photos" value:@"" table:nil],nil];
    actionSheets.tag=202;
    [actionSheets showInView:self.view];
    
}



#pragma mark - -*********************
#pragma mark ActionSheet clickedButton Method
#pragma mark - -*********************

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing=YES;
    if (buttonIndex==0)
    {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes=[NSArray arrayWithObjects:(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage, nil];;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
        else
        {
            
            
            
            UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Message!!" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Camera is not available , Please choose Picture from Library" value:@"" table:nil] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            [alert show];
            
        }
        
    }
    else if (buttonIndex==1)
    {
        
        
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.mediaTypes=[NSArray arrayWithObjects:(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage, nil];
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    mtableView.frame=CGRectMake(15, Description_TV.frame.origin.y+Description_TV.frame.size.height+10, self.view.frame.size.width-30,100);
    Post_data_IMG.frame=CGRectMake((self.view.frame.size.width-300)/2, mtableView.frame.origin.y+mtableView.frame.size.height+10, 300, 48);
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width, 470);
    
    
    checkactionSheet=true;
    
    
    Value_id=[[NSMutableDictionary alloc]init];
    
    dic_all_data=[[NSMutableDictionary alloc]init];
    
      
    
    [[ALAssetsLibrary new] assetForURL:info[UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset) {
        [Value_id setValue:[NSString stringWithFormat:@"%ld",(long)id_value] forKey:@"id"];
        
        
        [Value_id setValue:@"0" forKey:@"ID"];
        
        imges_thumnail= [UIImage imageWithCGImage:asset.thumbnail];
        
        
        [Value_id setValue:imges_thumnail forKey:@"thumbnail"];
        
        
        NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ( [mediaType isEqualToString:@"public.movie" ])
        {
            NSLog(@"Picked a movie at URL %@",  [info objectForKey:UIImagePickerControllerMediaURL]);
            NSURL *url =  [info objectForKey:UIImagePickerControllerMediaURL];
            NSLog(@"> %@", [url absoluteString]);
            
            
            NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
            NSData *webData = [NSData dataWithContentsOfURL:videoURL];
            [Video_pick addObject:[webData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
            
            
            
            [Value_id setValue:[webData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"Data"];
            
            
            [Value_id setValue:@"mp4" forKey:@"type"];
            
            //[[data valueForKey:@"Data"]addObject:[webData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
            
            
        }
        
        else
        {
            
            
            chosenImage = info[UIImagePickerControllerEditedImage];
            NSData *imageData = UIImageJPEGRepresentation(chosenImage, 0.6);
            
            [images_pick addObject:[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
            
            
            
            
            [Value_id setValue:[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"Data"];
            
            
            [Value_id setValue:@"jpg" forKey:@"type"];
            
            
            
            
        }
        
        
        [Array_all_data addObject:Value_id];
        
        
        
        [dic_all_data  setObject:Array_all_data forKey:@"all_data"];
        
        
        
        id_value+=1;
        [mtableView reloadData];
        
        [picker dismissViewControllerAnimated:YES completion:NULL];
        
    } failureBlock:^(NSError *error) {
        // handle error
    }];
    
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

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
    
 //   user_pic.frame=CGRectMake(50, 0, 30, 30);
    
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
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Edit News" value:@"" table:nil];
    
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  //  UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
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
    
    
//    NSArray *array = [self.navigationController viewControllers];
//    
//    [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
    
    
    
}

-(void)doneButtonClicked
{
    [Description_TV resignFirstResponder];
    //    if(Description_TV.text.length == 0){
    //        Description_TV.textColor = [UIColor lightGrayColor];
    //        Description_TV.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
    //        //        [Description_TV resignFirstResponder];
    //    }
}



-(void)load_view
{
    [self Navigation_bar];
    
    
    Get_id=[[NSMutableArray alloc]init];
    Get_Tages=[[NSMutableArray alloc]init];
    Get_Student=[[NSMutableArray alloc]init];
    
    demo1=[[NSMutableArray alloc]init];
    demo2=[[NSMutableArray alloc]init];
    
    Delete_id_array=[[NSMutableArray alloc]init];
    
    if (check_uncheck==false) {
        Notification=@"no";
        
        dic_all_data=[[NSMutableDictionary alloc]init];
        
        id_value=1;
        
        images_pick=[[NSMutableArray alloc]init];
        Video_pick=[[NSMutableArray alloc]init];
        Array_all_data=[[NSMutableArray alloc]init];
        random_files_AR=[[NSMutableArray alloc]init];
        
        
        
    }
    
    
    
    pickre_Tags=@"";
    
    // self.view.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    
    //////////////////// TopView Main background Lable\\\\\\\\\\\\\\
    
    Top_Main_background_color=[[UIView alloc]init];
    Top_Main_background_color.backgroundColor=[Text_color_ News_Color_code];
    Top_Main_background_color.userInteractionEnabled=YES;
    Top_Main_background_color.frame=CGRectMake(0, 64, self.view.frame.size.width, 60);
    [self.view addSubview:Top_Main_background_color];
    
    
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64,[[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    scrollview.backgroundColor = [Text_color_ News_Color_code];
    
    
    [self.view addSubview:scrollview];
    
    
    
    
    Top_Post_LB=[[UILabel alloc]init];
    Top_Post_LB.backgroundColor=[UIColor clearColor];
    Top_Post_LB.frame=CGRectMake(15,0,150, 25);
    Top_Post_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Recipients" value:@"" table:nil];
    Top_Post_LB.textColor=[UIColor whiteColor];
    Top_Post_LB.font=[Font_Face_Controller opensansLight:11];
    Top_Post_LB.textAlignment=NSTextAlignmentLeft;
    [scrollview addSubview:Top_Post_LB];
    
    
    
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Select_Group_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15,  Top_Post_LB.frame.origin.y+Top_Post_LB.frame.size.height+5, self.view.frame.size.width-30, 35)];
    
    
    Select_Group_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Group" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    Select_Group_TXT.userInteractionEnabled=NO;
    
    Select_Group_TXT.borderStyle = UITextBorderStyleNone;
    Select_Group_TXT.font = [UIFont systemFontOfSize:15];
    Select_Group_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    Select_Group_TXT.delegate = self;
    Select_Group_TXT.backgroundColor=[UIColor whiteColor];
    Select_Group_TXT.textColor=[UIColor blackColor];
    Select_Group_TXT.font=[Font_Face_Controller opensansLight:13];
    Select_Group_TXT.tag=001;
    Select_Group_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    Select_Group_TXT.layer.masksToBounds = YES;
    Select_Group_TXT.textAlignment=NSTextAlignmentCenter;
    Select_Group_TXT.textColor=[Text_color_ Content_Text_Color_code];
    [scrollview addSubview:Select_Group_TXT];
    
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Title_TF = [[UITextField alloc] initWithFrame:CGRectMake(15,  Select_Group_TXT.frame.origin.y+Select_Group_TXT.frame.size.height+5, self.view.frame.size.width-30, 30)];
    
    
    Title_TF.placeholder =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@" News title here" value:@"" table:nil];
    
    
    //Title_TF.borderStyle = UITextBorderStyleNone;
    Title_TF.font = [UIFont systemFontOfSize:15];
    Title_TF.autocorrectionType = UITextAutocorrectionTypeNo;
    Title_TF.delegate = self;
    Title_TF.backgroundColor=[UIColor whiteColor];
    Title_TF.textColor=[UIColor blackColor];
    Title_TF.font=[Font_Face_Controller opensansLight:13];
    Title_TF.tag=002;
    Title_TF.userInteractionEnabled=YES;
    Title_TF.textColor=[Text_color_ Content_Text_Color_code];

    [scrollview addSubview:Title_TF];
    
    
    Description_TV = [[UITextView alloc] initWithFrame:CGRectMake(15, Title_TF.frame.origin.y+Title_TF.frame.size.height+1,self.view.frame.size.width-30, 50)];
    [Description_TV setDelegate:self];
    [Description_TV setReturnKeyType:UIReturnKeyDefault];
   // [Description_TV setText:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil]];
    //Description_TV.textColor=[Text_color_ Placeholder_Text_Color_code];
    [Description_TV setFont:[Font_Face_Controller opensansregular:12]];
    [Description_TV setTextColor:[UIColor lightGrayColor]];
    Description_TV.backgroundColor=[UIColor whiteColor];
    Description_TV.autocorrectionType = UITextAutocorrectionTypeNo;
    [scrollview addSubview:Description_TV];
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    Description_TV.inputAccessoryView = myToolbar;

    
    // init table view
    mtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,0,0) style:UITableViewStylePlain];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    mtableView.delegate = self;
    mtableView.dataSource = self;
    mtableView.separatorColor=[UIColor clearColor];
    mtableView.backgroundColor = [UIColor clearColor];
    // mtableView.showsVerticalScrollIndicator=NO;
    
    // add to canvas
    [scrollview addSubview:mtableView];
    
    
    
    
    //////////////////// Save_Draft No Button\\\\\\\\\\\\\\
    
    Post_data_IMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sub_btn.png"]];
    Post_data_IMG.frame=CGRectMake((self.view.frame.size.width-300)/2, Description_TV.frame.origin.y+Description_TV.frame.size.height+10, 300, 48);
    Post_data_IMG.userInteractionEnabled=YES;
    [scrollview addSubview:Post_data_IMG];
    
    
    
    //////////////////// Save_Draft No Button\\\\\\\\\\\\\\
    
    images_video_IMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Edu-Blog.png"]];
    images_video_IMG.userInteractionEnabled=YES;
    images_video_IMG.frame=CGRectMake((Post_data_IMG.frame.size.width-190)/2, (Post_data_IMG.frame.size.height-33)/2, 15, 15);
    
    [Post_data_IMG addSubview:images_video_IMG];
    
    
    
    Upload_images_video=[[UILabel alloc]init];
    Upload_images_video.frame=CGRectMake((Post_data_IMG.frame.size.width-140)/2, (Post_data_IMG.frame.size.height-45)/2, 145, 25);
    Upload_images_video.textColor=[UIColor whiteColor];
    // Upload_images_video.text=@"Upload image/video";
    [Upload_images_video setText:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Upload image/video" value:@"" table:nil]];
    [Upload_images_video setFont:[Font_Face_Controller opensansregular:12]];
    [Post_data_IMG addSubview:Upload_images_video];
    
    
    
    UITapGestureRecognizer *Post_data_IMG_action = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(Post_data_IMG_action)];
    [Post_data_IMG addGestureRecognizer:Post_data_IMG_action];
    
    
    
    
    
    //////////////////// Save_Draft No Button\\\\\\\\\\\\\\
    
    BTN_Save_Draft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [BTN_Save_Draft addTarget:self
                       action:@selector(aMethod_Save_Draft:)
             forControlEvents:UIControlEventTouchUpInside];
    BTN_Save_Draft.backgroundColor=[UIColor colorWithRed:48.0f/255.0f green:143.0f/255.0f blue:165.0f/255.0f alpha:1.0];
    [BTN_Save_Draft setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Delete" value:@"" table:nil] forState:UIControlStateNormal];
    [BTN_Save_Draft.titleLabel setFont:[Font_Face_Controller opensanssemibold:12]];
    [BTN_Save_Draft setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    BTN_Save_Draft.frame = CGRectMake(0,self.view.frame.size.height-50,(self.view.frame.size.width/2)-5, 50);
    [self.view addSubview:BTN_Save_Draft];
    
    
    
    
    
    //////////////////// Publish YES Button\\\\\\\\\\\\\\
    
    BTN_POST_NEWS = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [BTN_POST_NEWS addTarget:self
                      action:@selector(aMethod_Publish:)
            forControlEvents:UIControlEventTouchUpInside];
    BTN_POST_NEWS.backgroundColor=[UIColor colorWithRed:48.0f/255.0f green:143.0f/255.0f blue:165.0f/255.0f alpha:1.0];
    [BTN_POST_NEWS setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Save" value:@"" table:nil] forState:UIControlStateNormal];
    [BTN_POST_NEWS.titleLabel setFont:[Font_Face_Controller opensanssemibold:12]];
    [BTN_POST_NEWS setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    BTN_POST_NEWS.frame = CGRectMake((self.view.frame.size.width/2)+5,self.view.frame.size.height-50,(self.view.frame.size.width/2)-5, 50);
    [self.view addSubview:BTN_POST_NEWS];
    
    
    
    
[self mStartIndicater];
    [self performSelector:@selector(CallTheServer_View_Edit_Deatil:) withObject:post_id afterDelay:0.5];
    
    
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width, 500);
    
    
    self.view.backgroundColor=[UIColor whiteColor];
}


- (void) REfress_NEWS_EDIT:(NSNotification *) notification
{
    
    [self Navigation_bar];
    
    Top_Post_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Recipients" value:@"" table:nil];
    Select_Group_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Group" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    Title_TF.placeholder =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@" News title here" value:@"" table:nil];
    [Description_TV setText:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil]];
    [Upload_images_video setText:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Upload image/video" value:@"" table:nil]];

    [BTN_Save_Draft setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Delete" value:@"" table:nil] forState:UIControlStateNormal];
    [BTN_POST_NEWS setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Save" value:@"" table:nil] forState:UIControlStateNormal];

    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(REfress_NEWS_EDIT:)
                                                 name:@"REfress_NEWS_EDIT"
                                               object:nil];
    
[self load_view];
    
    
}

#pragma mark - -*********************
#pragma mark Call API Group Method
#pragma mark - -*********************


-(void)CallTheServer_View_Edit_Deatil:(NSString *)id_post
{
    if ([API connectedToInternet]==YES) {
        
        Value_id=[[NSMutableDictionary alloc]init];
        
        dic_all_data=[[NSMutableDictionary alloc]init];
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&id=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],id_post,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@news/view_news",[Utilities API_link_url_subDomain]]];
        
        
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict_Login = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
    if ([[dict_Login valueForKey:@"status"] isEqualToString:@"true"]) {
        
        
        
        Select_Group_TXT.text=[[[[[dict_Login valueForKey:@"response"]valueForKey:@"groups"]objectAtIndex:0]objectAtIndex:0]valueForKey:@"name"];
             
            
         [Title_TF setText:[[[[dict_Login valueForKey:@"response"]objectAtIndex:0]valueForKey:@"title"] stringByConvertingHTMLToPlainText]];
            
            [Description_TV setText:[[[[dict_Login valueForKey:@"response"]objectAtIndex:0]valueForKey:@"description"] stringByConvertingHTMLToPlainText]];
            
            
        
            if ([[[[dict_Login valueForKey:@"response"]valueForKey:@"images"]objectAtIndex:0]count]==0 &&[[[[dict_Login valueForKey:@"response"]valueForKey:@"videos"]objectAtIndex:0]count]==0 ) {
                
                
                scrollview.contentSize = CGSizeMake(self.view.frame.size.width, 440);
                
            }
            else
            {
                
                mtableView.frame=CGRectMake(15, Description_TV.frame.origin.y+Description_TV.frame.size.height+10, self.view.frame.size.width-30,100);
                Post_data_IMG.frame=CGRectMake((self.view.frame.size.width-300)/2, mtableView.frame.origin.y+mtableView.frame.size.height+10, 300, 48);
                scrollview.contentSize = CGSizeMake(self.view.frame.size.width, 470);
                
                                
                for (int s=0; s<[[[[dict_Login valueForKey:@"response"]valueForKey:@"images"]objectAtIndex:0]count]; s++) {
                    
                    Value_id=[[NSMutableDictionary alloc]init];
                    
                    dic_all_data=[[NSMutableDictionary alloc]init];
              // API_link_url_subDomain_for_IMG_NEWS
                    
                    
                    
                    NSLog(@"%@",[Utilities API_link_url_subDomain_for_IMG_NEWS:[[[[[dict_Login valueForKey:@"response"]valueForKey:@"images"]objectAtIndex:0]objectAtIndex:s]valueForKey:@"id"]]);
                    
                    
                    
                    NSURL *imageURL = [NSURL URLWithString:[Utilities API_link_url_subDomain_for_IMG_NEWS:[[[[[dict_Login valueForKey:@"response"]valueForKey:@"images"]objectAtIndex:0]objectAtIndex:s]valueForKey:@"id"]]];
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                    
                    
                    [Value_id setValue:[[[[[dict_Login valueForKey:@"response"]valueForKey:@"images"]objectAtIndex:0]objectAtIndex:s]valueForKey:@"id"] forKey:@"ID"];
                    
                    [Value_id setValue:[UIImage imageWithData:imageData] forKey:@"thumbnail"];
                    
                    
                    [Value_id setValue:[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"Data"];
                    [Value_id setValue:@"jpg" forKey:@"type"];
                    
                    [Array_all_data addObject:Value_id];
                    
                    
                    
                }
                
                
                
        for (int v=0; v<[[[[dict_Login valueForKey:@"response"]valueForKey:@"videos"]objectAtIndex:0]count]; v++) {
                    
                    
                    Value_id=[[NSMutableDictionary alloc]init];
                    
                    dic_all_data=[[NSMutableDictionary alloc]init];
                    
                    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_NEWS_Thumnail],[[[[[dict_Login valueForKey:@"response"]valueForKey:@"videos"]objectAtIndex:0]objectAtIndex:v]valueForKey:@"imagename"]]];
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                    
                    [Value_id setValue:[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"Data"];
                    
                    [Value_id setValue:[[[[[dict_Login valueForKey:@"response"]valueForKey:@"videos"]objectAtIndex:0]objectAtIndex:v]valueForKey:@"id"] forKey:@"ID"];
                    
                    [Value_id setValue:[UIImage imageWithData:imageData] forKey:@"thumbnail"];
                    
                    
                    [Value_id setValue:@"mp4" forKey:@"type"];
                    
                    
                    [Array_all_data addObject:Value_id];
                    
                    
                    
                }
                
                [dic_all_data  setObject:Array_all_data forKey:@"all_data"];
                
                
                [mtableView reloadData];
            }
            
            
    }else if([[dict_Login valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
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


- (BOOL)gestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UISwipeGestureRecognizer *)otherGestureRecognizer
{
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}


- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [[dic_all_data valueForKey:@"all_data"]count];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [mtableView dequeueReusableCellWithIdentifier:@"Cell"];
    
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
    
    
    back_ground=[[UIView alloc]init];
    back_ground.frame=CGRectMake(0, 0, mtableView.frame.size.width,33);
    [cell.contentView addSubview:back_ground];
    
    
    //////////////////// Save_Draft No Button\\\\\\\\\\\\\\
    
    Thumnail_Image_IMG = [[UIImageView alloc] initWithImage:nil];
    Thumnail_Image_IMG.userInteractionEnabled=YES;
    Thumnail_Image_IMG.frame=CGRectMake(0,0, 33, 33);
    Thumnail_Image_IMG.image=[[[dic_all_data valueForKey:@"all_data"]objectAtIndex:indexPath.row]valueForKey:@"thumbnail"];
    [back_ground addSubview:Thumnail_Image_IMG];
    
    Images_name_LB=[[UILabel alloc]init];
    Images_name_LB.frame=CGRectMake(Thumnail_Image_IMG.frame.origin.x+Thumnail_Image_IMG.frame.size.width+10,(back_ground.frame.size.height-33)/2,mtableView.frame.size.width-80, 33);
    
    
    
    Images_name_LB.text=[NSString stringWithFormat:@"%@%@.%@",@"Index",[NSString stringWithFormat:@"%d",indexPath.row],[[[dic_all_data valueForKey:@"all_data"]objectAtIndex:indexPath.row]valueForKey:@"type"]];
    Images_name_LB.textColor=[UIColor whiteColor];
    Images_name_LB.font=[Font_Face_Controller opensansregular:11];
    Images_name_LB.textAlignment=NSTextAlignmentLeft;
    [back_ground addSubview:Images_name_LB];
    
    
    //////////////////// Save_Draft No Button\\\\\\\\\\\\\\
    
    delete_BTN = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [delete_BTN addTarget:self
                   action:@selector(aMethod_delete:)
         forControlEvents:UIControlEventTouchUpInside];
    //BTN_Save_Draft.backgroundColor=[UIColor colorWithRed:242.0f/255.0f green:158.0f/255.0f blue:195.0f/255.0f alpha:1.0];
    [delete_BTN setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-times"] forState:UIControlStateNormal];
    delete_BTN.tag=indexPath.row;
    [delete_BTN.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:18]];
    [delete_BTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    delete_BTN.frame = CGRectMake(back_ground.frame.size.width-40,(back_ground.frame.size.height-33)/2,33, 33);
    [back_ground addSubview:delete_BTN];
    
    
    
    
    
    
    if (indexPath.row%2==0) {
        
        back_ground.backgroundColor=
        [UIColor colorWithRed:55.0f/255.0f green:166.0f/255.0f blue:190.0f/255.0f alpha:1.0];
        
    }
    else
    {
        back_ground.backgroundColor=[UIColor colorWithRed:70.0f/255.0f green:182.0f/255.0f blue:205.0f/255.0f alpha:1.0];
    }
    
    
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return  cell;
}

#pragma mark - -*********************
#pragma mark Call API Group Method
#pragma mark - -*********************


-(void)CallTheServer_Group_API
{
    if ([API connectedToInternet]==YES) {
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@picture_diary/filter_view",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict_Login = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[dict_Login valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
        }else if([[dict_Login valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
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
    
 [self mStopIndicater];
    
    
}


#pragma mark - -*********************
#pragma mark Call Student_API Method
#pragma mark - -*********************


-(void)CallTheServer_Student_API:(NSMutableArray *)get_id_group
{
    if ([API connectedToInternet]==YES) {
        
        
        
        //------------ Call API for signup With Post Method --------------//
        
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"] forKey:@"authentication_token"];
        
        [dic setValue:get_id_group forKey:@"group_ids"];
        
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
        
        
        
        
        
        
        NSString *responseString = [API makeCallPostData_ALLs:dic:[NSString stringWithFormat:@"%@picture_diary/get_group_students",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict_Student = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        Get_Student=[[NSMutableArray alloc]init];
        
        
        if ([[dict_Student valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            [Get_Student removeAllObjects];
            
            
            
            // [Get_Student addObjectsFromArray:[[dict_Student valueForKey:@"students"]valueForKey:@"name"]];
            
            
            //[Get_Tages addObjectsFromArray:[[dict_Student valueForKey:@"curriculum_tags"]valueForKey:@"title"]];
            
            
            //            selectedStudent = [[NSMutableArray alloc] init];
            //            for (int i =0; i< [[dict_Student valueForKey:@"students"]count]; i++) {
            //
            //                [selectedStudent addObject:@"0"];
            //
            //
            //            }
            
            
        }else if([[dict_Student valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[dict_Student valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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

- (void)viewWillDisappear:(BOOL)animated

{
    [super viewWillDisappear:YES];

    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    //    // register for keyboard notifications
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(keyboardWillShow)
    //                                                 name:UIKeyboardWillShowNotification
    //                                               object:nil];
    //
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(keyboardWillHide)
    //                                                 name:UIKeyboardWillHideNotification
    //                                               object:nil];
    
    [self.navigationItem setHidesBackButton:YES];
    
}


-(void)keyboardWillShow {
    //    // Animate the current view out of the way
    //    if (self.view.frame.origin.y >= 0)
    //    {
    //        [self setViewMovedUp:YES];
    //    }
    //    else if (self.view.frame.origin.y < 0)
    //    {
    //        [self setViewMovedUp:NO];
    //    }
}

-(void)keyboardWillHide {
    //    if (self.view.frame.origin.y >= 0)
    //    {
    //        [self setViewMovedUp:YES];
    //    }
    //    else if (self.view.frame.origin.y < 0)
    //    {
    //        [self setViewMovedUp:NO];
    //    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    // if ([sender isEqual:Description_TV])
    //{
    //move the main view, so that the keyboard does not hide it.
    //        if  (self.view.frame.origin.y >= 0)
    //        {
    //            [self setViewMovedUp:YES];
    //        }
    //}
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    
    return YES;
}


//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

// MARK:- Modify for Textfield.
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    //Description_TV.text = @"";
    Description_TV.textColor = [Text_color_ Content_Text_Color_code];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(Description_TV.text.length == 0){
        Description_TV.textColor = [Text_color_ Placeholder_Text_Color_code];
        // Description_TV.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
        //        [Description_TV resignFirstResponder];
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    
    if(Description_TV.text.length == 0){
        Description_TV.textColor = [UIColor lightGrayColor];
        Description_TV.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
        //        [Description_TV resignFirstResponder];
    }
}


- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
    return YES;
    //    }
    
    //    [txtView resignFirstResponder];
    //    return NO;
}


//
//- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
//{
//   // Description_TV.text = @"";
//    Description_TV.textColor = [Text_color_ Content_Text_Color_code];
//    return YES;
//}
//
//-(void) textViewDidChange:(UITextView *)textView
//{
//    
//    if(Description_TV.text.length == 0){
//      //  Description_TV.textColor = [Text_color_ Placeholder_Text_Color_code];
//      //  Description_TV.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
//        [Description_TV resignFirstResponder];
//    }
//}
//
//
//- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
//        return YES;
//    }
//    
//    [txtView resignFirstResponder];
//    return NO;
//}


-(void)aMethod_CHeck_Uncheck:(UIButton *)sender
{
    UIButton *BTN=(UIButton *)sender;
    
    
    if (button_check==false) {
        [BTN setBackgroundImage:[UIImage imageNamed:@"with_check.png"] forState:UIControlStateNormal];
        button_check=true;
        
        
        Notification=@"yes";
        
    }
    else
    {
        [BTN setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        button_check=false;
        
        Notification=@"no";
    }
    
    
    
    
    
    
}

-(UIImageView *)golble_img:(NSInteger )frames
{
    UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenu.frame = CGRectMake(0, frames-1, 30, 30);
    [btnMenu setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-down"] forState:UIControlStateNormal];
    [btnMenu setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    [btnMenu.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:12]];
    
    
    UIImageView *img=[[UIImageView alloc]init];
    img.frame=CGRectMake(0, (Select_Knowledge_Areas_TXT.frame.size.height-30)/2, 30, 30);
    
    
    [img addSubview:btnMenu];
    
    return img;
}


-(UIImageView *)golble_img_right:(NSInteger )frames
{
    UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenu.frame = CGRectMake(0, frames, 30, 30);
    [btnMenu setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"] forState:UIControlStateNormal];
    [btnMenu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnMenu.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:12]];
    
    
    UIImageView *img=[[UIImageView alloc]init];
    img.frame=CGRectMake(0, (Select_Knowledge_Areas_TXT.frame.size.height-30)/2, 30, 30);
    
    
    [img addSubview:btnMenu];
    
    return img;
}



-(void)aMethod_delete:(UIButton *)sender
{
    
    Tag_value=sender.tag;
    
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Alert" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Are you sure you want to Delete" value:@"" table:nil] delegate:self cancelButtonTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"NO" value:@"" table:nil] otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YES" value:@"" table:nil],nil];
    
    alter.tag=110;
    [alter show];
    
    
    
}





- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==110) {
        
        
        if (buttonIndex==0) {
            
            
        }
        
        else
        {
            
                      
            if (![[[[dic_all_data valueForKey:@"all_data"]objectAtIndex:Tag_value]valueForKey:@"ID"]isEqualToString:@"0"]) {
                
                [Delete_id_array addObject:[[[dic_all_data valueForKey:@"all_data"]objectAtIndex:Tag_value]valueForKey:@"ID"]];
                
            }
            
            
            [[dic_all_data valueForKey:@"all_data"] removeObjectAtIndex:Tag_value];
            
            
            
            
            
            [mtableView reloadData];
            
            if ([[dic_all_data valueForKey:@"all_data"]count]==0) {
                
                mtableView.frame =CGRectMake(0, 0,0,0);
                
                Post_data_IMG.frame=CGRectMake((self.view.frame.size.width-300)/2, Description_TV.frame.origin.y+Description_TV.frame.size.height+10, 300, 48);
                
                
                scrollview.contentSize = CGSizeMake(self.view.frame.size.width, 440);
            }
            
        }
        
        
    }

    else if (alertView.tag==120) {
        
        [self mStartIndicater];
        
        [self performSelector:@selector(CallTheServer_Delete_post_API) withObject:nil afterDelay:0.5];
        
    }
}

#pragma mark - -*********************
#pragma mark Call Delete Post Method
#pragma mark - -*********************


-(void)CallTheServer_Delete_post_API
{
    
    
    
    
    
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
        
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&news_id=%@&language=%@",@"H67jdS7wwfh",[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"],post_id,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"]]:[NSString stringWithFormat:@"%@news/delete_news",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"Refress_NEWS"
             object:nil];
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
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
    
    
    
    
    [self mStopIndicater];
    
    
}




-(void)aMethod_Save_Draft:(UIButton *)sender
{
    Tag_value=sender.tag;
    
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Alert" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Are you sure you want to Delete this Post" value:@"" table:nil] delegate:self cancelButtonTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"NO" value:@"" table:nil] otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"YES" value:@"" table:nil],nil];
    
    alter.tag=120;
    [alter show];
    
}
-(void)aMethod_Publish:(UIButton *)sender
{
    
      if ([[Description_TV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || [Description_TV.text  isEqualToString:@"Description"] || [Description_TV.text isEqualToString:@"Beskrivning"]|| [[Title_TF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || [Title_TF.text  isEqualToString:@""] || [Title_TF.text isEqualToString:@""]) {
        
        
        alert = [[UIAlertView alloc] initWithTitle:nil message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"You must enter a news title and description" value:@"" table:nil] delegate:nil cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
        
        
    }
    
    
    
    else
    {
        
        if (![dic_all_data valueForKey:@"all_data"]==0) {
            
            
            
            NSArray *resultArray = [[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(ID <= %@)",@"0"]];
            
            
            
            //  NSLog(@"%@",resultArray);
            
            
            [dic_all_data removeAllObjects];
            
            [dic_all_data setObject:resultArray forKey:@"all_data"];
            
            
            
            
            Video_pick = (NSMutableArray *)[[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(type == %@)",@"mp4"]];
            
            
            images_pick = (NSMutableArray *)[[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(type == %@)",@"jpg"]];
        }
        
        
        [self mStartIndicater];
        
        [self performSelector:@selector(CallTheServer_Filter_API) withObject:nil afterDelay:0.5];
    }
}

#pragma mark - -*********************
#pragma mark Call Student_API Method
#pragma mark - -*********************


-(void)CallTheServer_Filter_API
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
               
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"] forKey:@"authentication_token"];
        
        [dic setValue:Title_TF.text forKey:@"title"];
        
         [dic setValue:post_id forKey:@"id"];

        [dic setValue:Delete_id_array forKey:@"ids_to_delete"];
        
        if ([[images_pick valueForKey:@"Data"]count]==0) {
            
            [dic setValue:demo1  forKey:@"images"];
            
        }
        else
        {
            [dic setValue:[images_pick valueForKey:@"Data"] forKey:@"images"];
        }
        
        
        if ([[Video_pick valueForKey:@"Data"]count]==0) {
            
            [dic setValue:demo2 forKey:@"videos"];
            
        }
        else
        {
            [dic setValue:[Video_pick valueForKey:@"Data"] forKey:@"videos"];
        }
        
        [dic setValue:Description_TV.text forKey:@"description"];
        [dic setValue:random_files_AR forKey:@"random_files"];
        
        
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
        
        
        NSString *responseString = [API makeCallPostData_ALLs:dic:[NSString stringWithFormat:@"%@news/edit_news",[Utilities API_link_url_subDomain]]];
        
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"Refress_NEWS"
             object:nil];
            
            
        }else if([[dict valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
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
    
    
    
    
    [self mStopIndicater];
    
    
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    TXT_tag=textField.tag;
    
    
    if (textField.tag==004 || textField.tag==005) {
        
        return YES;
        
    }
    else
    {
        
        
        
        if (textField.tag==001) {
            
//            Selection_list_ViewController *objSelection_list_ViewController=[[Selection_list_ViewController alloc]init];
//            objSelection_list_ViewController.values=dict_Login;
//            objSelection_list_ViewController.Main_values=@"groups";
//            objSelection_list_ViewController.Sub_values=@"name";
//            objSelection_list_ViewController.notification=@"POST_screen_Groupes_getting";
//            objSelection_list_ViewController.post_type=@"POST";
//            
//            [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
//            
            
            
        }
        else if (textField.tag==002)
        {
            
            return YES;
            
        }
        else if (textField.tag==003)
        {
            Post_Curriculum_Tags_ViewController *objSelection_list_ViewController=[[Post_Curriculum_Tags_ViewController alloc]init];
            
            objSelection_list_ViewController.notifications=@"POST_screen_tages_getting";
            objSelection_list_ViewController.post_type=@"POST";
            
            [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
        }
        
    }
    
    return NO;
}



@end
