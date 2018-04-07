//
//  Survey_Forms_WebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 9/21/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"
@interface Survey_Forms_WebViewController : UIViewController
{
    UIImageView * loader_image, * user_pic;
    NSString *loginUserId;
}
@property (strong, nonatomic) IBOutlet UIWebView *surveyformsWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;

@end
