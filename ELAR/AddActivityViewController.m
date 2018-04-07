//
//  AddActivityViewController.m
//  SampleForKaaylabs
//
//  Created by admin on 11/3/16.
//  Copyright © 2016 Venugopal Devarala. All rights reserved.
//

#import "AddActivityViewController.h"
#import "ELR_loaders_.h"
#import "Font_Face_Controller.h"
#import "MainViewController.h"
#import "ImageCustomClass.h"
@interface AddActivityViewController ()

@end

@implementation AddActivityViewController

@synthesize schemaIdReceived = _schemaIdReceived;


static NSInteger  SELECT_COURSE_TEXTFIELD_TAG = 201;
static NSInteger  SELECT_GROUP_TEXTFIELD_TAG = 202;
static NSInteger  SCHEDULE_TYPE_TEXTFIELD_TAG = 203;
static NSInteger  START_DATE_TEXTFIELD_TAG = 204;
static NSInteger  END_DATE_TEXTFIELD_TAG = 205;
static NSInteger  START_TIME_TEXTFIELD_TAG = 206;
static NSInteger  END_TIME_TEXTFIELD_TAG = 207;

static NSInteger  GROUP_TABLE_TAG = 301;
static NSInteger  ASPECT_TABLE_TAG = 302;
static NSInteger  SCHEDULE_TABLE_TAG = 303;
static NSInteger  STUDENT_TABLE_TAG = 304;

static const NSInteger WEBSERVICE_GROUPS= 1001;
static const NSInteger WEBSERVICE_ADD_ACTIVITY_FOR_TEACHER = 1002;
static const NSInteger WEBSERVICE_ASPECT_LIST = 1003;
static const NSInteger WEBSERVICE_STUDENTS_GROUP_LIST = 1004;
static const NSInteger WEBSERVICE_TO_GET_ACTIVITY_INFO_WHILE_EDITING = 1005;
static const NSInteger WEBSERVICE_TO_DELETE_ACTIVITY = 1006;


static const NSInteger ASPECT_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG = 5000;
static const NSInteger SCHEDULE_TABLE_VIEW_CELL_RADIO_BUTTON_TAG = 6000;
static const NSInteger STUDY_PARTNERS_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG = 7000;

//static const NSInteger WEBSERVICE_ASPECT_LIST = 1003;


- (void)viewDidLoad {
    self.navigationController.navigationBarHidden = NO;
    [super viewDidLoad];
    [self restoreToDefaults];
    [self addPickerView];
    [self addDatePickerView];
    [self addTimePickerView];
    [self webserviceToGetGroupsAndCourses];
    
      isDeadlineCheacked = NO;
        // Do any additional setup after loading the view.
}

-(void) restoreToDefaults
{
    
    api = [[APIWithProtocol alloc]init];
    api.delegateObject = self;
    
    courseArray = [[NSMutableArray alloc]init];
    groupArray = [[NSMutableArray alloc]init];
    aspectListArray = [[NSMutableArray alloc]init];
     typeArray = [[NSMutableArray alloc]initWithObjects:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Lesson" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Activity" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Examination" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Assignment" value:@"" table:nil], nil];
    scheduleTypeArray = [[NSMutableArray alloc]initWithObjects:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Individually" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Unique" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Study groups" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Unique Study groups" value:@"" table:nil], nil];
    aspectListSelectedArray = [[NSMutableArray alloc]init];
    studentListArray = [[NSMutableArray alloc]init];
    studyPartnersListArray = [[NSMutableArray alloc]init];
    studyPartnersListSelectedArray = [[NSMutableArray alloc]init];
    studentListSelectedArray = [[NSMutableArray alloc]init];
    
    
    
    _selectCourseTextField.tag = SELECT_COURSE_TEXTFIELD_TAG;
    _selectGroupTextField.tag = SELECT_GROUP_TEXTFIELD_TAG;
    _scheduleTypeTextField.tag = SCHEDULE_TYPE_TEXTFIELD_TAG;
    _startDateTExtField.tag = START_DATE_TEXTFIELD_TAG;
    _endDateTextField.tag = END_DATE_TEXTFIELD_TAG;
    _startTimeTextField.tag = START_TIME_TEXTFIELD_TAG;
    _endTimeTextField.tag = END_TIME_TEXTFIELD_TAG;
    
    _tableViewForGroup.tag = GROUP_TABLE_TAG;
    _aspectTableView.tag = ASPECT_TABLE_TAG;
    _scheduleTypeTableView.tag = SCHEDULE_TABLE_TAG;
    _studentListTableView.tag = STUDENT_TABLE_TAG;
    
    selectedItems = [[NSMutableArray alloc]init];
    _mainScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width+100);
    
    
    _heightConstraintForScheduleTypeTableview.constant = 160;
    
    selectedScheduleTypeString = @"";
     courseIdSelected = @"";
    selectedGroupString = @"";
    
    [self onSelectionOtherScheduleTypes];
    [self Navigation_bar];
    [self changeLanguage];
    _heightcontraintForAspectTableView.constant = 0;
    
    selectedIndexOfCourse = 0;
    selectedIndexOfScheduleType = 0;
    
}


-(void) changeLanguage
{
    
    _selectCourseLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Course" value:@"" table:nil];
    _selectGroupLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select group" value:@"" table:nil];
    _scheduleTypeLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule type" value:@"" table:nil];

    _startDateLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start date" value:@"" table:nil];
    _startTimeLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start time" value:@"" table:nil];
    _endDateLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date" value:@"" table:nil];
    _endTimeLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End time" value:@"" table:nil];

    
    
    _selectCourseTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Course" value:@"" table:nil];
    _selectGroupTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select group" value:@"" table:nil];
    _scheduleTypeTextField.placeholder = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule type" value:@"" table:nil];
    _aspectLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Aspect" value:@"" table:nil];
    _examinationTypeLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type" value:@"" table:nil];
    _studentTypeLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Students" value:@"" table:nil];
    
    _startDateTExtField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start date" value:@"" table:nil];
    _startTimeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start time" value:@"" table:nil];
    _endDateTextField.placeholder = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date" value:@"" table:nil];
    _endTimeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End time" value:@"" table:nil];
    _scheduleTitleLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Title" value:@"" table:nil];
    _scheduleTitleTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule Title" value:@"" table:nil];
    _descriptionLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Description" value:@"" table:nil];
    _descriptionTextView.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil];

    //    groupSelectionLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Group Selection" value:@"" table:nil];
    //    allergiesLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"USE DRAFT" value:@"" table:nil];
}

-(void)addPickerView
{
    pickerViewForTextfields = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    [pickerViewForTextfields setDataSource: self];
    [pickerViewForTextfields setDelegate: self];
    pickerViewForTextfields.showsSelectionIndicator = YES;
    _selectCourseTextField.inputView = pickerViewForTextfields;
    _selectGroupTextField.inputView = _tableViewForGroup;
    _scheduleTypeTextField.inputView = pickerViewForTextfields;

    
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonClicked)];

//    UIBarButtonItem *doneButton =
//    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                  target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    _selectCourseTextField.inputAccessoryView = myToolbar;
     _selectGroupTextField.inputAccessoryView = myToolbar;
     _scheduleTypeTextField.inputAccessoryView = myToolbar;
    _descriptionTextView.inputAccessoryView = myToolbar;
}


-(void)addDatePickerView
{
    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0,10, 150)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    datePicker.hidden=NO;
    if (_selectedDate != nil)
    {
    [datePicker setDate:_selectedDate animated:NO];
    }
//    datePicker.date=_selectedDate;
    
    [datePicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:datePicker];
    
    
    _startDateTExtField.inputView = datePicker;
    _endDateTextField.inputView = datePicker;
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    
     UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonClicked)];
    
//    UIBarButtonItem *doneButton =
//    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                  target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    _startDateTExtField.inputAccessoryView = myToolbar;
    _endDateTextField.inputAccessoryView = myToolbar;
}

-(void)addTimePickerView
{
    timePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0,10, 150)];
    timePicker.datePickerMode=UIDatePickerModeTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    timePicker.hidden=NO;
    timePicker.date=[NSDate date];
    
    [timePicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
    //    [self.view addSubview:datePicker];
    
    
    _startTimeTextField.inputView = timePicker;
    _endTimeTextField.inputView = timePicker;
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    _startTimeTextField.inputAccessoryView = myToolbar;
    _endTimeTextField.inputAccessoryView = myToolbar;
}


