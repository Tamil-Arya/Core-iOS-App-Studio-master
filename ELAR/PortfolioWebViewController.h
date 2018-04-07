//
//  PortfolioWebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 9/19/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"

@interface PortfolioWebViewController : UIViewController
{
    UIImageView * loader_image, * user_pic;
    NSString *loginUserId;
}
@property (strong, nonatomic) IBOutlet UIWebView *portfolioWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;
@end
