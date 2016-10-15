//
//  HPSToggleView.m
//  UIPractice
//
//  Created by Quinto Technologies Pvt. Ltd. on 11/10/16.
//  Copyright © 2016 Quinto Technologies Pvt. Ltd. All rights reserved.
//

#import "HPSToggleView.h"
#define BUTTON_BASEVIEW  @"buttonBaseView"
#define PAGER_VIEW  @"pagerView"
#define COLOR_DIVIDER 255.0
#define COLOR(r, g, b, a) [UIColor colorWithRed:r/COLOR_DIVIDER green:g/COLOR_DIVIDER blue:b/COLOR_DIVIDER alpha:a]
@interface HPSToggleView ()
@property (nonatomic, strong) NSArray *views;
@property (nonatomic, strong) UIView *buttonBaseView;
@property (nonatomic, strong) HPSPagerView *pagerView;
@end

@implementation HPSToggleView
{
    NSLayoutConstraint *leadingConstraintForLine;
}
@synthesize hpsToggleDelegate = _hpsToggleDelegate;
- (id) init {
    if (self = [super init]) {
        [self setupViewHierarchy];
    }
    return self;
}

- (void) setupViewHierarchy {
    self.buttonBaseView = [[UIView alloc] init];
    [self.buttonBaseView setBackgroundColor:[UIColor colorWithRed:15.0/255.0 green:97.0/255.0 blue:163.0/255.0 alpha:1.0]];
    self.buttonBaseView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.buttonBaseView];
    
    self.pagerView = [[HPSPagerView alloc] init];
    [self.pagerView setPagerDelegate:self];
    self.pagerView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.pagerView];
    
    [self setupViewsConstraint];
}

- (void) setupViewsConstraint {
    NSMutableDictionary *views = [[NSMutableDictionary alloc] init];
    [views setObject:self.buttonBaseView forKey:BUTTON_BASEVIEW];
    [views setObject:self.pagerView forKey:PAGER_VIEW];
    
    NSString *horizontalConstraintStringForButtonBaseView = [NSString stringWithFormat:@"H:|-0-[%@]-0-|", BUTTON_BASEVIEW];
    NSArray *horizontalConstraintForButtonBaseView = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintStringForButtonBaseView
                                                                                             options:0
                                                                                             metrics:nil
                                                                                               views:views];
    NSString *verticalConstraintStringForButtonBaseView = [NSString stringWithFormat:@"V:|-0-[%@(50)]", BUTTON_BASEVIEW];
    NSArray *verticalConstraintForButtonBaseView = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForButtonBaseView
                                                                                           options:0
                                                                                           metrics:nil
                                                                                             views:views];
    
    NSString *horizontalConstraintStringForBaseScrollView = [NSString stringWithFormat:@"H:|-0-[%@]-0-|", PAGER_VIEW];
    NSArray *horizontalConstraintsForBaseScrollView = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintStringForBaseScrollView
                                                                                              options:0
                                                                                              metrics:nil
                                                                                                views:views];
    NSString *verticalConstraintStringForBaseScrollView = [NSString stringWithFormat:@"V:[%@]-0-[%@]-0-|", BUTTON_BASEVIEW, PAGER_VIEW];
    NSArray *verticalConstraintsForBaseScrollView = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForBaseScrollView
                                                                                            options:0
                                                                                            metrics:nil
                                                                                              views:views];
    
    [NSLayoutConstraint activateConstraints:horizontalConstraintForButtonBaseView];
    [NSLayoutConstraint activateConstraints:verticalConstraintForButtonBaseView];
    [NSLayoutConstraint activateConstraints:horizontalConstraintsForBaseScrollView];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForBaseScrollView];
    
}

- (void) loadWithViews:(NSArray *)views {
    self.views = views;
    [self.pagerView loadHPSPagerViewWithView:views];
    [self addToggleButtons:views];
}

