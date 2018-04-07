//
//  Recovery_Notes_WebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 9/26/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"

@interface Recovery_Notes_WebViewController : UIViewController
{
    UIImageView * loader_image, * user_pic;
    NSString *loginUserId;
}
@property (strong, nonatomic) IBOutlet UIWebView *recoveryNotesWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;
@end
