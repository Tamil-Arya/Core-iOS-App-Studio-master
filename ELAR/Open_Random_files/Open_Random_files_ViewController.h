//
//  Open_Random_files_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 02/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "ELR_loaders_.h"
#import "NSString+HTML.h"
@interface Open_Random_files_ViewController : UIViewController<UIWebViewDelegate,NSURLConnectionDelegate>
{
    
    UIActivityIndicatorView *activityView;
    UIWebView *webView;
    BOOL isDone;
    NSURLConnection *con;
    NSURLRequest *req;
    UIButton *Back_BTN;
    
    
    UIImageView *user_pic;
     UIImageView *loader_image;
}
@property(nonatomic, strong)UIActivityIndicatorView *activityIndicator;
@property(nonatomic, strong)NSString *URL_VALUE;



@end
