//
//  note_history.h
//  SCM
//
//  Created by pnf on 12/28/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "note_history.h"
#import "NSString+HTML.h"
@interface note_history : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *imageView;
    UIAlertView *alert;
    
    UIImageView *user_pic;
    
    NSMutableDictionary *dict1;
    
    NSMutableDictionary *note_history_dict;
    
    UITableView *tableView;
    UILabel *usernamelabel;
    UILabel *guardian1namelabel;
    UILabel *guardian1phonelabel;
    UILabel *guardian2namelabel;
    UILabel *guardian2phonelabel;
    
    UIImageView *loader_image;
    NSString *responseString;
    
    UIView *backgroundBox;
    }
@property(nonatomic,retain)UIColor *color;
@property (nonatomic, assign) CGFloat note_history_table_view_height_single;
@end
