//
//  Edublog_Statistics_WebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 9/18/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"
@interface Edublog_Statistics_WebViewController : UIViewController
{
    UIImageView * loader_image, * user_pic;
    NSString *loginUserId;
}
@property (strong, nonatomic) IBOutlet UIWebView *edublog_StatisticsWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;

@end
