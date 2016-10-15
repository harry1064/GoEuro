//
//  HPSToggleView.h
//  UIPractice
//
//  Created by Harpreet Singh on 10/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPSPagerView.h"

@protocol HPSToggleViewDelegate <NSObject>

- (void) toggledWithIndex:(NSInteger)index;

@end

@interface HPSToggleView : UIView<UIScrollViewDelegate, HPSPagerViewDelegate>
{
    id<HPSToggleViewDelegate> hpsToggleDelegate;
}
@property (nonatomic) id<HPSToggleViewDelegate> hpsToggleDelegate;
- (void) loadWithViews:(NSArray *)views;

@end
