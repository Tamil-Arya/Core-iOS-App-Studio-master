//
//  Child_Information.m
//  ELAR
//
//  Created by Bhushan Bawa on 27/02/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Child_Information.h"
#import "Font_Face_Controller.h"
#import "UIImageView+WebCache.h"
#import "Text_color_.h"
#import "ELR_loaders_.h"
#import "API.h"
#import "JSON.h"
#import "Utilities.h"
#import "NSString+HTML.h"
#import "ImageCustomClass.h"
#import "NSString+FontAwesome.h"
#import "LogoutManager.h"

#define kOFFSET_FOR_KEYBOARD 80.0
@interface Child_Information ()

@end

@implementation Child_Information



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
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Important info" value:@"" table:nil];
    
    
    
    
    
           self.navigationItem.hidesBackButton = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
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
    
//    
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
    
    [self Navigation_bar];
    
    self.view.backgroundColor=[Text_color_ Child_info_Color_code];
    
    childInfoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    childInfoScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+50);
    [self.view addSubview:childInfoScrollView];
    
    
    child_image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, (self.view.frame.size.width/3)-13, (self.view.frame.size.width/3)-40)];
    child_image.image =[UIImage imageNamed:@"user"];
    child_image.layer.borderColor = [[UIColor grayColor] CGColor];
    child_image.layer.borderWidth = 1;
    
    [child_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"USR_image"]objectAtIndex:_indexOfChildSelected]]] placeholderImage:[UIImage imageNamed:@"profile9.png"]];

    
    [childInfoScrollView addSubview:child_image];
    
    edit_button = [UIButton buttonWithType: UIButtonTypeCustom];
    [edit_button setFrame:CGRectMake(child_image.frame.origin.x,  child_image.frame.origin.y+child_image.frame.size.height, (self.view.frame.size.width/3)-13, 30)];
    [edit_button setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Edit" value:@"" table:nil] value:@"" table:nil] forState: UIControlStateNormal];
//    edit_button.layer.cornerRadius=5;
//    edit_button.clipsToBounds=YES;
    [edit_button setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0]];
    [edit_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [edit_button.titleLabel setFont:[Font_Face_Controller opensansLight:15]];
    [edit_button addTarget:self action:@selector(editButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [childInfoScrollView addSubview:edit_button];

    // Replace Button
    replaceButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [replaceButton setFrame:CGRectMake(edit_button.frame.origin.x,edit_button.frame.origin.y, 90, edit_button.frame.size.height )];
    UIImage * imageForReplaceButton = [UIImage imageNamed:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"ReplaceImage" value:@"" table:nil] value:@"" table:nil]];
    [replaceButton setBackgroundImage:imageForReplaceButton forState:UIControlStateNormal];
//    [replaceButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"replace" value:@"" table:nil] value:@"" table:nil] forState: UIControlStateNormal];
    replaceButton.layer.cornerRadius=5;
    replaceButton.clipsToBounds=YES;
    [replaceButton setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0]];
    [replaceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [replaceButton.titleLabel setFont:[Font_Face_Controller opensansLight:15]];
    [replaceButton addTarget:self action:@selector(ChangePicture) forControlEvents:UIControlEventTouchUpInside];
    replaceButton.alpha = 0;
    [childInfoScrollView addSubview:replaceButton];
    
    // Remove Button
    removeButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [removeButton setFrame:CGRectMake(edit_button.frame.origin.x+edit_button.frame.size.width + 10,edit_button.frame.origin.y, 90, edit_button.frame.size.height )];
    UIImage * imageForRemoveButton = [UIImage imageNamed:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"RemoveImage" value:@"" table:nil] value:@"" table:nil]];
    [removeButton setBackgroundImage:imageForRemoveButton forState:UIControlStateNormal];
    removeButton.layer.cornerRadius=5;
    removeButton.clipsToBounds=YES;
    [removeButton setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0]];
    [removeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [removeButton.titleLabel setFont:[Font_Face_Controller opensansLight:15]];
    [removeButton addTarget:self action:@selector(removeButtonclicked) forControlEvents:UIControlEventTouchUpInside];
    removeButton.alpha = 0;
    [childInfoScrollView addSubview:removeButton];
    
    
    // Close Button
    closeButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake(removeButton.frame.origin.x+removeButton.frame.size.width + 10,edit_button.frame.origin.y, 90, edit_button.frame.size.height)];
    UIImage * imageForCloseButton = [UIImage imageNamed:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"CloseImage" value:@"" table:nil] value:@"" table:nil]];
    [closeButton setBackgroundImage:imageForCloseButton forState:UIControlStateNormal];

