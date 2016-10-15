//
//  GOEuroListViewCellTableViewCell.m
//  UIPractice
//
//  Created by Harpreet Singh on 16/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import "GOEuroListViewCellTableViewCell.h"

NSString *const PROVIDER_IMAGEVIEW_KEY = @"providerImageView";
NSString *const CELL_TYPE_IMAGEVIEW_KEY = @"cellTypeImageView";
NSString *const PRICE_LABEL_KEY = @"priceLabel";
NSString *const STOPS_AND_DURATION_LABEL_KEY = @"stopsAndDurationLabel";
NSString *const DEPART_VIEW_KEY = @"departView";
NSString *const ARRIVE_VIEW_KEY = @"arriveView";
@interface GOEuroListViewCellTableViewCell ()
@end

@implementation GOEuroListViewCellTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void) setupViews {
    self.providerImageView  = [[UIImageView alloc] init];
    self.providerImageView.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.providerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.providerImageView setImage:[UIImage imageNamed:@"megabus.png"]];
    [self.contentView addSubview:self.providerImageView];
    
    self.cellTypeImageView = [[UIImageView alloc] init];
    self.cellTypeImageView.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.cellTypeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.cellTypeImageView];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.priceLabel];
    
    self.stopsAndDurationLabel = [[UILabel alloc] init];
    self.stopsAndDurationLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.stopsAndDurationLabel.textAlignment = NSTextAlignmentCenter;
    [self.stopsAndDurationLabel setFont:[UIFont systemFontOfSize:10.0]];
    [self.contentView addSubview:self.stopsAndDurationLabel];
    
    self.departView = [[InfoView alloc] init];
    self.departView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.departView.titleLabel setText:@"DEPARTURE"];
    [self.contentView addSubview:self.departView];
    
    self.arriveView = [[InfoView alloc] init];
    self.arriveView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.arriveView.titleLabel setText:@"ARRIVAL"];
    [self.contentView addSubview:self.arriveView];
    
    [self setupViewsConstraints];
}

