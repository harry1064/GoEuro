//
//  GOEuroListView.m
//  UIPractice
//
//  Created by Quinto Technologies Pvt. Ltd. on 15/10/16.
//  Copyright © 2016 Quinto Technologies Pvt. Ltd. All rights reserved.
//

#import "GOEuroListView.h"
#import "GoEuroDataModel.h"
#import "GOEuroListViewCellTableViewCell.h"
NSString *const INFO_TABLEVIEW_KEY = @"infoTableView";
@interface GOEuroListView ()
@property (nonatomic) LIST_TYPE listType;
@property (nonatomic, strong) UITableView *infoTableView;
@end

@implementation GOEuroListView
{
    NSString *cellTypeImageFile;
}

- (id) initWithType:(LIST_TYPE)type {
    if (self = [super init]) {
        self.listType = type;
        [self defaultInitialization];
        [self setupViews];
    }
    return self;
}

- (void) defaultInitialization {
    switch (self.listType) {
        case TRAIN:
            self.title = @"Train";
            cellTypeImageFile = @"train.png";
            break;
        case BUS:
            self.title = @"Bus";
            cellTypeImageFile = @"bus.png";
            break;
        case FLIGHT:
            self.title = @"Flight";
            cellTypeImageFile = @"flight.png";
            break;
        default:
            break;
    }
}

- (void) setupViews {
    self.infoTableView = [[UITableView alloc] init];
    self.infoTableView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.infoTableView setDelegate:self];
    [self.infoTableView setDataSource:self];
    [self.infoTableView registerClass:[GOEuroListViewCellTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:self.infoTableView];
    
    [self setupViewsConstraints];
}

- (void) setupViewsConstraints {
    NSMutableDictionary *views = [[NSMutableDictionary alloc] init];
    [views setObject:self.infoTableView forKey:INFO_TABLEVIEW_KEY];
    
    NSString *horizontalConstraintStringForInfoTableview = [NSString stringWithFormat:@"H:|-0-[%@]-0-|", INFO_TABLEVIEW_KEY];
    NSArray *horizontalConstraintsForInfoTableView = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintStringForInfoTableview
                                                                                             options:0
                                                                                             metrics:nil
                                                                                               views:views];
    [NSLayoutConstraint activateConstraints:horizontalConstraintsForInfoTableView];
    
    NSString *verticalConstraintStringForInfoTableview = [NSString stringWithFormat:@"V:|-0-[%@]-0-|", INFO_TABLEVIEW_KEY];
    NSArray *verticalConstraintsForInfoTableView = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForInfoTableview
                                                                                           options:0
                                                                                           metrics:nil
                                                                                             views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForInfoTableView];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GOEuroListViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[GOEuroListViewCellTableViewCell alloc] initWithType:BUS reuseIdentifier:@"cell"];
    }
    NSDictionary *dic = @{
                          @"id": @(1),
                          @"provider_logo": @"http://cdn-goeuro.com/static_content/web/logos/63/postbus.png",
                          @"price_in_euros": @(5.48),
                          @"departure_time": @"2:41",
                          @"arrival_time": @"5:41",
                          @"number_of_stops": @(2)
                          };
    GoEuroDataModel *model = [[GoEuroDataModel alloc] initWithDictionary:dic];
    cell.cellTypeImageView.image = [UIImage imageNamed:cellTypeImageFile];
    [cell.departView.timeLabel setText:[model getDepartureTime]];
    [cell.arriveView.timeLabel setText:[model getArrivalTime]];
    [cell.priceLabel setText:[model getPriceInEuros]];
    [cell.stopsAndDurationLabel setText:[model getNumberOfStopsAndDuration]];
    [cell.departView.dateLabel setText:[model getDepartureDate]];
    [cell.arriveView.dateLabel setText:[model getArrivalDate]];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
