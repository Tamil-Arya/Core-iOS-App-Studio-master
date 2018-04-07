//
//  retrieval_list_home.h
//  SCM
//
//  Created by pnf on 12/11/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "MFSideMenu.h"
#import "NSString+HTML.h"
@interface retrieval_list_home : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
{
    
    UISearchBar *search;
    UIImageView *user_pic;
    
    NSString *CalenderDate_Selected;
    
    UITextField *GroupSelectionDropDownList;
    NSString *GroupSelectionDropDownListArray_Selected;
    NSMutableArray *GroupSelectionDropDownListIdArray;
    NSMutableDictionary *GroupsData;
    NSMutableDictionary *TickMarkApi;
    
    NSString *totalmarkedchildren;
    
    //variables for table view list of children
    NSMutableDictionary *students_list;
    UITableView *mtableView;
    UITableView *tableView_options;
        
    BOOL CheckIfShowGroupTitles;
    
    UIView *OptionsListBox;
    UIView *OptionsBox;
    UIButton *OptionsBoximageView;
    UIImage *OptionsbtnImage;
    UIView *ChildrensBox;
    UILabel *totallabel;
    UIButton *totalimageView;
    UILabel *tickbelowtimelabel;
    UIView *ChildrensBoxOverlay;
    
    NSString *language;
    
    NSString *authentication_token;
    
    UILabel *groupstudentcountlabel;
    UITextField *selected_date_btn;
   // UIDatePicker *datepicker;
    
    
    UIAlertView *alert;
    UIImageView *loader_image;
    
    
    NSString *Group_id;
    UIRefreshControl *refreshControl;
    
    UILabel *Updated_time;
}


@property (strong, nonatomic)  UIDatePicker *datepicker;


@property (strong, nonatomic) DownPicker *downPicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end