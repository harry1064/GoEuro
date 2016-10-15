//
//  GoEuroDataModel.h
//  UIPractice
//
//  Created by Quinto Technologies Pvt. Ltd. on 15/10/16.
//  Copyright © 2016 Quinto Technologies Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoEuroDataModel : NSObject
- (id) initWithDictionary:(NSDictionary *)dictionary;
- (NSString *) getDepartureTime;
- (NSString *) getArrivalTime;
- (NSString *) getNumberOfStopsAndDuration;
- (NSString *) getPriceInEuros;
- (NSString *) getDepartureDate;
- (NSString *) getArrivalDate;
@end
