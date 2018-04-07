//
//  ReachabilityManager.h
//  Smart Classroom Manager
//
//  Created by Tamil Selvan R on 18/03/18.
//  Copyright © 2018 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Reachability;

@interface ReachabilityManager : NSObject
@property (strong, nonatomic) Reachability *reachability;
+(ReachabilityManager *)sharedManager;

-(BOOL)isReachable;
-(void)showAlertForNoInternetNotification;
@end
