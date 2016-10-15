//
//  GOEuroNetworkCommunicationController.m
//  GoEuro
//
//  Created by Quinto Technologies Pvt. Ltd. on 16/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import "GOEuroNetworkCommunicationController.h"

@implementation GOEuroNetworkCommunicationController

+ (void) makeGetRequestToUrl:(NSString *)urlString
         withCompletionBlock:(networkCompletionBlock) completionBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        completionBlock(true, responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completionBlock(false, error);
    }];

}
@end
