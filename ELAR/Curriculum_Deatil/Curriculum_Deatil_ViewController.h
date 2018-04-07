//
//  Curriculum_Deatil_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 04/12/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+HTML.h"
@interface Curriculum_Deatil_ViewController : UIViewController
{
    UIButton *close_BTN;
    UILabel *mtitle_LB;
    UITextView *mtext_View;
    
}
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSString *Detail;


@end
