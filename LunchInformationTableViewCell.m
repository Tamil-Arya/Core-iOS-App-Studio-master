//
//  LunchInformationTableViewCell.m
//  XIBTest
//
//  Created by jeff ayan on 28/12/16.
//  Copyright © 2016 jeff ayan. All rights reserved.
//

#import "LunchInformationTableViewCell.h"

@implementation LunchInformationTableViewCell

@synthesize backgroundView = _backgroundView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self backgroundViewLoad];
}

-(void) backgroundViewLoad {
    _backgroundView.layer.cornerRadius = 10 ;
    _backgroundView.layer.borderWidth = 0.5;
    _backgroundView.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
