//
//  Save_Draft_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 19/01/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "NSString+HTML.h"
@interface Save_Draft_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *user_pic;
    UILabel *Filter_LB;
    UIImageView *loader_image;
    UIAlertView *alert;
    NSMutableDictionary *dict;
    
    NSMutableDictionary *dict_Remove_Drfat;
    
    UITableView *mtableview;
    UIRefreshControl *refreshControl;
    
    
    UIButton *Remove_Draft;
     UIButton *Use_Draft;
    
    
    NSString *from_date;
    NSString *to_date;
    NSString * my_draft;
    NSString *description_value;
    CGRect fFrame;
    NSString *Post_id;
    NSInteger Index_Paths;
    
    NSMutableArray *array_Group;
    

}

@end
