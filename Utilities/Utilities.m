//
//  Utilities.m
//  ELAR
//
//  Created by Bhushan Bawa on 04/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

#pragma mark - -*********************
#pragma mark Email Id Validatsion  Check Method
#pragma mark - -*********************

+ (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

+(NSString *)API_link_url
{
    NSString *app_main_url=[NSString stringWithFormat:@"%@%@",@"http://presentation.elar.se/",@"lms_api/"];
    
    
    
    return app_main_url;
}

+(NSString *)API_link_url_Quiz_manager
{
    NSString *app_main_url=[NSString stringWithFormat:@"%@%@",@"http://presentation.elar.se/",@"quiz_app/"];
    
    
    
    return app_main_url;
}


+(NSString *)API_link_url_subDomain
{
    
    NSString *mainUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"sub_domain"] == nil ? @"https://dev.elar.se/": [[NSUserDefaults standardUserDefaults] valueForKey:@"sub_domain"];
    
    NSString *app_main_url=[NSString stringWithFormat:@"%@%@",mainUrl,@"lms_api/"];
    
    return app_main_url;
}


+(NSString *)API_link_url_subDomain_for_IMG :(NSString *)IMG_ID;

{
    NSString *app_main_url=[NSString stringWithFormat:@"%@%@%@?authentication_token=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"],@"picture_diary/viewPictureDiaryImages/",IMG_ID,[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"]];
    
    return app_main_url;
}


+(NSString *)API_link_url_subDomain_for_IMG_NEWS :(NSString *)IMG_ID;

{
    NSString *app_main_url=[NSString stringWithFormat:@"%@%@%@?authentication_token=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"],@"news/viewPictureDiaryImages/",IMG_ID,[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"]];
    
    return app_main_url;
}






+(NSString *)API_link_url_subDomain_for_other_files :(NSString *)Files_ID;

{
    NSString *app_main_url=[NSString stringWithFormat:@"%@%@%@?authentication_token=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"],@"picture_diary/viewOtherFiles/",Files_ID,[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"]];
    
    return app_main_url;
}


+(NSString *)API_link_url_subDomain_for_other_files_NEWS :(NSString *)Files_ID;

{
    NSString *app_main_url=[NSString stringWithFormat:@"%@%@%@?authentication_token=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"],@"news/viewOtherFiles/",Files_ID,[[NSUserDefaults standardUserDefaults]valueForKey:@"authentication_token"]];
    
    return app_main_url;
}


+(NSString *)API_link_url_IMG
{
   
        NSString *app_main_url=[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"];
        
        return app_main_url;
    
 
}



+(NSString *)API_link_url_NEWS_Video
{
    
    NSString *app_main_url=[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"],@"files/news/flv/"];
    
    return app_main_url;
    
    
}



+(NSString *)API_link_url_NEWS_Thumnail
{
    
    NSString *app_main_url=[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"],@"files/news/images/"];
    
    return app_main_url;
    
    
}


+(NSString *)API_link_TermsOfUse {
    NSString *termURL = [[NSUserDefaults standardUserDefaults] valueForKey:@"sub_domain"] == nil ? @"https://dev.elar.se/": [[NSUserDefaults standardUserDefaults] valueForKey:@"sub_domain"];
    NSString *app_term_url=[NSString stringWithFormat:@"%@%@",termURL,@"mobile_api/get_userterms_formobile"];
    return app_term_url;
    
}




@end
