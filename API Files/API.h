//
//  API.h

//
//  Created by bhushan on 14/11/13.

//

 #import <Foundation/Foundation.h>
 //#import "Reachability.h"

@interface API : NSObject
{
  
    
}


+ (NSString *)makeCallPostData_ALL:(NSString *)dict :(NSString *)STR_URL;

+ (NSString *)makeCallPostData_ALLs:(NSDictionary *)dict :(NSString *)STR_URL;

+ (NSMutableDictionary *)UserLogin:(NSString *)PEmail :(NSString *)pPassword;

+ (NSMutableDictionary *)About:(NSString *)URL;


+ (NSString *)ForGot:(NSMutableDictionary*)dict;

+ (NSString *)Login:(NSMutableDictionary*)dict;


+(NSMutableDictionary *)contact_Us:(NSString *)URL;
+ (NSString *)makeCallPostData:(NSMutableDictionary*)dict;


+ (NSString *)makeCallPostData_profile:(NSMutableDictionary*)dict;

+ (NSMutableDictionary *)ForGetpassword :(NSString *)Email_id;

+ (NSMutableDictionary *)HomeScreen:(NSString *)URL;

+ (NSString *)Edit_Post:(NSMutableDictionary*)dict;

+ (NSString *)Payment:(NSMutableDictionary*)dict;

+ (NSString *)Upload_Product:(NSMutableDictionary*)dict;
+ (NSString *)PhotoPOST:(NSMutableDictionary*)dict;
+ (NSString *)Earning:(NSMutableDictionary*)dict;

+ (NSString *)MARKETPLACE_Earning:(NSMutableDictionary*)dict;

+ (NSString *)makeCallPostData_pic:(NSMutableDictionary*)dict;
+ (NSString *)makeCallPostData_cover:(NSMutableDictionary*)dict;
+ (NSMutableDictionary *)Change_password:(NSString *)old_password :(NSString *)New_password;
+ (NSString *)TextPOST:(NSMutableDictionary*)dict;


+ (NSString *)makeCallPost:(NSString *)STR_URL;

+ (BOOL)connectedToInternet;



+ (NSString *)google_place_api:(NSString*)URL;



@end
