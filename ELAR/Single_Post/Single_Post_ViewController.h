//
//  Single_Post_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 08/01/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALScrollViewPaging.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NSString+HTML.h"
@interface Single_Post_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableViewm;
    
    UILabel *description;
    NSMutableDictionary *dict;
    ALScrollViewPaging *scrollView;
    NSMutableArray *scrollView_views;
    UIImageView *Demoimg;
    
    ALScrollViewPaging   *scrollView_Vedio;
    
    NSMutableArray *scrollView_views__Vedio;

    
    UIImageView *Demoimg__Vedio;
    
    UIImageView *cap_IMGs;
    
    UIButton *Play_BTN;
    
    UIImageView *download_IMG;
    UILabel *number_of_random_files;
    UIButton *Like;
    UILabel *number_of_like;
    
    MPMoviePlayerController *moviePlayerController;
 NSInteger indexvalues;
    
    UIAlertView *alert;
    
    
    NSMutableDictionary *dict_like;
    
    UIImageView *loader_image;
    
}
@property(nonatomic,retain)NSMutableDictionary *array_all_detail;


@end
