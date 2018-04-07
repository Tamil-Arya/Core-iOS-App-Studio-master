//
//  MainViewController.m
//  CalendarDemo - Graphical Calendars Library for iOS
//
//  Copyright (c) 2014-2015 Julien Martin. All rights reserved.
//

#import "MainViewController.h"
#import "WeekViewController.h"
#import "MonthViewController.h"
#import "YearViewController.h"
#import "DayViewController.h"
#import "NSCalendar+MGCAdditions.h"
#import "WeekSettingsViewController.h"
#import "MonthSettingsViewController.h"
#import "Utilities.h"
#import "Font_Face_Controller.h"
#import "ELR_loaders_.h"
#import "UIImageView+WebCache.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "Text_color_.h"
#import "ImageCustomClass.h"
typedef enum : NSUInteger
{
    CalendarViewWeekType  = 0,
    CalendarViewMonthType = 1,
    CalendarViewYearType = 2,
    CalendarViewDayType
} CalendarViewType;


@interface MainViewController ()<YearViewControllerDelegate,MonthViewControllerDelegate, WeekViewControllerDelegate, DayViewControllerDelegate>

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic) EKCalendarChooser *calendarChooser;
@property (nonatomic) BOOL firstTimeAppears;

@property (nonatomic) DayViewController *dayViewController;
@property (nonatomic) WeekViewController *weekViewController;
@property (nonatomic) MonthViewController *monthViewController;
@property (nonatomic) YearViewController *yearViewController;

@end


@implementation MainViewController

@synthesize responsesData = _responsesData;

//#pragma mark -
//#pragma mark - UIBarButtonItems
//
//- (void)setupMenuBarButtonItems {
//    // self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
//    
//    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
//       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
//        // self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
//    } else {
//        //self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
//    }
//}
//
//- (void)rightSideMenuButtonPressed {
//    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
//        
//        
//        [self setupMenuBarButtonItems];
//    }];
//}
//
//- (UIBarButtonItem *)backBarButtonItem {
//    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
//                                            style:UIBarButtonItemStyleBordered
//                                           target:self
//                                           action:@selector(backButtonPressed:)];
//}

#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//- (void)rightSideMenuButtonPressed:(id)sender {
//    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
//        [self setupMenuBarButtonItems];
//    }];
//}
//
//-(void)Action_slider
//{
//    [self rightSideMenuButtonPressed];
//}

#pragma mark - UIViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _eventStore = [[EKEventStore alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"arrayWithDatesFromWebService"];
    
    _responsesData =[[NSMutableData alloc]init];
    arrayWithMonthsInMonthView = [[NSMutableArray alloc]init];
    arrayWithDatesFromWebService = [[NSMutableArray alloc]init];
    arrayWithWeeksInWeekWebService = [[NSMutableArray alloc]init];
    arrayWithEventIdAdded = [[NSMutableArray alloc]init];
     arrayWithEventStartDate = [[NSMutableArray alloc]init];
     arrayWithEventendDate = [[NSMutableArray alloc]init];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"eventStartDate"]!=nil) {
    arrayWithEventIdAdded = [[[NSUserDefaults standardUserDefaults]objectForKey:@"eventId"] mutableCopy];
        arrayWithEventStartDate = [[[NSUserDefaults standardUserDefaults]objectForKey:@"eventStartDate"] mutableCopy];
        arrayWithEventendDate = [[[NSUserDefaults standardUserDefaults]objectForKey:@"eventEndDate"] mutableCopy];
    }
    
//    [self webservice];
    
    dateSelected= [NSDate date];
   //    self.navigationController.navigationBarHidden = YES;
    
    NSString *calID = [[NSUserDefaults standardUserDefaults]stringForKey:@"calendarIdentifier"];
    self.calendar = [NSCalendar mgc_calendarFromPreferenceString:calID];
    
    NSUInteger firstWeekday = [[NSUserDefaults standardUserDefaults]integerForKey:@"firstDay"];
    if (firstWeekday != 0) {
        self.calendar.firstWeekday = firstWeekday;
    } else {
        [[NSUserDefaults standardUserDefaults]registerDefaults:@{ @"firstDay" : @(self.calendar.firstWeekday) }];
    }
    
    self.dateFormatter = [NSDateFormatter new];
    self.dateFormatter.calendar = self.calendar;
    
//    if (isiPad) {
//        //NSLog(@"---------------- iPAD ------------------");
//    }
//    else{
        //NSLog(@"---------------- iPhone ------------------");
        self.navigationItem.leftBarButtonItem.customView = self.currentDateLabel;
