//
//  GoEuroDataModel.m
//  UIPractice
//
//  Created by Harpreet Singh on 16/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import "GOEuroDataModel.h"

NSString *const PROVIDER_LOGO = @"provider_logo";
NSString *const PRICE_IN_EUROS = @"price_in_euros";
NSString *const DEPARTURE_TIME = @"departure_time";
NSString *const ARRIVAL_TIME = @"arrival_time";
NSString *const NUMBER_OF_STOPS = @"number_of_stops";
NSString *const DATE_FORMAT = @"dd/MM/YYYY";
@interface GOEuroDataModel()
@property (nonatomic, strong) NSString *provider_logo;
@property (nonatomic) double price_in_euros;
@property (nonatomic, strong) NSString *departure_time;
@property (nonatomic, strong) NSString *arrival_time;
@property (nonatomic) NSInteger number_of_stops;
@end

@implementation GOEuroDataModel {
    NSDate *depatureDate;
    NSDate *arrivalDate;
}
- (id) initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.provider_logo = [dictionary objectForKey:PROVIDER_LOGO];
        self.price_in_euros = [[dictionary objectForKey:PRICE_IN_EUROS] doubleValue];
        self.departure_time =  [GOEuroDataModel getFormattedTimeString:[dictionary objectForKey:DEPARTURE_TIME]];
        self.arrival_time = [GOEuroDataModel getFormattedTimeString:[dictionary objectForKey:ARRIVAL_TIME]];
        self.number_of_stops = [[dictionary objectForKey:NUMBER_OF_STOPS] integerValue];
        depatureDate = [NSDate date];
        arrivalDate = [depatureDate copy];
    }
    return self;
}

- (NSString *) getDepartureTime {
    return self.departure_time;
}

- (NSString *) getArrivalTime {
    return self.arrival_time;
}

- (NSString *) getNumberOfStopsAndDuration {
    return (self.number_of_stops > 0) ? [NSString stringWithFormat:@"%ld stops, %@", (long)self.number_of_stops, [self getDuration]] : [NSString stringWithFormat:@"Direct, %@", [self getDuration]];
}

- (NSString *) getPriceInEuros {
    return [NSString stringWithFormat:@"€%.2f", (double)self.price_in_euros];
}

- (NSString *) getDepartureDate {
    return [GOEuroDataModel getDateStringInFormat:DATE_FORMAT date:depatureDate];
}

- (NSString *) getArrivalDate {
    return [GOEuroDataModel getDateStringInFormat:DATE_FORMAT date:arrivalDate];
}
#pragma mark PRIVATE METHOD

- (NSString *) getDuration  {
    NSDate *departure = [GOEuroDataModel dateFromString:self.departure_time
                                         withDateFromat:@"HH:mm"];
    NSDate *arrival = [GOEuroDataModel dateFromString:self.arrival_time
                                       withDateFromat:@"HH:mm"];
    return [self formatedDurationStringForDepartureDate:departure
                                            arrivalDate:arrival];
}

- (NSString *) formatedDurationStringForDepartureDate:(NSDate *)departure
                                          arrivalDate:(NSDate *)arrival {
    NSTimeInterval distanceBetweenDates = [arrival timeIntervalSinceDate:departure];
    int secondsInAnHour = 3600;
    int hour = (int)distanceBetweenDates / secondsInAnHour;
    if (hour <= 0) {
        hour += 24;
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = 1;
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        arrivalDate = [theCalendar dateByAddingComponents:dayComponent
                                                   toDate:arrivalDate
                                                  options:0];
    }
    int mintute = ((int)distanceBetweenDates % secondsInAnHour) / 60;
    return (mintute > 0) ? [NSString stringWithFormat:@"%d:%dh", hour, mintute] : [NSString stringWithFormat:@"%dh", hour];
}

#pragma  mark PRIVATE CLASS METHODS

+ (NSString *) getFormattedTimeString:(NSString *)inputTimeString {
    NSArray *componenets = [inputTimeString componentsSeparatedByString:@":"];
    if (componenets.count == 2) {
        return  [componenets[0] integerValue] < 10 ? [NSString stringWithFormat:@"0%@:%@", componenets[0], componenets[1]] : inputTimeString;
    }else {
        return inputTimeString;
    }
}

+ (NSDate *) dateFromString:(NSString *)dateString
             withDateFromat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *dateObject = [dateFormatter dateFromString:dateString];
    return dateObject;
}

+ (NSString *) getDateStringInFormat:(NSString *)format date:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

@end