- (void) setupViewsConstraints {
    NSMutableDictionary *views = [NSMutableDictionary dictionary];
    [views setObject:self.providerImageView forKey:PROVIDER_IMAGEVIEW_KEY];
    [views setObject:self.cellTypeImageView forKey:CELL_TYPE_IMAGEVIEW_KEY];
    [views setObject:self.departView forKey:DEPART_VIEW_KEY];
    [views setObject:self.arriveView forKey:ARRIVE_VIEW_KEY];
    [views setObject:self.priceLabel forKey:PRICE_LABEL_KEY];
    [views setObject:self.stopsAndDurationLabel forKey:STOPS_AND_DURATION_LABEL_KEY];
    
    NSString *horizontalConstraintStringForProviderImageView = [NSString stringWithFormat:@"H:|-0-[%@]-0-|", PROVIDER_IMAGEVIEW_KEY];
    NSArray *horizontalConstraintForProviderImageView = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintStringForProviderImageView
                                                                                                options:0
                                                                                                metrics:nil
                                                                                                  views:views];
    [NSLayoutConstraint activateConstraints:horizontalConstraintForProviderImageView];
    
    NSString *verticalConstraintStringForProviderImageView = [NSString stringWithFormat:@"V:|-0-[%@(30)]", PROVIDER_IMAGEVIEW_KEY];
    NSArray *verticalConstraintForProviderImageView = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForProviderImageView
                                                                                                options:0
                                                                                                metrics:nil
                                                                                                  views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintForProviderImageView];
    
    NSLayoutConstraint *centerXForCellTypeImageView = [NSLayoutConstraint constraintWithItem:self.cellTypeImageView
                                                                                   attribute:NSLayoutAttributeCenterX
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.contentView
                                                                                   attribute:NSLayoutAttributeCenterX
                                                                                  multiplier:1.0
                                                                                    constant:0.0];
    NSLayoutConstraint *centerYConstraintForCellTypeImageView = [NSLayoutConstraint constraintWithItem:self.cellTypeImageView
                                                                                             attribute:NSLayoutAttributeCenterY
                                                                                             relatedBy:NSLayoutRelationEqual
                                                                                                toItem:self.contentView
                                                                                             attribute:NSLayoutAttributeCenterY
                                                                                            multiplier:1.0
                                                                                              constant:15.0];
    NSLayoutConstraint *widthConstraintForCellTypeImageView = [NSLayoutConstraint constraintWithItem:self.cellTypeImageView
                                                                                           attribute:NSLayoutAttributeWidth
                                                                                           relatedBy:NSLayoutRelationEqual
                                                                                              toItem:nil
                                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                                          multiplier:1.0
                                                                                            constant:32];
    NSLayoutConstraint *heightConstraintForCellTypeImageView = [NSLayoutConstraint constraintWithItem:self.cellTypeImageView
                                                                                           attribute:NSLayoutAttributeHeight
                                                                                           relatedBy:NSLayoutRelationEqual
                                                                                              toItem:nil
                                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                                          multiplier:1.0
                                                                                            constant:32.0];
    NSArray<NSLayoutConstraint *> *constraintsForCellTypeImageView = @[centerXForCellTypeImageView, centerYConstraintForCellTypeImageView, widthConstraintForCellTypeImageView, heightConstraintForCellTypeImageView];
    [NSLayoutConstraint activateConstraints:constraintsForCellTypeImageView];
    
    NSString *horizontalConstraintStringForDepartAndArriveView = [NSString stringWithFormat:@"H:[%@(110)]-30-[%@]-30-[%@(110)]", DEPART_VIEW_KEY, CELL_TYPE_IMAGEVIEW_KEY, ARRIVE_VIEW_KEY];
    NSArray *horizontalConstraintsForDepartAndArriveView = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintStringForDepartAndArriveView
                                                                                                   options:0
                                                                                                   metrics:nil
                                                                                                     views:views];
    [NSLayoutConstraint activateConstraints:horizontalConstraintsForDepartAndArriveView];
    
    NSString *verticalConstraintStringForDepartView = [NSString stringWithFormat:@"V:[%@]-10-[%@(90)]", PROVIDER_IMAGEVIEW_KEY, DEPART_VIEW_KEY];
    NSArray *verticalConstraintsForDepartView = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForDepartView
                                                                                                   options:0
                                                                                                   metrics:nil
                                                                                                     views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForDepartView];
    
    NSString *verticalConstraintStringForArriveView = [NSString stringWithFormat:@"V:[%@]-10-[%@(90)]", PROVIDER_IMAGEVIEW_KEY, ARRIVE_VIEW_KEY];
    NSArray *verticalConstraintsForArriveView = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForArriveView
                                                                                        options:0
                                                                                        metrics:nil
                                                                                          views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForArriveView];
    
    
    NSString *horizontalConstraintStringForPriceLabel = [NSString stringWithFormat:@"H:[%@]-0-[%@]-0-[%@]", DEPART_VIEW_KEY, PRICE_LABEL_KEY, ARRIVE_VIEW_KEY];
    NSArray *horizontalConstraintsForPriceLabel = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintStringForPriceLabel options:0 metrics:nil views:views];
    [NSLayoutConstraint activateConstraints:horizontalConstraintsForPriceLabel];
    NSString *verticalConstraintStringForPriceLabel = [NSString stringWithFormat:@"V:[%@]-10-[%@]-0-[%@]", PROVIDER_IMAGEVIEW_KEY,PRICE_LABEL_KEY, CELL_TYPE_IMAGEVIEW_KEY];
    NSArray *verticalConstraintsForPriceLabel = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForPriceLabel
                                                                                        options:0
                                                                                        metrics:nil
                                                                                          views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForPriceLabel];
    
    
    NSString *horizontalConstraintStringForStopsAndDurationLabel = [NSString stringWithFormat:@"H:[%@]-0-[%@]-0-[%@]", DEPART_VIEW_KEY, STOPS_AND_DURATION_LABEL_KEY, ARRIVE_VIEW_KEY];
    NSArray *horizontalConstraintsForStopsAndDurationLabel = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintStringForStopsAndDurationLabel options:0 metrics:nil views:views];
    [NSLayoutConstraint activateConstraints:horizontalConstraintsForStopsAndDurationLabel];
    NSString *verticalConstraintStringForStopsAndDurationLabel = [NSString stringWithFormat:@"V:[%@]-10-[%@]-10-|", CELL_TYPE_IMAGEVIEW_KEY, STOPS_AND_DURATION_LABEL_KEY];
    NSArray *verticalConstraintsForStopsAndDurationLabel = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForStopsAndDurationLabel
                                                                                        options:0
                                                                                        metrics:nil
                                                                                          views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForStopsAndDurationLabel];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


