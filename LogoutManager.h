//
//  LogoutManager.h
//  Smart Classroom Manager
//
//  Created by Tamil Selvan R on 03/04/18.
//  Copyright © 2018 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogoutManager : NSObject
+(LogoutManager *)sharedManager;
-(void)forceLogoutForChangePassword;
@end
