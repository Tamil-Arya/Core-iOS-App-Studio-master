//
//  EDU_Blog_Post_ViewController.m
//  ELAR
//
//  Created by Bhushan Bawa on 29/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "EDU_Blog_Post_ViewController.h"
#import "Font_Face_Controller.h"
#import "Text_color_.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "Font_Face_Controller.h"
#import "EDU_Blog_Home_screen_ViewController.h"
#import "Selection_list_ViewController.h"
#import "Post_Curriculum_Tags_ViewController.h"
#import "ImageCustomClass.h"
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
#import "Save_Draft_ViewController.h"
#import "EDU_Group_List.h"
#import "LogoutManager.h"
#define kOFFSET_FOR_KEYBOARD 180.0
@interface EDU_Blog_Post_ViewController ()
{
    UIImageView *loader_image;
}

@end

@implementation EDU_Blog_Post_ViewController



- (void) POST_screen_Save_Draft:(NSNotification *) notification
{
    
    
    [Get_Student removeAllObjects];
    [Get_id removeAllObjects];
    [Get_Tages removeAllObjects];
    
    
    demo1=[[NSMutableArray alloc]init];
    demo2=[[NSMutableArray alloc]init];

    
     Delete_id_array=[[NSMutableArray alloc]init];
    
    dic_all_data=[[NSMutableDictionary alloc]init];
    
    id_value=1;
    
    images_pick=[[NSMutableArray alloc]init];
    Video_pick=[[NSMutableArray alloc]init];
    Array_all_data=[[NSMutableArray alloc]init];
    random_files_AR=[[NSMutableArray alloc]init];

    NSLog(@"%@",notification.object);
    
    
  //  *****************************                  ************************************
    
    [[NSUserDefaults standardUserDefaults]setObject:[[notification.object valueForKey:@"PictureDiary"]valueForKey:@"id"] forKey:@"Publish_draft_id"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    
   // Post_id=[[notification.object valueForKey:@"PictureDiary"]valueForKey:@"id"];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EDU_Group_List"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EDU_Student_List"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Tages"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Description_TV"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setValue:[[[notification.object valueForKey:@"PictureDiary"]valueForKey:@"description"]stringByConvertingHTMLToPlainText] forKey:@"Description_TV"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    NSLog(@"%@",[notification.object valueForKey:@"PicturediaryGroup"]);
    
    
      
 NSMutableArray  *array_Group=[[NSMutableArray alloc]init];
    
   for (int s=0; s<[[notification.object valueForKey:@"PicturediaryGroup"]count]; s++)
    {
        
        [array_Group addObject:[[[[notification.object valueForKey:@"PicturediaryGroup"]valueForKey:@"ClaClass"]objectAtIndex:s]valueForKey:@"id"]];
        
        NSLog(@"%@",[[[[notification.object valueForKey:@"PicturediaryGroup"]valueForKey:@"ClaClass"]objectAtIndex:s]valueForKey:@"id"]);

        
        
        NSLog(@"%@",array_Group);
        
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:array_Group forKey:@"EDU_Group_List"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [array_Group removeAllObjects];

    
    
    for (int s=0; s<[[notification.object valueForKey:@"PicturediaryKnowledgeArea"]count]; s++) {
        
        
        
        
        
        [array_Group addObject:[[[[notification.object valueForKey:@"PicturediaryKnowledgeArea"]valueForKey:@"KnowledgeArea"]objectAtIndex:s]valueForKey:@"id"]];
      
        NSLog(@"%@",[[[[notification.object valueForKey:@"PicturediaryKnowledgeArea"]valueForKey:@"KnowledgeArea"]objectAtIndex:s]valueForKey:@"id"]);
        NSLog(@"%@",array_Group);

        
        
        
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:array_Group forKey:@"Tages"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [array_Group removeAllObjects];

    
    
    
    
    
    for (int s=0; s<[[notification.object valueForKey:@"PicturediaryStudent"]count]; s++) {
        
        [array_Group addObject:[[[[notification.object valueForKey:@"PicturediaryStudent"]valueForKey:@"Student"]objectAtIndex:s]valueForKey:@"id"]];
        
        
        NSLog(@"%@",[[[[notification.object valueForKey:@"PicturediaryStudent"]valueForKey:@"Student"]objectAtIndex:s]valueForKey:@"id"]);
        NSLog(@"%@",array_Group);

        
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:array_Group forKey:@"EDU_Student_List"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [array_Group removeAllObjects];
    
    
    
    
    
    NSLog(@"%u",[[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]count]);
    
    NSLog(@"%u",[[[NSUserDefaults standardUserDefaults]valueForKey:@"Tages"]count]);
    NSLog(@"%u",[[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Student_List"]count]);
    
    
    
    
    
    //     //  *****************************                  ************************************
    
    
    
    
    
    for (int s=0; s<[[notification.object valueForKey:@"images"]count]; s++) {
        
        Value_id=[[NSMutableDictionary alloc]init];
        
        dic_all_data=[[NSMutableDictionary alloc]init];
        
        
        NSURL *imageURL = [NSURL URLWithString:[Utilities API_link_url_subDomain_for_IMG:[[[notification.object valueForKey:@"images"]objectAtIndex:s]valueForKey:@"id"]]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        [Value_id setValue:[[[notification.object valueForKey:@"images"]objectAtIndex:s]valueForKey:@"id"] forKey:@"ID"];

        
        
        [Value_id setValue:[UIImage imageWithData:imageData] forKey:@"thumbnail"];
        
        
        [Value_id setValue:[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"Data"];
        [Value_id setValue:@"jpg" forKey:@"type"];
        
        [Array_all_data addObject:Value_id];
        
        
        
    }
    
    
    
    
    
    
    for (int v=0; v<[[notification.object valueForKey:@"videos"]count]; v++) {
        
        
        Value_id=[[NSMutableDictionary alloc]init];
        
        dic_all_data=[[NSMutableDictionary alloc]init];
        
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[[notification.object valueForKey:@"videos"]objectAtIndex:v]valueForKey:@"imagename"]]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        [Value_id setValue:[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"Data"];
        
        [Value_id setValue:[[[notification.object valueForKey:@"videos"]objectAtIndex:v]valueForKey:@"id"] forKey:@"ID"];
        
        [Value_id setValue:[UIImage imageWithData:imageData] forKey:@"thumbnail"];
        
        
        [Value_id setValue:@"mp4" forKey:@"type"];
        
        
        [Array_all_data addObject:Value_id];
        
        
        
    }
    
    [dic_all_data  setObject:Array_all_data forKey:@"all_data"];
    
    
    NSLog(@"%@",dic_all_data);
    
    if (![[dic_all_data valueForKey:@"all_data"]count]==0) {
        mtableView.frame=CGRectMake(15, Description_TV.frame.origin.y+Description_TV.frame.size.height+10, self.view.frame.size.width-30,100);
        Post_data_IMG.frame=CGRectMake((self.view.frame.size.width-300)/2, mtableView.frame.origin.y+mtableView.frame.size.height+10, 300, 48);
        scrollview.contentSize = CGSizeMake(self.view.frame.size.width, 630);

    }
    
    
    [[NSUserDefaults standardUserDefaults]setValue:@"Publish_unchange" forKey:@"Publish_type"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
    
    
    
    Select_Group_TXT.text =@"";
    Select_Student_TXT.text =@"";
    Select_Knowledge_Areas_TXT.text =@"";
    
    

    Select_Knowledge_Areas_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Knowledge Areas" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [Description_TV setText:[[NSUserDefaults standardUserDefaults]valueForKey:@"Description_TV"]];
    check_uncheck.backgroundColor=[UIColor whiteColor];
    
    
    
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]);
    
    
    NSLog(@"%lu",(unsigned long)Get_id.count);

    [Get_id addObjectsFromArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]];
    
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
    else
    {
          Select_Group_TXT.text=@"";
         Select_Group_TXT.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"All" value:@"" table:nil];
    }
    

    
    
    
    [Get_Student addObjectsFromArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Student_List"]];
    
    
    
    if (Get_Student.count==0) {
        
        
        Select_Student_TXT.placeholder=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"All" value:@"" table:nil];
    }
    else
    {
        
        Select_Student_TXT.text=[NSString stringWithFormat:@"%lu %@",(unsigned long)Get_Student.count,[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Users" value:@"" table:nil]];
    }
    
    
    
    [Get_Tages addObjectsFromArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"Tages"]];
    
    if (!Get_Tages.count==0) {
        
        
        Select_Knowledge_Areas_TXT.text=[NSString stringWithFormat:@"%d Curriculum Tags",Get_Tages.count];
        
    }
    else
    {
        pickre_Tags=@"";
    }
    
    
    NSLog(@"%@", notification.object);
    
    
    

    [check_uncheck setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
  
    
    button_check=false;
    
    Notification=@"no";

 NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Tages"]);
    
    
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                   {
                       // Background work
                       dispatch_async(dispatch_get_main_queue(), ^(void)
                                      {[mtableView reloadData];

                                                                                    
                                          if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"]count]==0) {
                                              [self mStartIndicater];
                                              
                                              [self performSelector:@selector(CallTheServer_Student_API:) withObject:[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Group_List"] afterDelay:0.5];
                                          }
                                          


                                      });
                   });
    
    

}

- (void) receiveTestNotification1:(NSNotification *) notification
{
 [self mStartIndicater];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EDU_Student_List"];
    [[NSUserDefaults standardUserDefaults]synchronize];

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
        
        
        [self performSelector:@selector(CallTheServer_Student_API:) withObject:notification.object afterDelay:0.5];

        
    }
    else
    {
        Select_Group_TXT.text=@"";
        
        Select_Group_TXT.placeholder=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"All" value:@"" table:nil];
        
        
        [Get_id addObject:@"all"];

        
        
        [self performSelector:@selector(CallTheServer_Student_API:) withObject:Get_id afterDelay:0.5];


    }
    
    
    
    
}

- (void) receiveTestNotification2:(NSNotification *) notification
{
    
        [Get_Tages removeAllObjects];

    
      [Get_Tages addObjectsFromArray:notification.object];
    
    if (!Get_Tages.count==0) {
        
        
        
        if([[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_Updated_Draft"])
            {

              Select_Knowledge_Areas_TXT.text=[NSString stringWithFormat:@"%d Curriculum Tags",Get_Tages.count];
        }
        else
        {
        
        Select_Knowledge_Areas_TXT.text=[NSString stringWithFormat:@"%d Curriculum Tags",Get_Tages.count/3];
        }
        
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
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width, 630);
    
    
   checkactionSheet=true;
    
    
    Value_id=[[NSMutableDictionary alloc]init];
    
    dic_all_data=[[NSMutableDictionary alloc]init];
    
    
    [[ALAssetsLibrary new] assetForURL:info[UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset) {
        [Value_id setValue:[NSString stringWithFormat:@"%ld",(long)id_value] forKey:@"id"];
        
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_unchange"] ||[[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_Updated_Draft"]) {
            
            [[NSUserDefaults standardUserDefaults]setValue:@"Publish_Updated_Draft" forKey:@"Publish_type"];
            
             [Value_id setValue:@"0" forKey:@"ID"];
        }
        
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
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_unchange"] ||[[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_Updated_Draft"]) {
        
        [[NSUserDefaults standardUserDefaults]setValue:@"Publish_Updated_Draft" forKey:@"Publish_type"];
    }


}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)Navigation_bar
    {
        
        [self.navigationItem setHidesBackButton:YES];

        
        user_pic = [[UIImageView alloc] init];
        NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"USR_image"]]);
        [user_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"customer_logo"]]]
                    placeholderImage:[UIImage imageNamed:@"profile9.png"]];
        
  //      user_pic.frame=CGRectMake(50, 0, 30, 30);
        
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
        self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Edu Blog" value:@"" table:nil];
        
        
        self.navigationItem.hidesBackButton = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
   //     UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
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

