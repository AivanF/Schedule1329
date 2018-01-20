//
//  Requester.m
//  Schedule1329
//
//  Created by Aivan on 19/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import "Requester.h"

@implementation Requester

+ (NSString *)fromJSON:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (void)getDataFrom:(NSString *)link
         completion:(void (^)(NSDictionary *, NSError *))completion {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:link]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    
    NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (!error) {
                    NSError *err;
                    // convert the NSData response to a dictionary
                    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
                    
//                    NSLog(@"Got JSON of GET with size %lu", data.length);
//                    NSLog(@"Got JSON of GET: %@\n", [self fromJSON:data]);
                    
                    if (err) {
                        // there was a parse error...
                        completion(nil, err);
                    } else {
                        // success!
                        completion(dictionary, nil);
                    }
                } else {
                    // error from the session...
                    completion(nil, error);
                }
                
            });
        }];
    [getDataTask resume];
}

+ (void)postDataTo:(NSString *)link
              data:(NSDictionary*)data
         completion:(void (^)(NSDictionary *, NSError *))completion {
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
    NSString *postLength = [NSString stringWithFormat:@"%d",(int)[postData length]];
//    NSLog(@"Post JSON: %@", [self fromJSON:postData]);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:link]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (!error) {
                    NSError *err;
                    // convert the NSData response to a dictionary
                    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
                    
//                    NSLog(@"Got JSON of POST with size %lu", data.length);
//                    NSLog(@"Got JSON of POST: %@\n", [self fromJSON:data]);
                    
                    if (err) {
                        // there was a parse error...
                        completion(nil, err);
                    } else {
                        // success!
                        completion(dictionary, nil);
                    }
                } else {
                    // error from the session...
                    completion(nil, error);
                }
                
            });
        }];
    [postDataTask resume];
}

@end
