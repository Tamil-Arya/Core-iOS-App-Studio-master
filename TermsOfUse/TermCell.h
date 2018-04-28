//
//  TermCell.h
//  Smart Classroom Manager
//
//  Created by Muthukumar on 22/04/18.
//  Copyright © 2018 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleForCheckBox;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property(nonatomic,retain) NSMutableArray *array_id;
@property (nonatomic, copy) void(^tapHandler)(NSMutableArray* tag);
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


- (IBAction)checkAction:(id)sender;






@end
