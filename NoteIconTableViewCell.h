//
//  NoteIconTableViewCell.h
//  Smart Classroom Manager
//
//  Created by admin on 1/9/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteIconTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *startDateTableView;
@property (strong, nonatomic) IBOutlet UILabel *endDateTableView;
@property (strong, nonatomic) IBOutlet UIButton *viewButton;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

@end
