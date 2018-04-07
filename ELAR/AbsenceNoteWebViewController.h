//
//  AbsenceNoteWebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 10/9/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"

@interface AbsenceNoteWebViewController : UIViewController
{
    UIImageView * loader_image, * user_pic;
    NSString *loginUserId;
}
@property (strong, nonatomic) IBOutlet UIWebView *absenceNotesWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;

@end
