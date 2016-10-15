//
//  ObserverBaseClass.m
//  JSQMessages
//
//  Created by Quinto Technologies Pvt. Ltd. on 29/03/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import "ObserverBaseClass.h"
@implementation ObserverBaseClass {
    UILabel *offlineLabel;
    NSLayoutConstraint *bottomConstraintOfflineView;
}
- (instancetype) init {
    self = [super init];
    if(self) {
        [self setupOfflineView];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    return self;
}

- (void) setupOfflineView {
    if(!offlineLabel) {
        offlineLabel = [[UILabel alloc] init];
        offlineLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
        [offlineLabel setBackgroundColor:[UIColor darkGrayColor]];
        [offlineLabel setFont:[UIFont systemFontOfSize:10]];
        [offlineLabel setTextColor:[UIColor whiteColor]];
        [offlineLabel setTextAlignment:NSTextAlignmentCenter];
        [offlineLabel setText:@"No internet connection"];
        [self.view addSubview:offlineLabel];

        // Leading constraint
        NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:offlineLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
        [self.view addConstraint:leadingConstraint];
        NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:offlineLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
        [self.view addConstraint:trailingConstraint];
        bottomConstraintOfflineView = [NSLayoutConstraint constraintWithItem:offlineLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
        [self.view addConstraint:bottomConstraintOfflineView];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:offlineLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30];
        [self.view addConstraint:heightConstraint];
    }
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setupOfflineView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void) hideOfflineLabel {
    bottomConstraintOfflineView.constant = 30;
    [UIView animateWithDuration:0.5 animations:^{
         [self.view layoutIfNeeded];
     } completion:^(BOOL finished) {
     }];
}

- (void) showOfflineLabel {
    [self.view bringSubviewToFront:offlineLabel];
    bottomConstraintOfflineView.constant = 0;
    [UIView animateWithDuration:0.5 animations:^{
         [self.view layoutIfNeeded];
     } completion:nil];
}
- (void) reachabilityDidChange:(NSNotification *)notification {
    // implement this method in every subclass
    if([notification.name isEqualToString:AFNetworkingReachabilityDidChangeNotification]) {
        if([[[notification userInfo] valueForKey:AFNetworkingReachabilityNotificationStatusItem] intValue] == AFNetworkReachabilityStatusNotReachable) {
            [self showOfflineLabel];
        } else {
            [self hideOfflineLabel];
        }
    }
}

@end
