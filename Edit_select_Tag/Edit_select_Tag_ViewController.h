//
//  Edit_select_Tag_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 22/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "ELR_loaders_.h"
#import "NSString+HTML.h"
@interface Edit_select_Tag_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableViewm;
    UILabel *description;
    
    
       UIAlertView *alert;
       UIScrollView *scrollview;
    
    
    UIImageView *imageView;
    UIImageView *user_pic;
    
    
    NSMutableArray *SUB_Id_alll_value;
    NSMutableArray *CHIL_alll_value;
    NSMutableArray *PAR_alll_value;
    
    NSMutableArray *Main_alll_value;
    NSMutableArray *Main_alll_value_DICT;
    BOOL check, isReloaded;
     UIImageView *loader_image;
    
}
@property(nonatomic,retain)NSMutableDictionary *dict;
@property(nonatomic)NSMutableArray *cellSelected;
@property(nonatomic,retain)NSMutableArray *values;
@property(nonatomic)NSString *notifications;
@property(nonatomic)NSString *post_type;


@end