//    }
	
	CalendarViewController *controller = [self controllerForViewType:CalendarViewWeekType];
	[self addChildViewController:controller];
	[self.containerView addSubview:controller.view];
	controller.view.frame = self.containerView.bounds;
	[controller didMoveToParentViewController:self];
	
	self.calendarViewController = controller;
    self.firstTimeAppears = YES;
    
    
    [self Navigation_bar];
    
      if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"elev"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"student"])
      {
          self.lunchInformatioButton.hidden = YES;
      }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstTimeAppears) {
        NSDate *date = [self.calendar mgc_startOfWeekForDate:[NSDate date]];
        [self.calendarViewController moveToDate:date animated:NO];
        self.firstTimeAppears = NO;
    }
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.tag = 1;
    [self toggleViewButton:button];
    CurrentSelectedButtonTag = 1;
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    self.navigationController.navigationBarHidden = NO;
    [self changeLanguage];
    if (!loader_image) {
        loader_image=[ELR_loaders_ Start_loader:CGRectMake(([[UIScreen mainScreen]bounds].size.width-85)/2,[[UIScreen mainScreen]bounds].size.height/2,85,85)];
        [self.view addSubview:loader_image];
        //    [_containerView setHidden:YES];
    }
    self.view.accessibilityViewIsModal = YES;
    loader_image.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];

}
-(void) changeLanguage
{
    [_monthButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Month" value:@"" table:nil] forState:UIControlStateNormal   ];
     [_dayButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Day" value:@"" table:nil] forState:UIControlStateNormal   ];
 [_todayButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Today" value:@"" table:nil] forState:UIControlStateNormal   ];
     [_weekButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Week" value:@"" table:nil] forState:UIControlStateNormal   ];
     [_foodMenuButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Food Menu" value:@"" table:nil] forState:UIControlStateNormal   ];
     [_lunchInformatioButton setTitle:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Food Notes" value:@"" table:nil] forState:UIControlStateNormal   ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    UINavigationController *nc = (UINavigationController*)[segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"dayPlannerSettingsSegue"]) {
        WeekSettingsViewController *settingsViewController = (WeekSettingsViewController*)nc.topViewController;
        WeekViewController *weekController = (WeekViewController*)self.calendarViewController;
        settingsViewController.dayPlannerView = weekController.dayPlannerView;
    }
    else if ([segue.identifier isEqualToString:@"monthPlannerSettingsSegue"]) {
        MonthSettingsViewController *settingsViewController = (MonthSettingsViewController*)nc.topViewController;
        MonthViewController *monthController = (MonthViewController*)self.calendarViewController;
        settingsViewController.monthPlannerView = monthController.monthPlannerView;
    }
    
    BOOL doneButton = (self.traitCollection.verticalSizeClass != UIUserInterfaceSizeClassRegular || self.traitCollection.horizontalSizeClass != UIUserInterfaceSizeClassRegular);
    if (doneButton) {
         nc.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissSettings:)];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    UINavigationController *nc = (UINavigationController*)self.presentedViewController;
    if (nc) {
        BOOL hide = (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular && self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular);
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissSettings:)];
        nc.topViewController.navigationItem.rightBarButtonItem = hide ? nil : doneButton;
    }
}

#pragma mark - Private

- (DayViewController*)dayViewController
{
    if (_dayViewController == nil) {
        _dayViewController = [[DayViewController alloc]initWithEventStore:self.eventStore];
        _dayViewController.calendar = self.calendar;
//        _dayViewController.showsWeekHeaderView = NO;
        _dayViewController.delegate = self;
    }
    return _dayViewController;
}

- (WeekViewController*)weekViewController
{
    if (_weekViewController == nil) {
        _weekViewController = [[WeekViewController alloc]initWithEventStore:self.eventStore];
        _weekViewController.calendar = self.calendar;
        _weekViewController.delegate = self;
    }
    return _weekViewController;
}

- (MonthViewController*)monthViewController
{
    if (_monthViewController == nil) {
        _monthViewController = [[MonthViewController alloc]initWithEventStore:self.eventStore];
        _monthViewController.calendar = self.calendar;
        _monthViewController.delegate = self;
    }
    return _monthViewController;
}

- (YearViewController*)yearViewController
{
    if (_yearViewController == nil) {
        _yearViewController = [[YearViewController alloc]init];
        _yearViewController.calendar = self.calendar;
        _yearViewController.delegate = self;
    }
    return _yearViewController;
}

- (CalendarViewController*)controllerForViewType:(CalendarViewType)type
{
    switch (type)
    {
        case CalendarViewDayType:  return self.dayViewController;
        case CalendarViewWeekType:  return self.weekViewController;
        case CalendarViewMonthType: return self.monthViewController;
        case CalendarViewYearType:  return self.yearViewController;
    }
    return nil;
}

-(void)moveToNewController:(CalendarViewController*)newController atDate:(NSDate*)date
{
    [self.calendarViewController willMoveToParentViewController:nil];
    [self addChildViewController:newController];
    
    [self transitionFromViewController:self.calendarViewController toViewController:newController duration:.5 options:UIViewAnimationOptionTransitionNone animations:^
     {
         newController.view.frame = self.containerView.bounds;
         newController.view.hidden = YES;
     } completion:^(BOOL finished)
     {
         [self.calendarViewController removeFromParentViewController];
         [newController didMoveToParentViewController:self];
         self.calendarViewController = newController;
         [newController moveToDate:date animated:NO];
         newController.view.hidden = NO;
     }];
    
    
}


#pragma mark - Navigation Bar


-(void)Navigation_bar
{
    
    
    
    
    
//        user_pic = [[UIImageView alloc] init];
//        NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"USR_image"]]);
//        [user_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[Utilities API_link_url_IMG],[[NSUserDefaults standardUserDefaults]valueForKey:@"customer_logo"]]]
//                    placeholderImage:[UIImage imageNamed:@"profile9.png"]];
//    
//        user_pic.frame=CGRectMake(50, 0, 30, 30);
//        user_pic.layer.cornerRadius=30*0.5;
//        user_pic.layer.borderColor=[UIColor clearColor].CGColor;
//        user_pic.layer.borderWidth=0;
//        user_pic.clipsToBounds=YES;
//        user_pic.userInteractionEnabled=YES;
//        user_pic.contentMode = UIViewContentModeScaleToFill;
//        user_pic.backgroundColor=[UIColor colorWithRed:97.0f/255.0f green:125.0f/255.0f blue:190.0f/255.0f alpha:1.0];
//        UIBarButtonItem *imageButton = [[UIBarButtonItem alloc] initWithCustomView:user_pic];
//        self.navigationItem.rightBarButtonItem = imageButton;
//    
//        UITapGestureRecognizer *tap_action_slider = [[UITapGestureRecognizer alloc]
//                                                     initWithTarget:self
//                                                     action:@selector(Action_slider)];
//    
//        [user_pic addGestureRecognizer:tap_action_slider];
//    
    
    
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
    
    
    self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule" value:@"" table:nil] ;
    
    
    //    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    UIImage *butImage1 = [[UIImage imageNamed:@"back-2"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    //    [button1 setBackgroundImage:butImage1 forState:UIControlStateNormal];
    //    [button1 addTarget:self action:@selector(downloadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    button1.frame = CGRectMake(0, 0, 20, 20);
    //    [button1 setTitleColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    //
    //
    //    UIBarButtonItem *backButton1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    //    self.navigationItem.rightBarButtonItem = backButton1;
    //
    //
    //    [[self navigationItem] setBackBarButtonItem:backButton1];
    
    
    
    //    }
    //    else
    //    {
    //        self.navigationItem.title = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Schedule" value:@"" table:nil] ;
    //    }
    
}

//-(void) backButtonPressed: (id) sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}


#pragma mark - Actions


-(void)moveToNoteIcon
{
    NoteIconViewController *noteIconViewController = [[NoteIconViewController alloc]initWithNibName:@"NoteIconViewController" bundle:nil];
    noteIconViewController.dateStringselected = _dsiplayDateLabel.text;
    [self.navigationController pushViewController:noteIconViewController animated:YES ];
}
- (IBAction)lunchInformationButtonclicked:(id)sender {
    LunchInformationViewController *lunchViewController = [[LunchInformationViewController alloc]initWithNibName:@"LunchInformation" bundle:nil];
    [self.navigationController pushViewController:lunchViewController animated:YES ];

}
- (IBAction)foodMenuButton:(id)sender {
//     [self moveToNoteIcon];
    AddFoodNotesViewController * addFoodnotesViewController = [[AddFoodNotesViewController alloc]initWithNibName:@"AddFoodNotesViewController" bundle:nil];
    [self.navigationController pushViewController:addFoodnotesViewController animated:YES ];
}

-(IBAction)switchControllers:(UISegmentedControl*)sender
{
    self.settingsButtonItem.enabled = NO;
    
    NSDate *date = [self.calendarViewController centerDate];
    CalendarViewController *controller = [self controllerForViewType:sender.selectedSegmentIndex];
    [self moveToNewController:controller atDate:dateSelected];
    
    
    if ([controller isKindOfClass:WeekViewController.class] || [controller isKindOfClass:MonthViewController.class]) {
        self.settingsButtonItem.enabled = YES;
    }
}

- (IBAction)toggleViewButton:(id)sender {
    
    UIButton * buttonClikced = (UIButton *)sender;
    
    if (buttonClikced.tag == CurrentSelectedButtonTag) {
        //
    }
    else
    {
        NSLog(@"dateSelected %@",dateSelected);
        NSLog(@"dateSelected %@",[self getMonthAndYearFromDate:dateSelected]);
        if (buttonClikced.tag == 1) {
            NSLog(@"Month selected");
            NSDate *date = [self.calendarViewController centerDate];
            CalendarViewController *controller = [self controllerForViewType:buttonClikced.tag];
            [self moveToNewController:controller atDate:[self getMonthAndYearFromDate:dateSelected]];
            if ([controller isKindOfClass:WeekViewController.class] || [controller isKindOfClass:MonthViewController.class]) {
                self.settingsButtonItem.enabled = YES;
            }
        }
        
      else
      {
        
         
          NSDate *date = [self.calendarViewController centerDate];
          CalendarViewController *controller = [self controllerForViewType:buttonClikced.tag];
          [self moveToNewController:controller atDate:dateSelected];
          if ([controller isKindOfClass:WeekViewController.class] || [controller isKindOfClass:MonthViewController.class]) {
              self.settingsButtonItem.enabled = YES;
          }
      }
    
    CurrentSelectedButtonTag = buttonClikced.tag;
    }
    if (buttonClikced.tag == 1) {
        [_monthButton setBackgroundColor:[UIColor colorWithRed:102.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0]];
        [_weekButton setBackgroundColor:[Text_color_ Food_Schedule_Color_code]];
        [_dayButton setBackgroundColor:[Text_color_ Food_Schedule_Color_code]];
        [_todayButton setBackgroundColor:[Text_color_ Food_Schedule_Color_code]];
    }
    else if (buttonClikced.tag == 0)
    {
        [_monthButton setBackgroundColor:[Text_color_ Food_Schedule_Color_code]];
        [_weekButton setBackgroundColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0]];
        [_dayButton setBackgroundColor:[Text_color_ Food_Schedule_Color_code]];
        [_todayButton setBackgroundColor:[Text_color_ Food_Schedule_Color_code]];
    }
    else if (buttonClikced.tag == 3)
    {
        [_monthButton setBackgroundColor:[Text_color_ Food_Schedule_Color_code]];
        [_weekButton setBackgroundColor:[Text_color_ Food_Schedule_Color_code]];
        [_dayButton setBackgroundColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0]];
        [_todayButton setBackgroundColor:[Text_color_ Food_Schedule_Color_code]];
    }
    else
    {
        [_monthButton setBackgroundColor:[Text_color_ Food_Schedule_Color_code]];
        [_weekButton setBackgroundColor:[Text_color_ Food_Schedule_Color_code]];
        [_dayButton setBackgroundColor:[Text_color_ Food_Schedule_Color_code]];
        [_todayButton setBackgroundColor:[UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0]];
    }
}


