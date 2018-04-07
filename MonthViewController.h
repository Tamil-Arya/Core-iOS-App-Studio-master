//
//  MonthViewController.h
//  CalendarDemo - Graphical Calendars Library for iOS
//
//  Copyright (c) 2014-2015 Julien Martin. All rights reserved.
//

#import "MGCMonthPlannerEKViewController.h"
#import "MainViewController.h"

@class MonthViewController ;

@protocol MonthViewControllerDelegate<CalendarViewControllerDelegate>

@optional

- (void)monthViewController:(MonthViewController *)controller didSelectdayAtDate:(NSDate*)date;

@end

@interface MonthViewController : MGCMonthPlannerEKViewController <CalendarViewControllerNavigation>


@property (nonatomic, weak) id<MonthViewControllerDelegate> delegate;


//@property (nonatomic, weak) id<CalendarViewControllerDelegate> delegate;

@end
