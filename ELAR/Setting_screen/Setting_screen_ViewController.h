//
//  Setting_screen_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 11/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+HTML.h"

@interface Setting_screen_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mtableview;
    UISwitch *switchView;
    UILabel *title;
    UIAlertView *alert;
     UIScrollView *scrollview;
    
    NSMutableDictionary *dict, *dictionary;
    
    
    UILabel *LANGUAGE_LB;
    NSString *Token_value;
    

}

@end