NSString *const TITLE_LABEL_KEY = @"titleLabel";
NSString *const TIME_LABEL_KEY = @"timeLabel";
NSString *const DATE_LABEL_KEY = @"dateLabel";

@implementation InfoView

- (id) init{
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void) setupViews {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.titleLabel setTextColor:[UIColor lightGrayColor]];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setFont:[UIFont systemFontOfSize:10.0]];
    [self addSubview:self.titleLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.timeLabel setTextColor:[UIColor darkGrayColor]];
    [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.timeLabel setFont:[UIFont systemFontOfSize:40.0]];
    [self.timeLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.timeLabel];
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.dateLabel setTextColor:[UIColor darkGrayColor]];
    [self.dateLabel setTextAlignment:NSTextAlignmentCenter];
    [self.dateLabel setText:@"22june,2016"];
    [self.dateLabel setBackgroundColor:[UIColor clearColor]];
    [self.dateLabel setFont:[UIFont systemFontOfSize:10.0]];
    [self addSubview:self.dateLabel];
    [self setupViewsConstraints];
}

- (void) setupViewsConstraints {
    NSMutableDictionary *views = [[NSMutableDictionary alloc] init];
    [views setObject:self.titleLabel forKey:TITLE_LABEL_KEY];
    [views setObject:self.timeLabel  forKey:TIME_LABEL_KEY];
    [views setObject:self.dateLabel forKey:DATE_LABEL_KEY];
    
    NSString *horizontalConstraintStringForTitleLabel = [NSString stringWithFormat:@"H:|-0-[%@]-0-|", TITLE_LABEL_KEY];
    NSArray *horizontalConstraintsForTitleLabel = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintStringForTitleLabel
                                                                                          options:0
                                                                                          metrics:nil
                                                                                            views:views];
    [NSLayoutConstraint activateConstraints:horizontalConstraintsForTitleLabel];
    
    
    
    
    NSString *horizontalConstraintStringForTimeLabel = [NSString stringWithFormat:@"H:|-0-[%@]-0-|", TIME_LABEL_KEY];
    NSArray *horizontalConstraintsForTimeLabel = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintStringForTimeLabel
                                                                                          options:0
                                                                                          metrics:nil
                                                                                            views:views];
    [NSLayoutConstraint activateConstraints:horizontalConstraintsForTimeLabel];
    
    
    
    
    NSString *horizontalConstraintStringForDateLabel = [NSString stringWithFormat:@"H:|-0-[%@]-0-|", DATE_LABEL_KEY];
    NSArray *horizontalConstraintsForDateLabel = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintStringForDateLabel
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:views];
    [NSLayoutConstraint activateConstraints:horizontalConstraintsForDateLabel];
    
    
    
    NSString *verticalConstraintStringForTitleLabel = [NSString stringWithFormat:@"V:|-0-[%@(20)]", TITLE_LABEL_KEY];
    NSArray *verticalConstraintsForTitleLabel = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForTitleLabel
                                                                                          options:0
                                                                                          metrics:nil
                                                                                            views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForTitleLabel];
    
    NSString *verticalConstraintStringForTimeLabel = [NSString stringWithFormat:@"V:[%@]-5-[%@(40)]", TITLE_LABEL_KEY, TIME_LABEL_KEY];
    NSArray *verticalConstraintsForTimeLabel = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForTimeLabel
                                                                                        options:0
                                                                                        metrics:nil
                                                                                          views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForTimeLabel];
    
    NSString *verticalConstraintStringForDateLabel = [NSString stringWithFormat:@"V:[%@]-5-[%@(20)]-0-|", TIME_LABEL_KEY, DATE_LABEL_KEY];
    NSArray *verticalConstraintsForDateLabel = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForDateLabel
                                                                                       options:0
                                                                                       metrics:nil
                                                                                         views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForDateLabel];
    
}


@end
