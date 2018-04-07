//
//  Single_NEWS_Post_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 11/01/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALScrollViewPaging.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "NSString+HTML.h"
@interface Single_NEWS_Post_ViewController :UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    UISearchBar *search;
    
    UIView *Top_Main_background_color;
    
    UIView *Top_Left_background_color;
    UIView *Top_right_background_color;
    
    UIImageView *download_IMG;
    
    UILabel *Left_Publish_LB;
    UIImageView *Left_Image;
    
    
    
    UILabel *Right_Publish_LB;
    UIImageView *Right_Image;
    
    
    
    UITextField *Filter_LB;
    UIImageView *Filter_IMG;
    
    
    
    UITableView *tableViewm;
    
    
    
    
    UIAlertView *alert;
    UIScrollView *scrollview;
    NSMutableDictionary *dict;
    NSMutableDictionary *dict_Login;
    
    
    UILabel *description;
    
    
    ALScrollViewPaging *scrollView;
    NSMutableArray *scrollView_views;
    UIImageView *Demoimg;
    
    
    
    ALScrollViewPaging *scrollView_Vedio;
    NSMutableArray *scrollView_views__Vedio;
    UIImageView *Demoimg__Vedio;
    
    BOOL check_section;
    
    UIButton *Like;
    
    UIButton *Play_BTN;
    
    UILabel *number_of_like;
    
    NSInteger indexvalues;
    
    NSMutableDictionary *dict_like;
    
    NSMutableArray *random_file_array;
    
    UILabel *number_of_random_files;
    NSString *msearch_STR;
    UIRefreshControl *refreshControl;
    
    
    MPMoviePlayerController *moviePlayerController;
    UIImageView *cap_IMGs;
    
    
    NSMutableArray *other_account;
    
    
    UIImageView  *user_pic;
    
    NSInteger indexvalue;
    NSInteger pickre_index_value;
    
    
    UIPickerView *pPickerState;
    NSMutableArray *course_ARR;
    
    NSString *pickre_STR;
    
    
    NSString *ID_STR;
    NSString *Type_STR;
    UIButton *btnMenu;
    
    UIBarButtonItem *doneButton;
    UIBarButtonItem *cancelButton;
    
    UIImageView *loader_image;
    
}

@property(nonatomic,retain)NSMutableDictionary *array_all_detail;
@end
