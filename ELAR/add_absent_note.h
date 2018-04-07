//
//  add_absent_note.h
//  SCM
//
//  Created by pnf on 12/21/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "add_absent_note.h"
#import "DownPicker.h"//;
#import "NSString+HTML.h"
@interface add_absent_note : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    UITextView *Notetextfield;
    
    UITextField *datetextfield;
    UITextField *totextfield;
    UITextField *LeaveTypeSelectionDropDownList;
    
    NSString *LeaveTypeSelectionDropDownList_selected;
    
    UIImageView *loader_image;
    UIAlertView *alert;
    UIImageView *user_pic;
    
    NSMutableDictionary *absentnotedict;
    NSMutableDictionary *dict;
    
    UIButton *selected_date_btn;
    
    NSMutableArray* LeaveTypeSelectionDropDownListNameArray;
       NSString *Token_value;
    
    UIButton *mcheck;
    
     NSString *allow;
    
    UILabel *check_lable;
    BOOL button_check;
    
    
    
}
@property (strong, nonatomic) DownPicker *downPicker;
@property (strong, nonatomic) NSString *add_check;
@end
