
#import "API.h"
#import "JSON.h"
#import "SBJsonWriter.h"
#import "NSObject+SBJSON.h"
#import "Utilities.h"
#import "ReachabilityManager.h"

@implementation API
#pragma mark -*********************
#pragma mark Request.
#pragma mark -*********************

+ (NSString *)sendRequest:(NSMutableURLRequest *)request
{
    NSHTTPURLResponse *response;
	NSError *error;
	NSData *responseData;
	responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if(responseData && [responseData length])
    {
		NSString* aStr;
		aStr = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
		return aStr;
	}
	else
    {
		return @"No Record Found";
	}
}


#pragma mark -*********************
#pragma mark User Login API with Get method
#pragma mark -*********************
+ (NSMutableDictionary *)UserLogin:(NSString *)PEmail :(NSString *)pPassword
{
    NSString *urlStr = [NSString stringWithFormat:@"http://demo/api/login/%@/%@",PEmail,pPassword];
    NSLog(@"%@",urlStr);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
	NSString *responseString = [API sendRequest:request];
	NSDictionary *responseDict = [responseString JSONValue];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
    NSLog(@"dict-------------%@",dict);
    return dict;
}


#pragma mark - -*********************
#pragma mark Signup API with post Method
#pragma mark - -*********************
+ (NSString *)makeCallPostData:(NSMutableDictionary*)dict
{
    
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@find_packages",[Utilities API_link_url]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
[urlRequest setTimeoutInterval:600];
NSString *requestBody = [NSString stringWithFormat:@"jsonData=%@", [dict JSONRepresentation]];
[urlRequest setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
[urlRequest setHTTPMethod:@"POST"];
	
NSURLResponse *response;
NSError *error;
NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error] ;
	
if([responseData length]) {
		NSString *data = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        return data;
	}
	return nil;
}

#pragma mark - -*********************
#pragma mark  post Method FOR ALLL API
#pragma mark - -*********************


+ (NSString *)makeCallPostData_ALL:(NSString *)dict :(NSString *)STR_URL

{
    
    NSLog(@"dict %@",dict);
    NSLog(@"URL %@",STR_URL);
       NSData *postData = [dict dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:STR_URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:postData];
    
         
    NSError *error = nil;
    
    NSHTTPURLResponse *response = nil;
    
    NSData *retData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *dataValue=nil;
    
    if (error)
        
    {
        
    }
    
    else
        
    {
        
        dataValue = [[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
        
    }
    return dataValue;

}


+ (NSString *)makeCallPostData_ALLs:(NSDictionary *)dict :(NSString *)STR_URL
{
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:STR_URL]];

      [urlRequest setTimeoutInterval:600];
    NSString *requestBody = [NSString stringWithFormat:@"jsonData=%@", [dict JSONRepresentation]];
    NSLog(@"%@",requestBody);
    [urlRequest setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest setHTTPMethod:@"POST"];
    
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error] ;
    
    if([responseData length]) {
        NSString *data = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        return data;
    }
    return nil;

}

+ (NSString *)makeCallPost:(NSString *)STR_URL

{
    NSData *postData = nil;
    
    NSURL *url = [NSURL URLWithString:STR_URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:postData];
    
    
    
    NSError *error = nil;
    
    NSHTTPURLResponse *response = nil;
    
    NSData *retData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *dataValue=nil;
    
    if (error)
        
    {
        
        //error
        
    }
    
    else
        
    {
        
        dataValue = [[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
        
    }
    return dataValue;
    
}





#pragma mark - -*********************
#pragma mark Home Screen Without Login API
#pragma mark - -*********************

+ (NSMutableDictionary *)HomeScreen:(NSString *)URL;
{
    NSString *encodedString = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:encodedString]];
	NSString *responseString = [API sendRequest:request];
	NSDictionary *responseDict = [responseString JSONValue];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc ]  initWithDictionary:responseDict];
    NSLog(@"dict-------------%@",dict);
    return dict;
}


+ (NSString *)google_place_api:(NSString*)URL
{
    //NSData *postData = [dict dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSError *error = nil;
    
    NSHTTPURLResponse *response = nil;
    
    NSData *retData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *dataValue=nil;
    
    if (error)
        
    {
        
        //error
        
    }
    
    else
        
    {
        
        dataValue = [[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
        
    }

    return dataValue;
}


#pragma mark - -*********************
#pragma mark checkNetworkStatus
#pragma mark - -*********************

+ (BOOL)connectedToInternet
{
    
    
//    NSString *urlString =@"https://www.google.com";
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"HEAD"];
//    NSHTTPURLResponse *response;
//    
//    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: NULL];
//    
//    return ([response statusCode] == 200) ? YES : NO;
    return [[ReachabilityManager sharedManager]isReachable];
}

@end
