//
//  AddActivityForStudentViewController.h
//  SampleForKaaylabs
//
//  Created by BALACHANDAR on 03/03/17.
//  Copyright © 2017 Venugopal Devarala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddActivityForStudentViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
    UIDatePicker * datePicker, * timePicker;
    NSMutableData * responsesData;
    UIImageView * loader_image;
    NSString * activityIdReceived;
}

@property (strong, nonatomic) IBOutlet UILabel *startDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *endDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;



@property (weak, nonatomic) IBOutlet UITextField *startDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *endDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *scheduleTitleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UILabel *scheduleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property BOOL  isEditActivity;
@property (strong,nonatomic) NSString * schemaIdReceived;

@property (strong) NSDate * selectedDate;

@end
