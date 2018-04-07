//
//  SmartNotes_WebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 10/30/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"
@interface SmartNotes_WebViewController : UIViewController
{
    
    UIImageView * loader_image, * user_pic;
    NSString *loginUserId;
    
}
@property (strong, nonatomic) IBOutlet UIWebView *smartNotesWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;
@end
