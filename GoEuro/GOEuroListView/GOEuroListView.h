//
//  GOEuroListView.h
//  UIPractice
//
//  Created by Harpreet Singh on 16/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    TRAIN = 1,
    BUS,
    FLIGHT
}LIST_TYPE;

@interface GOEuroListView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSString *title;
- (id) initWithType:(LIST_TYPE)type;
@end
