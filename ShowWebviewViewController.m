//
//  ShowWebviewViewController.m
//  Smart Classroom Manager
//
//  Created by admin on 1/25/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "ShowWebviewViewController.h"
#import "ELR_loaders_.h"

@interface ShowWebviewViewController ()

@end

@implementation ShowWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [_webViewToDisplayBus loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://map-html-kishoreindraganti.c9users.io/hello-world.html"]]];
    _webViewToDisplayBus.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closebarButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark - UIWebView Delegates

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    loader_image=[ELR_loaders_ Start_loader:CGRectMake(([[UIScreen mainScreen]bounds].size.width-85)/2,[[UIScreen mainScreen]bounds].size.height/2,85,85)];
    [self.view addSubview:loader_image];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
     [loader_image removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
