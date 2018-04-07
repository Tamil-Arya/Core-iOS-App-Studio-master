//
//  Single_retriever_note_Notifications.h
//  Smart Classroom Manager
//
//  Created by Bhushan Bawa on 17/03/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "NSString+HTML.h"

@interface Single_retriever_note_Notifications : UIViewController<UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    
    NSString *Token_value;
    
    UIScrollView *fullpagescrollview;
    
    NSMutableDictionary *dict;
    
    NSString *user_id;
    NSString *selected_date;
    
    
    UILabel *retrievalnamevalue;
    UILabel *contactdetailsvalue;
    UIImage *retrieverUserpicImage;
    UILabel *writtenbyvaluelabel;
    UILabel *writtenbydatelabel;
    UILabel *retrievalnotedescriptionlabel;
    UIImageView *retrieverimageView;
    UIButton *selected_date_btn;
    
    UIImageView *loader_image;
    
    
    UIImageView *user_pic;
    UIAlertView *alert;
    UIImageView *imageView;
    UILabel *usernamelabel;
    UILabel *guardianslabel;
    UILabel *userimage_background;
    UIView *backgroundBox;
    CGSize result;
    UILabel *writtenbylabel;
    UILabel *descriptionheading;
    UILabel *retrieveruserimage_background;
    UILabel *contactdetailslabel;
    UILabel *retrievalnamelabel;
    UILabel *retrievalnotelabel;
    UIView *retrievalnotedetailsBox;
}
@property (strong, nonatomic)  UIColor *color;
@property (strong, nonatomic)  NSString *date_value;
@property (strong, nonatomic)  UIDatePicker *datepicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property(nonatomic,retain)NSMutableDictionary *array_all_detail;
@end
