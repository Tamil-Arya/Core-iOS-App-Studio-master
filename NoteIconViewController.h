//
//  NoteIconViewController.h
//  XIBTest
//
//  Created by jeff ayan on 02/01/17.
//  Copyright © 2017 jeff ayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "Utilities.h"
#import "NoteIconTableViewCell.h"
#import "ViewFoodMenuWebViewViewController.h"
#import "AddActivityViewController.h"
#import "ViewAbsentNoteViewController.h"
#import "AddVacationViewController.h"
#import "AddAbsentNotesViewController.h"
#import "AddActivityForParentsViewController.h"
#import "MakeWholeDayAsLeaveViewController.h"
#import "AddActivityForStudentViewController.h"
#import "APIWithProtocol.h"


@interface NoteIconViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,AFURLRequestSerialization,UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,APIProtocol>
{
   __weak IBOutlet UITableView *NoteIconTableView;
    NSMutableArray * arrayWithTitleOfEvents, *arrayWithStartDateOfEvents, *arrayWithendDateOfEvents , * arrayWithDictionariesInFoodMenu, * arrayWithSchemaGroupsDictionary;
    UIImageView *loader_image;
    UIPickerView *pickerView;
    NSMutableArray *courseArray;
    UIToolbar *myToolbar;
    int absentNoteCount;
    APIWithProtocol * api;
}

@property (strong,nonatomic) NSMutableData * responsesData;
@property (strong) NSString * dateStringselected;
@end
 
