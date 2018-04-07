//
//  AddAbsentNotesViewController.m
//  SampleForSCM
//
//  Created by BALACHANDAR on 15/01/17.
//  Copyright © 2017 BALACHANDAR. All rights reserved.
//

#import "AddAbsentNotesViewController.h"
#import "API.h"
#import "Utilities.h"
#import "JSON.h"
#import "ELR_loaders_.h"
#import "LogoutManager.h"
@interface AddAbsentNotesViewController ()

@end

@implementation AddAbsentNotesViewController


static NSInteger  FROM_DATE_TEXTFIELD_TAG = 201;
static NSInteger  TO_DATE_TEXTFIELD_TAG = 202;
static NSInteger  TYPE_TEXTFIELD_TAG = 203;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    
    
    [self restoreToDefaults];
    [self addDatePickerView];
    [self addPickerView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{    [super viewWillAppear:YES];

    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

   [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
    [self changeLanguage];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) restoreToDefaults
{
    typeArray = [[NSMutableArray alloc]initWithObjects:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Sickness" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Leave" value:@"" table:nil],[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Other reasons" value:@"" table:nil], nil];

    _fromDateTextField.tag = FROM_DATE_TEXTFIELD_TAG;
    _toDateTextField.tag = TO_DATE_TEXTFIELD_TAG;
    _typeSelectionTextField.tag = TYPE_TEXTFIELD_TAG;
    
    _typeSelectionTextField.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Sickness" value:@"" table:nil];
    
    _headerLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent Note" value:@"" table:nil];
}



-(void) changeLanguage
{
    _dateLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Date" value:@"" table:nil];
    _toLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"To" value:@"" table:nil];
    _typeLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Type" value:@"" table:nil];
    _noteLabe.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Note" value:@"" table:nil];
    _makeAsAbsentLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Make whole day as absent" value:@"" table:nil];
    [_doneButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Done" value:@"" table:nil] forState:UIControlStateNormal] ;
    [_cancelButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Cancel" value:@"" table:nil] forState:UIControlStateNormal] ;

}

#pragma mark - Picker View

-(void)addPickerView
{
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    [pickerView setDataSource: self];
    [pickerView setDelegate: self];
    pickerView.showsSelectionIndicator = YES;
    _typeSelectionTextField.inputView = pickerView;
   
    
    
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    _typeSelectionTextField.inputAccessoryView = myToolbar;
   
}


-(void)addDatePickerView
{
    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0,10, 150)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    datePicker.hidden=NO;
    datePicker.date=[NSDate date];
    
    [datePicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
    //    [self.view addSubview:datePicker];
    
    
    _fromDateTextField.inputView = datePicker;
    _toDateTextField.inputView = datePicker;
    
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(doneButtonClicked)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    _fromDateTextField.inputAccessoryView = myToolbar;
    _toDateTextField.inputAccessoryView = myToolbar;
    
    _notesTextView.inputAccessoryView = myToolbar;
}

-(void)doneButtonClicked
{
    [_fromDateTextField resignFirstResponder];
    [_toDateTextField resignFirstResponder];
    [_notesTextView resignFirstResponder];
    [_typeSelectionTextField resignFirstResponder];
}
-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    
    if (datePicker.tag == FROM_DATE_TEXTFIELD_TAG) {
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        _fromDateTextField.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
    }
    else if(datePicker.tag == TO_DATE_TEXTFIELD_TAG)
    {
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        _toDateTextField.text=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
        
    }
       //assign text to label
}


#pragma mark - General

-(BOOL) checkIfStartDateIsGreater
{
    NSString * startDateString = [NSString stringWithFormat:@"%@", _fromDateTextField.text];
    NSString * endDateString = [NSString stringWithFormat:@"%@", _toDateTextField.text];
    NSDate* startdate = [self convertSitingToDate:startDateString];
    NSDate* enddate = [self convertSitingToDate:endDateString];
//    NSTimeInterval distanceBetweenDates = [enddate timeIntervalSinceDate:startdate];
//    double secondsInMinute = 60;
//    NSInteger secondsBetweenDates = distanceBetweenDates / secondsInMinute;
    
//    if (secondsBetweenDates == 0)
//        return YES;
//    else if (secondsBetweenDates < 0)
//        return YES;
//    else
//        return NO;
    if ([_toDateTextField.text isEqualToString:@""]) {
        return YES;
    }
    else
    {
        if ([startdate compare:enddate] == NSOrderedAscending) {
            return YES;
        }
        else if ([startdate compare:enddate] == NSOrderedDescending)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
}

-(NSDate *) convertSitingToDate : (NSString *) dateString
{
    //    NSString *dateStr = @"Tue, 25 May 2010 12:53:58 +0000";
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [dateFormat dateFromString:dateString];
    
    return date;
}

-(void) showAlertWithMessgae : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIElement Actions

- (IBAction)makeAsAbsentSwitchValueChanged:(UISwitch *)sender {
}


- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneButtonclicked:(id)sender {
    if ([_fromDateTextField.text isEqualToString:@""]) {
        
        [self showAlertWithMessgae:@"Please select from date"];
    }
    else if ([_typeSelectionTextField.text isEqualToString:@""])
    {
        [self showAlertWithMessgae:@"Please select Type"];
    }
    else if ([_notesTextView.text isEqualToString:@""] || [_notesTextView.text isEqualToString:@"Type extra detail here"])
    {
        [self showAlertWithMessgae:@"Please enter description"];
    }
    else if (![self checkIfStartDateIsGreater])
    {
        [self showAlertWithMessgae:@"End date should be recent"];
    }
    else
    {
        NSLog(@"Success");
        [self CallTheServer_Absent_note_Update_API];
    }

}


#pragma mark - -*********************
#pragma mark Call get_drafts_API Method
#pragma mark - -*********************


-(void)CallTheServer_Absent_note_Update_API
{
    if ([API connectedToInternet]==YES) {
        
        [self mStartIndicater];
        NSString *Leave_type;
    

        
        if ([_typeSelectionTextField.text isEqualToString:@"Sickness"] || [_typeSelectionTextField.text isEqualToString:@"Sjukdom"]) {
            Leave_type=@"sick";
            
        }
        else if ([_typeSelectionTextField.text isEqualToString:@"Leave"] || [_typeSelectionTextField.text isEqualToString:@"Ledighet"])
        {
            Leave_type=@"leave";
        }
        
        else if ([_typeSelectionTextField.text isEqualToString:@"Other reasons"] || [_typeSelectionTextField.text isEqualToString:@"Andra skäl"])
        {
            Leave_type=@"other";
        }
        else
        {
            Leave_type=@"other";
        }
        
        NSString * Token_value;
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]){
            Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_authentication_token"];
        }
        else{
         Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"];
        }
        

     
         NSString *responseString = [API makeCallPostData_ALL:[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@&to_sickdate=%@&sick_description=%@&leave_type=%@&approved=%hhd",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],_fromDateTextField.text,_toDateTextField.text,_notesTextView.text,Leave_type,_absentSwitch.isOn]:[NSString stringWithFormat:@"%@retrivals/update_absence_note",[Utilities API_link_url_subDomain]]];
        
        
        
        NSDictionary *responseDict = [responseString JSONValue];
        
         NSLog(@"request %@",[NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@&to_sickdate=%@&sick_description=%@&leave_type=%@&approved=%hhd",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],_fromDateTextField.text,_toDateTextField.text,_notesTextView.text,Leave_type,_absentSwitch.isOn]);
        
        NSLog(@"responseDict %@",responseDict);
        
       
        if ([[responseDict valueForKey:@"status"] isEqualToString:@"true"]) {
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:[responseDict valueForKey:@"message"]  message:nil  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else if([[responseDict valueForKey:@"message"] isEqualToString:@"Authentication Failed"]){
            [[LogoutManager sharedManager] forceLogoutForChangePassword];
        }
        
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"An error has occurred" value:@"" table:nil] message:[responseDict valueForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
            [alert show];
            
        }
        
        
        
    }
    
    else
    {
        
        
        
        alert = [[UIAlertView alloc] initWithTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Error" value:@"" table:nil] message:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Not connected to the internet" value:@"" table:nil] delegate:self cancelButtonTitle:nil otherButtonTitles:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Ok" value:@"" table:nil], nil];
        [alert show];
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


#pragma mark - UIPickerView Delegates

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [typeArray count];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == TYPE_TEXTFIELD_TAG) {
        _typeSelectionTextField.text=[typeArray objectAtIndex:row];
    }
   
    
    //    [pickerView removeFromSuperview];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == TYPE_TEXTFIELD_TAG) {
        return [typeArray objectAtIndex:row];
    }
    return @"";
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    return sectionWidth;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UITableViewCell *cell = (UITableViewCell *)view;
           if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setBounds: CGRectMake(0, 0, cell.frame.size.width -20 , 44)];
            
        }
        if (pickerView.tag == TYPE_TEXTFIELD_TAG) {
            cell.textLabel.text = [typeArray objectAtIndex:row];
        }
        cell.tag = row;
        return cell;
        
    
}


#pragma mark - UITextView Delegates

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView isEqual: _notesTextView]) {
        _mainScrollView.contentOffset = CGPointMake(0, 170);
        if ([textView.text isEqualToString:@"Type extra detail here"]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
        }
    }
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Type Extra detail here";
        textView.textColor = [UIColor lightGrayColor];
    }
    _mainScrollView.contentOffset = CGPointMake(0, 0);
}

#pragma mark - UITextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    pickerView.tag = textField.tag;
    datePicker.tag = textField.tag;
    
    [self LabelTitle:textField];
    
    if (textField.tag == TO_DATE_TEXTFIELD_TAG) {
        
        [datePicker setMinimumDate:[self convertSitingToDate:_fromDateTextField.text]];
    }
    else if ([textField isEqual:_typeSelectionTextField])
    {
        
    }
    else
    {
        
    }
//    if ([textField isEqual: _scheduleTitleTextField]) {
//        _mainScrollView.contentOffset = CGPointMake(0, 200);
//        if ([textField.text isEqualToString:@"Title"]) {
//            textField.text = @"";
//        }
//    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
//    _mainScrollView.contentOffset = CGPointMake(0, 0);
//    if ([textField isEqual: _scheduleTitleTextField]) {
//        if ([textField.text isEqualToString:@""]) {
//            textField.text = @"Title";
//        }
//    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return  [textField resignFirstResponder];
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