- (IBAction)showToday:(id)sender
{
    [self.calendarViewController moveToDate:[NSDate date] animated:YES];
}

- (IBAction)nextPage:(id)sender
{
    
//    [self webservice];
    [self.calendarViewController moveToNextPageAnimated:YES];
}

- (IBAction)previousPage:(id)sender
{
//    [self webservice];
    [self.calendarViewController moveToPreviousPageAnimated:YES];
}

- (IBAction)showCalendars:(id)sender
{
    if ([self.calendarViewController respondsToSelector:@selector(visibleCalendars)]) {
        self.calendarChooser = [[EKCalendarChooser alloc]initWithSelectionStyle:EKCalendarChooserSelectionStyleMultiple displayStyle:EKCalendarChooserDisplayAllCalendars eventStore:self.eventStore];
        self.calendarChooser.delegate = self;
        self.calendarChooser.showsDoneButton = YES;
        self.calendarChooser.selectedCalendars = self.calendarViewController.visibleCalendars;
    }
    
    if (self.calendarChooser) {
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:self.calendarChooser];
        self.calendarChooser.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(calendarChooserStartEdit)];
        nc.modalPresentationStyle = UIModalPresentationPopover;
 
        [self showDetailViewController:nc sender:self];
        
        UIPopoverPresentationController *popController = nc.popoverPresentationController;
        popController.barButtonItem = (UIBarButtonItem*)sender;
    }
}

