//
//  WeekListViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 10/16/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"

@interface WeekListViewController : UIViewController
{
    
        UIImageView * loader_image, * user_pic;
        NSString *loginUserId;
    
}
@property (strong, nonatomic) IBOutlet UIWebView *weekListWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;
@end
