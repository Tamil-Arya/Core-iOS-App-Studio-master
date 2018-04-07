//
//  AddAbsentNotesViewController.h
//  SampleForSCM
//
//  Created by BALACHANDAR on 15/01/17.
//  Copyright © 2017 BALACHANDAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAbsentNotesViewController : UIViewController <UITextViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIDatePicker * datePicker;
    NSMutableArray * typeArray;
    UIPickerView * pickerView;
    UIAlertView * alert;
    UIImageView * loader_image;
}

@property (weak, nonatomic) IBOutlet UITextField *fromDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *toDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeSelectionTextField;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
@property (weak, nonatomic) IBOutlet UISwitch *absentSwitch;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabe;
@property (weak, nonatomic) IBOutlet UILabel *makeAsAbsentLabel;

@property (strong, nonatomic) IBOutlet UIView *addAbsentNotesView;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end