-(void) showAlert : (NSString * ) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)doneButtonClicked
{
    [_selectGroupTextField resignFirstResponder];
    [_selectCourseTextField resignFirstResponder];
    [_scheduleTypeTextField resignFirstResponder];
    [_startDateTExtField resignFirstResponder];
    [_endDateTextField resignFirstResponder];
    [_startTimeTextField resignFirstResponder];
    [_endTimeTextField resignFirstResponder];
    [_descriptionTextView resignFirstResponder];
    
    if (pickerViewForTextfields.tag == SCHEDULE_TYPE_TEXTFIELD_TAG) {
        if ([_scheduleTypeTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Examination" value:@"" table:nil]]) {
            [self onSelectingExamination];
        }
       else  if ([_scheduleTypeTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Assignment" value:@"" table:nil]]) {
            [self onSelectingAssignment];
        }
        else
        {
            [self onSelectionOtherScheduleTypes];
        }
    }
    else if (pickerViewForTextfields.tag == SELECT_GROUP_TEXTFIELD_TAG) {
        if ([selectedGroupString isEqualToString:@""]) {
            _selectGroupTextField.text = [NSString stringWithFormat:@"%d group(s) selected",[selectedItems count]];

            _scheduleTypeTextField.hidden = NO;
            _scheduleTypeDropDownImage.hidden = NO;
        [self onSelectingGroups];
        }
        else if ([selectedGroupString isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Your own booking" value:@"" table:nil]])
        {
            [self onSelectionOtherScheduleTypes];
            _scheduleTypeTextField.hidden = YES;
            _scheduleTypeDropDownImage.hidden = YES;
//            _heightConstraintForAspectView.constant = 0;
//            _heightConstraintForExaminationTypeView.constant = 0;
//            _scheduleTypeView.hidden = YES;
//            _startDateTExtField.hidden = NO;
//            _startTimeTextField.hidden = NO;
            _selectGroupTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Your own booking" value:@"" table:nil];

        }
        else if ([selectedGroupString isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"School" value:@"" table:nil]])
        {
            _scheduleTypeTextField.hidden = NO;
            _scheduleTypeDropDownImage.hidden = NO;
            _selectGroupTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"School" value:@"" table:nil];

        }
        else
        {
        }
        
    }
    else if (pickerViewForTextfields.tag == SELECT_COURSE_TEXTFIELD_TAG) {
        [self onSelectingCourse];
    }
//    else if (pickerViewForTextfields.tag == SELECT_COURSE_TEXTFIELD_TAG) {
//        if ([_scheduleTypeTextField.text isEqualToString:@"Examination"]) {
//            [self onSelectingExamination];
//        }
//        else  if ([_scheduleTypeTextField.text isEqualToString:@"Assignment"]) {
//            [self onSelectingAssignment];
//        }
//        else
//        {
//            [self onSelectionOtherScheduleTypes];
//        }
//
//    }

}
-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    
    if (datePicker.tag == START_DATE_TEXTFIELD_TAG) {
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        _startDateTExtField.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
    }
    else if(datePicker.tag == END_DATE_TEXTFIELD_TAG)
    {
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        _endDateTextField.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];

    }
    else if(timePicker.tag == START_TIME_TEXTFIELD_TAG)
    {
        [dateFormat setDateFormat:@"HH:mm:ss"];
        _startTimeTextField.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:timePicker.date]];
        
    }
    else
    {
        [dateFormat setDateFormat:@"HH:mm:ss"];
        _endTimeTextField.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:timePicker.date]];
        
    }
    //assign text to label
   }

- (IBAction)tickButtonClicked:(id)sender {
//    if ([_selectCourseTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Course" value:@"" table:nil]])
//    {
//        [self showAlert:@"Please select course"];
//        
//    }
//    else if ([_selectGroupTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select group" value:@"" table:nil]])
//    {
//        [self showAlert:@"Please select groups"];
//    }
     if ([_scheduleTypeTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule type" value:@"" table:nil]])
    {
        [self showAlert:@"Please select Schedule type"];
    }
//    else if ([_startDateTExtField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start date" value:@"" table:nil]] && !_startDateTExtField.isHidden)
//    {
//        [self showAlert:@"Please select Start date"];
//    }
//    else if ([_startTimeTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Start time" value:@"" table:nil]]  && !_startTimeTextField.isHidden)
//    {
//        [self showAlert:@"Please select Start time"];
//    }
//    else if ([_endDateTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date" value:@"" table:nil]])
//    {
//        [self showAlert:@"Please select End date"];
//    }
//    else if ([_endTimeTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End time" value:@"" table:nil]])
//    {
//        [self showAlert:@"Please select End time"];
//    }

    else if ([_scheduleTitleTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule Title" value:@"" table:nil]])
    {
        [self showAlert:@"Please enter title"];
    }
    else if ([_descriptionTextView.text isEqualToString:@""] || [_descriptionTextView.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil]])
    {
        [self showAlert:@"Please enter description"];
    }
    else
    {
        [self webserviceToAddActivity];
    }

}

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)deadlinecheckBoxButtonClicked:(id)sender {
    
    if (isDeadlineCheacked) {
    [_deadlineCheckBoxButton setImage:[UIImage imageNamed: @"nonclick" ] forState:UIControlStateNormal];
        isDeadlineCheacked = NO;
    }
    else
    {
        [_deadlineCheckBoxButton setImage:[UIImage imageNamed: @"click" ] forState:UIControlStateNormal];
        isDeadlineCheacked = YES;
    }
}


#pragma mark - UITableView Cell Button Actions

- (IBAction)scheduleTypeRadioButtonClicked:(id)sender {
    UIButton * buttonSelected = (UIButton *)sender;
    NSLog(@"%ld",(long)buttonSelected.tag);
    selectedScheduleTypeString = [scheduleTypeArray objectAtIndex:buttonSelected.tag - SCHEDULE_TABLE_VIEW_CELL_RADIO_BUTTON_TAG];
    
    [_scheduleTypeTableView reloadData];
    
    if (buttonSelected.tag - SCHEDULE_TABLE_VIEW_CELL_RADIO_BUTTON_TAG == 0) { // Individually
        [self onSelectingOtherTypes];
    }
    else if (buttonSelected.tag - SCHEDULE_TABLE_VIEW_CELL_RADIO_BUTTON_TAG == 1) { // Unique
         [self onSelectingTypeUnique];
    }
    else if (buttonSelected.tag - SCHEDULE_TABLE_VIEW_CELL_RADIO_BUTTON_TAG == 2) { // Study groups
         [self onSelectingOtherTypes];
    }
    else // Unique Study groups
    {
         [self onSelectingTypeUniqueStudyGroups];
    }
    
}

- (IBAction)aspectTableViewCellCheckBox:(id)sender {
    UIButton * buttonSelected = (UIButton *)sender;
    NSLog(@"%ld",(long)buttonSelected.tag);
    
    if (0 <= buttonSelected.tag-ASPECT_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG && buttonSelected.tag-ASPECT_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG < 999 ) {
        if ([aspectListSelectedArray containsObject:aspectListArray[buttonSelected.tag - ASPECT_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG]]) {
            [aspectListSelectedArray removeObject:aspectListArray[buttonSelected.tag - ASPECT_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG]];
        }
        else
        {
            [aspectListSelectedArray addObject:aspectListArray[buttonSelected.tag - ASPECT_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG]];
        }
        [_aspectTableView reloadData];
    }
    else // Study partners and student list
    {
        if ([selectedScheduleTypeString isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Unique" value:@"" table:nil]]) {
            if ([studentListSelectedArray containsObject:studentListArray[buttonSelected.tag - STUDY_PARTNERS_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG]]) {
                [studentListSelectedArray removeObject:studentListArray[buttonSelected.tag - STUDY_PARTNERS_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG]];
            }
            else
            {
                [studentListSelectedArray addObject:studentListArray[buttonSelected.tag - STUDY_PARTNERS_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG]];
            }

            NSLog(@"%@",studentListSelectedArray);
//            NSLog(@"%@",studentListSelectedArray[0]);
        }
        else
        {
            if ([studyPartnersListSelectedArray containsObject:studyPartnersListArray[buttonSelected.tag - STUDY_PARTNERS_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG]]) {
                [studyPartnersListSelectedArray removeObject:studyPartnersListArray[buttonSelected.tag - STUDY_PARTNERS_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG]];
            }
            else
            {
                [studyPartnersListSelectedArray addObject:studyPartnersListArray[buttonSelected.tag - STUDY_PARTNERS_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG]];
            }
        }
        [_studentListTableView reloadData];
    }

}



#pragma mark - Schedule Type Selection


-(void) onSelectingAssignment
{
    _examinationTypeLabel.hidden = NO;
    _aspectLabel.hidden = NO;
     _scheduleTypeTableView.hidden = NO;
    _studentTypeLabel.hidden = NO;
    _aspectTableView.hidden = NO;
    
    _heightConstraintForAspectView.constant = 40 + _heightcontraintForAspectTableView.constant;
   
    _heightConstraintForExaminationTypeView.constant = 250;
    
    
    _startDateTExtField.hidden = YES;
    _startTimeTextField.hidden = YES;
    
    _endDateTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Date" value:@"" table:nil];
    _endTimeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Time" value:@"" table:nil];
    
    _scheduleTypeView.hidden = NO;
    UIButton * radioButtonSelected =[UIButton buttonWithType:UIButtonTypeCustom];
    radioButtonSelected.tag = SCHEDULE_TABLE_VIEW_CELL_RADIO_BUTTON_TAG;
    [self scheduleTypeRadioButtonClicked:radioButtonSelected];
    
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600);
    _heightConstrainForMainView.constant =self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600;
}

-(void) onSelectingExamination
{
     _examinationTypeLabel.hidden = YES;
    _heightConstraintForExaminationTypeView.constant = 0;
    _scheduleTypeTableView.hidden = YES;
    _aspectLabel.hidden = NO;
_aspectTableView.hidden = NO;
    
    _heightConstraintForAspectView.constant = 40 + _heightcontraintForAspectTableView.constant;

    
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 400);
    _heightConstrainForMainView.constant =self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600;

    if (![_selectCourseTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Course" value:@"" table:nil]]) {
//        [self webserviceToGetAspectList];
    }

    _startDateTExtField.hidden = NO;
    _startTimeTextField.hidden = NO;
    _endDateTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date" value:@"" table:nil];
    _endTimeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End time" value:@"" table:nil];
}

-(void) onSelectionOtherScheduleTypes
{
    _examinationTypeLabel.hidden = YES;
    _aspectLabel.hidden = YES;
     _scheduleTypeTableView.hidden = YES;
     _studentTypeLabel.hidden = YES;
    
    _aspectTableView.hidden = YES;
    _heightConstraintForAspectView.constant = 0;
   
    _heightConstraintForExaminationTypeView.constant = 0;
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600);
    _heightConstrainForMainView.constant =self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600;

    
    _startDateTExtField.hidden = NO;
    _startTimeTextField.hidden = NO;
    
    _scheduleTypeView.hidden = YES;
    
    _endDateTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End date" value:@"" table:nil];
    _endTimeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"End time" value:@"" table:nil];
    
}

