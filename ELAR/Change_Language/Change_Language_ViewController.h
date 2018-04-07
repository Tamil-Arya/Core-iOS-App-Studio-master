//
//  Change_Language_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 07/01/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+HTML.h"
@interface Change_Language_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mtableview;
    UILabel *title;
    
    NSMutableArray *language_ARR;
    
    BOOL check_language;
    NSIndexPath *myIP;
    
    NSMutableDictionary *dict;
    UIAlertView *alert;
    UIImageView *loader_image;
    
    NSString *Token_value;
    
}
@property(nonatomic)NSMutableArray *cellSelected;

@end
