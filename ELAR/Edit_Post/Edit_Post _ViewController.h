//
//  Edit_Post _ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 17/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+HTML.h"
@interface Edit_Post__ViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *mtableView;
    
    UIView *Top_Main_background_color;
    
    UIView *Top_Left_background_color;
    UIView *Top_right_background_color;
    
    
    
    UILabel *Left_Publish_LB;
    UIImageView *Left_Image;
    
    
    
    UILabel *Right_Publish_LB;
    UIImageView *Right_Image;
    
    
    UILabel *Top_Post_LB;
    
    
    UITextField *Retrieve_Draft_TXT;
    UITextField *Select_Group_TXT;
    UITextField *Select_Student_TXT;
    UITextField *Select_Knowledge_Areas_TXT;
    
    
    UIButton *BTN_Save_Draft;
    UIButton *BTN_Publish;
    
    UIButton *check_uncheck;
    UILabel *Notify_LB;
    
    
    UIImageView *Post_data_IMG;
    
    
    BOOL button_check;
    
    
    UILabel *Description_LB;
    UITextView *Description_TV;
    
    NSInteger TXT_tag;
    
      UIAlertView *alert;
  
  
    UIScrollView *scrollview;
    
    NSMutableArray *dmo_array;
    
    NSMutableArray *Delete_id_array;
    
    NSMutableDictionary *dict_filter;
    
    NSMutableDictionary *dict_Login;
    NSMutableDictionary *dict_Student;
     NSMutableArray *dict_Tages;
    
    NSMutableDictionary *Other_Deatil;

    
    NSMutableArray *Get_Student;
    NSMutableArray *Get_id;
    NSMutableArray *Get_Tages;
    NSString *pickre_Tags;
    
    NSString *Notification;
    NSMutableDictionary *dict;
    
    
    NSMutableArray *images_pick;
    NSMutableArray *Video_pick;
    
    
    UIActionSheet *actionSheets;
    
    
    BOOL checkactionSheet;
    UIImage *chosenImage;
    
    UIView *back_ground;
    UILabel *Images_name_LB;
    UIImageView *Thumnail_Image_IMG;
    UIButton *delete_BTN;
    
    
    NSMutableDictionary *dic_all_data;
    NSMutableArray *Array_all_data;
    
    NSMutableDictionary *Value_id;
    NSMutableDictionary *type;
    NSMutableDictionary *data;
    NSInteger id_value;
    NSInteger Tag_value;
    
    UIImage *imges_thumnail;
    
    
    NSMutableArray *random_files_AR;
    
    NSMutableArray *demo1;
    NSMutableArray *demo2;
    
    UILabel *Upload_images_video;
    
    UIImageView *images_video_IMG;

    UIImageView *user_pic;
    
    UIImageView *loader_image;
    
}
@property(nonatomic,retain)NSString *post_id;



@end