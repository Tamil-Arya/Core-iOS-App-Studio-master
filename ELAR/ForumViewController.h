//
//  ForumViewController.h
//  SampleForKaaylabs
//
//  Created by admin on 3/7/17.
//  Copyright © 2017 Venugopal Devarala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "ALScrollViewPaging.h"

#import "NSString+HTML.h"

#import "MWPhotoBrowser.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ForumViewController : UIViewController
{
    UIAlertView * alert;
    UIImageView * loader_image, * user_pic;
    NSString * msearch_STR;
     NSMutableDictionary *dict;
    
    //Table View Cell
    UILabel * description;
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
    UIImageView *download_IMG, *cap_IMGs;
    NSMutableArray *random_file_array;
    
    UILabel *number_of_random_files;

    UIRefreshControl *refreshControl;
    
    //Image
    NSMutableArray  * array_With_Image_Of_Each_Tag , *_selections;
    
    MWPhotoBrowser *browser ;
    int indexOf_Image_viewed;


    // Like
     NSMutableDictionary *dict_like;

}
@property (strong, nonatomic) IBOutlet UIButton *postButton;
@property (strong, nonatomic) IBOutlet UIButton *createButton;
@property (strong, nonatomic) IBOutlet UIButton *filterButton;
@property (strong, nonatomic) IBOutlet UITableView *forumListTableView;
@property (strong, nonatomic) IBOutlet UILabel *createLabel;
@property (strong, nonatomic) IBOutlet UILabel *postLabel;
@property (strong, nonatomic) IBOutlet UISearchBar *seachBarTExt;


@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) ALAssetsLibrary *ALAssetsLibrary;


@end