//    [closeButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Save Changes" value:@"" table:nil] value:@"" table:nil] forState: UIControlStateNormal];
    closeButton.layer.cornerRadius=5;
    closeButton.clipsToBounds=YES;
    [closeButton setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0]];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeButton.titleLabel setFont:[Font_Face_Controller opensansLight:15]];
    [closeButton addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    closeButton.alpha = 0;
    [childInfoScrollView addSubview:closeButton];

    
    first_name_Text_field = [[UITextField alloc]initWithFrame:CGRectMake(child_image.frame.origin.x + child_image.frame.size.width + 20, child_image.frame.origin.y, 150, 20)];
    first_name_Text_field.text = [[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"USR_FirstName"]objectAtIndex:_indexOfChildSelected];
    first_name_Text_field.backgroundColor = [UIColor clearColor];
//    first_name_Text_field.layer.borderColor = [[UIColor grayColor] CGColor];
//    first_name_Text_field.layer.borderWidth = 1;
    first_name_Text_field.delegate = self;
    [childInfoScrollView addSubview:first_name_Text_field];
    
    
    second_name_Text_field = [[UITextField alloc]initWithFrame:CGRectMake(child_image.frame.origin.x + child_image.frame.size.width + 20, first_name_Text_field.frame.origin.y+first_name_Text_field.frame.size.height + 10, 150, 20)];
    second_name_Text_field.text = [[[[NSUserDefaults standardUserDefaults]valueForKey:@"children"]valueForKey:@"USR_LastName"]objectAtIndex:_indexOfChildSelected];
    second_name_Text_field.backgroundColor = [UIColor clearColor];
//    second_name_Text_field.layer.borderColor = [[UIColor orangeColor] CGColor];
//    second_name_Text_field.layer.borderWidth = 1;
    second_name_Text_field.delegate = self;
    [childInfoScrollView addSubview:second_name_Text_field];

    
    //Contactdetails label text
    Contact_Info_LB = [[UILabel alloc] initWithFrame:CGRectMake(10,edit_button.frame.origin.y+edit_button.frame.size.height+20 ,self.view.frame.size.width-144, 18)];
    Contact_Info_LB.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Contact Information" value:@"" table:nil];
    Contact_Info_LB.textColor = [UIColor whiteColor];
    [Contact_Info_LB setFont:[Font_Face_Controller opensanssemibold:16]];
    Contact_Info_LB.textAlignment=NSTextAlignmentLeft;
    [childInfoScrollView addSubview:Contact_Info_LB];

    
    
    Contact_Info_TV = [[UITextView alloc] initWithFrame:CGRectMake(5, Contact_Info_LB.frame.origin.y+Contact_Info_LB.frame.size.height+10, self.view.frame.size.width-10, 35)];
    [Contact_Info_TV setFont:[Font_Face_Controller opensansregular:15]];
    [Contact_Info_TV setScrollEnabled:YES];
   Contact_Info_TV.autocorrectionType = UITextAutocorrectionTypeNo;
    [Contact_Info_TV setUserInteractionEnabled:YES];
    [Contact_Info_TV setBackgroundColor:[UIColor whiteColor]];
    Contact_Info_TV.delegate=self;
     Contact_Info_TV.textColor=[Text_color_ Placeholder_Text_Color_code];
    [Contact_Info_TV setText:@""];
    
    
    

    [childInfoScrollView addSubview:Contact_Info_TV];
    
    
    
    
    //Contactdetails label text
    Allergies_LB = [[UILabel alloc] initWithFrame:CGRectMake(10,Contact_Info_TV.frame.origin.y+Contact_Info_TV.frame.size.height+5 ,self.view.frame.size.width-144, 18)];
    Allergies_LB.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Allergies" value:@"" table:nil];
    Allergies_LB.textColor = [UIColor whiteColor];
    [Allergies_LB setFont:[Font_Face_Controller opensanssemibold:16]];
    Allergies_LB.textAlignment=NSTextAlignmentLeft;
    [childInfoScrollView addSubview:Allergies_LB];
    
    
    Allergies_TV = [[UITextView alloc] initWithFrame:CGRectMake(5, Allergies_LB.frame.origin.y+Allergies_LB.frame.size.height+10, self.view.frame.size.width-10, 50)];
    [Allergies_TV setFont:[Font_Face_Controller opensansregular:15]];
    [Allergies_TV setScrollEnabled:YES];
    [Allergies_TV setUserInteractionEnabled:YES];
    [Allergies_TV setBackgroundColor:[UIColor whiteColor]];
    [Allergies_TV setText:@""];
    Allergies_TV.autocorrectionType = UITextAutocorrectionTypeNo;
    Allergies_TV.textColor=[Text_color_ Placeholder_Text_Color_code];

 Allergies_TV.delegate=self;
     [childInfoScrollView addSubview:Allergies_TV];
    
    
    
    //Contactdetails label text
    Additional_Info_LB = [[UILabel alloc] initWithFrame:CGRectMake(10,Allergies_TV.frame.origin.y+Allergies_TV.frame.size.height+5 ,self.view.frame.size.width-144, 20)];
    Additional_Info_LB.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Other information" value:@"" table:nil];
    Additional_Info_LB.textColor = [UIColor whiteColor];
    [Additional_Info_LB setFont:[Font_Face_Controller opensanssemibold:15]];
    Additional_Info_LB.textAlignment=NSTextAlignmentLeft;
    
    [childInfoScrollView addSubview:Additional_Info_LB];
    

    
    
    
    Additional_info_TV = [[UITextView alloc] initWithFrame:CGRectMake(5, Additional_Info_LB.frame.origin.y+Additional_Info_LB.frame.size.height+10, self.view.frame.size.width-10, 50)];
    [Additional_info_TV setFont:[Font_Face_Controller opensansregular:15]];
    [Additional_info_TV setScrollEnabled:YES];
    [Additional_info_TV setUserInteractionEnabled:YES];
    [Additional_info_TV setBackgroundColor:[UIColor whiteColor]];
    [Additional_info_TV setText:@""];
    
      Additional_info_TV.autocorrectionType = UITextAutocorrectionTypeNo;
    Additional_info_TV.delegate=self;
 Additional_info_TV.textColor=[Text_color_ Placeholder_Text_Color_code];
[childInfoScrollView addSubview:Additional_info_TV];
    
    
    
    
    
    // Save Button
    Save_Changes = [UIButton buttonWithType: UIButtonTypeCustom];
    [Save_Changes setFrame:CGRectMake((self.view.frame.origin.x+self.view.frame.size.width-150)/2,  self.view.frame.size.height-60, 150, 40)];
    [Save_Changes setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Save Changes" value:@"" table:nil] value:@"" table:nil] forState: UIControlStateNormal];
    Save_Changes.layer.cornerRadius=5;
    Save_Changes.clipsToBounds=YES;
    [Save_Changes setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0]];
    [Save_Changes setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Save_Changes.titleLabel setFont:[Font_Face_Controller opensansLight:15]];
    [Save_Changes addTarget:self action:@selector(action_Save_Changes) forControlEvents:UIControlEventTouchUpInside];
    [childInfoScrollView addSubview:Save_Changes];
    
    
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]);
    
    
     NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"]);
    
    
     NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"]);
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"elev"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"student"]) {
        
          Id_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
           }
    else
    {
        Id_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"];

    }
    
    
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        
        
     
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_authentication_token"];        }
    else
    {
       
        
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"];
    }
    

    
    [self mStartIndicater];
    [self performSelector:@selector(CallTheServer_Child_Information_API) withObject:nil afterDelay:0.5];
    

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    [super viewWillAppear:YES];
      [self.navigationItem setHidesBackButton:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


#pragma mark -
#pragma mark - UIButton Actions

-(void) editButtonClicked
{
    [UIView animateWithDuration:0.5 animations:^{
        edit_button.alpha = 0;
        removeButton.alpha = 1;
        replaceButton.alpha = 1;
        closeButton.alpha = 1;
           } completion:^(BOOL finished) {
              
    }];
}
-(void)ChangePicture
{
    NSLog(@"oneTAP");
    //    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //    picker.delegate = self;
    //    picker.allowsEditing = YES;
    //    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Source"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Camera Roll"
                                                    otherButtonTitles:@"Camera", nil];
    
    [actionSheet showInView:self.view];
    
    
    //  actionSheet.tag = 100;
    
    // [self presentViewController:picker animated:YES completion:NULL];
    
}


