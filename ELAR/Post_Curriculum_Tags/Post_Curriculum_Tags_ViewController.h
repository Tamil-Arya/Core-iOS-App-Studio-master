//
//  Post_Curriculum_Tags_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 15/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "NSString+HTML.h"
@interface Post_Curriculum_Tags_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableViewm;
    UILabel *description;
    UILabel *curriculum_tags;
    
      UIAlertView *alert;
     UIScrollView *scrollview;
    
    
    UIImageView *imageView;
    UIImageView *user_pic;
    
    
    NSMutableArray *SUB_Id_alll_value;
    NSMutableArray *CHIL_alll_value;
    NSMutableArray *PAR_alll_value;
    
     NSMutableArray *Main_alll_value;
     NSMutableArray *Main_alll_value_DICT;
    BOOL check;
    
}
@property(nonatomic,retain)NSMutableDictionary *dict;
@property(nonatomic)NSMutableArray *cellSelected;

@property(nonatomic)NSString *notifications;
@property(nonatomic)NSString *post_type;

@end
