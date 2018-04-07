//
//  AddFoodNotesViewController.h
//  Smart Classroom Manager
//
//  Created by admin on 1/12/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "Utilities.h"
#import "AddFoodNotesTableViewCell.h"
#import "ViewFoodMenuWebViewViewController.h"
#import "APIWithProtocol.h"

@interface AddFoodNotesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,AFURLRequestSerialization,UIAlertViewDelegate,APIProtocol>
{
    __weak IBOutlet UITableView * AddfoodNotesTableView;
    NSMutableArray * arrayWithTitleOfEvents, *arrayWithStartDateOfEvents, *arrayWithendDateOfEvents , * arrayWithDictionariesInFoodMenu;
    UIImageView *loader_image;
    APIWithProtocol * api;

}

@property (strong,nonatomic) NSMutableData * responsesData;
@property (strong) NSString * dateStringselected;

@end
