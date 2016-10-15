//
//  GOEuroTitleView.m
//  UIPractice
//
//  Created by Quinto Technologies Pvt. Ltd. on 15/10/16.
//  Copyright © 2016 Quinto Technologies Pvt. Ltd. All rights reserved.
//

#import "GOEuroTitleView.h"
NSString *const SOURCE_LABEL_KEY = @"sourceLabel";
NSString *const DESTINATION_LABEL_KEY  = @"destinationLabel";
NSString *const CURRENT_SELECTED_IMAGEVIEW_KEY = @"currentSelectedImageView";
@implementation GOEuroTitleView

- (id) init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void) setupViews {
    self.sourcelabel = [[UILabel alloc] init];
    [self.sourcelabel setTextColor:[UIColor whiteColor]];
    self.sourcelabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.sourcelabel];
    
    self.destinationLabel = [[UILabel alloc] init];
    [self.destinationLabel setTextColor:[UIColor whiteColor]];
    self.destinationLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.destinationLabel];
    
    self.currentSelectedImageView = [[UIImageView alloc] init];
    self.currentSelectedImageView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.currentSelectedImageView];
    
    [self setupViewsConstraints];
}

- (void) setupViewsConstraints {
    [self.sourcelabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.destinationLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    NSMutableDictionary *views = [[NSMutableDictionary alloc] init];
    [views setObject:self.sourcelabel forKey:SOURCE_LABEL_KEY];
    [views setObject:self.destinationLabel forKey:DESTINATION_LABEL_KEY];
    [views setObject:self.currentSelectedImageView forKey:CURRENT_SELECTED_IMAGEVIEW_KEY];
    
    NSString *horizontalConstraintString = [NSString stringWithFormat:@"H:|-0-[%@]-20-[%@(26)]-20-[%@]-0-|", SOURCE_LABEL_KEY, CURRENT_SELECTED_IMAGEVIEW_KEY, DESTINATION_LABEL_KEY];
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintString
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views];
    [NSLayoutConstraint activateConstraints:horizontalConstraints];
    
    NSString *verticalConstraintStringForSourceLabel = [NSString stringWithFormat:@"V:|-0-[%@(40)]-0-|", SOURCE_LABEL_KEY];
    NSArray *verticalConstraintsForSourceLabel = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForSourceLabel
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForSourceLabel];
    
    NSString *verticalConstraintStringForCurrentSelectedImageView = [NSString stringWithFormat:@"V:|-7-[%@(26)]-7-|", CURRENT_SELECTED_IMAGEVIEW_KEY];
    NSArray *verticalConstraintsForCurrentSelectedImageView = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForCurrentSelectedImageView
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForCurrentSelectedImageView];
    
    NSString *verticalConstraintStringForDestinationLabel = [NSString stringWithFormat:@"V:|-0-[%@(40)]-0-|", DESTINATION_LABEL_KEY];
    NSArray *verticalConstraintsForDestinationLabel = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForDestinationLabel
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForDestinationLabel];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
