//
//  Selection_list_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 30/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+HTML.h"
@interface Selection_list_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mtable_view;
    
    BOOL check_values;
    BOOL check_values_tableview;
    
    NSMutableArray *get_id_Group;
    
    BOOL check;
    
}
@property(nonatomic)NSMutableArray *cellSelected;
@property(nonatomic,retain)NSMutableDictionary *values;
@property(nonatomic,retain)NSMutableDictionary *values_select;
@property(nonatomic,retain)NSString *Main_values;
@property(nonatomic,retain)NSString *Sub_values;
@property(nonatomic,retain)NSString *notification;
@property(nonatomic,retain)NSString *post_type;

@end