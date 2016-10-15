//
//  GOEuroListView.m
//  UIPractice
//
//  Created by Harpreet Singh on 16/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import "GOEuroListView.h"
#import "GoEuroDataModel.h"
#import "GOEuroListViewCellTableViewCell.h"
#import "GOEuroNetworkCommunicationController.h"
#import <UIImageView+AFNetworking.h>
NSString *const INFO_TABLEVIEW_KEY = @"infoTableView";
@interface GOEuroListView ()
@property (nonatomic) LIST_TYPE listType;
@property (nonatomic, strong) UITableView *infoTableView;
@end

@implementation GOEuroListView
{
    NSString *cellTypeImageFile;
    NSString *restApiUrl;
    NSArray *resApiDataArray;
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
            restApiUrl = @"https://api.myjson.com/bins/3zmcy";
            break;
        case BUS:
            self.title = @"Bus";
            cellTypeImageFile = @"bus.png";
            restApiUrl = @"https://api.myjson.com/bins/37yzm";
            break;
        case FLIGHT:
            self.title = @"Flight";
            cellTypeImageFile = @"flight.png";
            restApiUrl = @"https://api.myjson.com/bins/w60i";
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
    self.infoTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.infoTableView.backgroundView = [self getBackgroundViewForInfoTableView];
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
    
    [self getRestApiData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return resApiDataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GOEuroListViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[GOEuroListViewCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *dic = [resApiDataArray objectAtIndex:indexPath.row];
    GOEuroDataModel *model = [[GOEuroDataModel alloc] initWithDictionary:dic];
    [cell.providerImageView setImageWithURL:[NSURL URLWithString:[model getProvideImageUrl]] placeholderImage:[UIImage imageNamed:@"defualtGoEuro.png"]];
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
    return 150;
}

- (void) refreshView {
    [self getRestApiData];
}

- (void) getRestApiData {
    [self showNetworkCallIndicator];
    [GOEuroNetworkCommunicationController makeGetRequestToUrl:restApiUrl withCompletionBlock:^(BOOL finished, id response) {
        [self hideNetworkCallIndicator];
        if (finished && response) {
            resApiDataArray = response;
            [self.infoTableView reloadData];
        }else {
            //Handle Error to notify user
        }
    }];
}

- (UIView *) getBackgroundViewForInfoTableView {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.infoTableView.bounds.size.width, self.infoTableView.bounds.size.height)];
    UIImageView *iconImageView = [[UIImageView alloc] init];
    
    [iconImageView setImage:[UIImage imageNamed:cellTypeImageFile]];
    iconImageView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [backgroundView addSubview:iconImageView];
    
    NSLayoutConstraint *widthConstraintIconImageView = [NSLayoutConstraint constraintWithItem:iconImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:32];
    [backgroundView addConstraint:widthConstraintIconImageView];
    NSLayoutConstraint *heightConstraintIconImageView = [NSLayoutConstraint constraintWithItem:iconImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:32];
    [backgroundView addConstraint:heightConstraintIconImageView];
    NSLayoutConstraint *centerXConstraintIconImageView = [NSLayoutConstraint constraintWithItem:iconImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [backgroundView addConstraint:centerXConstraintIconImageView];
    NSLayoutConstraint *centerYConstraintIconImageView = [NSLayoutConstraint constraintWithItem:iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [backgroundView addConstraint:centerYConstraintIconImageView];
    
    return backgroundView;
}

- (void) showNetworkCallIndicator {
    [self.infoTableView setTableHeaderView:[self networkCallIndicator]];
    [self.infoTableView scrollRectToVisible:[self.infoTableView convertRect:self.infoTableView.tableHeaderView.bounds fromView:self.infoTableView.tableHeaderView] animated:YES];
}

- (void) hideNetworkCallIndicator {
    [self.infoTableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (UIView *) networkCallIndicator {
    NSString *const PAD1 = @"pad1";
    NSString *const PAD2 = @"pad2";
    NSString *const ACTIVITY_INDICATOR = @"activityIndicator";
    NSString *const STATUS_LABEL = @"statusLabel";
    UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.infoTableView.bounds.size.width, 40)];
    [indicatorView setBackgroundColor:[UIColor darkGrayColor]];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.translatesAutoresizingMaskIntoConstraints = FALSE;
    [activityIndicator startAnimating];
    [indicatorView addSubview:activityIndicator];
    
    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [statusLabel setFont:[UIFont systemFontOfSize:10]];
    [statusLabel setTextColor:[UIColor whiteColor]];
    [statusLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [statusLabel setText:@"   Fetching..."];
    [indicatorView addSubview:statusLabel];
    UIView *paddingView1 = [[UIView alloc] init];
    paddingView1.translatesAutoresizingMaskIntoConstraints = FALSE;
    [indicatorView addSubview:paddingView1];
    
    UIView *paddingView2 = [[UIView alloc] init];
    paddingView2.translatesAutoresizingMaskIntoConstraints = FALSE;
    [indicatorView addSubview:paddingView2];
    
    NSMutableDictionary *views = [NSMutableDictionary dictionary];
    [views setObject:activityIndicator forKey:@"activityIndicator"];
    [views setObject:statusLabel forKey:@"statusLabel"];
    [views setObject:paddingView1 forKey:@"pad1"];
    [views setObject:paddingView2 forKey:@"pad2"];
    
    NSString *horizontalConstraintString = [NSString stringWithFormat:@"H:|-0-[%@(==%@)]-0-[%@]-0-[%@]-0-[%@]-0-|", PAD1, PAD2, ACTIVITY_INDICATOR, STATUS_LABEL, PAD2];
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintString
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views];
    [NSLayoutConstraint activateConstraints:horizontalConstraints];
    
    NSString *verticalConstraintStringForActivityIndicator = [NSString stringWithFormat:@"V:|-10-[%@]", ACTIVITY_INDICATOR];
    NSArray *verticalConstraintsForActivityIndicator = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForActivityIndicator
                                                                                               options:0
                                                                                               metrics:nil
                                                                                                 views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForActivityIndicator];
    
    NSString *verticalConstraintsStringForStatusLabel = [NSString stringWithFormat:@"V:|-0-[%@]-0-|", STATUS_LABEL];
    NSArray *verticalConstraintsForStatusLabel = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintsStringForStatusLabel
                                                                                               options:0
                                                                                               metrics:nil
                                                                                                 views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForStatusLabel];
    
    return indicatorView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
