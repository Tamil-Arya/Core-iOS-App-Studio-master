//
//  LunchInformationTableViewCell.h
//  XIBTest
//
//  Created by jeff ayan on 28/12/16.
//  Copyright © 2016 jeff ayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LunchInformationTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *LunchImageView;
@property (strong, nonatomic) IBOutlet UILabel *LunchFirstName;
@property (strong, nonatomic) IBOutlet UILabel *LunchLastName;
@property (strong, nonatomic) IBOutlet UITextView *allerrgyTextView;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UILabel *freeTextLabel;

@end
