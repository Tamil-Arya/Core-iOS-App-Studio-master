//
//  Select_Week.h
//  ELAR
//
//  Created by Bhushan Bawa on 05/03/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Select_Week : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mtable_view;
    
    BOOL check_values;
    BOOL check_values_tableview;
    
    NSMutableArray *get_id_Group;
    
    BOOL check;
    
    NSString *select_value;
    
}
@property(nonatomic,retain)NSMutableDictionary *values;
@property(nonatomic,retain)NSMutableDictionary *values_select;
@property(nonatomic,retain)NSString *Main_values;
@property(nonatomic,retain)NSString *Sub_values;
@property(nonatomic,retain)NSString *notification;
@property(nonatomic,retain)NSString *post_type;


@end
