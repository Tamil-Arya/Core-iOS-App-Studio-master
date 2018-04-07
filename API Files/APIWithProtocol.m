//
//  APIWithProtocol.m
//  Smart Classroom Manager
//
//  Created by admin on 6/29/17.
//  Copyright © 2017 PICNFRAMES TECHNOLOGIES. All rights reserved.
//

#import "APIWithProtocol.h"

@implementation APIWithProtocol


-(void)CallWebserviceWithDataParametrs:(id)parameters WithURL:(NSURL *)urlToBeHit withMsgType : (int) msgType
{
    NSError * error;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
//    NSURL *url = [NSURL URLWithString:requestUrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlToBeHit
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    //    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: @"TEST IOS", @"name",
    //                             @"IOS TYPE", @"typemap",
    //                             nil];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *errorInResponse)
                                          {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                              //        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&errorInResponse];
                                              //        NSLog(@"%@", json);
                                                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

                                              [self moveToParentClasswithData:json withError:error withMsgType:msgType];
                                               });
                                              
                                          }];
    
    [postDataTask resume];

}

-(void)CallAFNetworkingWebserviceWithDataParametrs:(id)parameters WithURL:(NSString *)urlToBeHit withMsgType : (int) msgType
{
    NSError * error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSLog(@"[NSUserDefaults standardUserDefaults]valueForKey:@sub_domain] %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sub_domain"]);
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString: urlToBeHit parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            //            NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
                [self moveToParentClasswithData:responseObject withError:error withMsgType:msgType];

                
            }
        } else {
            [self moveToParentClasswithData:responseObject withError:error withMsgType:msgType];
        }
    }] resume];

    
}

-(void) moveToParentClasswithData : (id) jsonParsedData withError : (NSError *) errorReceived withMsgType: (int) msgType
{
    if (jsonParsedData == NULL)
    {
        if ([self.delegateObject respondsToSelector:@selector(errorOccured:withMsgType:)])
        {
            [self.delegateObject errorOccured:[errorReceived localizedDescription] withMsgType:msgType];
        }
    }
    else
    {
        NSLog(@"%@", jsonParsedData);
        
        if ([self.delegateObject respondsToSelector:@selector(dataIsReceived:withMsgType:)])
        {
            [self.delegateObject dataIsReceived:jsonParsedData withMsgType:msgType];
        }
    }
    
}

@end
