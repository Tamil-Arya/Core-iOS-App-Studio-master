//
//  AddVacationViewController.h
//  SampleForKaaylabs
//
//  Created by admin on 11/8/16.
//  Copyright © 2016 Venugopal Devarala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWithProtocol.h"
@interface AddVacationViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate,UITextViewDelegate,APIProtocol>
{
//    NSMutableArray * courseArray, *selectedItems;
//    UIPickerView * pickerView;
    UIDatePicker * datePicker, *timePicker;
    UIImageView * loader_image;
    APIWithProtocol * api;
}


@property (strong, nonatomic) IBOutlet UITextField *startDateTExtField;
@property (strong, nonatomic) IBOutlet UITextField *endDateTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *endTimeTextField;
@property (strong, nonatomic) IBOutlet UITableView *tableViewForGroup;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@property NSMutableData * responsesData;

@property (strong) NSDate * selectedDate;


@end
