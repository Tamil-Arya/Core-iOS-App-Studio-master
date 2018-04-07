//
//  Right_slider_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 08/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "NSString+HTML.h"
@interface Right_slider_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *tableViewm;
    UILabel *school_LB;
    UILabel *User_type_LB;

    UILabel *Name_LB;

    UILabel *User_name_LB;

    
    UIImageView *profilepic;
    
    
    UILabel *school_LOGIN_LB;
    UILabel *User_type_LOGIN_LB;
    
    UILabel *Name_LOGIN_LB;
    
    UILabel *User_name_LOGIN_LB;
    
    
    UIImageView *profilepic_LOGIN;
    
    
     UILabel *Other_account_LB;
    
    
    UILabel *Setting_LB;
    
    UILabel *LOgOut_LB;
    UILabel *Website_LB;
    
    UIButton *Setting_BTN;
    
    UIButton *LOgOut_BTN;
    UIButton *Website_BTN;
    
    NSMutableArray *other_account;
    NSMutableArray *User_array;
    UIView *setting_view;
     UIView *logout_view;
    UIView *website_view;
    
      UIAlertView *alert;
 
    UIScrollView *scrollview;
    NSMutableDictionary *dict;

    NSMutableDictionary *Refress;
    
    NSString *Token_value;
    
}

@end
