//
//  Login_ViewController.h
//  ELAR
//
//  Created by Bhushan Bawa on 06/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+HTML.h"
#import "NSString+StringManipulation.h"
#import "TwoFactorLoginView.h"
@import GoogleSignIn;

@protocol Login_ViewControllerDelegate
-(void) webserviceForLogin :(BOOL)isGoogleLogin withGoogleResponseDic:(NSMutableDictionary *)loginResponseDic;
@end

@interface Login_ViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,NSURLSessionTaskDelegate,GIDSignInUIDelegate,Login_ViewControllerDelegate>{
    
    UIToolbar *toolBar ;
    UIImageView *Application_logo;
    
    
    UITextField  *email_TXT;
    UITextField  *Passwprd_TXT;
     UITextField  *Schools_TXT;
    UITextField * search_TXT;
    UIImageView *login_img;
    UIImageView *Pass_WRD_img;
    
    UIButton *BTN_sign_In;
    GIDSignInButton *BTM_sign_In_GMAIL;

    UIButton *BTN_Forgot;
    
    UILabel *background_language;
    UIImageView *language_img;
    UILabel *language_LB;

    
    UIPickerView *pPickerState;
    NSMutableArray *language_ARR;
    NSMutableArray *Demo_ARR;
     NSMutableArray *Copy_Of_Demo_ARR , *copy_Of_Array_Of_Customers;
    
      NSMutableArray *Domain_name_ARR;
    NSString *pickre_STR;
    NSString *Language_STR;
     NSInteger pickre_index_value;
    NSMutableDictionary *dict;
     NSMutableDictionary *dict_forgot;
     NSMutableDictionary *dict_School;
    NSMutableDictionary *dict_Login;
    NSMutableDictionary * dict_Customer;
    
    UIView *back_ground_pickerview;
    
    BOOL canPicker_Array;
    
    
    NSMutableDictionary *mUserResponseDict;
    UIAlertView *alert;
  
  
    UIScrollView *scrollview;
    
       UITextField *mEmail_id;
    UIImageView *loader_image;
    
    NSMutableString * searchString;
    
    int customerListServicecount;
    NSArray * arrayWithCustomerUrl;
    NSMutableArray * arrayOfCustomers;
    
    

    
    // New objects
    
    NSMutableArray * arrayWithLanguages , * arrayForCustomers;
    UIPickerView * pickerviewForLanguage, * pickerViewForCustomers;
     UIToolbar *toolBarForLanguiage, *toolBarForCustomers ;
    UIView * backgroundViewforLanguagePicker, * backgroundViewforCustomerPicker;
    NSString * languageStringFromUserDefaults , * receivedCodeForTwoFactorLogin;
    
    UIBarButtonItem *cancelButtonForCusomer , *doneButtonForCustomer ,*cancelButtonorLanguage, * doneButtonForLanguage;
    UIView * transparentView ;
    
    int totalSeconds;
    NSTimer * twoMinTimer;
    
    NSMutableArray *childrensListArray;
    NSString *student_id;
}

@end
