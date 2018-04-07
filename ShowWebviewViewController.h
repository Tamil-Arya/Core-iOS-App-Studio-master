//
//  ShowWebviewViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 1/25/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowWebviewViewController : UIViewController<UIWebViewDelegate>
{
    UIImageView * loader_image;
}
@property (strong, nonatomic) IBOutlet UIWebView *webViewToDisplayBus;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
- (IBAction)closeButtonAction:(id)sender;

@end
