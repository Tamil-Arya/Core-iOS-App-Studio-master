//
//  ViewFoodMenuWebViewViewController.h
//  Smart Classroom Manager
//
//  Created by Developer on 06/10/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewFoodMenuWebViewViewController : UIViewController<UIWebViewDelegate,UIDocumentInteractionControllerDelegate>
{
    UIImageView * loader_image;
}

@property NSURL * foodMenuUrlReceived;
@property NSString * fromPage;
@end
