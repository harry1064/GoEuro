//
//  GOEuroListView.h
//  UIPractice
//
//  Created by Quinto Technologies Pvt. Ltd. on 15/10/16.
//  Copyright © 2016 Quinto Technologies Pvt. Ltd. All rights reserved.
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