- (IBAction)showSettings:(id)sender
{
    if ([self.calendarViewController isKindOfClass:WeekViewController.class]) {
        [self performSegueWithIdentifier:@"dayPlannerSettingsSegue" sender:nil];
    }
    else if ([self.calendarViewController isKindOfClass:MonthViewController.class]) {
        [self performSegueWithIdentifier:@"monthPlannerSettingsSegue" sender:nil];
    }
}

- (void)dismissSettings:(UIBarButtonItem*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)calendarChooserStartEdit
{
    self.calendarChooser.editing = YES;
    self.calendarChooser.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(calendarChooserEndEdit)];
}

- (void)calendarChooserEndEdit
{
    self.calendarChooser.editing = NO;
    self.calendarChooser.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(calendarChooserStartEdit)];
}


-(NSDate *) getMonthAndYearFromDate : (NSDate *) dateReceived
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    
     NSLog(@"dateReceived %@",dateReceived);
    
    [df setDateFormat:@"MM/yyyy"];
   NSString *   myDayString = [NSString stringWithFormat:@"02/%@",[df stringFromDate:dateReceived] ];
    
    NSLog(@"%@",myDayString);
    
    [df setDateFormat:@"dd/MM/yyyy"];
    
    NSDate * datefromString = [df dateFromString:myDayString];
    NSLog(@"%@",datefromString);
    
    return datefromString;
    
}
#pragma mark - YearViewControllerDelegate



