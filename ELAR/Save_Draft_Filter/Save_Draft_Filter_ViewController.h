//
//  Save_Draft_Filter_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 19/01/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownCheckMarking.h"
#import "MFSideMenu.h"
#import "UIImageView+WebCache.h"
#import "NSString+HTML.h"
@interface Save_Draft_Filter_ViewController : UIViewController<DropDownCheckMarkingDelegate,UITextFieldDelegate>{
    
    
    
    
    DropDownCheckMarking * countriesDropDown;
    NSMutableArray * countries;
    NSMutableArray * selectedCountries;
    
    NSMutableArray * selectedStudent;
    
    NSMutableArray * selectedTages;
    
    NSMutableArray *get_all_tages;
    
    UIButton *BTN_Filter;
    UIButton *BTN_Cancel;
    
    
    UILabel *Select_Group_LB;
    UILabel *Select_Student_LB;
    UILabel *Select_Knowledge_Areas_LB;
    
    
    UILabel *Frome_LB;
    UILabel *To_LB;
    
    
    
    UITextField *Select_Group_TXT;
    UITextField *Select_Student_TXT;
    UITextField *Select_Knowledge_Areas_TXT;
    
    
    UITextField *Frome_TXT;
    UITextField *To_TXT;
    
    
    
    
    UIAlertView *alert;
    
    UIScrollView *scrollview;
    
    
    
    NSMutableDictionary *dict_filter;
    
    NSMutableDictionary *dict_Login;
    NSMutableDictionary *dict_Student;
    
    
    
    NSString  *ALL_DATA;
    
    
    NSInteger TXT_tag;
    
       NSString *pickre_STR;
    NSString *pickre_Tags;
    
    
    
    BOOL check_drop;
    UIImageView  *user_pic;
    
    UIImageView *loader_image;
    
    
    UIButton *check_uncheck;
    UILabel *Notify_LB;
    NSString *Notification;
    BOOL button_check;

}



@end
