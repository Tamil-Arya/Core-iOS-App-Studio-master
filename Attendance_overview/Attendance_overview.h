//
//  Attendance_overview.h
//  ELAR
//
//  Created by Bhushan Bawa on 09/02/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "ELR_loaders_.h"
#import "NSString+HTML.h"
@interface Attendance_overview : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    UIView *Header_Back;
    UITableView *mtableview;
    
    UILabel *Group_name;
     UILabel *Group_Count;
    
    UIImageView *loader_image;
    
    NSMutableDictionary *dict;
    UIAlertView *alert;
    
    UILabel *absent_day_students_L_LB;
    
    UILabel *absent_day_students_R_LB;
    UIImageView *user_pic;
    
    
}
@property (strong, nonatomic)  NSString *date_value;
@end
