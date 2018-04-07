//
//  absent_note.h
//  SCM
//
//  Created by pnf on 12/18/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "NSString+HTML.h"
@interface absent_note : UIViewController<UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    
     UIButton *Add_Remove_button;
    
    NSString *Token_value;
    
    UIScrollView *fullpagescrollview;
    
    
    UILabel *writtenbyvaluelabel;
    UILabel *writtenbydatelabel;
    UILabel *absentnotedescriptionlabel;
    
    NSMutableDictionary *dict;
    
    NSString *user_id, *receivedAbsentNoteId, *dateSelected;
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
    
    UIButton * deleteButton;

}
@property (strong, nonatomic)  NSString *date_value;
@property (strong, nonatomic)  UIColor *color;
@property (strong, nonatomic)  UIDatePicker *datepicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end
