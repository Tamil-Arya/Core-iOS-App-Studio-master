//
//  ViewFoodMenuPdfViewController.h
//  Smart Classroom Manager
//
//  Created by Developer on 14/09/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewFoodMenuWebViewViewController.h"
#import "Text_color_.h"
@interface ViewFoodMenuPdfViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIImageView *user_pic;
    
    UIView *back_ground_pickerview;
    UIPickerView *pPickerState;
    UIToolbar *toolBar ;
    UITextField *search_TXT;
    
    
    NSMutableArray *Demo_ARR;
    
    
    NSString * pickre_STR;
}
@end
