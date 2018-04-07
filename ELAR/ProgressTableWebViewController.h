//
//  ProgressTableWebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 9/4/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"

@interface ProgressTableWebViewController : UIViewController<UIWebViewDelegate,APIProtocol>
{
    UIImageView * loader_image, * user_pic;
      NSString *loginUserId;
}
@property (strong, nonatomic) IBOutlet UIWebView *progressTablesWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;
@end
