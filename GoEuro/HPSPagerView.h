//
//  HPSPagerView.h
//  UIPractice
//
//  Created by Quinto Technologies Pvt. Ltd. on 10/10/16.
//  Copyright © 2016 Quinto Technologies Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HPSPagerViewDelegate <NSObject>

- (void) pageScrolledWithIndex:(NSInteger)index;
- (void) pagerViewDidScroll:(CGPoint)offset;
@end

@interface HPSPagerView : UIView<UIScrollViewDelegate>
{
    id<HPSPagerViewDelegate> pagerDelegate;
}
@property (nonatomic, strong) NSArray *views;
@property (nonatomic) id<HPSPagerViewDelegate> pagerDelegate;
- (void) loadHPSPagerViewWithView:(NSArray *)views;
- (void) scrollToIndex:(NSInteger)index animated:(BOOL)animated;
@end
