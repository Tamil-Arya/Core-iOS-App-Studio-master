//
//  AddActivityViewController.h
//  SampleForKaaylabs
//
//  Created by admin on 11/3/16.
//  Copyright © 2016 Venugopal Devarala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "AspectTableViewCell.h"
#import "ScheduleTypeTableViewCell.h"
#import "APIWithProtocol.h"


@interface AddActivityViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate,UITextViewDelegate,APIProtocol>
{
    NSMutableArray * courseArray,* groupArray, *selectedItems, * typeArray, * aspectListArray, * scheduleTypeArray, * studentListArray, *studentListSelectedArray, *studyPartnersListArray , *studyPartnersListSelectedArray, * aspectListSelectedArray;
    UIPickerView * pickerViewForTextfields;
    UIDatePicker * datePicker, *timePicker;
    UIImageView * loader_image;
    
    BOOL isDeadlineCheacked;
    
    NSString * selectedScheduleTypeString , * courseIdSelected, * selectedGroupString;
    
    int selectedIndexOfCourse, selectedIndexOfScheduleType;
    
     APIWithProtocol * api;
}

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintForAspectView;
@property (strong, nonatomic) IBOutlet UITableView *aspectTableView;
@property (strong, nonatomic) IBOutlet UITableView *scheduleTypeTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintForExaminationTypeView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintForScheduleTypeTableview;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightcontraintForAspectTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightContraintForStudentList;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstrainForMainView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topContrainStartDateToSelectGroup;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topConstrainFromStartDateToScheduleTypeView;

@property (strong, nonatomic) IBOutlet UILabel *aspectLabel;
@property (strong, nonatomic) IBOutlet UILabel *examinationTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *studentTypeLabel;
@property (strong, nonatomic) IBOutlet UITableView *studentListTableView;

@property (strong, nonatomic) IBOutlet UIButton *deadlineCheckBoxButton;

@property (strong, nonatomic) IBOutlet UIView *scheduleTypeView;
@property (strong, nonatomic) IBOutlet UIImageView *scheduleTypeDropDownImage;

@property (strong, nonatomic) IBOutlet UILabel *selectCourseLabel;
@property (strong, nonatomic) IBOutlet UILabel *selectGroupLabel;
@property (strong, nonatomic) IBOutlet UILabel *scheduleTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *startDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *endDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;


@property (strong, nonatomic) IBOutlet UILabel *scheduleTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
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
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *startDateTextFieldTopConstraint;

@property (strong,nonatomic) NSMutableData * responsesData;

@property BOOL isEditActivity;
@property (strong,nonatomic) NSString * schemaIdReceived;

@property (strong) NSDate * selectedDate;



@end
