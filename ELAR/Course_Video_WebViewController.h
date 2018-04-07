//
//  Course_Video_WebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 9/21/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"
@interface Course_Video_WebViewController : UIViewController
{
    UIImageView * loader_image, * user_pic;
    NSString *loginUserId;
}
@property (strong, nonatomic) IBOutlet UIWebView *courseVideoWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;
@end
