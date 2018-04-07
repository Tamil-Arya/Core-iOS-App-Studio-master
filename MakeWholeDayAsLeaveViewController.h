//
//  MakeWholeDayAsLeaveViewController.h
//  SampleForKaaylabs
//
//  Created by admin on 2/22/17.
//  Copyright © 2017 Venugopal Devarala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeWholeDayAsLeaveViewController : UIViewController
{
    NSMutableData * responsesData;
    UIImageView * loader_image;
}
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UITextView *enterDescriptionTextField;

@property (strong, nonatomic) IBOutlet UIButton *addButton;

@property (strong) NSString * dateStringSelected;
@end
