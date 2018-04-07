//
//  Evaluation_Matrix_WebViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 9/19/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"

@interface Evaluation_Matrix_WebViewController : UIViewController
{
    UIImageView * loader_image, * user_pic;
    NSString *loginUserId;
}
@property (strong, nonatomic) IBOutlet UIWebView *evaluationMatrixWebView;

@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;

@end
