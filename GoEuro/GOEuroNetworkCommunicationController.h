//
//  GOEuroNetworkCommunicationController.h
//  GoEuro
//
//  Created by Quinto Technologies Pvt. Ltd. on 16/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef void (^networkCompletionBlock)(BOOL finished, id response);
@interface GOEuroNetworkCommunicationController : NSObject
+ (void) makeGetRequestToUrl:(NSString *)urlString
         withCompletionBlock:(networkCompletionBlock) completionBlock;
@end
