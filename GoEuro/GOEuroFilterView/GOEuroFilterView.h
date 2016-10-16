//
//  GOEuroFilterView.h
//  GoEuro
//
//  Created by Harpreet Singh on 16/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DEPARTURE = 1,
    ARRIVAL = 2,
    DURATION = 3
}ORDER_BY;

typedef void (^filterChangedCompletionBlock)(ORDER_BY orderby);
@interface GOEuroFilterView : UIView
- (void) notifyWithChangeBlock:(filterChangedCompletionBlock)changeBlock;
@end
