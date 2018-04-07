//
//  DayViewController.h
//  Calendar
//
//  Copyright © 2016 Julien Martin. All rights reserved.
//

#import "MGCDayPlannerEKViewController.h"
#import "MainViewController.h"

@class DayViewController;

@protocol DayViewControllerDelegate <MGCDayPlannerEKViewControllerDelegate, CalendarViewControllerDelegate, UIViewControllerTransitioningDelegate>

@optional

- (void)dayViewController:(DayViewController *)controller didSelectdayAtDate:(NSDate*)date;

@end



@interface DayViewController : MGCDayPlannerEKViewController <CalendarViewControllerNavigation>

@property (nonatomic, weak) id<DayViewControllerDelegate> delegate;

@end

