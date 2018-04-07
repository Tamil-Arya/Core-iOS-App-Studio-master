//
//  profile.h
//  SCM
//
//  Created by pnf on 12/24/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "NSString+HTML.h"
@interface profile : UIViewController<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate>
{
    UIDatePicker *datepicker;
    
    UITextField *Dropofftextfield;
    UITextField *Retrievaltextfield;
      UIButton *Update_Btn ;
    
    NSMutableDictionary *Dropoff_Update;
    
    
    UIButton *additionalinfoeditBtn ;
    UIButton *descriptioneditBtn;
    UIButton *allergieseditBtn;
    
    NSMutableDictionary *dict1;
    UITableView *tableView;
    UITableView *tableView_absencedays;
    UITableView *tableView_retrievalhistory;
    UIScrollView *fullpagescrollview;
    UIButton *selected_date_btn;
    NSMutableDictionary *userprofile;
    NSMutableDictionary *user_profile_update;
    NSString *responseString;
    
    UIImage *Absencedays_dropdown_arrow_btnImage;
    UIButton *Absencedays_dropdown_arrow_ImgBtn;
    UIView *Absencedays_background;
    
    bool isShown;
    bool isRetrievalShown;
    
    UIView *retrievalhistory_background;
    UIButton *retrievalhistory_dropdown_arrow_ImgBtn;
    UIImage *retrievalhistory_dropdown_arrow_btnImage;
    UIAlertView *alert;
    UIImageView *loader_image;
    
    UIImageView *user_pic;
    UILabel *usernamelabel;
    UILabel *guardianslabel ;
    UILabel *userimage_background;
    UIView *backgroundBox;
    UILabel *additionalinformationdetails ;
    UITextView *descriptiondetails;
    UILabel *allergiesdetails ;
    
    UIImageView *imageView;
    UIView *descriptionbox;
    UIView *allergiesbox;
    UIView *additionalinformationbox;
    
    UIView *Mfake_view;
    
    UITextField *Mtextfeild;
    UIButton *mcancel;
    UIButton *Msave;
    NSString *update_type;
    UIView *retrievaltimes_background ;
    UIView *retrievaltimescontent_background;
    
    NSString *tag_value;
    UIButton *guardiansButton;
    
    
}
@property (strong, nonatomic)  UIColor *color;
@property (strong, nonatomic)  NSString *date_value;
@property (strong, nonatomic)  NSString *Dropoff_str;
@property (strong, nonatomic)  NSString *Retrieval_str;
@property (strong, nonatomic)  UIDatePicker *datepicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end