-(void)Action_slider
{
    [self rightSideMenuButtonPressed];
}

-(void)gotoBack
{
    if (Description_TV.text.length != 0) {
        isEdited = YES;
    }
    else if (dic_all_data.count != 0)
    {
        isEdited = YES;
    }
    else
    {
        isEdited = NO;
    }
    if (isEdited)
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"" message:@"Go back?"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes, please"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        NSArray *array = [self.navigationController viewControllers];
                                        [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
                                        NSLog(@"you pressed Yes, please button");
                                        // call method whatever u need
                                    }];
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"No, thanks"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       NSLog(@"you pressed No, thanks button");
                                       
                                   }];
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
    }
}
- (void) REfress_EDU_POST:(NSNotification *) notification
{
    [self Navigation_bar];
    Left_Publish_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Publish" value:@"" table:nil];
    Right_Publish_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Post" value:@"" table:nil];
    
    Top_Posts_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"New Post" value:@"" table:nil];
    
    Retrieve_Draft_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"RETRIEVE DRAFT" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    Select_Group_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Multiple Groups" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    Select_Student_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"All" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    Select_Knowledge_Areas_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Knowledge Areas" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    Notify_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"NOTIFY BY MAIL" value:@"" table:nil];
    
    Top_Post_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
    
    [Description_TV setText:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil]];
    [Upload_images_video setText:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Upload image/video" value:@"" table:nil]];
    [BTN_Save_Draft setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"SAVE DRAFT" value:@"" table:nil] forState:UIControlStateNormal];
    [BTN_Publish setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"PUBLISH" value:@"" table:nil] forState:UIControlStateNormal];
}

