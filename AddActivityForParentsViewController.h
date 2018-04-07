//
//  AddActivityForParentsViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 2/22/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddActivityForParentsViewController : UIViewController
{
    NSMutableArray * courseArray, *selectedItems , * studentList;
    UIPickerView * pickerView;
    UIDatePicker * datePicker, *timePicker;
    NSMutableData * responsesData;
    UIImageView * loader_image;
    NSString * activityIdReceived;
}

@property (strong, nonatomic) IBOutlet UILabel *startDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *endDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;


@property (strong, nonatomic) IBOutlet UITextField *selectCourseTextField;
@property (strong, nonatomic) IBOutlet UITextField *selectGroupTextField;
@property (strong, nonatomic) IBOutlet UITextField *scheduleTypeTextField;
@property (strong, nonatomic) IBOutlet UITextField *startDateTExtField;
@property (strong, nonatomic) IBOutlet UITextField *endDateTextField;
@property (strong, nonatomic) IBOutlet UITextField *scheduleTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *endTimeTextField;
@property (strong, nonatomic) IBOutlet UITableView *tableViewForGroup;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UITableView *tableViewForchildrenList;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintForChildrenTableView;
@property (strong, nonatomic) IBOutlet UILabel *scheduleTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@property NSMutableData * responsesData;

@property(strong,nonatomic) NSMutableDictionary * dictionaryReceived;
@property BOOL  isEditActivity;
@property (strong,nonatomic) NSString * schemaIdReceived;

@property (strong) NSDate * selectedDate;

@end