-(void) onSelectingCourse
{
    [self webserviceToGetAspectList];
}

-(void) onSelectingGroups
{
     [self webserviceToGetStudentGroupList];
}

-(void) onSelectingTypeUnique
{

    _studentTypeLabel.hidden = NO;
    _studentTypeLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Students" value:@"" table:nil];
    
    if (studentListArray.count != 0) {
    _heightContraintForStudentList.constant = studentListArray.count * 40;
    
    _heightConstraintForExaminationTypeView.constant = _heightConstraintForScheduleTypeTableview.constant + _heightContraintForStudentList.constant + 150;
        [_studentListTableView reloadData];
    }
    else
    {
        _heightContraintForStudentList.constant = 0;
        _heightConstraintForExaminationTypeView.constant = _heightConstraintForScheduleTypeTableview.constant +100;
        
    }

    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600);
    _heightConstrainForMainView.constant =self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600;


}

-(void) onSelectingTypeUniqueStudyGroups
{
    _studentTypeLabel.hidden = NO;
    _studentTypeLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Study Partners" value:@"" table:nil];
    
     _heightContraintForStudentList.constant = 100;
    _heightConstraintForExaminationTypeView.constant = _heightConstraintForScheduleTypeTableview.constant + _heightContraintForStudentList.constant + 100;

    if (studyPartnersListArray.count != 0) {
        _heightContraintForStudentList.constant = studyPartnersListArray.count * 40;
        
        _heightConstraintForExaminationTypeView.constant = _heightConstraintForScheduleTypeTableview.constant + _heightContraintForStudentList.constant + 100;
        [_studentListTableView reloadData];
    }
    else
    {
        _heightContraintForStudentList.constant = 0;
        _heightConstraintForExaminationTypeView.constant = _heightConstraintForScheduleTypeTableview.constant +100;

    }
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600);
    _heightConstrainForMainView.constant =self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600;


}

-(void) onSelectingOtherTypes
{
    _studentTypeLabel.hidden = YES;
    
     _heightContraintForStudentList.constant = 0;
    _heightConstraintForExaminationTypeView.constant = _heightConstraintForScheduleTypeTableview.constant +100;
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 300);
    _heightConstrainForMainView.constant =self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 300;



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark WEb services

