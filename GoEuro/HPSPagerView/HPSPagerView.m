//
//  HPSPagerView.m
//  UIPractice
//
//  Created by Harpreet Singh on 10/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import "HPSPagerView.h"
#define BASE_SCROLL_VIEW       @"baseScrollView"
#define SELF_VIEW                  @"selfView"
@interface HPSPagerView ()
@property (nonatomic, strong) UIScrollView *baseScrollView;
@end

@implementation HPSPagerView
@synthesize pagerDelegate = _pagerDelegate;
- (id) init {
    if (self = [super init]) {
        [self setupBaseScrollView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void) setupBaseScrollView {
    self.baseScrollView = [[UIScrollView alloc] init];
    [self.baseScrollView setDelegate:self];
    [self.baseScrollView setBackgroundColor:[UIColor blackColor]];
    self.baseScrollView.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.baseScrollView.pagingEnabled = YES;
    [self addSubview:self.baseScrollView];
    [self addConstraintForBaseScrollView];
}

- (void) addConstraintForBaseScrollView {
    NSMutableDictionary *views = [[NSMutableDictionary alloc] init];
    [views setObject:self.baseScrollView forKey:BASE_SCROLL_VIEW];
    [views setObject:self forKey:SELF_VIEW];
    NSString *horizontalConstraintString = [NSString stringWithFormat:@"H:|-0-[%@]-0-|", BASE_SCROLL_VIEW];
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintString
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views];
    NSString *verticalConstraintString = [NSString stringWithFormat:@"V:|-0-[%@]-0-|", BASE_SCROLL_VIEW];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintString
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views];
    
    [NSLayoutConstraint activateConstraints:horizontalConstraints];
    [NSLayoutConstraint activateConstraints:verticalConstraints];

}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    [self.pagerDelegate pageScrolledWithIndex:page];
    [self.pagerDelegate pagerViewDidScroll:scrollView.contentOffset];
}

- (void) loadHPSPagerViewWithView:(NSArray *)views {
    [self layoutIfNeeded];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height - 64;
    for (int i = 0; i < views.count; i++) {
        UIView *view = (UIView *)[views[i] objectForKey:@"view"];
        [view setFrame:CGRectMake(i * width, 0, width, height)];
        [self.baseScrollView addSubview:view];
    }
    [self.baseScrollView setContentSize:CGSizeMake(views.count * width, height)];
}

- (void) scrollToIndex:(NSInteger)index animated:(BOOL)animated {
    [self layoutIfNeeded];
    CGFloat width = self.frame.size.width;
    [self.baseScrollView setContentOffset:CGPointMake((index-1) * width, 0) animated:animated];
}
@end
