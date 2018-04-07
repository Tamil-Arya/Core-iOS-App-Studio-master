//
//  ViewAbsentNoteViewController.m
//  Smart Classroom Manager
//
//  Created by Developer on 12/01/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "ViewAbsentNoteViewController.h"
#import "API.h"
#import "Utilities.h"
#import "JSON.h"
#import "MainViewController.h"

@interface ViewAbsentNoteViewController ()

@end

@implementation ViewAbsentNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webserviceForLogin];
    [self changeLanguage];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"elev"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"student"]) {
        self.deletButton.hidden = YES;
    }
}

-(void) showAlert : (NSString * ) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) changeLanguage
{
    _absentDetailLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Absent detail" value:@"" table:nil];
    _reasonLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Reason" value:@"" table:nil];
    _writtenByLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Written By" value:@"" table:nil];
  }


//-(void) webserviceToGetAbsentNote   {
//    
////    [self mStartIndicater];
//    
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//    NSDate *date = [dateFormatter dateFromString: _dateSelected];
//    dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
////here convert date in NSString
//    
//    securityKey=H67jdS7wwfh&authentication_token=c6c904b1985ef90ff76d859c26435b7ecaa8c9e1&language=sw&student_id=1&user_type_app=android&sickdate=2017-03-14
//    
////    "securityKey":"H67jdS7wwfh","language":"en",”authentication_token”:”dddb92327639f49285a1ff6dcf1c89dbd40207e6”,”student_id”:”104”,”sickdate”:”2017-01-06”
//    
//    NSString * Token_value;
//    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]){
//        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_authentication_token"];
//    }
//    else{
//        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"];
//    }
//
//    
//    NSDictionary * postDict;
//    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
//        
//        postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],@"student_id",Token_value,@"authentication_token",@"en",@"language",date_correct_format,@"sickdate",nil];
//    }
//    else
//    {
//         postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"student_id",Token_value,@"authentication_token",@"en",@"language",date_correct_format,@"sickdate",nil];
//    }
//    _responsesData = [[NSMutableData alloc]init];
//    
//    NSError * error;
//    NSLog(@"[[NSUserDefaults standardUserDefaults]valueForKey:] %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"]);
//    NSLog(@"postDict %@",postDict);
//    
//    
//    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/get_absence_note",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:60.0];
//    
//    [request addValue:@"application/json" forHTTPHeaderField:@ "Content-Type"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    
//    [request setHTTPMethod:@"POST"];
//    
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
//    [request setHTTPBody:postData];
//    
//    
//    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        //        NSLog(@"data:%@",data);
//        if (data != nil) {
//            id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            //        NSLog(@"dictionaryreceived %@",str);
//            NSLog(@"dictionaryreceived %@",dictionaryreceived);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if(dictionaryreceived == nil)
//                {
//                    
//                }
//                else
//                {
////                    [self ParseArray:dictionaryreceived WithTag:WEBSERVICE_GROUPS];
//                    NSLog(@"%@",dictionaryreceived);
//                }
//                
//            });
//        }
//    }];
//    
//    [postDataTask resume];
//    
//    
//    
//}

-(void) webserviceForLogin  {
    
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [dateFormatter dateFromString: _dateSelected];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
    //here convert date in NSString
    
//    securityKey=H67jdS7wwfh&authentication_token=c6c904b1985ef90ff76d859c26435b7ecaa8c9e1&language=sw&student_id=1&user_type_app=android&sickdate=2017-03-14
    
    //    "securityKey":"H67jdS7wwfh","language":"en",”authentication_token”:”dddb92327639f49285a1ff6dcf1c89dbd40207e6”,”student_id”:”104”,”sickdate”:”2017-01-06”
    
    NSString * Token_value;
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]){
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"parent_authentication_token"];
    }
    else{
        Token_value=[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"];
    }
    
    
    NSDictionary * postDict;
    NSString *requestString;
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
        
//        postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],@"student_id",Token_value,@"authentication_token",@"en",@"language",date_correct_format,@"sickdate",nil];
       requestString = [NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],date_correct_format];
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"elev"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"student"])

    {
//        postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"student_id",Token_value,@"authentication_token",@"en",@"language",date_correct_format,@"sickdate",nil];
            requestString = [NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],date_correct_format];
    }
    else
    {
       requestString = [NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],date_correct_format];
    }
    
//    NSString *requestString = [NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],date_correct_format];
    

    
    
    NSLog(@"Reply JSON: %@", requestString);
