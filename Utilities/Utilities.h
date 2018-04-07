//
//  Utilities.h
//  ELAR
//
//  Created by Bhushan Bawa on 04/11/15.
//  Copyright © 2015 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+ (BOOL)validateEmail:(NSString *)emailStr;
+(NSString *)API_link_url;
+(NSString *)API_link_url_Quiz_manager;
+(NSString *)API_link_url_subDomain;
+(NSString *)API_link_url_subDomain_for_IMG :(NSString *)IMG_ID;
+(NSString *)API_link_url_subDomain_for_other_files :(NSString *)Files_ID;
+(NSString *)API_link_url_subDomain_for_IMG_NEWS :(NSString *)IMG_ID;

+(NSString *)API_link_url_subDomain_for_other_files_NEWS :(NSString *)Files_ID;

+(NSString *)API_link_url_IMG;

+(NSString *)API_link_url_NEWS_Video;
+(NSString *)API_link_url_NEWS_Thumnail;

@end