- (void)yearViewController:(YearViewController*)controller didSelectMonthAtDate:(NSDate*)date
{
    CalendarViewController *controllerNew = [self controllerForViewType:CalendarViewMonthType];
    [self moveToNewController:controllerNew atDate:date];
    self.viewChooser.selectedSegmentIndex = CalendarViewMonthType;
}

#pragma mark - MonthViewControllerDelegate

-(void)monthViewController:(MonthViewController *)controller didSelectdayAtDate:(NSDate *)date
{
    
    dateSelected = date;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MM-yyyy";
//    NSLog(@"%@",[dateFormatter stringFromDate:date]);

    _dsiplayDateLabel.text = [dateFormatter stringFromDate:date];
    
   [self moveToNoteIcon];
}

-(void)dayViewController:(DayViewController *)controller didSelectdayAtDate:(NSDate *)date
{
    dateSelected = date;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MM-yyyy";
    //    NSLog(@"%@",[dateFormatter stringFromDate:date]);
    
    _dsiplayDateLabel.text = [dateFormatter stringFromDate:date];
    
    [self moveToNoteIcon];
}

#pragma mark - CalendarViewControllerDelegate

- (void)calendarViewController:(CalendarViewController*)controller didShowDate:(NSDate*)date
{
   
    if (controller.class == YearViewController.class)
        [self.dateFormatter setDateFormat:@"yyyy"];
    else
        [self.dateFormatter setDateFormat:@"dd MMMM yyyy"];
    
    NSString *str = [self.dateFormatter stringFromDate:date];
    self.currentDateLabel.text = str;
    [self.currentDateLabel sizeToFit];
//    NSLog(@"%@",str);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMMM yyyy"];
    
//    NSDate *yearDate = [dateFormatter dateFromString:str];
//    
//   
//    
//    NSDate *monthDate = [dateFormatter dateFromString:str];
    
     [dateFormatter setDateFormat:@"MM"];
    
    NSString * monthStringFromDate = [dateFormatter stringFromDate:date];
    
    [dateFormatter setDateFormat:@"yyyy"];
    
    NSString * yearStringFromDate = [dateFormatter stringFromDate:date];
    
    
    [dateFormatter setDateFormat:@"dd"];
    
    NSString * dayStringFromDate = [dateFormatter stringFromDate:date];
    
    
    NSString * weekStringFromDate = [NSString stringWithFormat:@"%li",(long)[[_calendar components: NSWeekOfYearCalendarUnit fromDate:date] weekOfYear] ];
    
    
    
    

//    NSLog(@"%d",CurrentSelectedButtonTag);
    if (CurrentSelectedButtonTag == 0)  // week
    {
       NSString * stringWithWeekAndYearForRefrence = [NSString stringWithFormat:@"%@%@",weekStringFromDate,yearStringFromDate];
        if (![arrayWithMonthsInMonthView containsObject:stringWithWeekAndYearForRefrence]) {
            [arrayWithMonthsInMonthView addObject:stringWithWeekAndYearForRefrence];
            [self webserviceForWeek:weekStringFromDate withYear:yearStringFromDate];
            
        }
        NSString * dateString = [NSString stringWithFormat:@"%@-%@-%@",dayStringFromDate,monthStringFromDate,yearStringFromDate];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy"];

        
        NSDate * dateFormated = [dateFormat dateFromString:dateString];
        
        NSDate *twoDaysAgo = [dateFormated dateByAddingTimeInterval:-2*24*60*60];
        
        
        
        _dsiplayDateLabel.text = [dateFormat stringFromDate:twoDaysAgo];
        
    }
    else if (CurrentSelectedButtonTag == 1) // month
    {
        NSString * stringWithMonthAndYearForRefrence = [NSString stringWithFormat:@"%@%@",monthStringFromDate,yearStringFromDate];
        if (![arrayWithMonthsInMonthView containsObject:stringWithMonthAndYearForRefrence]) {
            [arrayWithMonthsInMonthView addObject:stringWithMonthAndYearForRefrence];
//            [self webserviceForMonth:monthStringFromDate withYear:yearStringFromDate];
            [self webserviceForMonth:monthStringFromDate withYear:yearStringFromDate];
        }
        
      
        _dsiplayDateLabel.text = [NSString stringWithFormat:@"%@-%@-%@",dayStringFromDate,monthStringFromDate,yearStringFromDate];
    }
    else if (CurrentSelectedButtonTag == 2)
    {
        // do nothing for year
    }
    else // day
    {
        NSString * stringWithMonthAndYearForRefrence = [NSString stringWithFormat:@"%@-%@-%@",dayStringFromDate,monthStringFromDate,yearStringFromDate];
        if (![arrayWithMonthsInMonthView containsObject:stringWithMonthAndYearForRefrence]) {
            [arrayWithMonthsInMonthView addObject:stringWithMonthAndYearForRefrence];
            [self webserviceForDay:stringWithMonthAndYearForRefrence];
            
        }
        _dsiplayDateLabel.text = [NSString stringWithFormat:@"%@-%@-%@",dayStringFromDate,monthStringFromDate,yearStringFromDate];
    }
    
    
    dateSelected = date;
//       NSLog(@"%@",monthStringFromDate);
    
}

