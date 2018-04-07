//
//  ViewAbsentNoteViewController.h
//  Smart Classroom Manager
//
//  Created by Developer on 12/01/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>


@interface ViewAbsentNoteViewController : UIViewController
{
    UIImageView * loader_image;
    NSMutableDictionary * absentnotedict;
    NSString * receivedAbsentNoteId;
}
- (IBAction)closeBtnEvent:(id)sender;

@property NSString * dateSelected;
@property (strong, nonatomic) IBOutlet UILabel *reasonLabel;
@property (strong, nonatomic) IBOutlet UILabel *reasonDeescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *writtenByLabel;
@property (strong, nonatomic) IBOutlet UILabel *writtenByDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *deletButton;
@property (strong, nonatomic) IBOutlet UILabel *absentDetailLabel;


@property NSMutableData* responsesData;
@end
