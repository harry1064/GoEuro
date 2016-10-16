//
//  GOEuroFilterView.m
//  GoEuro
//
//  Created by Harpreet Singh on 16/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import "GOEuroFilterView.h"
NSString *const TITLE_LABEL = @"titleLabel";
NSString *const DEPARTURE_BUTTON = @"departureButton";
NSString *const ARRIVAL_BUTTON = @"arrivalButton";
NSString *const DURATION_BUTTON = @"durationButton";
NSString *const DEPARTURE_LABEL = @"departureLabel";
NSString *const ARRIVAL_LABEL = @"arrivalLabel";
NSString *const DURATION_LABEL = @"durationLabel";

@interface GOEuroFilterView ()
@property (nonatomic) filterChangedCompletionBlock changeBlock;
@end
@implementation GOEuroFilterView
{
    UILabel *titleLabel;
    UILabel *departureLabel;
    UILabel *arrivalLabel;
    UILabel *durationLabel;
    UIButton *departureTimeButton;
    UIButton *arrivalTimeButton;
    UIButton *durationTimeButton;
}
- (id) init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void) setupViews {
    
    self.backgroundColor = [UIColor colorWithRed:15.0/255.0 green:97.0/255.0 blue:163.0/255.0 alpha:1.0];
    self.layer.cornerRadius = 4.0;
    self.layer.shadowRadius = 20.0;
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    
    UIImage *plusImage = [UIImage imageNamed:@"plusIcon"];
    UIImage *tickImage = [UIImage imageNamed:@"tickIcon"];
    titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [titleLabel setText:@"ORDER BY"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:titleLabel];
    
    departureLabel = [[UILabel alloc] init];
    departureLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [departureLabel setText:@"Departure"];
    [departureLabel setTextAlignment:NSTextAlignmentLeft];
    [departureLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:departureLabel];
    
    arrivalLabel = [[UILabel alloc] init];
    arrivalLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [arrivalLabel setText:@"Arrival"];
    [arrivalLabel setTextAlignment:NSTextAlignmentLeft];
    [arrivalLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:arrivalLabel];
    
    durationLabel = [[UILabel alloc] init];
    durationLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [durationLabel setText:@"Duration"];
    [durationLabel setTextAlignment:NSTextAlignmentLeft];
    [durationLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:durationLabel];
    
    departureTimeButton = [[UIButton alloc] init];
    departureTimeButton.tag = DEPARTURE;
    [departureTimeButton setImage:plusImage forState:UIControlStateNormal];
    [departureTimeButton setImage:tickImage forState:UIControlStateSelected];
    [departureTimeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    departureTimeButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:departureTimeButton];
    
    arrivalTimeButton = [[UIButton alloc] init];
    arrivalTimeButton.tag = ARRIVAL;
    [arrivalTimeButton setImage:plusImage forState:UIControlStateNormal];
    [arrivalTimeButton setImage:tickImage forState:UIControlStateSelected];
    [arrivalTimeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    arrivalTimeButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:arrivalTimeButton];
    
    durationTimeButton = [[UIButton alloc] init];
    durationTimeButton.tag = DURATION;
    [durationTimeButton setImage:plusImage forState:UIControlStateNormal];
    [durationTimeButton setImage:tickImage forState:UIControlStateSelected];
    [durationTimeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    durationTimeButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:durationTimeButton];
    
    [departureTimeButton setSelected:YES];
    
    [self setupViewConstraints];
}

- (void) setupViewConstraints {
    NSMutableDictionary *views = [NSMutableDictionary dictionary];
    [views setObject:titleLabel forKey:TITLE_LABEL];
    [views setObject:departureTimeButton forKey:DEPARTURE_BUTTON];
    [views setObject:arrivalTimeButton forKey:ARRIVAL_BUTTON];
    [views setObject:durationTimeButton forKey:DURATION_BUTTON];
    [views setObject:departureLabel forKey:DEPARTURE_LABEL];
    [views setObject:arrivalLabel forKey:ARRIVAL_LABEL];
    [views setObject:durationLabel forKey:DURATION_LABEL];
    
    NSArray *keys = @[@[DEPARTURE_LABEL ,DEPARTURE_BUTTON],
                      @[ARRIVAL_LABEL, ARRIVAL_BUTTON],
                      @[DURATION_LABEL, DURATION_BUTTON]];
    
    NSArray *horizontalConstraintForTitleLabel = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[%@]-0-|", TITLE_LABEL]
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views];
    [NSLayoutConstraint activateConstraints:horizontalConstraintForTitleLabel];
    for (NSArray *keyArray in keys) {
        NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[%@]-[%@(40)]-10-|", keyArray[0], keyArray[1]]
                                                                                             options:0
                                                                                             metrics:nil
                                                                                               views:views];
        [NSLayoutConstraint activateConstraints:horizontalConstraints];
    }
    
    NSString *verticalConstraintsString = [NSString stringWithFormat:@"V:|-5-[%@(20)]-10-[%@(40)]-0-[%@(40)]-0-[%@(40)]-0-|", TITLE_LABEL, DEPARTURE_BUTTON, ARRIVAL_BUTTON, DURATION_BUTTON];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintsString
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraints];
    
    NSString *verticalConstraintsStringForLabels = [NSString stringWithFormat:@"V:[%@]-10-[%@(40)]-0-[%@(40)]-0-[%@(40)]-0-|", TITLE_LABEL, DEPARTURE_LABEL, ARRIVAL_LABEL, DURATION_LABEL];
    NSArray *verticalConstraintsLabels = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintsStringForLabels
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsLabels];
}

- (void) buttonClicked:(UIButton *) button {
    [button setSelected:YES];
    self.changeBlock ? self.changeBlock((ORDER_BY)button.tag) : nil;
    NSArray *buttonsArray = @[departureTimeButton, arrivalTimeButton, durationTimeButton];
    for (UIButton *bttn in buttonsArray) {
        if (bttn.tag != button.tag) {
            [bttn setSelected:NO];
        }
    }
}

- (void) notifyWithChangeBlock:(filterChangedCompletionBlock)changeBlock {
    self.changeBlock = changeBlock;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
