//
//  APIWithProtocol.h
//  Smart Classroom Manager
//
//  Created by admin on 6/29/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


@protocol APIProtocol <NSObject>

@optional

-(void) dataIsReceived : (id) dataReceived withMsgType:(int) msgType;
-(void) errorOccured : (NSString *) errorString withMsgType:(int) msgType;

@end

@interface APIWithProtocol : NSObject<NSURLSessionDelegate>

@property id<APIProtocol> delegateObject;

-(void) CallWebserviceWithDataParametrs : (id) parameters WithURL : (NSURL *) urlToBeHit withMsgType : (int) msgType;
-(void) CallAFNetworkingWebserviceWithDataParametrs : (id) parameters WithURL : (NSString *) urlToBeHit withMsgType : (int) msgType;



@end
