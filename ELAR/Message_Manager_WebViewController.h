//
//  Message_Manager_WebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 9/18/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"

@interface Message_Manager_WebViewController : UIViewController
{
    UIImageView * loader_image, * user_pic;
    NSString *loginUserId;
}
@property (strong, nonatomic) IBOutlet UIWebView *messageManagerWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;
@end
