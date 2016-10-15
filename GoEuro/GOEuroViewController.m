//
//  ViewController.m
//  GoEuro
//
//  Created by Harpreet Singh. on 16/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import "GOEuroViewController.h"
#import "GOEuroListView.h"
#import "GOEuroTitleView.h"
@interface GOEuroViewController ()

@end

@implementation GOEuroViewController
{
    GOEuroListView *trainView;
    GOEuroListView *busView;
    GOEuroListView *flightView;
    HPSToggleView *toggleView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.titleView = [self getTitleViewWithSource:@"Berlin" destination:@"Munich" image:[UIImage imageNamed:@"trainWhite.png"]];
    trainView = [[GOEuroListView alloc] initWithType:TRAIN];
    busView = [[GOEuroListView alloc] initWithType:BUS];
    flightView = [[GOEuroListView alloc] initWithType:FLIGHT];
    
    [self setupViews];
}

- (void) setupViews {
    toggleView = [[HPSToggleView alloc] init];
    toggleView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [toggleView setHpsToggleDelegate:self];
    [self.view addSubview:toggleView];
    
    [self setupViewsConstraints];
    [self.view layoutIfNeeded];
     [toggleView loadWithViews:@[@{@"title":trainView.title,@"view":trainView}, @{@"title":busView.title, @"view":busView}, @{@"title":flightView.title, @"view":flightView}]];
}

- (void) setupViewsConstraints {
    NSString *const TOGGLE_VIEW = @"toggleView";
    NSDictionary *views = [NSDictionary dictionaryWithObjectsAndKeys:toggleView, TOGGLE_VIEW, nil];
    NSString *horizontalConstraintStringForToggleView = [NSString stringWithFormat:@"H:|-0-[%@]-0-|", TOGGLE_VIEW];
    NSArray *horizontalConstraintsForToggleView = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintStringForToggleView
                                                                                          options:0
                                                                                          metrics:nil
                                                                                            views:views];
    [NSLayoutConstraint activateConstraints:horizontalConstraintsForToggleView];
    
    
    NSString *verticalConstraintStringForToggleView = [NSString stringWithFormat:@"V:|-0-[%@]-0-|", TOGGLE_VIEW];
    NSArray *verticalConstraintsForToggleView = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintStringForToggleView
                                                                                          options:0
                                                                                          metrics:nil
                                                                                            views:views];
    [NSLayoutConstraint activateConstraints:verticalConstraintsForToggleView];
    
}



- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) toggledWithIndex:(NSInteger)index {
    UIImage *image;
    switch (index) {
        case 0:
            image = [UIImage imageNamed:@"trainWhite.png"];
            break;
        case 1:
            image = [UIImage imageNamed:@"busWhite.png"];
            break;
        case 2:
            image = [UIImage imageNamed:@"flightWhite.png"];
            break;
        default:
            break;
    }
    self.navigationItem.titleView = [self getTitleViewWithSource:@"Berlin" destination:@"Munich" image:image];
}

- (GOEuroTitleView *) getTitleViewWithSource:(NSString *)source
                                 destination:(NSString *)destination
                                       image:(UIImage *)image {
    GOEuroTitleView *titleView = [[GOEuroTitleView alloc] init];
    [titleView.sourcelabel setText:source];
    [titleView.destinationLabel setText:destination];
    [titleView.currentSelectedImageView setImage:image];
    titleView.translatesAutoresizingMaskIntoConstraints = false;
    [titleView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [titleView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    return titleView;
}

- (void) reachabilityDidChange:(NSNotification *)notification {
    [super reachabilityDidChange:notification];
    if([notification.name isEqualToString:AFNetworkingReachabilityDidChangeNotification]) {
        if([[[notification userInfo] valueForKey:AFNetworkingReachabilityNotificationStatusItem] intValue] != AFNetworkReachabilityStatusNotReachable) {
            [trainView refreshView];
            [busView refreshView];
            [flightView refreshView];
        }
    }
}

@end