-(void)doneButtonClicked
{
    [Description_TV resignFirstResponder];
    if(Description_TV.text.length == 0){
        Description_TV.textColor = [UIColor lightGrayColor];
        Description_TV.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
        //        [Description_TV resignFirstResponder];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    isEdited = NO;
    Delete_id_array=[[NSMutableArray alloc]init];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Publish_type"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EDU_Group_List"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EDU_Student_List"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Tages"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self Navigation_bar];
    
    
    Get_id=[[NSMutableArray alloc]init];
    Get_Tages=[[NSMutableArray alloc]init];
    Get_Student=[[NSMutableArray alloc]init];
    
    demo1=[[NSMutableArray alloc]init];
    demo2=[[NSMutableArray alloc]init];

   //if (check_uncheck==false) {
        Notification=@"no";
        
        dic_all_data=[[NSMutableDictionary alloc]init];
        
        id_value=1;

        images_pick=[[NSMutableArray alloc]init];
        Video_pick=[[NSMutableArray alloc]init];
        Array_all_data=[[NSMutableArray alloc]init];
        random_files_AR=[[NSMutableArray alloc]init];
        
        

 // }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(REfress_EDU_POST:)
                                                 name:@"REfress_EDU_POST"
                                               object:nil];

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(POST_screen_Save_Draft:)
                                                 name:@"POST_screen_Save_Draft"
                                               object:nil];

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification1:)
                                                 name:@"POST_screen_Groupes_getting"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification2:)
                                                 name:@"POST_screen_tages_getting"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification3:)
                                                 name:@"POST_screen_student_getting"
                                               object:nil];
    

    
    
    pickre_Tags=@"";
 
   // self.view.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    
    //////////////////// TopView Main background Lable\\\\\\\\\\\\\\
    
    Top_Main_background_color=[[UIView alloc]init];
    Top_Main_background_color.backgroundColor=[Text_color_ EDU_Blog_Color_code];
    Top_Main_background_color.userInteractionEnabled=YES;
    Top_Main_background_color.frame=CGRectMake(0, 64, self.view.frame.size.width, 60);
    [self.view addSubview:Top_Main_background_color];
    
    
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, Top_Main_background_color.frame.origin.y+Top_Main_background_color.frame.size.height,[[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    scrollview.backgroundColor = [Text_color_ EDU_Blog_Color_code];
    
    
   // scrollview.delaysContentTouches = YES;
  scrollview.translatesAutoresizingMaskIntoConstraints = NO;
    scrollview.panGestureRecognizer.delaysTouchesBegan = YES;
    
    [self.view addSubview:scrollview];

    
    
    //////////////////// TopView Left background Lable\\\\\\\\\\\\\\
    
    Top_Left_background_color=[[UIView alloc]init];
    Top_Left_background_color.backgroundColor=[UIColor clearColor];
    Top_Left_background_color.userInteractionEnabled=YES;
    Top_Left_background_color.frame=CGRectMake(0, 0, Top_Main_background_color.frame.size.width/2, 55);
    [Top_Main_background_color addSubview:Top_Left_background_color];
    
    
    ////////////////////  Left_Publish  Lable\\\\\\\\\\\\\\
    
    
    Left_Publish_LB=[[UILabel alloc]init];
    Left_Publish_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    Left_Publish_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Publish" value:@"" table:nil];
    Left_Publish_LB.frame=CGRectMake(Top_Left_background_color.frame.size.width-80,(Top_Left_background_color.frame.size.height-25)/2,50, 25);
    Left_Publish_LB.textColor=[UIColor whiteColor];
    // Left_Publish_LB.layer.cornerRadius=5;
    //Left_Publish_LB.clipsToBounds = YES;
    Left_Publish_LB.font=[Font_Face_Controller opensansLight:11];
    Left_Publish_LB.textAlignment=NSTextAlignmentCenter;
    [Top_Left_background_color addSubview:Left_Publish_LB];
    
    //////////////////  Left Image  Lable\\\\\\\\\\\\\\
    
    
    Left_Image=[[UIImageView alloc]init];
    Left_Image.image=[UIImage imageNamed:@"plus.png"];
    Left_Image.frame=CGRectMake((Left_Publish_LB.frame.origin.x-32)-20,(Top_Left_background_color.frame.size.height-32)/2,32, 32);
    [Top_Left_background_color addSubview:Left_Image];
    
    
    
    //////////////////// TopView Right background Lable\\\\\\\\\\\\\\
    
    Top_right_background_color=[[UIView alloc]init];
    Top_right_background_color.backgroundColor=[UIColor colorWithRed:214.0f/255.0f green:106.0f/255.0f blue:154.0f/255.0f alpha:1.0];
    Top_right_background_color.userInteractionEnabled=YES;
    Top_right_background_color.frame=CGRectMake(Top_Main_background_color.frame.size.width/2, 0, Top_Main_background_color.frame.size.width/2, 55);
    [Top_Main_background_color addSubview:Top_right_background_color];
    
    
    UITapGestureRecognizer *Top_right_background_action = [[UITapGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(Top_right_background_action)];
    
    [Top_right_background_color addGestureRecognizer:Top_right_background_action];

    
    //////////////////  Right Image  Lable\\\\\\\\\\\\\\
    
    
    Right_Image=[[UIImageView alloc]init];
    Right_Image.image=[UIImage imageNamed:@"Edu-Blog.png"];
    Right_Image.frame=CGRectMake(30,(Top_right_background_color.frame.size.height-32)/2,32, 32);
    [Top_right_background_color addSubview:Right_Image];
    
    
    ////////////////////  Right Publish  Lable\\\\\\\\\\\\\\
    
    
    Right_Publish_LB=[[UILabel alloc]init];
    Right_Publish_LB.backgroundColor=[UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
    Right_Publish_LB.frame=CGRectMake(Right_Image.frame.origin.x+Right_Image.frame.size.width+20,(Top_right_background_color.frame.size.height-25)/2,50, 25);
    Right_Publish_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Post" value:@"" table:nil];
    Right_Publish_LB.textColor=[UIColor whiteColor];
    Right_Publish_LB.font=[Font_Face_Controller opensansLight:11];
    Right_Publish_LB.textAlignment=NSTextAlignmentCenter;
    [Top_right_background_color addSubview:Right_Publish_LB];
    
    
    Top_Posts_LB=[[UILabel alloc]init];
    Top_Posts_LB.backgroundColor=[UIColor clearColor];
    Top_Posts_LB.frame=CGRectMake(15,0,150, 25);
    Top_Posts_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"New Post" value:@"" table:nil];
    Top_Posts_LB.textColor=[UIColor whiteColor];
    Top_Posts_LB.font=[Font_Face_Controller opensansLight:12];
    Top_Posts_LB.textAlignment=NSTextAlignmentLeft;
    [scrollview addSubview:Top_Posts_LB];
    
    
    
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Retrieve_Draft_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Top_Posts_LB.frame.origin.y+Top_Posts_LB.frame.size.height+5, self.view.frame.size.width-30, 25)];
    
    
    Retrieve_Draft_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"RETRIEVE DRAFT" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
    
    
    Retrieve_Draft_TXT.borderStyle = UITextBorderStyleNone;
    Retrieve_Draft_TXT.font = [UIFont systemFontOfSize:15];
    Retrieve_Draft_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    Retrieve_Draft_TXT.delegate = self;
    Retrieve_Draft_TXT.backgroundColor=[UIColor colorWithRed:214.0f/255.0f green:106.0f/255.0f blue:154.0f/255.0f alpha:1.0];
    Retrieve_Draft_TXT.textColor=[UIColor whiteColor];
    Retrieve_Draft_TXT.font=[Font_Face_Controller opensansLight:13];
    Retrieve_Draft_TXT.tag=006;
    Retrieve_Draft_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    Retrieve_Draft_TXT.layer.masksToBounds = YES;
    Retrieve_Draft_TXT.textAlignment=NSTextAlignmentCenter;
    
    
    Retrieve_Draft_TXT.rightViewMode = UITextFieldViewModeAlways;
    Retrieve_Draft_TXT.rightView = [self golble_img_right:(Retrieve_Draft_TXT.frame.size.height-25)/2];
    
    
    
//    Retrieve_Draft_TXT.leftViewMode = UITextFieldViewModeAlways;
//    
//    UIImageView * imgvw = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reterive_darft_30.png"]];
//    
//   [imgvw setFrame:CGRectMake(10, (Select_Knowledge_Areas_TXT.frame.size.height-16)/2, 16, 16)];
//    
//    
//    Retrieve_Draft_TXT.leftView = imgvw;

    
    [scrollview addSubview:Retrieve_Draft_TXT];

    
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Select_Group_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Retrieve_Draft_TXT.frame.origin.y+Retrieve_Draft_TXT.frame.size.height+15, self.view.frame.size.width-30, 25)];
    
    
    Select_Group_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Multiple Groups" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[Text_color_ Placeholder_Text_Color_code]}];
    
    
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
    
    
    Select_Group_TXT.textColor= [Text_color_ Content_Text_Color_code];

    Select_Group_TXT.rightViewMode = UITextFieldViewModeAlways;
    Select_Group_TXT.rightView = [self golble_img:(Select_Group_TXT.frame.size.height-25)/2];
    [scrollview addSubview:Select_Group_TXT];
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Select_Student_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Select_Group_TXT.frame.origin.y+Select_Group_TXT.frame.size.height+15, self.view.frame.size.width-30, 25)];
    
    Select_Student_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"All" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[Text_color_ Placeholder_Text_Color_code]}];
    
    Select_Student_TXT.textColor=   [Text_color_ Content_Text_Color_code];
    Select_Student_TXT.borderStyle = UITextBorderStyleNone;
    Select_Student_TXT.font = [UIFont systemFontOfSize:15];
    Select_Student_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    Select_Student_TXT.delegate = self;
    Select_Student_TXT.backgroundColor=[UIColor whiteColor];
    Select_Student_TXT.font=[Font_Face_Controller opensansLight:13];
    Select_Student_TXT.tag=002;
    Select_Student_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    Select_Student_TXT.layer.masksToBounds = YES;
    Select_Student_TXT.textAlignment=NSTextAlignmentCenter;
    
    
    Select_Student_TXT.rightViewMode = UITextFieldViewModeAlways;
    Select_Student_TXT.rightView = [self golble_img:(Select_Student_TXT.frame.size.height-25)/2];
    [scrollview addSubview:Select_Student_TXT];
    
    
    //////////////////// Schools  TextField \\\\\\\\\\\\\\
    
    Select_Knowledge_Areas_TXT = [[UITextField alloc] initWithFrame:CGRectMake(15, Select_Student_TXT.frame.origin.y+Select_Student_TXT.frame.size.height+15, self.view.frame.size.width-30, 25)];
    
    
    
    Select_Knowledge_Areas_TXT.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Knowledge Areas" value:@"" table:nil]
     attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    Select_Knowledge_Areas_TXT.borderStyle = UITextBorderStyleNone;
    Select_Knowledge_Areas_TXT.font = [UIFont systemFontOfSize:15];
    Select_Knowledge_Areas_TXT.autocorrectionType = UITextAutocorrectionTypeNo;
    Select_Knowledge_Areas_TXT.delegate = self;
    Select_Knowledge_Areas_TXT.backgroundColor=[UIColor colorWithRed:214.0f/255.0f green:106.0f/255.0f blue:154.0f/255.0f alpha:1.0];
    Select_Knowledge_Areas_TXT.textColor=[UIColor whiteColor];
    Select_Knowledge_Areas_TXT.font=[Font_Face_Controller opensansLight:13];
    Select_Knowledge_Areas_TXT.tag=003;
    Select_Knowledge_Areas_TXT.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    Select_Knowledge_Areas_TXT.layer.masksToBounds = YES;
    Select_Knowledge_Areas_TXT.textAlignment=NSTextAlignmentCenter;
    
    
    Select_Knowledge_Areas_TXT.rightViewMode = UITextFieldViewModeAlways;
    Select_Knowledge_Areas_TXT.rightView = [self golble_img_right:(Select_Knowledge_Areas_TXT.frame.size.height-25)/2];
    
    
