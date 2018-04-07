//
//  Child_Information.h
//  ELAR
//
//  Created by Bhushan Bawa on 27/02/16.
//  Copyright © 2016 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Child_Information : UIViewController<UITextViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    
    UIButton *Save_Changes;
    UIButton * edit_button;
    UIButton * replaceButton, * removeButton, * closeButton;
    
    UILabel *Contact_Info_LB;
    UILabel *Allergies_LB;
    UILabel *Additional_Info_LB;

      UITextView *Contact_Info_TV;
      UITextView *Allergies_TV;
    
      UITextView *Additional_info_TV;
    
    UIImageView *user_pic;
    
    UIImageView *loader_image;
    
    UIImageView * child_image;
    
    UITextField * first_name_Text_field;
    UITextField * second_name_Text_field;

    
    NSMutableDictionary *Childe_information;
    
    UIAlertView *alert;
    
    NSString *Token_value;
    
     NSString *Id_value;
    
    UIScrollView * childInfoScrollView;
    
}


@property int indexOfChildSelected;


@end