- (void)calendarViewController:(CalendarViewController*)controller didSelectEvent:(EKEvent*)event
{
    //NSLog(@"calendarViewController:didSelectEvent");
}

#pragma mark - MGCDayPlannerEKViewControllerDelegate

- (UINavigationController*)navigationControllerForEKEventViewController
{
//    if (!isiPad) {
//        return self.navigationController;
//    }
    return nil;
}


#pragma mark - EKCalendarChooserDelegate

- (void)calendarChooserSelectionDidChange:(EKCalendarChooser*)calendarChooser
{
    if ([self.calendarViewController respondsToSelector:@selector(setVisibleCalendars:)]) {
        self.calendarViewController.visibleCalendars = calendarChooser.selectedCalendars;
    }
}

- (void)calendarChooserDidFinish:(EKCalendarChooser*)calendarChooser
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - -*********************
#pragma mark Activity Indicater
#pragma mark - -*********************

-(void)mStartIndicater
{
    
//    loader_image.hidden = NO;
}

#pragma mark - -*********************
#pragma mark Stop Indicater
#pragma mark - -*********************

-(void)mStopIndicater
{
    
//    [loader_image removeFromSuperview];
////    [_containerView setHidden:NO];
//    self.view.userInteractionEnabled = YES;
//    loader_image.hidden = YES;
}




#pragma mark - WEb Service




-(void) webserviceForMonth : (NSString *) monthString withYear : (NSString * ) yearString  {
    
//    [self mStartIndicater];
//  NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",monthString,@"month",yearString,@"year",nil];
     _responsesData = [[NSMutableData alloc]init];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc] init];
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        [postDict setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
        [postDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"] forKey:@"loginUserID"];
        [postDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
        [postDict setValue:monthString forKey:@"month"];
        [postDict setValue:yearString forKey:@"year"];
    }
    else
    {
        [postDict setValue:@"H67jdS7wwfh" forKey:@"securityKey"];
        [postDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"] forKey:@"loginUserID"];
        [postDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] forKey:@"language"];
        [postDict setValue:monthString forKey:@"month"];
        [postDict setValue:yearString forKey:@"year"];

    }
//    NSDictionary * postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",monthString,@"month",yearString,@"year",nil];
    _responsesData = [[NSMutableData alloc]init];
    
    NSLog(@"postDict %@", postDict);
//    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSLog(@"[NSUserDefaults standardUserDefaults]valueForKey:@sub_domain] %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]);
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@mobile_api/getSchemaDetailsForMonth",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         [self mStopIndicater];
        if (!error) {
//            NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
                [self ParseArray:responseObject];
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
       [self mStopIndicater];
    }] resume];
    
//    NSError *error;
//      NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration: config delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
//      NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://dev.elar.se/mobile_api/getSchemaDetailsForMonth"]];
//     [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//      [request setHTTPMethod: @"POST"];
//      NSData *posData = [NSJSONSerialization dataWithJSONObject: postDict options:0 error: &error];
//    
//    //NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[posData length]];
//    
//    
//    
//    [request setHTTPBody: posData];
//    
//    // [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    
//    
//    
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        if (error == nil) {
//            [_responsesData appendData:data];
//            id json = [NSJSONSerialization JSONObjectWithData:_responsesData options: NSJSONReadingAllowFragments error:nil];
//               NSLog(@"Log    >>> %@",json);
////            NSLog(@"schemaCalendar %@",[json objectForKey:@"schemaCalendar"]);
//            
//             NSLog(@"Data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//            
//          }else {
//            
//            NSLog(@"Error....");
//            
//        }
//        
//    }];
//    
//    [dataTask resume];
    
    
    
}
//-(void) webserviceForMonth : (NSString *) monthString withYear : (NSString * ) yearString
//{
////    NSString * Current_Date_STR = [NSString stringWithFormat:@"%@",[NSDate date]];
////    NSData *responseString = [self makeCallPostData_ALL:@"securityKey=%@&authentication_token=%@&parent_id=%@&selected_date=%@&language=%@" :[NSString stringWithFormat:@"devlms.com/mobile_api/getSchemaDetailsForWeek"]];
//    
//    
////    {"month":"11","year":"2016","loginUserID":"44","securityKey":"H67jdS7wwfh"}
//    _responsesData = [[NSMutableData alloc]init];
//    
//    [self mStartIndicater];
//    NSError *error;
//    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
//    NSURL *url = [NSURL URLWithString:@"http://dev.elar.se/mobile_api/getSchemaDetailsForMonth"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:60.0];
//    
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    
//    
////    FjG7xS0mbu9313Frg8Mic2PU8qYVHkgl3c6EU3jV  x-api-key
//    
//    [request setHTTPMethod:@"POST"];
//    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh", @"securityKey",
//                             @"44", @"loginUserID",[NSString stringWithFormat:@"%@", monthString ],@"month",@"en",@"language",[NSString stringWithFormat:@"%@", yearString ],@"year",
//                             nil];
//    NSLog(@"mapData %@",mapData);
//    
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
//    [request setHTTPBody:postData];
//    
//    
//    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        [_responsesData appendData:data];
//        id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:_responsesData options:NSJSONReadingMutableContainers error:nil];
////        NSLog(@"dictionaryreceived for month %@",error.localizedDescription);
//        
////         NSLog(@"Data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//        
//        [self ParseArray:dictionaryreceived];
//    }];
//
//    [postDataTask resume];
//}


