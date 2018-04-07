//
//  EDU_Blog_Home_screen_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 23/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALScrollViewPaging.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MFSideMenu.h"
#import "Curriculum_Tags_ViewController.h"
#import "ELR_loaders_.h"
#import "NSString+HTML.h"
#import "ImageCustomClass.h"


#import "MWPhotoBrowser.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface EDU_Blog_Home_screen_ViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,MWPhotoBrowserDelegate>
{
    
    UIImageView *loader_image;
    
    
    
    UISearchBar *search;
    
    UIView *Top_Main_Show_color;
    
    UIView *Top_Main_background_color;
    
    UIView *Top_Left_background_color;
    UIView *Top_right_background_color;
    
    UIImageView *download_IMG;
    
    UILabel *Left_Publish_LB;
    UIImageView *Left_Image;
    
    
    
    UILabel *Right_Publish_LB;
    UIImageView *Right_Image;
    
    
    
    UILabel *Filter_LB;
    UIImageView *Filter_IMG;
    
    
    
    UITableView *tableViewm;
    
    
    
    
    UIAlertView *alert;
    
    UIScrollView *scrollview;
    NSMutableDictionary *dict;
    NSMutableDictionary *dict_Login;
    
    
    UITextView *description;
    
    
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
    NSMutableArray *array_With_Image_Of_Each_Tag;
    
    
    NSMutableArray *random_file_array;
    
    UILabel *number_of_random_files;
    NSString *msearch_STR;
    UIRefreshControl *refreshControl;
    
    
    MPMoviePlayerController *moviePlayerController;
    UIImageView *cap_IMGs;
    
    
    NSMutableArray *other_account;
    
    
    UIImageView  *user_pic;
    UIButton *btnMenuss;
    
    NSString *authentication_token_STR;
    NSMutableArray *_selections;
    
    int indexOf_Image_viewed;
    MWPhotoBrowser *browser ;
    
    NSURL *fileURLForVideo;
    UIButton *downloadButtonForVideo;
    UIButton *backButton;
    UINavigationBar *navbarForVideo;
}

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) ALAssetsLibrary *ALAssetsLibrary;


@end
