//
//  TermOfUseViewController.h
//  Smart Classroom Manager
//
//  Created by Muthukumar on 21/04/18.
//  Copyright © 2018 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TermOfUseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
   
    AppDelegate *appDelegate;

}

@property (weak, nonatomic) IBOutlet UILabel *termsOfUseSubLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UILabel *termsOfUseLabel;

@property (weak, nonatomic) IBOutlet UIButton *accept_Button;
@property (weak, nonatomic) IBOutlet UIButton *decline_button;
@property (weak, nonatomic) IBOutlet UIButton *logOut_button;


@end


