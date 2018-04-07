//
//  EDU_Group_List.h
//  ELAR
//
//  Created by Bhushan Bawa on 05/03/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+HTML.h"
@interface EDU_Group_List : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mtable_view;
    
    BOOL check_values;
    BOOL check_values_tableview;
    
    
    NSMutableArray *get_id_Group;
    NSMutableArray *get_id_type;
    
    
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
