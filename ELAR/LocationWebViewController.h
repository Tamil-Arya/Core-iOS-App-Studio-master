//
//  LocationWebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 11/6/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"

@interface LocationWebViewController : UIViewController
{
    
    UIImageView * loader_image, * user_pic;
    NSString *loginUserId;
    
}
@property (strong, nonatomic) IBOutlet UIWebView *locationWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;
@end
