//
//  Requester.h
//  Schedule1329
//
//  Created by Aivan on 19/01/2018.
//  Copyright © 2018 AivanF. All rights reserved.
//

#import <Foundation/Foundation.h>

#define URL_COURSES @"http://144.76.74.53:8080/api/courses"

@interface Requester : NSObject

+ (void)getDataFrom:(NSString *)link
         completion:(void (^)(NSDictionary *, NSError *))completion;

+ (void)postDataTo:(NSString *)link
              data:(NSDictionary*)data
        completion:(void (^)(NSDictionary *, NSError *))completion;

@end
