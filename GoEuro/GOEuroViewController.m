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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.titleView = [self getTitleViewWithSource:@"Berlin" destination:@"Munich" image:[UIImage imageNamed:@"trainWhite.png"]];
    GOEuroListView *trainView = [[GOEuroListView alloc] initWithType:TRAIN];
    GOEuroListView *busView = [[GOEuroListView alloc] initWithType:BUS];
    GOEuroListView *flightView = [[GOEuroListView alloc] initWithType:FLIGHT];
    HPSToggleView *toggleView = [[HPSToggleView alloc] init];
    [toggleView setHpsToggleDelegate:self];
    [toggleView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    [toggleView loadWithViews:@[@{@"title":trainView.title,@"view":trainView}, @{@"title":busView.title, @"view":busView}, @{@"title":flightView.title, @"view":flightView}]];
    [self.view addSubview:toggleView];
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

@end
