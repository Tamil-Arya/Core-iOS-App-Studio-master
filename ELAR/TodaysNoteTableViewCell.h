//
//  TodaysNoteTableViewCell.h
//  Smart Classroom Manager
//
//  Created by admin on 9/7/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodaysNoteTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *note_date_Label;
@property (strong, nonatomic) IBOutlet UILabel *description_Label;

@end
