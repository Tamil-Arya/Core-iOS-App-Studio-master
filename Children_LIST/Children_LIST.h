//
//  Children_LIST.h
//  ELAR
//
//  Created by Bhushan Bawa on 20/02/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+HTML.h"
@interface Children_LIST : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mtableview;
    
    
    UIImageView *user_pic;
    UILabel *mUser_name;
    
    NSMutableDictionary *mUserResponseDict;
    UIActivityIndicatorView *spinner;
    UIAlertView *alert;
    UIView *loader;
    UILabel *ActivityLabel;
    
    UIImageView *selectallcheckboximageView;
    
    BOOL selectallbtnCheck;
    
    NSMutableArray *array_list_checked;
    NSMutableDictionary *Friend_Invite_List_Dict;
    NSMutableDictionary *dict_updateacitivities;
}
@property(nonatomic,retain)NSString *event_id;


@end
