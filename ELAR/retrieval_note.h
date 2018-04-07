//
//  retrieval_note.h
//  SCM
//
//  Created by pnf on 12/20/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "NSString+HTML.h"
@interface retrieval_note : UIViewController<UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
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
@end