-(void) webserviceForWeek : (NSString *) weekString withYear : (NSString * ) yearString
{
    //    NSString * Current_Date_STR = [NSString stringWithFormat:@"%@",[NSDate date]];
    //    NSData *responseString = [self makeCallPostData_ALL:@"securityKey=%@&authentication_token=%@&parent_id=%@&selected_date=%@&language=%@" :[NSString stringWithFormat:@"devlms.com/mobile_api/getSchemaDetailsForWeek"]];
    
    
    //    {"month":"11","year":"2016","loginUserID":"44","securityKey":"H67jdS7wwfh"}
    
    
    [self mStartIndicater];
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/getSchemaDetailsForWeek",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]] ];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh", @"securityKey",
                             [[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"], @"loginUserID",[NSString stringWithFormat:@"%@", weekString ],@"weekNumber",[NSString stringWithFormat:@"%@", yearString ],@"year",
                             nil];
    NSLog(@"%@",mapData);
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dictionaryreceived %@",dictionaryreceived);
        [self ParseArray:dictionaryreceived];
        [self mStopIndicater];
    }];
    
    [postDataTask resume];
}


-(void) webserviceForDay  : (NSString *) dateString
{
    //    NSString * Current_Date_STR = [NSString stringWithFormat:@"%@",[NSDate date]];
    //    NSData *responseString = [self makeCallPostData_ALL:@"securityKey=%@&authentication_token=%@&parent_id=%@&selected_date=%@&language=%@" :[NSString stringWithFormat:@"devlms.com/mobile_api/getSchemaDetailsForWeek"]];
    
    
    //    {"month":"11","year":"2016","loginUserID":"44","securityKey":"H67jdS7wwfh"}
    
    
    [self mStartIndicater];
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/getSchemaDetailsForDay",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh", @"securityKey",
                             [[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"], @"loginUserID",[NSString stringWithFormat:@"%@", dateString ],@"date",
                             nil];
//    NSLog(@"%@",mapData);
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"dictionaryreceived %@",dictionaryreceived);
        [self ParseArray:dictionaryreceived];
        [self mStopIndicater];
    }];
    
    [postDataTask resume];
}


#pragma mark - NSURL Session Delegates

//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
//    NSMutableData *responseData = self.responsesData[@(dataTask.taskIdentifier)];
//    if (!responseData) {
//        responseData = [NSMutableData dataWithData:data];
//        self.responsesData[@(dataTask.taskIdentifier)] = responseData;
//    } else {
//        [responseData appendData:data];
//    }
//}
//
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
//    if (error) {
//        NSLog(@"%@ failed: %@", task.originalRequest.URL, error);
//    }
//    
//    NSMutableData *responseData = self.responsesData[@(task.taskIdentifier)];
//    
//    if (responseData) {
//        // my response is JSON; I don't know what yours is, though this handles both
//        
//        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
//        if (response) {
//            NSLog(@"response = %@", response);
//        } else {
//            NSLog(@"responseData = %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
//        }
//        
//        [self.responsesData removeObjectForKey:@(task.taskIdentifier)];
//    } else {
//        NSLog(@"responseData is nil");
//    }
//}

-(void) ParseArray : (NSDictionary *) dictionaryReceived
{
      arrayWithDatesFromWebService = [[NSMutableArray alloc]init];
    NSMutableArray * arrayFromMainDictionary = [dictionaryReceived objectForKey:@"schemaCalendar"];
    for (int i = 0; i<[arrayFromMainDictionary count]; i++) {
        NSDictionary * dictionaryWithEachIndex =[arrayFromMainDictionary objectAtIndex:i];
         NSDictionary * dictionaryInsideSchema =[dictionaryWithEachIndex objectForKey:@"Schema"];
        
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString * stringWithStartDate = [NSString stringWithFormat:@"%@",[dictionaryInsideSchema objectForKey:@"start"]];
        NSDate *startDate = [dateFormat dateFromString:stringWithStartDate];
    
        
        NSString * stringWithEndDate = [NSString stringWithFormat:@"%@",[dictionaryInsideSchema objectForKey:@"end"]];
         NSDate *endDate = [dateFormat dateFromString:stringWithEndDate];
        
        NSString * titleString = [NSString stringWithFormat:@"%@",[dictionaryInsideSchema objectForKey:@"title"]];
        
        NSString * idString = [NSString stringWithFormat:@"%@",[dictionaryInsideSchema objectForKey:@"id"]];

        NSLog(@"arrayWithDatesFromWebService %@",dictionaryInsideSchema);
         [self addEventsTocalendarWithTitle:titleString WithStarttingDate:startDate withEndingDate:endDate withId:idString];
//        [arrayWithDatesFromWebService addObject:startDate];
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:arrayWithDatesFromWebService forKey:@"arrayWithDatesFromWebService"];
    
   
    
    
    if ([arrayWithDatesFromWebService count] != 0) {
    [_monthViewController reloadEventsWithDate:[arrayWithDatesFromWebService objectAtIndex:0]];
        [_dayViewController reloadEvents];
    }
    [self mStopIndicater];
}