//    Select_Knowledge_Areas_TXT.leftViewMode = UITextFieldViewModeAlways;
//    
//    UIImageView * imgvws = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"curiculum_30.png"]];
//    
//    
//     Select_Knowledge_Areas_TXT.leftView = imgvws;
//    
    
    [scrollview addSubview:Select_Knowledge_Areas_TXT];
    
    
      
    //////////////////// Save_Draft No Button\\\\\\\\\\\\\\
    
    check_uncheck = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [check_uncheck addTarget:self
                      action:@selector(aMethod_CHeck_Uncheck:)
             forControlEvents:UIControlEventTouchUpInside];
    check_uncheck.backgroundColor=[UIColor whiteColor];
      check_uncheck.frame = CGRectMake(15,Select_Knowledge_Areas_TXT.frame.origin.y+Select_Knowledge_Areas_TXT.frame.size.height+5,20, 20);
    [scrollview addSubview:check_uncheck];
    
    
    
    
    
    
    Notify_LB=[[UILabel alloc]init];
    Notify_LB.backgroundColor=[UIColor clearColor];
    Notify_LB.frame=CGRectMake(check_uncheck.frame.origin.x+check_uncheck.frame.size.width+5,Select_Knowledge_Areas_TXT.frame.origin.y+Select_Knowledge_Areas_TXT.frame.size.height+5,150, 20);
    Notify_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"NOTIFY BY MAIL" value:@"" table:nil];
    Notify_LB.textColor=[UIColor whiteColor];
    Notify_LB.font=[Font_Face_Controller opensanssemibold:9];
    Notify_LB.textAlignment=NSTextAlignmentLeft;
    [scrollview addSubview:Notify_LB];

    
    
    
    
    Top_Post_LB=[[UILabel alloc]init];
    Top_Post_LB.backgroundColor=[UIColor clearColor];
    Top_Post_LB.frame=CGRectMake(15,check_uncheck.frame.origin.y+check_uncheck.frame.size.height+7,150, 25);
    Top_Post_LB.text=[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
    Top_Post_LB.textColor=[UIColor whiteColor];
    Top_Post_LB.font=[Font_Face_Controller opensansregular:11];
    Top_Post_LB.textAlignment=NSTextAlignmentLeft;
    [scrollview addSubview:Top_Post_LB];
    

    
    
    Description_TV = [[UITextView alloc] initWithFrame:CGRectMake(15, Top_Post_LB.frame.origin.y+Top_Post_LB.frame.size.height,self.view.frame.size.width-30, 50)];
    [Description_TV setDelegate:self];
//    [Description_TV setReturnKeyType:UIReturnKeyDone];
  //  [Description_TV setText:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil]];
    [Description_TV setFont:[Font_Face_Controller opensansregular:12]];
    [Description_TV setTextColor:[UIColor lightGrayColor]];
    Description_TV.backgroundColor=[UIColor whiteColor];
    
    Description_TV.textColor=   [Text_color_ Placeholder_Text_Color_code];

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
    Post_data_IMG.userInteractionEnabled=YES;
    Post_data_IMG.frame=CGRectMake((self.view.frame.size.width-300)/2, Description_TV.frame.origin.y+Description_TV.frame.size.height+10, 300, 48);
    
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
    BTN_Save_Draft.backgroundColor=[UIColor colorWithRed:242.0f/255.0f green:158.0f/255.0f blue:195.0f/255.0f alpha:1.0];
    [BTN_Save_Draft setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"SAVE DRAFT" value:@"" table:nil] forState:UIControlStateNormal];
    [BTN_Save_Draft.titleLabel setFont:[Font_Face_Controller opensanssemibold:12]];
    [BTN_Save_Draft setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    BTN_Save_Draft.frame = CGRectMake(0,self.view.frame.size.height-50,(self.view.frame.size.width/2)-5, 50);
    [self.view addSubview:BTN_Save_Draft];
    
    
    
    
    
    //////////////////// Publish YES Button\\\\\\\\\\\\\\
    
    BTN_Publish = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [BTN_Publish addTarget:self
                   action:@selector(aMethod_Publish:)
         forControlEvents:UIControlEventTouchUpInside];
    BTN_Publish.backgroundColor=[UIColor colorWithRed:242.0f/255.0f green:158.0f/255.0f blue:195.0f/255.0f alpha:1.0];
    [BTN_Publish setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"PUBLISH" value:@"" table:nil] forState:UIControlStateNormal];
    [BTN_Publish.titleLabel setFont:[Font_Face_Controller opensanssemibold:12]];
    [BTN_Publish setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    BTN_Publish.frame = CGRectMake((self.view.frame.size.width/2)+5,self.view.frame.size.height-50,(self.view.frame.size.width/2)-5, 50);
    [self.view addSubview:BTN_Publish];
    
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Group_API) withObject:nil afterDelay:0.5];
    
     scrollview.contentSize = CGSizeMake(self.view.frame.size.width, 540);
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
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
        [UIColor colorWithRed:223.0f/255.0f green:110.0f/255.0f blue:160.0f/255.0f alpha:1.0];
        
    }
    else
    {
        back_ground.backgroundColor=[UIColor colorWithRed:242.0f/255.0f green:158.0f/255.0f blue:195.0f/255.0f alpha:1.0];
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

    
    
    //[self.navigationItem setHidesBackButton:YES];

    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
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

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:Description_TV])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
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
            
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_unchange"] ||[[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_Updated_Draft"]) {
                
                [[NSUserDefaults standardUserDefaults]setValue:@"Publish_Updated_Draft" forKey:@"Publish_type"];
            }

            
            if (![[[[dic_all_data valueForKey:@"all_data"]objectAtIndex:Tag_value]valueForKey:@"id"]isEqualToString:@"0"]) {
                
                [Delete_id_array addObject:[[[dic_all_data valueForKey:@"all_data"]objectAtIndex:Tag_value]valueForKey:@"id"]];
                
            }

            
            [[dic_all_data valueForKey:@"all_data"] removeObjectAtIndex:Tag_value];
            
            [mtableView reloadData];
            
            if ([[dic_all_data valueForKey:@"all_data"]count]==0) {
                
                mtableView.frame =CGRectMake(0, 0,0,0);
                
                 Post_data_IMG.frame=CGRectMake((self.view.frame.size.width-300)/2, Description_TV.frame.origin.y+Description_TV.frame.size.height+10, 300, 48);
                
                
                scrollview.contentSize = CGSizeMake(self.view.frame.size.width, 540);
            }

        }
        
        
    }
}