-(void) removeButtonclicked
{
    child_image.image =[UIImage imageNamed:@"user"];

}
-(void) closeButtonClicked
{
    [UIView animateWithDuration:0.5 animations:^{
        edit_button.alpha = 1;
        removeButton.alpha = 0;
        replaceButton.alpha = 0;
        closeButton.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];

}
#pragma mark - UIActionsheet Delegates

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            [self openCameraRoll];
            
            break;
        case 1:
            [self openCamera];
            break;
            
        default:
            break;
    }
    
}

-(void)openCameraRoll
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
    
}

-(void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    else{
        //other action
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
    
}

#pragma mark - UIImagepicker delegates
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    child_image.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - -*********************
#pragma mark CallTheServer_Child_Information_API Method
#pragma mark - -*********************


-(void)CallTheServer_Child_Information_API
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
      NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],Id_value]:[NSString stringWithFormat:@"%@allergies/get_child_info",[Utilities API_link_url_subDomain]]];
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        Childe_information = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[Childe_information valueForKey:@"status"] isEqualToString:@"true"]) {
            
        
            
            
            if (![[[Childe_information valueForKey:@"child_info"]valueForKey:@"information"]isEqualToString:@""]) {
                
                
                Additional_info_TV.textColor=[Text_color_ Content_Text_Color_code];
             
                
            }
            else
            {
                Additional_info_TV.textColor=[Text_color_ Placeholder_Text_Color_code];
            }
            
            
            
            if (![[[Childe_information valueForKey:@"child_info"]valueForKey:@"contact_info"]isEqualToString:@""]) {
                
                Contact_Info_TV.textColor=[Text_color_ Content_Text_Color_code];
                
                
            }
            else
            {
                Contact_Info_TV.textColor=[Text_color_ Placeholder_Text_Color_code];
            }
            
            
            
            if (![[[Childe_information valueForKey:@"child_info"]valueForKey:@"allergy_name"]isEqualToString:@""]) {
                
                Allergies_TV.textColor=[Text_color_ Content_Text_Color_code];

                
            }
            else
            {
                Allergies_TV.textColor=[Text_color_ Placeholder_Text_Color_code];
            }
            
            
            
            Additional_info_TV.text=[[Childe_information valueForKey:@"child_info"]valueForKey:@"information"];
            
             Contact_Info_TV.text=[[Childe_information valueForKey:@"child_info"]valueForKey:@"contact_info"];
            
             Allergies_TV.text=[[Childe_information valueForKey:@"child_info"]valueForKey:@"allergy_name"];
            
            
            
        }
        
        else
        {
            
            
//            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[Childe_information valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [alert show];
            
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
#pragma mark CallTheServer_Child_Information_Update_API Method
#pragma mark - -*********************


-(void)CallTheServer_Child_Information_Update_API
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&allergy_name=%@&contact_info=%@&information=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],Id_value,Allergies_TV.text,Contact_Info_TV.text,Additional_info_TV.text]:[NSString stringWithFormat:@"%@allergies/update_child_info",[Utilities API_link_url_subDomain]]];
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        Childe_information = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[Childe_information valueForKey:@"status"] isEqualToString:@"true"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
          
            
        }else if([[Childe_information valueForKey:@"message"] isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Authentication Failed" value:@"" table:nil]]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            
            
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[Childe_information valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
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






-(void)action_Save_Changes
{
    [self mStartIndicater];
    [self performSelector:@selector(CallTheServer_Child_Information_Update_API) withObject:nil afterDelay:0.5];
    
    
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
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


- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
}

#pragma mark - -*********************
#pragma mark Text Field
#pragma mark - -*********************

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
  return [textField resignFirstResponder];
}

@end
