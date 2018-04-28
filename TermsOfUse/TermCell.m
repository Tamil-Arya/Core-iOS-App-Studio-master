//
//  TermCell.m
//  Smart Classroom Manager
//
//  Created by Muthukumar on 22/04/18.
//  Copyright © 2018 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "TermCell.h"

@implementation TermCell
@synthesize array_id;
@synthesize checkButton;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.array_id = [[NSMutableArray alloc] init];
    // Configure the view for the selected state
}

- (IBAction)checkAction:(id)sender {
//    UIButton *button = sender;
//    if([self.checkButton backgroundImageForState:UIControlStateNormal] == [UIImage imageNamed:@"nonclick20*20.png"]) {
//        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"click.png"] forState:UIControlStateNormal];
//        NSString *string_tag= [NSString stringWithFormat:@"%d", self.checkButton.tag];
//        [self.array_id addObject:string_tag];
//    }else{
//        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"nonclick20*20.png"] forState:UIControlStateNormal];
//        int tag= self.checkButton.tag;
//        NSString *string_tag= [NSString stringWithFormat:@"%d", self.checkButton.tag];
//        [self.array_id removeObject:string_tag];
//    }
//    self.tapHandler(self.array_id);
}
@end