-(void) webserviceToGetActivityInfoWhileEditing  {
    
    [self mStartIndicater];
    
//    {"schema_id":"870","loginUserID":"44","securityKey":"H67jdS7wwfh","language":"en"}
    
    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",self.schemaIdReceived,@"schema_id",nil];
    _responsesData = [[NSMutableData alloc]init];
    
    NSError * error;
    NSLog(@"postDict %@",postDict);
    
    
    [api CallAFNetworkingWebserviceWithDataParametrs:postDict WithURL:[NSString stringWithFormat:@"%@mobile_api/get_Activity",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] withMsgType:WEBSERVICE_TO_GET_ACTIVITY_INFO_WHILE_EDITING];
    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSLog(@"[NSUserDefaults standardUserDefaults]valueForKey:@sub_domain] %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]);
//    
//    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@mobile_api/get_Activity",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] parameters:nil error:nil];
//    
//    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        
//        if (!error) {
//            //            NSLog(@"Reply JSON: %@", responseObject);
//            
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                //blah blah
//                [self ParseArray:responseObject withTag:WEBSERVICE_TO_GET_ACTIVITY_INFO_WHILE_EDITING];
//                
//            }
//        } else {
//            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
//        }
//        [self mStopIndicater];
//    }] resume];
    
    
    
}


-(void) webserviceToGetGroupsAndCourses  {
    
    [self mStartIndicater];

    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];
    _responsesData = [[NSMutableData alloc]init];
    
    NSError * error;
    NSLog(@"postDict %@",postDict);

    [api CallAFNetworkingWebserviceWithDataParametrs:postDict WithURL:[NSString stringWithFormat:@"%@mobile_api/getCoursesAndGroups",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] withMsgType:WEBSERVICE_GROUPS];

    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSLog(@"[NSUserDefaults standardUserDefaults]valueForKey:@sub_domain] %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]);
//    
//    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@mobile_api/getCoursesAndGroups",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] parameters:nil error:nil];
//    
//    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        
//        if (!error) {
//            //            NSLog(@"Reply JSON: %@", responseObject);
//            
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                //blah blah
//                 [self ParseArray:responseObject withTag:WEBSERVICE_GROUPS];
//                
//            }
//        } else {
//            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
//        }
//        [self mStopIndicater];
//    }] resume];

    
    
}


-(void) webserviceToAddActivity  {
    
    [self mStartIndicater];
    
//    {"CourseObject":"","students":[],"securityKey":"H67jdS7wwfh","building_id":"","aspects":[],"todate":"2017-02-09 8:32","dateTimeAssignment":"","type":"","teachers":"","id":"","scheduleType":"lesson","Course":"147","title":"activity","class_id":"40","description":"activity","fromdate":"2017-02-09 7:32","room_id":"","studyPartners":[],"language":"en","deadline":"","customer_id":"","loginUserID":"44"}
    
    NSString * fromDateToBePushed = [NSString stringWithFormat:@"%@ %@",_startDateTExtField.text,_startTimeTextField.text];
    NSString * toDateToBePushed = [NSString stringWithFormat:@"%@ %@",_endDateTextField.text,_endTimeTextField.text];

    
    NSMutableArray * studyPartnersidArray = [[NSMutableArray alloc]init];
//    for (int i = 0; i<[studyPartnersListSelectedArray count]; i++) {
        studyPartnersidArray =[studyPartnersListSelectedArray valueForKey:@"id"];
//    }
    
    NSMutableArray * studentsidArray = [[NSMutableArray alloc]init];
    //    for (int i = 0; i<[studyPartnersListSelectedArray count]; i++) {
    studentsidArray = [studentListSelectedArray valueForKey:@"id"];
    //    }
    
    NSLog(@"studyPartnersidArray %@",studyPartnersidArray);
    
//    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"",@"CourseObject",@"H67jdS7wwfh",@"securityKey",studentsidArray,@"students",@"",@"building_id",aspectListSelectedArray,@"aspects",toDateToBePushed,@"todate",@"",@"dateTimeAssignment",@"",@"type",@"",@"teachers",@"",@"id",_scheduleTypeTextField.text,@"scheduleType",courseIdSelected,@"Course",_scheduleTitleTextField.text,@"title",@"40",@"class_id",_descriptionTextView.text,@"description",fromDateToBePushed,@"fromdate",@"",@"room_id",studyPartnersidArray,@"studyPartners",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",[NSNumber numberWithBool:isDeadlineCheacked],@"deadline",@"",@"customer_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",nil];

//    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"",@"CourseObject",@"H67jdS7wwfh",@"securityKey",studentsidArray,@"students",@"",@"building_id",aspectListSelectedArray,@"aspects",@"2017-02-09 8:32",@"todate",@"2017-02-09 8:32",@"dateTimeAssignment",@"",@"type",@"",@"teachers",@"",@"id",_scheduleTypeTextField.text,@"scheduleType",courseIdSelected,@"Course",_scheduleTitleTextField.text,@"title",@"40",@"class_id",_descriptionTextView.text,@"description",@"2017-02-07 8:32",@"fromdate",@"",@"room_id",studyPartnersidArray,@"studyPartners",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",[NSNumber numberWithBool:isDeadlineCheacked],@"deadline",@"",@"customer_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",nil];

//      NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"",@"CourseObject",@"H67jdS7wwfh",@"securityKey",studentsidArray,@"students",@"",@"building_id",aspectListSelectedArray,@"aspects",toDateToBePushed,@"todate",@"2017-02-09 8:32",@"dateTimeAssignment",@"",@"type",@"",@"teachers",@"",@"id",_scheduleTypeTextField.text,@"scheduleType",courseIdSelected,@"Course",_scheduleTitleTextField.text,@"title",@"40",@"class_id",_descriptionTextView.text,@"description",fromDateToBePushed,@"fromdate",@"",@"room_id",studyPartnersidArray,@"studyPartners",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",[NSNumber numberWithBool:isDeadlineCheacked],@"deadline",@"",@"customer_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",nil];
    
    
//    {"securityKey":"H67jdS7wwfh","class_id":"18","id":"","loginUserID":"44","scheduleType":"assignment","description":"Testing","title":"Test","Course":"237","fromdate":"2017-04-21 11:59","todate":"2017-04-21 11:59","type":"studypartners","dateTimeAssignment":"2017-04-21 11:59","deadline":"0","students":[],"studyPartners":[],"aspects":[],"teachers":"","CourseObject":"","building_id":"","room_id":"","customer_id":"","language":"en","course_id":"237"}
    
    
    NSMutableDictionary * postDict ;
    
    NSString * scheduleTExtString ;
    
    if ([_scheduleTypeTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Examination" value:@"" table:nil]]) {
        scheduleTExtString = @"examination";
    }
    else if ([_scheduleTypeTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Lesson" value:@"" table:nil]])
    {
         scheduleTExtString = @"lesson";
    }
    else if ([_scheduleTypeTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Activity" value:@"" table:nil]])
    {
                scheduleTExtString = @"activity";
    }
     else
    {
    scheduleTExtString = @"assignment";
    }
    
    if (_isEditActivity) {
        postDict = [[NSMutableDictionary alloc] init];
        [postDict setValue:@" " forKey:@"CourseObject"];
        [postDict setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
        [postDict setValue:studentsidArray forKey:@"students"];
        [postDict setValue:@" " forKey:@"building_id"];
        [postDict setValue:aspectListSelectedArray forKey:@"aspects"];
        [postDict setValue:toDateToBePushed forKey:@"todate"];
        [postDict setValue:toDateToBePushed forKey:@"dateTimeAssignment"];
        [postDict setValue:@"" forKey:@"teachers"];
        [postDict setValue:@"" forKey:@"id"];
        [postDict setValue:scheduleTExtString forKey:@"scheduleType"];
        [postDict setValue:courseIdSelected forKey:@"Course"];
        [postDict setValue:_scheduleTitleTextField.text forKey:@"title"];
        [postDict setValue:@"40" forKey:@"class_id"];
        [postDict setValue:_descriptionTextView.text forKey:@"description"];
        [postDict setValue:fromDateToBePushed forKey:@"fromdate"];
        [postDict setValue:@"" forKey:@"room_id"];
        [postDict setValue:studyPartnersidArray forKey:@"studyPartners"];
        [postDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
        [postDict setValue:[NSNumber numberWithBool:isDeadlineCheacked] forKey:@"deadline"];
        [postDict setValue:@"" forKey:@"customer_id"];
        [postDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"] forKey:@"loginUserID"];
        [postDict setValue:_schemaIdReceived forKey:@"schemaId"];
        [postDict setValue:courseIdSelected forKey:@"course_id"];

        
//        postDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys: @"",@"CourseObject",@"H67jdS7wwfh",@"securityKey",studentsidArray,@"students",@"",@"building_id",aspectListSelectedArray,@"aspects",toDateToBePushed,@"todate",toDateToBePushed,@"dateTimeAssignment",@"",@"type",@"",@"teachers",@"",@"id",[_scheduleTypeTextField.text lowercaseString],@"scheduleType",courseIdSelected,@"Course",_scheduleTitleTextField.text,@"title",@"40",@"class_id",_descriptionTextView.text,@"description",fromDateToBePushed,@"fromdate",@"",@"room_id",studyPartnersidArray,@"studyPartners",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",[NSNumber numberWithBool:isDeadlineCheacked],@"deadline",@"",@"customer_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",_schemaIdReceived,@"schemaId",courseIdSelected,"course_id",nil];

    }
    else
    {
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"]);
        postDict = [[NSMutableDictionary alloc] init];
        [postDict setValue:@" " forKey:@"CourseObject"];
        [postDict setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
        [postDict setValue:studentsidArray forKey:@"students"];
        [postDict setValue:@" " forKey:@"building_id"];
        [postDict setValue:aspectListSelectedArray forKey:@"aspects"];
        [postDict setValue:toDateToBePushed forKey:@"todate"];
        [postDict setValue:toDateToBePushed forKey:@"dateTimeAssignment"];
       
        [postDict setValue:@"" forKey:@"teachers"];
        [postDict setValue:@"" forKey:@"id"];
        [postDict setValue:scheduleTExtString forKey:@"scheduleType"];
        [postDict setValue:courseIdSelected forKey:@"Course"];
        [postDict setValue:_scheduleTitleTextField.text forKey:@"title"];
        [postDict setValue:@"40" forKey:@"class_id"];
        [postDict setValue:_descriptionTextView.text forKey:@"description"];
        [postDict setValue:fromDateToBePushed forKey:@"fromdate"];
        [postDict setValue:@"" forKey:@"room_id"];
        [postDict setValue:studyPartnersidArray forKey:@"studyPartners"];
        [postDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
        [postDict setValue:[NSNumber numberWithBool:isDeadlineCheacked] forKey:@"deadline"];
        [postDict setValue:@"" forKey:@"customer_id"];
        [postDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"] forKey:@"loginUserID"];
        [postDict setValue:courseIdSelected forKey:@"course_id"];
      
        
//    postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"",@"CourseObject",@"H67jdS7wwfh",@"securityKey",studentsidArray,@"students",@"",@"building_id",aspectListSelectedArray,@"aspects",toDateToBePushed,@"todate",toDateToBePushed,@"dateTimeAssignment",@"",@"type",@"",@"teachers",@"",@"id",[_scheduleTypeTextField.text lowercaseString],@"scheduleType",courseIdSelected,@"Course",_scheduleTitleTextField.text,@"title",@"40",@"class_id",_descriptionTextView.text,@"description",fromDateToBePushed,@"fromdate",@"",@"room_id",studyPartnersidArray,@"studyPartners",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",[NSNumber numberWithBool:isDeadlineCheacked],@"deadline",@"",@"customer_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",courseIdSelected,"course_id",nil];
    }
    
    
    //            1.individually - Individually
    //            2.unique - Unique
    //            3.studypartners - studypartners.
    //            4.uniquestudypartners - Unique Study groups
    
    
    
//    if ([[schemaDictionary objectForKey:@"type"] isEqualToString:@"individually"]) {
//        selectedScheduleTypeString = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Individually" value:@"" table:nil];
//        [self onSelectingOtherTypes];
//    }
//    else  if ([[schemaDictionary objectForKey:@"type"] isEqualToString:@"unique"]) {
//        selectedScheduleTypeString = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Unique" value:@"" table:nil];
//        [self onSelectingTypeUnique];
//    }
//    else  if ([[schemaDictionary objectForKey:@"type"] isEqualToString:@"studypartners"]) {
//        selectedScheduleTypeString = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Study groups" value:@"" table:nil];
//        [self onSelectingOtherTypes];
//    }
//    else  if ([[schemaDictionary objectForKey:@"type"] isEqualToString:@"uniquestudypartners"]) {
//        selectedScheduleTypeString = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Unique Study groups" value:@"" table:nil];
//        [self onSelectingTypeUniqueStudyGroups];
//    }
//
    
    
    if ([_scheduleTypeTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Assignment" value:@"" table:nil]]) {
        if ([selectedScheduleTypeString isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Individually" value:@"" table:nil]]) {
            [postDict setValue:@"individually" forKey:@"type"];
        }
        else  if ([selectedScheduleTypeString isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Unique" value:@"" table:nil]]) {
            [postDict setValue:@"unique" forKey:@"type"];
        }
        else  if ([selectedScheduleTypeString isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"studypartners" value:@"" table:nil]]) {
            [postDict setValue:@"studypartners" forKey:@"type"];
        }
        else
        {
            [postDict setValue:@"uniquestudypartners" forKey:@"type"];
        }
    }
    
    _responsesData = [[NSMutableData alloc]init];
    
    NSLog(@"postDict %@",postDict);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/addActivityForTeacher",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];

    [api CallWebserviceWithDataParametrs:postDict WithURL:url withMsgType:WEBSERVICE_GROUPS];

    
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
////    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://172.16.19.55/mobile_api/addActivityForTeacher" ]];
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:60.0];
//    
//    [request addValue:@"application/json" forHTTPHeaderField:@ "Content-Type"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    
//    [request setHTTPMethod:@"POST"];
//    
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
//    [request setHTTPBody:postData];
//    
//    
//    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        //        NSLog(@"data:%@",data);
//        id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"dictionaryreceived %@",dictionaryreceived);
//        
//          NSLog(@"dictionaryreceived %@",str);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self ParseArray:dictionaryreceived withTag:WEBSERVICE_ADD_ACTIVITY_FOR_TEACHER];
//        });
//        
//    }];
//    
//    [postDataTask resume];
    
    
    
}

-(void) webserviceToGetAspectList  {
    
    [self mStartIndicater];
    
    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",courseIdSelected,@"course_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];
    _responsesData = [[NSMutableData alloc]init];
    
    NSLog(@"postDict %@",postDict);
    
    [api CallAFNetworkingWebserviceWithDataParametrs:postDict WithURL:[NSString stringWithFormat:@"%@mobile_api/getAspectsList",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] withMsgType:WEBSERVICE_ASPECT_LIST];

    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSLog(@"[NSUserDefaults standardUserDefaults]valueForKey:@sub_domain] %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]);
//    
//    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@mobile_api/getAspectsList",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] parameters:nil error:nil];
//    
//    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        
//        if (!error) {
//                        NSLog(@"Reply JSON: %@", responseObject);
//            
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                //blah blah
//                [self ParseArray:responseObject withTag:WEBSERVICE_ASPECT_LIST];
//                
//            }
//        } else {
//            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
//        }
//        [self mStopIndicater];
//    }] resume];
    
    
    
}
-(void) webserviceToGetStudentGroupList  {
    
    [self mStartIndicater];
    
//    {"securityKey":"H67jdS7wwfh","loginUserID":"44","group_ids":["40","11"],"language":"en"}

//    {"securityKey":"H67jdS7wwfh","loginUserID":"44","group_ids":["40","11"],"language":"en"}

    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",selectedItems,@"group_ids",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];
    
//    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",@"40",@"group_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];

    _responsesData = [[NSMutableData alloc]init];
    
    NSLog(@"postDict %@",postDict);
    
    [api CallAFNetworkingWebserviceWithDataParametrs:postDict WithURL:[NSString stringWithFormat:@"%@mobile_api/getGroupStudentsList",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] withMsgType:WEBSERVICE_STUDENTS_GROUP_LIST];

    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSLog(@"[NSUserDefaults standardUserDefaults]valueForKey:@sub_domain] %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]);
//    
//    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@mobile_api/getGroupStudentsList",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] parameters:nil error:nil];
//    
//    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        
//        if (!error) {
//                        NSLog(@"Reply JSON: %@", responseObject);
//            
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                //blah blah
//                [self ParseArray:responseObject withTag:WEBSERVICE_STUDENTS_GROUP_LIST];
//                
//            }
//        } else {
//            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
//        }
//        [self mStopIndicater];
//    }] resume];
    
    
    
}

-(void) webserviceToDelete  {
    
    [self mStartIndicater];
    
    
    
    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",_schemaIdReceived,@"schema_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];
    
    //    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",@"40",@"group_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];
    
    _responsesData = [[NSMutableData alloc]init];
    
    NSLog(@"postDict %@",postDict);
    
    [api CallAFNetworkingWebserviceWithDataParametrs:postDict WithURL:[NSString stringWithFormat:@"%@mobile_api/delete_Activity",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] withMsgType:WEBSERVICE_STUDENTS_GROUP_LIST];

    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSLog(@"[NSUserDefaults standardUserDefaults]valueForKey:@sub_domain] %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]);
//    
//    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@mobile_api/delete_Activity",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] parameters:nil error:nil];
//    
//    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        
//        if (!error) {
//            NSLog(@"Reply JSON: %@", responseObject);
//            
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                //blah blah
//                [self ParseArray:responseObject withTag:WEBSERVICE_TO_DELETE_ACTIVITY];
//                
//            }
//        } else {
//            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
//        }
//        [self mStopIndicater];
//    }] resume];
//    
    
    
}


-(void) ParseArray : (NSDictionary *) dictionaryReceived withTag : (int) tag
{
     [self mStopIndicater];
    if (tag == WEBSERVICE_GROUPS) {
        if ([dictionaryReceived objectForKey: @"status"] == 0) {
            //
        }
        else
        {
            NSMutableArray * arrayFromMainDictionary = [dictionaryReceived objectForKey:@"usercourses"];
            [courseArray addObject:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Select Course" value:@"" table:nil]];
            for (int i = 0; i<[arrayFromMainDictionary count]; i++) {
                NSDictionary * dictionaryWithEachIndex =[arrayFromMainDictionary objectAtIndex:i];
                
                NSDictionary * dictionaryWithcourse=[dictionaryWithEachIndex objectForKey:@"CouCourse"];
                
//                NSLog(@"dictionaryInsideSchema  %@",dictionaryWithGroups);
                [courseArray addObject:dictionaryWithcourse ];
                if ([courseArray count] != 0) {
                    [pickerViewForTextfields reloadAllComponents];
                }
            }
            NSMutableArray * arrayWithWholeGroups = [dictionaryReceived objectForKey:@"groups"];
            for (int i = 0; i<[arrayWithWholeGroups count]; i++) {
                NSDictionary * dictionaryWithEachIndex =[arrayWithWholeGroups objectAtIndex:i];
                
//                NSDictionary * dictionaryWithGroups=[dictionaryWithEachIndex objectForKey:@"groups"];
                
                NSLog(@"dictionaryInsideSchema  %@",dictionaryWithEachIndex);
                [groupArray addObject:dictionaryWithEachIndex];
               
            }
             [groupArray addObject:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Your own booking" value:@"" table:nil]];
             [groupArray addObject:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"School" value:@"" table:nil]];
            if ([groupArray count] != 0) {
                [_tableViewForGroup reloadData];
            }

        }
        if (_isEditActivity) {
            [self webserviceToGetActivityInfoWhileEditing];
        }

    }
    else if (tag == WEBSERVICE_TO_DELETE_ACTIVITY)
    {
         NSLog(@"dictionaryReceived  %@",dictionaryReceived);
        if ([[dictionaryReceived objectForKey:@"msg"] isEqualToString:@"File deleted successfully"]) {
                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionaryReceived objectForKey: @"msg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    //                 [self.navigationController popViewControllerAnimated:YES ];
                    
                    
//                    for (UIViewController *controller in self.navigationController.viewControllers)
//                    {
//                        if ([controller isKindOfClass:[MainViewController class]])
//                        {
//                            [self.navigationController popToViewController:controller
//                                                                  animated:YES];
//                            break;
//                        }
//                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
                
            

        }
    }
    else if (tag == WEBSERVICE_TO_GET_ACTIVITY_INFO_WHILE_EDITING)
    {
        NSLog(@"dictionaryReceived  %@",dictionaryReceived);
          NSDictionary * dictionaryFrmMainDictionary = [dictionaryReceived objectForKey:@"data"];
        NSDictionary * schemaDictionary  = [dictionaryFrmMainDictionary objectForKey:@"Schema"];
       
        
        
        NSString * classIdReceived = [schemaDictionary objectForKey:@"class_id"];
            if ([classIdReceived isEqualToString:@"-1"]) {
                selectedGroupString = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Your own booking" value:@"" table:nil];
            }
            else if ([classIdReceived isEqualToString:@"-2"])
            {
                selectedGroupString = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Your own booking" value:@"" table:nil];
            }
            else
            {
                classIdReceived = @"40";
                if ([classIdReceived containsString:@","]) {
                NSArray * arrayBySplittingTheClassId = [classIdReceived componentsSeparatedByString:@","];
                for (int i = 0 ; i<[groupArray count]; i++) {
                    NSDictionary * dictionaryAtEAchIndex = [groupArray objectAtIndex:i];
                    if ([arrayBySplittingTheClassId containsObject:dictionaryAtEAchIndex[@"id"]]) {
                        [selectedItems addObject:dictionaryAtEAchIndex];
                    }
                }
                }
                else
                {
                    for (int i = 0 ; i<[groupArray count]-2; i++) {
                        NSDictionary * dictionaryAtEAchIndex = [groupArray objectAtIndex:i];
                        if ([classIdReceived isEqualToString:dictionaryAtEAchIndex[@"id"]]) {
                            [selectedItems addObject:dictionaryAtEAchIndex];
                        }
                    }
                }
                NSLog(@"%@",selectedItems);
            }
        
            [_tableViewForGroup reloadData];
        
         NSString * courseIdReceived = [schemaDictionary objectForKey:@"cou_course_id"];
        
            for (int i = 1; i<[courseArray count]; i++) {
                NSDictionary * dictionaryAtEachIndex = courseArray[i];
                if ([[dictionaryAtEachIndex objectForKey:@"id"] isEqualToString:courseIdReceived]) {
                    _selectCourseTextField.text = [dictionaryAtEachIndex objectForKey:@"COU_Name"];
                    
                }
            }
        
        courseIdSelected = courseIdReceived;
        [self onSelectingCourse];
        
        
        NSString * scheduleTypeStringReceived = [schemaDictionary objectForKey:@"schedule_type"];
        
        
        if ([scheduleTypeStringReceived isEqualToString:@"assignment"]) {
            [self onSelectingAssignment];
            
            
//            1.individually - Individually
//            2.unique - Unique
//            3.studypartners - studypartners.
//            4.uniquestudypartners - Unique Study groups
            
            

            
            _scheduleTypeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Assignment" value:@"" table:nil];
        
            if ([[schemaDictionary objectForKey:@"type"] isEqualToString:@"individually"]) {
                selectedScheduleTypeString = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Individually" value:@"" table:nil];
                [self onSelectingOtherTypes];
            }
            else  if ([[schemaDictionary objectForKey:@"type"] isEqualToString:@"unique"]) {
                selectedScheduleTypeString = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Unique" value:@"" table:nil];
                [self onSelectingTypeUnique];
            }
            else  if ([[schemaDictionary objectForKey:@"type"] isEqualToString:@"studypartners"]) {
                selectedScheduleTypeString = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Study groups" value:@"" table:nil];
                [self onSelectingOtherTypes];
            }
            else  if ([[schemaDictionary objectForKey:@"type"] isEqualToString:@"uniquestudypartners"]) {
                selectedScheduleTypeString = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Unique Study groups" value:@"" table:nil];
                [self onSelectingTypeUniqueStudyGroups];
            }
            else
            {
                
            }
        }
        else if ([scheduleTypeStringReceived isEqualToString:@"examination"]) {
            [self onSelectingExamination];
            _scheduleTypeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Examination" value:@"" table:nil];
        }
        else if ([scheduleTypeStringReceived isEqualToString:@"lesson"])
        {
            [self onSelectionOtherScheduleTypes];
            _scheduleTypeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Lesson" value:@"" table:nil];
        }
        else if ([scheduleTypeStringReceived isEqualToString:@"activity"])
        {
            [self onSelectionOtherScheduleTypes];
            _scheduleTypeTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Activity" value:@"" table:nil];
        }
        else{
            
        }
        
        NSString * startDAteAndTimeReceived = [schemaDictionary objectForKey:@"start"];
        
        NSArray * arrayBySplittingTheStartDate = [startDAteAndTimeReceived componentsSeparatedByString:@" "];
        _startDateTExtField.text = [arrayBySplittingTheStartDate objectAtIndex:0];
        _startTimeTextField.text = [arrayBySplittingTheStartDate objectAtIndex:1];
        
        NSString * endDAteAndTimeReceived = [schemaDictionary objectForKey:@"end"];
        
        NSArray * arrayBySplittingTheEndDate = [endDAteAndTimeReceived componentsSeparatedByString:@" "];
        _endDateTextField.text = [arrayBySplittingTheEndDate objectAtIndex:0];
        _endTimeTextField.text = [arrayBySplittingTheEndDate objectAtIndex:1];
        
        _scheduleTitleTextField.text = [schemaDictionary objectForKey:@"title"];
        
        _descriptionTextView.text = [schemaDictionary objectForKey:@"description"];
        
        isDeadlineCheacked = (BOOL)[schemaDictionary objectForKey:@"deadline"];
        
        [self deadlinecheckBoxButtonClicked:nil];

    }
     else if (tag == WEBSERVICE_ASPECT_LIST)
     {
         if ([dictionaryReceived objectForKey: @"status"] == 0) {
           
         }
         else
         {
              NSMutableArray * arrayFromMainDictionary = [dictionaryReceived objectForKey:@"aspects"];
             for (int i = 0; i<[arrayFromMainDictionary count]; i++) {
                 NSDictionary * dictionaryWithEachIndex =[arrayFromMainDictionary objectAtIndex:i];
                 NSLog(@"aspectListArrayDict  %@",dictionaryWithEachIndex);
                 [aspectListArray addObject:dictionaryWithEachIndex ];
            }
             if ([aspectListArray count] != 0) {
                 [_aspectTableView reloadData];
                 _heightcontraintForAspectTableView.constant = aspectListArray.count * 40;
                 
                 NSLog(@"%f",_heightcontraintForAspectTableView.constant);
                 
                 if (_heightConstraintForAspectView.constant != 0) {
                     _heightConstraintForAspectView.constant = _heightcontraintForAspectTableView.constant + 40;
                 }
                 
                 _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600);
                 _heightConstrainForMainView.constant =self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600;

             }


         }
     }
     else if (tag == WEBSERVICE_ADD_ACTIVITY_FOR_TEACHER)
     {
         if ([[dictionaryReceived objectForKey: @"error"] isEqualToString:@"false"]) {
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionaryReceived objectForKey: @"msg"] preferredStyle:UIAlertControllerStyleAlert];
             [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                 [self.navigationController popViewControllerAnimated:YES ];
                 
                 
//                 for (UIViewController *controller in self.navigationController.viewControllers)
//                 {
//                     if ([controller isKindOfClass:[MainViewController class]])
//                     {
//                         [self.navigationController popToViewController:controller
//                                                               animated:YES];
//                         break;
//                     }
//                 }
                 
                 UIViewController *View = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-4];
                 [self.navigationController popToViewController:View animated:YES];
                 
//                 [self.navigationController popViewControllerAnimated:YES];
             }]];
             [self presentViewController:alertController animated:YES completion:nil];

         }
         else
         {
             [self showAlert:[dictionaryReceived objectForKey: @"msg"]];
         }
     }
     else if (tag == WEBSERVICE_STUDENTS_GROUP_LIST)
     {
         if ([dictionaryReceived objectForKey: @"status"] == 0) {
             //
         }
         else
         {
             NSMutableArray * arrayFromMainDictionaryWithPartners = [dictionaryReceived objectForKey:@"partners"];
             for (int i = 0; i<[arrayFromMainDictionaryWithPartners count]; i++) {
                 NSDictionary * dictionaryWithEachIndex =[arrayFromMainDictionaryWithPartners objectAtIndex:i];
                 NSLog(@"aspectListArrayDict  %@",dictionaryWithEachIndex);
                 [studyPartnersListArray addObject:dictionaryWithEachIndex ];
            }
             if ([studyPartnersListArray count] != 0) {
                 [_scheduleTypeTableView reloadData];
                 if ([selectedScheduleTypeString isEqualToString:@"Unique Atudy groups"]) {
                     [self onSelectingTypeUniqueStudyGroups];
                 }
                 //                     _heightConstraintForAspectView.constant = aspectListArray.count * 40;
                 //                     _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 400);
             }

             
             NSMutableArray * arrayFromMainDictionaryWithStudentList = [dictionaryReceived objectForKey:@"students"];
             for (int i = 0; i<[arrayFromMainDictionaryWithStudentList count]; i++) {
                 NSDictionary * dictionaryWithEachIndex =[arrayFromMainDictionaryWithStudentList objectAtIndex:i];
                 NSLog(@"aspectListArrayDict  %@",dictionaryWithEachIndex);
                 [studentListArray addObject:dictionaryWithEachIndex ];
             }
             if ([studentListArray count] != 0) {
                 [_scheduleTypeTableView reloadData];
                 if ([selectedScheduleTypeString isEqualToString:@"Unique"]) {
                     [self onSelectingTypeUnique];
                 }
                 //                     _heightConstraintForAspectView.constant = aspectListArray.count * 40;
                 //                     _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 400);
             }

             
         }
     }

    [self mStopIndicater];
}

#pragma mark - -*********************
#pragma mark Activity Indicater
#pragma mark - -*********************

-(void)mStartIndicater
{
    
    loader_image=[ELR_loaders_ Start_loader:CGRectMake(([[UIScreen mainScreen]bounds].size.width-85)/2,[[UIScreen mainScreen]bounds].size.height/2,85,85)];
    [self.view addSubview:loader_image];
    
    
    
}

#pragma mark - -*********************
#pragma mark Stop Indicater
#pragma mark - -*********************

-(void)mStopIndicater
{
    
    [loader_image removeFromSuperview];
    
    
    
}


#pragma mark - TableView Delegates & Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section
{
    if (tableView.tag == GROUP_TABLE_TAG) {
    return [groupArray count];
    }
    else if(tableView.tag == ASPECT_TABLE_TAG)
    {
        return [aspectListArray count];
    }
    else if(tableView.tag == SCHEDULE_TABLE_TAG)
    {
        return [scheduleTypeArray count];
    }
    else if(tableView.tag == STUDENT_TABLE_TAG)
    {
        if ([selectedScheduleTypeString isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Unique" value:@"" table:nil]]) {
            return [studentListArray count];
        }
        else
        {
            return [studyPartnersListArray count];
        }
    }
    else
    {
        return 4;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView.tag == GROUP_TABLE_TAG) {
    
    cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        if (indexPath.row < groupArray.count-2) {
            NSLog(@"group %d",indexPath.row);
            cell.textLabel.text =[[groupArray objectAtIndex:indexPath.row]objectForKey:@"name"];
            if ([selectedItems indexOfObject:[[groupArray objectAtIndex:indexPath.row]objectForKey:@"id"]] != NSNotFound) {
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            } else {
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            }
        }
        else{
            NSLog(@"group %d",indexPath.row);
            cell.textLabel.text =[groupArray objectAtIndex:indexPath.row];
            if ([cell.textLabel.text isEqualToString:selectedGroupString]) {
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            }
            else {
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            }
        }
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    
        }
    else if (tableView.tag == ASPECT_TABLE_TAG)
    {
        AspectTableViewCell *aspectCell;
        aspectCell= [tableView dequeueReusableCellWithIdentifier: @"aspectTableViewCell"];
        if (aspectCell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AspectTableViewCell" owner:self options:nil];
            aspectCell = [nib objectAtIndex:0];
            
        }
        NSDictionary * aspectdictionaryAtEachIndex = [aspectListArray objectAtIndex:indexPath.row];
        NSDictionary * aspectdictionary = [aspectdictionaryAtEachIndex objectForKey:@"Aspect"];
        aspectCell.aspectsNameLabel.text = [aspectdictionary objectForKey:@"name"];
        aspectCell.checkBoxButton.tag = ASPECT_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG + indexPath.row;
        if ([aspectListSelectedArray containsObject:aspectListArray [indexPath.row]]) {
            [aspectCell.checkBoxButton setImage:[UIImage imageNamed: @"click" ] forState:UIControlStateNormal];
        }
        else
        {
             [aspectCell.checkBoxButton setImage:[UIImage imageNamed: @"nonclick" ] forState:UIControlStateNormal];
        }
        
        aspectCell.selectionStyle = UITableViewCellSelectionStyleDefault;
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor clearColor];
        [aspectCell setSelectedBackgroundView:bgColorView];

        
        return aspectCell;
    }
    else if (tableView.tag == SCHEDULE_TABLE_TAG)
    {
        ScheduleTypeTableViewCell *scheduleTypeTableViewCell;
        scheduleTypeTableViewCell= [tableView dequeueReusableCellWithIdentifier: @"scheduleTypeTableViewCell"];
        if (scheduleTypeTableViewCell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ScheduleTypeTableViewCell" owner:self options:nil];
            scheduleTypeTableViewCell = [nib objectAtIndex:0];
            
        }
//        NSDictionary * aspectdictionaryAtEachIndex = [aspectListArray objectAtIndex:indexPath.row];
//        NSDictionary * aspectdictionary = [aspectdictionaryAtEachIndex objectForKey:@"Aspect"];
        
        scheduleTypeTableViewCell.scheduleTypeNameLabel.text = [scheduleTypeArray objectAtIndex:indexPath.row];
        scheduleTypeTableViewCell.scheduleTypeRadioButton.tag = SCHEDULE_TABLE_VIEW_CELL_RADIO_BUTTON_TAG + indexPath.row;
        
        if ([[scheduleTypeArray objectAtIndex:indexPath.row] isEqualToString:selectedScheduleTypeString]) {
            [scheduleTypeTableViewCell.scheduleTypeRadioButton setImage:[UIImage imageNamed:@"grp_selected"] forState:UIControlStateNormal];
        }
        else
        {
            [scheduleTypeTableViewCell.scheduleTypeRadioButton setImage:[UIImage imageNamed:@"grp_unselected"] forState:UIControlStateNormal];
        }
        
        scheduleTypeTableViewCell.selectionStyle = UITableViewCellSelectionStyleDefault;
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor clearColor];
        [scheduleTypeTableViewCell setSelectedBackgroundView:bgColorView];
        
        return scheduleTypeTableViewCell;
    }
    else if (tableView.tag == STUDENT_TABLE_TAG)
    {
         AspectTableViewCell *aspectCell;
        if ([selectedScheduleTypeString isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Unique Study groups" value:@"" table:nil]]) {
           
            aspectCell= [tableView dequeueReusableCellWithIdentifier: @"aspectTableViewCell"];
            if (aspectCell == nil) {
                
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AspectTableViewCell" owner:self options:nil];
                aspectCell = [nib objectAtIndex:0];
                
            }
        NSDictionary * studyPartnersdictionaryAtEachIndex = [studyPartnersListArray objectAtIndex:indexPath.row];
        
        NSLog(@"%@",studyPartnersdictionaryAtEachIndex);
//        NSDictionary * ; = [aspectdictionaryAtEachIndex objectForKey:@"Aspect"];
        aspectCell.aspectsNameLabel.text = [studyPartnersdictionaryAtEachIndex objectForKey:@"name"];
        aspectCell.checkBoxButton.tag = STUDY_PARTNERS_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG + indexPath.row;
            
            if ([studyPartnersListSelectedArray containsObject:studyPartnersListArray [indexPath.row]]) {
                [aspectCell.checkBoxButton setImage:[UIImage imageNamed: @"click" ] forState:UIControlStateNormal];
            }
            else
            {
                [aspectCell.checkBoxButton setImage:[UIImage imageNamed: @"nonclick" ] forState:UIControlStateNormal];
            }

        }
        else
        {
            
            aspectCell= [tableView dequeueReusableCellWithIdentifier: @"aspectTableViewCell"];
            if (aspectCell == nil) {
                
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AspectTableViewCell" owner:self options:nil];
                aspectCell = [nib objectAtIndex:0];
                
            }

            NSDictionary * studentdictionaryAtEachIndex = [studentListArray objectAtIndex:indexPath.row];
            
            NSLog(@"%@",studentdictionaryAtEachIndex);
            //        NSDictionary * ; = [aspectdictionaryAtEachIndex objectForKey:@"Aspect"];
            aspectCell.aspectsNameLabel.text = [studentdictionaryAtEachIndex objectForKey:@"name"];
            aspectCell.checkBoxButton.tag = STUDY_PARTNERS_TABLE_VIEW_CELL_CHECK_BOX_BUTTON_TAG + indexPath.row;
            
            if ([studentListSelectedArray containsObject:studentListArray [indexPath.row]]) {
                [aspectCell.checkBoxButton setImage:[UIImage imageNamed: @"click" ] forState:UIControlStateNormal];
            }
            else
            {
                [aspectCell.checkBoxButton setImage:[UIImage imageNamed: @"nonclick" ] forState:UIControlStateNormal];
            }
//
        }
        
        aspectCell.selectionStyle = UITableViewCellSelectionStyleDefault;
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor clearColor];
        [aspectCell setSelectedBackgroundView:bgColorView];
        
        return aspectCell;
    }

    
    
    

    else
    {
        
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor clearColor];
    [cell setSelectedBackgroundView:bgColorView];
    
   return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == GROUP_TABLE_TAG) {
        if (indexPath.row < groupArray.count - 2) {
            selectedGroupString = @"";
            if ([selectedItems indexOfObject:[[groupArray objectAtIndex:indexPath.row]objectForKey:@"id"]] != NSNotFound) {
                [selectedItems removeObject:[[groupArray objectAtIndex:indexPath.row]objectForKey:@"id"]];
            } else {
            [selectedItems addObject:[[groupArray objectAtIndex:indexPath.row]objectForKey:@"id"]];
            }
        }
        else
        {
            [selectedItems removeAllObjects];
            selectedGroupString = [groupArray objectAtIndex:indexPath.row];
        }
    [tableView reloadData];
    }
   // NSNumber *row = [NSNumber numberWithInt:indexPath.row];
//    NSUInteger index = [selectedItems indexOfObject:indexPath.row];
//    if (index != NSNotFound) {
//        [selectedItems removeObjectAtIndex:index];
//        [(UITableViewCell *) setAccessoryType:UITableViewCellAccessoryNone];
//    } else {
//        [selectedItems addObject:row];
//        [(UITableViewCell *)(recognizer.view) setAccessoryType:UITableViewCellAccessoryCheckmark];
//    }
//
//    NSString *cityString = [addedTocityArray objectAtIndex:indexPath.row];
//    NSUserDefaults * cityDefault=[NSUserDefaults standardUserDefaults];
//    [cityDefault setObject:cityString forKey:@"city"];
//    NSString *cityIdString = [addedToCityIdArray objectAtIndex:indexPath.row];
//    NSUserDefaults *cityIdDefault=[NSUserDefaults standardUserDefaults];
//    [cityIdDefault setObject:cityIdString forKey:@"cityid"];
//    [self dismissViewControllerAnimated:YES completion:nil];
    //[self performSegueWithIdentifier:@"CityToSignUp" sender:nil];
}


#pragma mark - UIPickerView Delegates

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == SELECT_COURSE_TEXTFIELD_TAG) {
    return [courseArray count];
    }
    else  if (pickerView.tag == SELECT_GROUP_TEXTFIELD_TAG) {
        return [groupArray count] + 2;
    }
    else  if (pickerView.tag == SCHEDULE_TYPE_TEXTFIELD_TAG) {
        return [typeArray count];
    }
    else
    {
        return 0;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == SELECT_COURSE_TEXTFIELD_TAG) {
        if(row == 0)
        {
            _selectCourseTextField.text = [courseArray objectAtIndex:row];
            courseIdSelected = @"";
        }
        else
        {
        selectedIndexOfCourse = row;
          _selectCourseTextField.text=[[courseArray objectAtIndex:row] objectForKey:@"COU_Name"];
        courseIdSelected = [[courseArray objectAtIndex:row] objectForKey:@"id"];
        }
    }
    else  if (pickerView.tag == SELECT_GROUP_TEXTFIELD_TAG) {
//        NSInteger index = [selectedItems indexOfObject:[NSString stringWithFormat:@"%ld", (long)row ]];
//        if (index != NSNotFound) {
//            [selectedItems removeObjectAtIndex:index];
//           // [(UITableViewCell *)(recognizer.view) setAccessoryType:UITableViewCellAccessoryNone];
//        } else {
//            [selectedItems addObject:[NSString stringWithFormat:@"%ld", (long)row ]];
//           // [(UITableViewCell *)(recognizer.view) setAccessoryType:UITableViewCellAccessoryCheckmark];
//        }
//
//        _selectGroupTextField.text=[courseArray objectAtIndex:row];
    }
    else
    {
        selectedIndexOfScheduleType = row;
        _scheduleTypeTextField.text=[typeArray objectAtIndex:row];
        
    }

  
//    [pickerView setHidden:YES];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == SELECT_COURSE_TEXTFIELD_TAG) {
        if (row == 0) {
            return [courseArray objectAtIndex:row];
        }
        else
        {
         return [[courseArray objectAtIndex:row]objectForKey:@"COU_Name"];
        }
    }
    else   {
        return [typeArray objectAtIndex:row];
    }
//    else
//    {
//    return [[courseArray objectAtIndex:row]objectForKey:@"COU_Name"] ;
//    }
   
   
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    return sectionWidth;
}


//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    UITableViewCell *cell = (UITableViewCell *)view;
//    if (pickerView.tag == SELECT_GROUP_TEXTFIELD_TAG)
//    {
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//        [cell setBackgroundColor:[UIColor clearColor]];
//        [cell setBounds: CGRectMake(0, 0, cell.frame.size.width -20 , 44)];
//        
//    }
//    
//    if ([selectedItems indexOfObject:[NSNumber numberWithInt:row]] != NSNotFound) {
//        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//    } else {
//        [cell setAccessoryType:UITableViewCellAccessoryNone];
//    }
//    cell.textLabel.text = [[groupArray objectAtIndex:row]objectForKey:@"name"] ;
//    cell.tag = row;
//    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleSelection:)];
//    singleTapGestureRecognizer.numberOfTapsRequired = 1;
//    [cell addGestureRecognizer:singleTapGestureRecognizer];
//        cell.userInteractionEnabled = YES;
//    return cell;
//    }
//    else
//    {
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//            [cell setBackgroundColor:[UIColor clearColor]];
//            [cell setBounds: CGRectMake(0, 0, cell.frame.size.width -20 , 44)];
//            
//        }
//        if (pickerView.tag == SELECT_COURSE_TEXTFIELD_TAG) {
//        cell.textLabel.text =[[groupArray objectAtIndex:row]objectForKey:@"name"] ;
//        }
//        else{
//            cell.textLabel.text = [[groupArray objectAtIndex:row]objectForKey:@"name"] ;
//        }
//        cell.tag = row;
//        return cell;
//
//    }
//}
//
- (void)toggleSelection:(UITapGestureRecognizer *)recognizer {
   }

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}


#pragma mark - Navigation Bar


-(void)Navigation_bar
{
    
    
    
    
    
    //    user_pic = [[UIImageView alloc] init];
    //    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"USR_image"]]);
    //    [user_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"customer_logo"]]]
    //                placeholderImage:[UIImage imageNamed:@"profile9.png"]];
    //
    //    user_pic.frame=CGRectMake(50, 0, 30, 30);
    //    user_pic.layer.cornerRadius=30*0.5;
    //    user_pic.layer.borderColor=[UIColor clearColor].CGColor;
    //    user_pic.layer.borderWidth=0;
    //    user_pic.clipsToBounds=YES;
    //    user_pic.userInteractionEnabled=YES;
    //    user_pic.contentMode = UIViewContentModeScaleToFill;
    //    user_pic.backgroundColor=[UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
    //    UIBarButtonItem *imageButton = [[UIBarButtonItem alloc] initWithCustomView:user_pic];
    //    self.navigationItem.rightBarButtonItem = imageButton;
    //
    //    UITapGestureRecognizer *tap_action_slider = [[UITapGestureRecognizer alloc]
    //                                                 initWithTarget:self
    //                                                 action:@selector(Action_slider)];
    //
    //    [user_pic addGestureRecognizer:tap_action_slider];
    
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName:[Font_Face_Controller opensanssemibold:15],
                                                                    NSForegroundColorAttributeName: [UIColor blackColor]
                                                                    };
    
    
    
    
    
    
    //    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
    
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 //   UIImage *butImage = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    CGSize size1;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=11){
        size1 = CGSizeMake(20, 20);
    } else {
        size1 = CGSizeMake(30, 30);
    }
    
    UIImage *butImage = [ImageCustomClass image:[UIImage imageNamed:@"back-2"] resize:size1];
    

    [button setBackgroundImage:butImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    //Edit Activity
    
    
    
    UIButton *tickbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *butImage1 = [[UIImage imageNamed:@"tickForHeader"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    //        [button1 setBackgroundImage:butImage1 forState:UIControlStateNormal];
    [tickbutton setImage:butImage1 forState:UIControlStateNormal];
    [tickbutton addTarget:self action:@selector(tickButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    tickbutton.frame = CGRectMake(0, 0, 20, 20);
    [tickbutton setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    UIBarButtonItem *tickBarButton = [[UIBarButtonItem alloc] initWithCustomView:tickbutton];
//    self.navigationItem.rightBarButtonItem = backButton1;
    
    
    UIButton *buttonToDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *butImageDelete = [[UIImage imageNamed:@"deleteIcon"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    //        [button1 setBackgroundImage:butImage1 forState:UIControlStateNormal];
    [buttonToDelete setImage:butImageDelete forState:UIControlStateNormal];
    [buttonToDelete addTarget:self action:@selector(webserviceToDelete) forControlEvents:UIControlEventTouchUpInside];
    buttonToDelete.frame = CGRectMake(0, 0, 20, 20);
    [buttonToDelete setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    UIBarButtonItem *barbuttonToDelete = [[UIBarButtonItem alloc] initWithCustomView:buttonToDelete];
    
    if (_isEditActivity) {
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:tickBarButton, barbuttonToDelete, nil]];
        self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Edit Activity" value:@"" table:nil] ;

    }
    else
    {
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:tickBarButton, nil]];
        self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Add Activity" value:@"" table:nil] ;

    }
    
    //  [[self navigationItem] setBackBarButtonItem:backButton1];
    
    
    
    //    }
    //    else
    //    {
    //        self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule" value:@"" table:nil] ;
    //    }
    
}

#pragma mark - API Protocol

-(void)dataIsReceived:(id)dataReceived withMsgType:(int)msgType
{
    if (msgType == WEBSERVICE_TO_GET_ACTIVITY_INFO_WHILE_EDITING) {
        [self mStopIndicater];
        NSLog(@"data received %@",dataReceived);
        [self ParseArray:dataReceived withTag:WEBSERVICE_TO_GET_ACTIVITY_INFO_WHILE_EDITING];
    }
    else if (msgType == WEBSERVICE_ASPECT_LIST)
    {
         [self ParseArray:dataReceived withTag:WEBSERVICE_ASPECT_LIST];
    }
    else if (msgType == WEBSERVICE_GROUPS)
    {
        [self ParseArray:dataReceived withTag:WEBSERVICE_GROUPS];
    }
    else if (msgType == WEBSERVICE_STUDENTS_GROUP_LIST)
    {
        [self ParseArray:dataReceived withTag:WEBSERVICE_STUDENTS_GROUP_LIST];
    }
    else if (msgType == WEBSERVICE_STUDENTS_GROUP_LIST)
    {
        [self ParseArray:dataReceived withTag:WEBSERVICE_STUDENTS_GROUP_LIST];
    }
    else if (msgType == WEBSERVICE_STUDENTS_GROUP_LIST)
    {
        [self ParseArray:dataReceived withTag:WEBSERVICE_ADD_ACTIVITY_FOR_TEACHER];
    }

    
    

}
#pragma mark - UITextView Delegates

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView isEqual: _descriptionTextView]) {
//        _mainScrollView.contentOffset = CGPointMake(0, 200);
        _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 800);
        CGPoint bottomOffset = CGPointMake(0, self.mainScrollView.contentSize.height - self.mainScrollView.bounds.size.height);
        [self.mainScrollView setContentOffset:bottomOffset animated:YES];
        if ([textView.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil]]) {
            textView.text = @"";
        }
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600);
    CGPoint bottomOffset = CGPointMake(0, self.mainScrollView.contentSize.height - self.mainScrollView.bounds.size.height);
    [self.mainScrollView setContentOffset:bottomOffset animated:YES];
    if ([textView.text isEqualToString:@""]) {
        textView.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Enter some Description" value:@"" table:nil];
    }
}

#pragma mark - UITextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    pickerViewForTextfields.tag = textField.tag;
    datePicker.tag = textField.tag;
    timePicker.tag = textField.tag;
    
    if (textField.tag == SELECT_COURSE_TEXTFIELD_TAG) {
        if (selectedIndexOfCourse == 0) {
            //
        }
        else
        {
       _selectCourseTextField.text=[[courseArray objectAtIndex:selectedIndexOfCourse] objectForKey:@"COU_Name"];
        courseIdSelected = [[courseArray objectAtIndex:selectedIndexOfCourse] objectForKey:@"id"];
        }
    }
    if (textField.tag == SCHEDULE_TYPE_TEXTFIELD_TAG) {
        textField.text =  [typeArray objectAtIndex:selectedIndexOfScheduleType];
    }
    if (textField.tag == START_DATE_TEXTFIELD_TAG || textField.tag == START_TIME_TEXTFIELD_TAG || textField.tag == END_DATE_TEXTFIELD_TAG || textField.tag == END_TIME_TEXTFIELD_TAG) {
        [self LabelTitle:nil];
    }

    if ([textField isEqual: _descriptionTextView]) {
        _mainScrollView.contentOffset = CGPointMake(0, 200);
    }
    else if ([textField isEqual:_scheduleTitleTextField])
    {    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 650);
        if ([_scheduleTitleTextField.text isEqualToString:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule Title" value:@"" table:nil]]) {
            _scheduleTitleTextField.text = @"";
            
        }
              CGPoint bottomOffset = CGPointMake(0, self.mainScrollView.contentSize.height - self.mainScrollView.bounds.size.height);
        [self.mainScrollView setContentOffset:bottomOffset animated:YES];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:_scheduleTitleTextField])
    {
        
        if ([_scheduleTitleTextField.text isEqualToString:@""]) {
            _scheduleTitleTextField.text =[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule Title" value:@"" table:nil];
            
        }

        _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightConstraintForAspectView.constant + self.heightConstraintForExaminationTypeView.constant + 600);
    }

    [textField resignFirstResponder];
//      _mainScrollView.contentOffset = CGPointMake(0, 0);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
#pragma mark - Format Date

-(NSString *) formatDateWithString : (NSString *) dateStringReceived
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    
    NSDate *startDate = [dateFormat dateFromString:dateStringReceived];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *startDateString = [dateFormat stringFromDate:startDate];
    
    return startDateString;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
