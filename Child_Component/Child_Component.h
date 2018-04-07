//
//  Child_Component.h
//  ELAR
//
//  Created by Bhushan Bawa on 26/02/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "NSString+HTML.h"
@interface Child_Component : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
    CGSize retval;
    BOOL Error_Check;
    
       UIImageView *loader_image;
    UIAlertView *alert;
    
    UIScrollView *scrollview;
    
     UIButton *Next_BTN;
     UIButton *Pre_BTN;
    
    UIImageView *panel_IMG;
    
    
    NSMutableDictionary *componet;
    NSMutableDictionary *mutableRetrievedDictionary;
    
       NSMutableDictionary *UpdateRetrievedDictionary;
      NSString *Current_Date_STR;
    
    UILabel *Component_name;
    
    UITextView *UNseen_count;
    UIImageView *user_pic;
    
        UILabel *Todays_Dropoff_Time;
        UILabel *Todays_Retrival_Time;
        UITextField *Current_Date;
    UIDatePicker *datepicker;
    
    
     UIButton *absent_note_IMG;
     UIButton *retrival_note_IMG;
    
    UILabel *Show_msg;
    
    
}

@property int indexOfChildSelected;

@end
