//
//  LunchInformationViewController.h
//  XIBTest
//
//  Created by jeff ayan on 28/12/16.
//  Copyright © 2016 jeff ayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
@interface LunchInformationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    
    __weak IBOutlet UILabel *scheduleLabel;
    __weak IBOutlet UILabel *currentLabel;
    __weak IBOutlet UITextField *startDateTextField;
    __weak IBOutlet UISegmentedControl *groupSegmentController;
    __weak IBOutlet UITableView *foodNotesTableView;
    IBOutlet UILabel *addFoodNotesHeaderLabel;
    
    IBOutlet UILabel *allergiesLabel;
    IBOutlet UILabel *childrenLabel;
    IBOutlet UILabel *groupSelectionLabel;
    UIImageView *loader_image;
    
    
    
}

@property (strong, nonatomic) IBOutlet UIView *foodMenuView;
@property (strong, nonatomic) IBOutlet UIScrollView *mailScrollView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintForTableview;

//@property (weak, nonatomic) IBOutlet UILabel *scheduleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
//@property (weak, nonatomic) IBOutlet UITextField *startDatePickerTextView;
//
//@property (weak, nonatomic) IBOutlet UISegmentedControl *groupSegmentController;
//
//@property (weak, nonatomic) IBOutlet UITableView *lunchTableView;



@end
