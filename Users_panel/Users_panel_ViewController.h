//
//  Users_panel_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 19/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "NSString+HTML.h"
#import "MainViewController.h"
@interface Users_panel_ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    
     UIImageView *loader_image, *busImage;
    UICollectionView *_collectionView;
    CGSize retval;
    BOOL Error_Check;
    
  
    UIAlertView *alert;
 
    UIScrollView *scrollview;
    
    UIWebView *webViewForSmartNotes;
    
    UIImageView *panel_IMG;
    
    
    NSMutableDictionary *componet;
    NSMutableDictionary *mutableRetrievedDictionary;
    
    
    UILabel *Component_name;
    
     UITextView *UNseen_count;
    UIImageView *user_pic;
    UIView *leftView;
    UIView *rightView;
    UIToolbar *toolBar;
    
    UIButton *nextdayBtn;
    UIView *nextdayBox;
    
//    UILabel *Show_msg;
//    UILabel *Todays_Dropoff_Time;
//    UILabel *Todays_Retrival_Time;
    UIView *CalenderSelectionBox ;
    
    UIButton *previousdayBtn;
    
    UIButton *Next_BTN;
    UIButton *Pre_BTN;
    UIView *previousdayBox;
    
    
    NSMutableDictionary *UpdateRetrievedDictionary;
    NSString *Current_Date_STR;
    
    
    UILabel *Todays_Dropoff_Time;
    UILabel *Todays_Retrival_Time;
    UITextField *Current_Dates;
    UIDatePicker *datepicker;
    
    
    UIButton *absent_note_IMG;
    UIButton *retrival_note_IMG;
    
    UILabel *Show_msg;
    
    UIView *topview_gray;
    
    UITextField *selected_date_btn;
    

    NSString *cuurent_date;
    NSMutableDictionary   *mutableRetrievedDictionarys;
    NSMutableDictionary  *dict_Login;
    NSMutableArray *componentArray;

}
@property(nonatomic,retain)NSString *dropOff_time;
@property(nonatomic,retain)NSString *Retival_time;
@property(nonatomic,retain)NSString *User_name;
@property int indexOfChildSelected;

@end
