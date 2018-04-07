//
//  Curriculum_Tags_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 03/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "NSString+HTML.h"
@interface Curriculum_Tags_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableViewm;
    UILabel *description;
    
    UIAlertView *alert;
    UIScrollView *scrollview;
    UIImageView *loader_image;

    UIImageView *imageView;
    UIImageView *user_pic;
    
}
@property(nonatomic,retain)NSMutableDictionary *dict;


@end
