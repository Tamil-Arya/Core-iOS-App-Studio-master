//
//  TodaysNoteViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 9/7/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"
#import "TodaysNoteTableViewCell.h"
#import "Text_color_.h"

@interface TodaysNoteViewController : UIViewController<APIProtocol>
{
    UIImageView * loader_image, * user_pic;
    NSString *Token_value;
    NSMutableArray *note_List_Array;
    NSMutableDictionary *todayNoteDictionary, *dict, *dictionary;
    UILabel *note_date_Label;
    
    
    
   
}
@property (strong, nonatomic) IBOutlet UILabel *message_Label;
@property (strong, nonatomic) IBOutlet UIView *emptyView;
@property (strong, nonatomic) NSString *note_date;
@property (strong, nonatomic) NSString *descriptionString;
@property (strong, nonatomic) IBOutlet UITableView *tableViewTodaysNote;
@property (strong, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (strong, nonatomic) IBOutlet  UIView *todaysNoteMainView;
@property (strong, nonatomic) NSDictionary * dictionaryFromNotification;
@property(nonatomic, strong) IBOutlet  TodaysNoteTableViewCell *todaysNoteTableViewCell;
@end