-(void)aMethod_Save_Draft:(UIButton *)sender
{
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]);
    
    save_as_draft=@"1";
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]);
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_unchange"]) {
        
        Save_Draft_ViewController *objSelection_list_ViewController=[[Save_Draft_ViewController alloc]init];
        [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
        
//        [self mStartIndicater];
//        
//        [self performSelector:@selector(CallTheServer_Publish_unchange_API) withObject:nil afterDelay:0.5];
        
        
    }

    
  else   if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_Updated_Draft"]) {
        
        
        NSArray *resultArray = [[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(ID <= %@)",@"0"]];
        
        
      
        //  NSLog(@"%@",resultArray);
        
        
        [dic_all_data removeAllObjects];
        
        [dic_all_data setObject:resultArray forKey:@"all_data"];

        
        Video_pick = (NSMutableArray *)[[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(type == %@)",@"mp4"]];
        
        
        images_pick = (NSMutableArray *)[[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(type == %@)",@"jpg"]];

        
        [self mStartIndicater];
        
        [self performSelector:@selector(CallTheServer_Publish_Updated_Draft) withObject:nil afterDelay:0.5];
    }
    else
    {

        if (Get_id.count==0) {
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"You have to select one or more groups, or individual users" value:@"" table:nil] delegate:nil cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        
        else  if ([[Description_TV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || [Description_TV.text  isEqualToString:@"Description"] || [Description_TV.text isEqualToString:@"Beskrivning"]) {
            
            
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil] delegate:nil cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        else
        {
            Video_pick = (NSMutableArray *)[[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(type == %@)",@"mp4"]];
            
            
            images_pick = (NSMutableArray *)[[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(type == %@)",@"jpg"]];
            
            
            [self mStartIndicater];
            
            [self performSelector:@selector(CallTheServer_Filter_API) withObject:nil afterDelay:0.5];
            
        }
    }
  

    save_as_draft=@"1";

}
-(void)aMethod_Publish:(UIButton *)sender
{
      save_as_draft=@"0";
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]);
    
    
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_unchange"]) {
        
        [self mStartIndicater];
        
    [self performSelector:@selector(CallTheServer_Publish_unchange_API) withObject:nil afterDelay:0.5];
        
  
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_type"]isEqualToString:@"Publish_Updated_Draft"])
    {
        
        
        
        
        if (Get_id.count==0) {
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"You have to select one or more groups, or individual users" value:@"" table:nil] delegate:nil cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        
        else  if ([[Description_TV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || [Description_TV.text  isEqualToString:@"Description"] || [Description_TV.text isEqualToString:@"Beskrivning"]) {
            
            
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil] delegate:nil cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        else
        {
            
            
            NSArray *resultArray = [[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(ID <= %@)",@"0"]];
            
            
            
            //  NSLog(@"%@",resultArray);
            
            
            [dic_all_data removeAllObjects];
            
            [dic_all_data setObject:resultArray forKey:@"all_data"];
            
            

            
            
            Video_pick = (NSMutableArray *)[[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(type == %@)",@"mp4"]];
            
            
            images_pick = (NSMutableArray *)[[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(type == %@)",@"jpg"]];
            
            
            [self mStartIndicater];
            
            [self performSelector:@selector(CallTheServer_Publish_Updated_Draft) withObject:nil afterDelay:0.5];
        }

        
        
       

    }
    else
    {
    
    
   
    
    if (Get_id.count==0) {
        
        alert = [[UIAlertView alloc] initWithTitle:nil message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"You have to select one or more groups, or individual users" value:@"" table:nil] delegate:nil cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
        
    }
    
    else  if ([[Description_TV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || [Description_TV.text  isEqualToString:@"Description"] || [Description_TV.text isEqualToString:@"Beskrivning"]) {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:nil message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil] delegate:nil cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];

    }
    else
    {
        Video_pick = (NSMutableArray *)[[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(type == %@)",@"mp4"]];
        
        
        images_pick = (NSMutableArray *)[[dic_all_data valueForKey:@"all_data"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(type == %@)",@"jpg"]];
        
    
    [self mStartIndicater];
    
    [self performSelector:@selector(CallTheServer_Filter_API) withObject:nil afterDelay:0.5];
        
    }
    }
}




#pragma mark - -*********************
#pragma mark Call CallTheServer Publish Unchange_API Method
#pragma mark - -*********************


-(void)CallTheServer_Publish_unchange_API
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"] forKey:@"authentication_token"];
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_draft_id"] forKey:@"draft_id"];
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
             [dic setValue:save_as_draft forKey:@"save_as_draft"];
         [dic setValue:Notification forKey:@"mail"];
        NSString *responseString = [API makeCallPostData_ALLs:dic:[NSString stringWithFormat:@"%@picture_diary/publish_draft",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"Refress_Post"
             object:nil];
            
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
        [dic setValue:Get_id forKey:@"group_ids"];
        [dic setValue:Get_Tages forKey:@"curriculum_tag_ids"];
        [dic setValue:Get_Student forKey:@"student_ids"];
        [dic setValue:save_as_draft forKey:@"save_as_draft"];

        
        
        
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
        
        
        
        
                
        
        
        
        
        
        
         [dic setValue:Notification forKey:@"mail"];
        
        
       // [dic setValue:Description_TV.text forKey:@"description"];
        stringReplace = [NSString stringWithFormat:@"%@",Description_TV.text];
        stringReplace = [stringReplace stringByReplacingOccurrencesOfString: @"<br>" withString: @"\n"];
        [dic setValue:stringReplace forKey:@"description"];
        [dic setValue:random_files_AR forKey:@"random_files"];
        
        
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
        
        NSLog(@"dic %@",dic);
        
        NSString *responseString = [API makeCallPostData_ALLs:dic:[NSString stringWithFormat:@"%@picture_diary/save_blog",[Utilities API_link_url_subDomain]]];
        
        
        //   [NSString stringWithFormat:@"%@signup_step2",[Utility API_link_url]]
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            
            if ([save_as_draft isEqualToString:@"0"]) {
                
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"Refress_Post"
             object:nil];
            }
            
            else
            {
                Save_Draft_ViewController *objSelection_list_ViewController=[[Save_Draft_ViewController alloc]init];
                [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];

            }
            
                    
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





#pragma mark - -*********************
#pragma mark Call publish_updated_draft_API Method
#pragma mark - -*********************


-(void)CallTheServer_Publish_Updated_Draft
{
    if ([API connectedToInternet]==YES) {
        
        //------------ Call API for signup With Post Method --------------//
        
        
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"] forKey:@"authentication_token"];
        
        [dic setValue:Get_id forKey:@"group_ids"];
        [dic setValue:Get_Tages forKey:@"curriculum_tag_ids"];
        [dic setValue:Get_Student forKey:@"student_ids"];
        
         [dic setValue:save_as_draft forKey:@"save_as_draft"];
        
        
        
     
        
        
        
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
        
        
        [dic setValue:Notification forKey:@"mail"];
        [dic setValue:Delete_id_array forKey:@"ids_to_delete"];
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Publish_draft_id"] forKey:@"draft_id"];
        [dic setValue:Description_TV.text forKey:@"description"];
        [dic setValue:random_files_AR forKey:@"random_files"];
        [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
        
        
        NSString *responseString = [API makeCallPostData_ALLs:dic:[NSString stringWithFormat:@"%@picture_diary/publish_updated_draft",[Utilities API_link_url_subDomain]]];
        
        NSDictionary *responseDict = [responseString JSONValue];
        dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
        
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"true"]) {
            
            if ([save_as_draft isEqualToString:@"0"]) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"Refress_Post"
                 object:nil];
            }
            
            else
            {
                Save_Draft_ViewController *objSelection_list_ViewController=[[Save_Draft_ViewController alloc]init];
                [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
                
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    TXT_tag=textField.tag;
    
    
    if (textField.tag==004 || textField.tag==005) {
        
        return YES;
        
    }
    else
    {
        
        if (textField.tag==001) {
            
            
            [Description_TV resignFirstResponder];
            
            
            EDU_Group_List *objSelection_list_ViewController=[[EDU_Group_List alloc]init];
            objSelection_list_ViewController.values=dict_Login;
            objSelection_list_ViewController.Main_values=@"groups";
            objSelection_list_ViewController.Sub_values=@"name";
             objSelection_list_ViewController.notification=@"POST_screen_Groupes_getting";
            objSelection_list_ViewController.post_type=@"POST";

            [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
            
            
            
        }
        else if (textField.tag==002 && [[dict_Student valueForKey:@"students"]count]!=0)
        {
            
            [Description_TV resignFirstResponder];
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"EDU_Student_List"]);
            
               NSLog(@"%@",dict_Student);
            
            Selection_list_ViewController *objSelection_list_ViewController=[[Selection_list_ViewController alloc]init];
            objSelection_list_ViewController.values=dict_Student;
            objSelection_list_ViewController.Main_values=@"students";
            objSelection_list_ViewController.Sub_values=@"name";
            objSelection_list_ViewController.notification=@"POST_screen_student_getting";
            objSelection_list_ViewController.post_type=@"POST";


            [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
            
            
        }
        else if (textField.tag==003)
        {
            [Description_TV resignFirstResponder];
            Post_Curriculum_Tags_ViewController *objSelection_list_ViewController=[[Post_Curriculum_Tags_ViewController alloc]init];
            
             objSelection_list_ViewController.notifications=@"POST_screen_tages_getting";
               objSelection_list_ViewController.post_type=@"POST";
            
            [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
        }
        
        else if (textField.tag==006)
        {
            [Description_TV resignFirstResponder];
            Save_Draft_ViewController *objSelection_list_ViewController=[[Save_Draft_ViewController alloc]init];
            [self.navigationController pushViewController:objSelection_list_ViewController animated:YES];
        }

        
    }
    
    return NO;
}


@end
