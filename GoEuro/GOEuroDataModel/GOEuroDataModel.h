//
//  GoEuroDataModel.h
//  UIPractice
//
//  Created by Harpreet Singh on 16/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GOEuroDataModel : NSObject
- (id) initWithDictionary:(NSDictionary *)dictionary;
- (NSString *) getProvideImageUrl;
- (NSString *) getDepartureTime;
- (NSString *) getArrivalTime;
- (NSString *) getNumberOfStopsAndDuration;
- (NSString *) getPriceInEuros;
- (NSString *) getDepartureDate;
- (NSString *) getArrivalDate;
@end
