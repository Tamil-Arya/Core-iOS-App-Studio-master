//
//  add_retriever_note.h
//  SCM
//
//  Created by pnf on 12/20/15.
//  Copyright © 2015 Picnframes Technologies. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "add_retriever_note.h"
#import "NSString+HTML.h"
#import <MobileCoreServices/UTCoreTypes.h>
@interface add_retriever_note : UIViewController<UITextFieldDelegate,UITextViewDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>
{

    
    UIActionSheet *actionSheets;
    
    UITextView *Notetextfield;
    
    UITextField *datetextfield;
    UITextField *totextfield;
    UITextField *retrievernametextfield;
    UITextField *Contactdetailstextfield;
    NSString *Portraitimg;
        
    UIImageView *retrieverimageView;
    
    UIImageView *loader_image;
    UIAlertView *alert;
    UIImageView *user_pic;
    
    UIImageView *retrieveruserimage_background;
    
    NSMutableDictionary *retrievernotedict;
    NSMutableDictionary *dict;
    
    NSString *retrieverid;
    
    
    NSString *Token_value;
    
    UIButton *selected_date_btn;
    
    UIButton *CancelButton , * SaveButton;
}
@property (strong, nonatomic) NSString *add_check;
@end