- (void) addToggleButtons:(NSArray *)views {
    NSMutableDictionary *buttons = [[NSMutableDictionary alloc] init];
    for (NSInteger i = 0; i < views.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.translatesAutoresizingMaskIntoConstraints = FALSE;
        NSString *title = [views[i] objectForKey:@"title"];
        [button setTitle:title forState:UIControlStateNormal];
        [buttons setObject:button forKey:[NSString stringWithFormat:@"button%ld", (long)i+1]];
        [button setTag:(i+1)];
        [button addTarget:self action:@selector(toggleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonBaseView addSubview:button];
    }
    [self setupConstraintForButtons:buttons];
}

- (void) setupConstraintForButtons:(NSMutableDictionary *)buttons {
    NSMutableString *horizontalConstraintStringForButtonBaseView = [NSMutableString string];
    [horizontalConstraintStringForButtonBaseView appendString:@"H:|-0-"];
    if([buttons objectForKey:@"button1"]) {
        [horizontalConstraintStringForButtonBaseView appendFormat:@"[%@]-0-", @"button1"];
        NSArray *verticalConstraintsForButton1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[button1]-|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:buttons];
        [NSLayoutConstraint activateConstraints:verticalConstraintsForButton1];
    }
    
    if([buttons objectForKey:@"button2"]) {
        [horizontalConstraintStringForButtonBaseView appendFormat:@"[%@(==%@)]-0-", @"button2", @"button1"];
        NSArray *verticalConstraintsForButton2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[button2]-|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:buttons];
        [NSLayoutConstraint activateConstraints:verticalConstraintsForButton2];
    }
    
    if ([buttons objectForKey:@"button3"]) {
        [horizontalConstraintStringForButtonBaseView appendFormat:@"[%@(==%@)]-0-", @"button3", @"button2"];
        NSArray *verticalConstraintsForButton3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[button3]-|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:buttons];
        [NSLayoutConstraint activateConstraints:verticalConstraintsForButton3];
    }
    
    [horizontalConstraintStringForButtonBaseView appendString:@"|"];
    
    NSArray *constraintsForButtons = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintStringForButtonBaseView options:0 metrics:nil views:buttons];
    [NSLayoutConstraint activateConstraints:constraintsForButtons];
    [self addLineToButtonBaseView];
}

- (void) toggleButtonClicked:(UIButton *)button {
    NSInteger index = button.tag;
    [self.pagerView scrollToIndex:index animated:YES];
    [self animateLineForButtonIndex:index];
}

- (void) addLineToButtonBaseView {
    UILabel *lineLabel = [[UILabel alloc] init];
    [lineLabel setBackgroundColor:COLOR(252, 156, 63, 1.0)];
    lineLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.buttonBaseView addSubview:lineLabel];
    leadingConstraintForLine = [NSLayoutConstraint constraintWithItem:lineLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.buttonBaseView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    [NSLayoutConstraint activateConstraints:@[leadingConstraintForLine]];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:lineLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:2.0];
    [NSLayoutConstraint activateConstraints:@[heightConstraint]];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:lineLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.buttonBaseView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [NSLayoutConstraint activateConstraints:@[bottomConstraint]];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:lineLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:(self.frame.size.width/(self.views.count))];
    [NSLayoutConstraint activateConstraints:@[widthConstraint]];
}

- (void) animateLineForButtonIndex:(NSInteger)index {
    [self layoutIfNeeded];
    CGFloat lineWidthDistance = self.frame.size.width/ (self.views.count);
    leadingConstraintForLine.constant = (index - 1) * lineWidthDistance;
    [UIView animateWithDuration:0.3 animations:^{
        [self.buttonBaseView layoutIfNeeded];
    }];
}

#pragma mark HPSPagerView delegate

- (void) pageScrolledWithIndex:(NSInteger)index {
    [self.hpsToggleDelegate toggledWithIndex:index];
}

- (void) pagerViewDidScroll:(CGPoint)offset {
    leadingConstraintForLine.constant = offset.x * (1.0/self.views.count);
    [self.buttonBaseView layoutIfNeeded];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