//-(void) addEventsTocalendar
//{
//    EKEventStore *store = [EKEventStore new];
//    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
//        if (!granted) { return; }
//        EKEvent *event = [EKEvent eventWithEventStore:store];
//        event.title = @"Event Title";
//        event.startDate = [NSDate date]; //today
//        event.endDate = [event.startDate dateByAddingTimeInterval:60*60*2];  //set 1 hour meeting
//        event.calendar = [store defaultCalendarForNewEvents];
//        NSError *err = nil;
//        
//        
//        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
////        self.savedEventId = event.eventIdentifier;  //save the event id if you want to access this later
//    }];
//}


- (void)addEventsTocalendarWithTitle : (NSString *) title WithStarttingDate : (NSDate*) startingDate withEndingDate : (NSDate *) endDate withId : (NSString *) identifier
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            // We need to run the main thread to issue alerts
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
//                    self.alertView.message = @"Could not access the calendar because an error ocurred.";
//                    [self.alertView show];
                }
                else if (!granted)
                {
//                    self.alertView.message = @"Could not access the calendar because permission was not granted.";
//                    [self.alertView show];
                }
                else
                {
//                    self.eventStartDate = [NSDate date];
                    
                    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
//                    event.title = @"Sample";
//                    event.startDate = [NSDate date];
//                    event.endDate = [event.startDate dateByAddingTimeInterval:60*60*2];

                    event.title = title;
                    event.startDate = startingDate;
                    event.endDate = endDate;
//                    event.eventIdentifier = identifier;
                    
                    
                    NSLog(@"event identifier%@",event.eventIdentifier);
                    
                    
                    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:event.startDate endDate:event.endDate calendars:nil];
                    NSArray *eventsOnDate = [eventStore eventsMatchingPredicate:predicate];
                    
                    __block BOOL eventExists = NO;
                    
                    [eventsOnDate enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        EKEvent *eventToCheck = (EKEvent*)obj;
                        
                        if([event.title isEqualToString:eventToCheck.title])
                        {
                            eventExists = YES;
                            *stop = YES;
                        }
                    }];
                    
                    if(! eventExists)
                    {
                        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                        
                        NSError *saveEventError;
                        [eventStore saveEvent:event span:EKSpanThisEvent error: &saveEventError];
                        
                        if(saveEventError)
                        {
//                            self.alertView.message = @"Could not add event to the calendar because an error ocurred.";
//                            [self.alertView show];
                        }
                        else
                        {
//                            self.addEventButton.enabled = NO;
//                            self.removeEventButton.enabled = YES;
                            
                            [arrayWithEventStartDate addObject:event.startDate];
                            [arrayWithEventendDate addObject:event.endDate];
                            
                            [arrayWithEventIdAdded addObject:event.eventIdentifier];
                            
                            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"eventId"];
                            
                            [[NSUserDefaults standardUserDefaults]setObject:arrayWithEventIdAdded forKey:@"eventId"];
                            [[NSUserDefaults standardUserDefaults]setObject:arrayWithEventStartDate forKey:@"eventStartDate"];
                            [[NSUserDefaults standardUserDefaults]setObject:arrayWithEventendDate forKey:@"eventEndDate"];
                            
//                            [[NSUserDefaults standardUserDefaults]setObject:endDate forKey:@"EndDate"];
//                            [[NSUserDefaults standardUserDefaults]setObject:tit forKey:@"StartDate"];
                            NSLog(@"event identifier%@",event.startDate);

                            
                            NSLog(@"The event was added to the calendar. %@",arrayWithEventStartDate);
//                            self.alertView.message = @"The event was added to the calendar.";
//                            [self.alertView show];
                        }
                    }
                    else
                    {
//                        self.addEventButton.enabled = NO;
//                        self.removeEventButton.enabled = YES;
//                        
//                        self.alertView.message = @"Could not add event to the calendar because it already existed.";
//                        [self.alertView show];
                    }
                }
            });
        }];
    }
    else
    {
//        self.alertView.message = @"Could not add event to the calendar because the feature is not supported.";
//        [self.alertView show];
    }
}
@end
