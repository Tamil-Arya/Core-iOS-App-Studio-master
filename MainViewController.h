//
//  MainViewController.h
//  CalendarDemo - Graphical Calendars Library for iOS
//
//  Copyright (c) 2014-2015 Julien Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKitUI/EventKitUI.h>
#import <AFNetworking/AFNetworking.h>
#import "LunchInformationViewController.h"
#import "ViewFoodMenuPdfViewController.h"
#import "NoteIconViewController.h"
#import "AddFoodNotesViewController.h"
#import "MFSideMenu.h"


@protocol CalendarViewControllerNavigation <NSObject>

@property (nonatomic, readonly) NSDate* centerDate;

- (void)moveToDate:(NSDate*)date animated:(BOOL)animated;
- (void)moveToNextPageAnimated:(BOOL)animated;
- (void)moveToPreviousPageAnimated:(BOOL)animated;

@optional

@property (nonatomic) NSSet* visibleCalendars;

@end


typedef  UIViewController<CalendarViewControllerNavigation> CalendarViewController;


@protocol CalendarViewControllerDelegate <NSObject>

@optional

- (void)calendarViewController:(CalendarViewController*)controller didShowDate:(NSDate*)date;
- (void)calendarViewController:(CalendarViewController*)controller didSelectEvent:(EKEvent*)event;

@end



@interface MainViewController : UIViewController<CalendarViewControllerDelegate, EKCalendarChooserDelegate,NSURLSessionDelegate>
{
    NSDate * dateSelected;
    int CurrentSelectedButtonTag;
    NSMutableArray * arrayWithDatesFromWebService, * arrayWithMonthsInMonthView, * arrayWithWeeksInWeekWebService,*arrayWithdaysInDayWebService, * arrayWithEventIdAdded , * arrayWithEventStartDate , * arrayWithEventendDate;
    BOOL isWebServiceToBeHit;
    UIImageView * loader_image, * user_pic;
}
@property (nonatomic) CalendarViewController* calendarViewController;

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UILabel *currentDateLabel;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *settingsButtonItem;
@property (nonatomic, weak) IBOutlet UISegmentedControl *viewChooser;
@property (strong, nonatomic) IBOutlet UILabel *dsiplayDateLabel;
@property (strong, nonatomic) IBOutlet UIButton *monthButton;
@property (strong, nonatomic) IBOutlet UIButton *weekButton;
@property (strong, nonatomic) IBOutlet UIButton *dayButton;
@property (strong, nonatomic) IBOutlet UIButton *todayButton;
@property (strong, nonatomic) IBOutlet UIButton *lunchInformatioButton;
@property (strong, nonatomic) IBOutlet UIButton *foodMenuButton;




@property NSMutableData * responsesData;



@property (nonatomic) NSCalendar *calendar;
@property (nonatomic) EKEventStore *eventStore;

@end
