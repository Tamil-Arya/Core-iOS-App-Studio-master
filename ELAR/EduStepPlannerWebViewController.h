//
//  EduStepPlannerWebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 11/3/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"
@interface EduStepPlannerWebViewController : UIViewController
{
    UIImageView * loader_image, * user_pic;
    NSString *loginUserId;
}
@property (strong, nonatomic) IBOutlet UIWebView *eduStepPlannerWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;
@end
