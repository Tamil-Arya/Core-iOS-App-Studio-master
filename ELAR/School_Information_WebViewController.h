//
//  School_Information_WebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 9/18/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"
@interface School_Information_WebViewController : UIViewController
{
    UIImageView * loader_image, * user_pic;
    NSString *loginUserId;
    
    
}
@property (strong, nonatomic) NSString *currentWebViewURL;
@property (strong, nonatomic) IBOutlet UIWebView *schoolInformationWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;
@end