//    NSLog(@"Reply JSON: %@", [NSString stringWithFormat:@"%@mobile_api/get_absence_note",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]);
    //    NSDictionary *body = @{@"snippet": @{@"topLevelComment":@{@"snippet":@{@"textOriginal":self.commentToPost.text}},@"videoId":self.videoIdPostingOn}};
    NSError *error;
    
    NSData *postData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    //        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestString options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSLog(@"[NSUserDefaults standardUserDefaults]valueForKey:@sub_domain] %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]);
    
    
    
    //    [NSString stringWithFormat:@"%@users/login",[Utilities API_link_url_subDomain]]
    
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@lms_api/retrivals/get_absence_note",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ] parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    //        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //        [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    
    [req setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        [self mStopIndicater];
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                
                receivedAbsentNoteId =[responseObject[@"data"] objectForKey:@"wholedaysick_id"];
               
                _dateLabel.text = [responseObject[@"data"] objectForKey:@"sickdate"];
                _reasonDeescriptionLabel.text = [responseObject[@"data"] objectForKey:@"description"];
                _nameLabel.text = [responseObject[@"data"] objectForKey:@"student_name"];
                NSLog(@"Error: %@", receivedAbsentNoteId);
                
                _writtenByDescriptionLabel.text = [ NSString stringWithFormat:@"%@, %@", [responseObject[@"data"] objectForKey:@"written_by"], [responseObject[@"data"] objectForKey:@"created"] ];

                
                if ([[responseObject[@"data"] objectForKey:@"leave_type"] isEqualToString:@"sick"] ) {
                    _dateLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Sickness" value:@"" table:nil];
//                    Leave_type=@"sick";
                    
                }
                else if ([[responseObject[@"data"] objectForKey:@"leave_type"] isEqualToString:@"other"] )
                {
                    _dateLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Other reasons" value:@"" table:nil];
//                    Leave_type=@"leave";
                }
                
                else if ([[responseObject[@"data"] objectForKey:@"leave_type"] isEqualToString:@"leave"] )
                {
                    _dateLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Leave" value:@"" table:nil];
//                    Leave_type=@"other";
                }
                else
                {
                    _dateLabel.text = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"] ofType:@"lproj"]] localizedStringForKey:@"Other reasons" value:@"" table:nil];
//                    Leave_type=@"other";
                }

                //blah blah
                //                    [self ];
//                [self CallTheServer_Login_API:responseObject];
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
//        [self mStopIndicater];
    }] resume];
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeBtnEvent:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)deleteButtonClicked:(id)sender {
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [dateFormatter dateFromString: _dateSelected];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_correct_format = [dateFormatter stringFromDate:date]; //here convert date in NSString
    //here convert date in NSString
    
    //    {"securityKey":"H67jdS7wwfh","loginUserID":"44","id":"","language":"en"}
    
    NSString * Token_value;
    
    
    NSDictionary * postDict;
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"parent"] || [[[NSUserDefaults standardUserDefaults]valueForKey:@"user_type"]isEqualToString:@"förälder"]) {
    
            postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",receivedAbsentNoteId,@"id",[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],@"language",nil];
        }
        else
        {
            postDict = [[NSDictionary alloc] initWithObjectsAndKeys: @"H67jdS7wwfh",@"securityKey",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],@"loginUserID",receivedAbsentNoteId,@"id",@"id",@"language",nil];
        }
    
    NSLog(@"postDict %@",postDict);
    
//    NSString *requestString = [NSString stringWithFormat:@"securityKey=%@&authentication_token=%@&language=%@&student_id=%@&sickdate=%@",@"H67jdS7wwfh",Token_value,[[NSUserDefaults standardUserDefaults]valueForKey:@"langugae"],[[NSUserDefaults standardUserDefaults]valueForKey:@"student_id"],date_correct_format];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@mobile_api/delete_absent_desc",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"] ]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@ "Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSError * error;
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //        NSLog(@"data:%@",data);
        if (data != nil) {
            id dictionaryreceived = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //        NSLog(@"dictionaryreceived %@",str);
            NSLog(@"dictionaryreceived %@",dictionaryreceived);
            dispatch_async(dispatch_get_main_queue(), ^{
                if(dictionaryreceived == nil)
                {
                    
                }
                else
                {
                    if (dictionaryreceived[@"status"]) {
//                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Absent note deleted successfully" preferredStyle:UIAlertControllerStyleAlert];
//                        
//                        UIAlertAction* OKAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
//                                                                         handler:^(UIAlertAction * action) {
//                                                                             for (UIViewController *controller in self.navigationController.viewControllers)
//                                                                             {
//                                                                                 if ([controller isKindOfClass:[MainViewController class]])
//                                                                                 {
//                                                                                     [self.navigationController popToViewController:controller
//                                                                                                                           animated:YES];
//                                                                                     break;
//                                                                                 }
//                                                                             }
//                                                                             
//                                                                         }];
//                        
//                        [alertController addAction:OKAction];
//                        
//                        [self presentViewController:alertController animated:YES completion:nil];

                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Absent note deleted successfully" preferredStyle:UIAlertControllerStyleAlert];
                        
                        
                        
                        UIAlertAction* OKAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                                         handler:^(UIAlertAction * action) {
//                                                                             for (UIViewController *controller in self.navigationController.viewControllers)
//                                                                             {
//                                                                                 if ([controller isKindOfClass:[MainViewController class]])
//                                                                                 {
//                                                                                     [self dismissViewControllerAnimated:YES completion:^{
                                                                                         [self.navigationController popViewControllerAnimated:YES];
//                                                                                     }];
//                                                                                     break;
//                                                                                 }
////                                                                             }
                                                   
                                                                         }];
                        
                        [alertController addAction:OKAction];
                        
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                    else
                    {
                        [self showAlert:[dictionaryreceived objectForKey:@"msg"]];
 
                    }
//                    [self ParseArray:dictionaryreceived WithTag:WEBSERVICE_GROUPS];
                }
                
            });
        }
    }];
    
    [postDataTask resume];
    

}


@end
