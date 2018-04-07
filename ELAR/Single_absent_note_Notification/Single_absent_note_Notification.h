//
//  Single_absent_note_Notification.h
//  Smart Classroom Manager
//
//  Created by Bhushan Bawa on 17/03/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "NSString+HTML.h"
@interface Single_absent_note_Notification : UIViewController<UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    UIButton *Add_Remove_button;
    
    NSString *Token_value;
    
    UIScrollView *fullpagescrollview;
    
    
    UILabel *writtenbyvaluelabel;
    UILabel *writtenbydatelabel;
    UILabel *absentnotedescriptionlabel;
    
    NSMutableDictionary *dict;
    
    NSString *user_id;
    NSString *selected_date;
    
    NSString *image_url;
    
    UIButton *selected_date_btn;
    
    UIImageView *user_pic;
    
    UIImageView *loader_image;
    UIAlertView *alert;
    UIImageView *imageView;
    
    UIView *leftView;
    UIView *rightView;
    UIView *nextdayBox;
    CGSize result;
    UIView *backgroundBox;
    UIView *userdetailsBox;
    UILabel *userimage_background;
    UILabel *usernamelabel;
    UILabel *guardianslabel;
    UIView *absentnotedetailsBox;
    UILabel *absentnotelabel;
    UILabel *absentnotedesclabel;
    UILabel *writtenbylabel;
    NSString *descriptionabsentnote;
    
}
@property (strong, nonatomic)  NSString *date_value;
@property (strong, nonatomic)  UIColor *color;
@property (strong, nonatomic)  UIDatePicker *datepicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property(nonatomic,retain)NSMutableDictionary *array_all_detail;

@end
