//
//  GOEuroListViewCellTableViewCell.h
//  UIPractice
//
//  Created by Harpreet Singh on 16/10/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InfoView;
@interface GOEuroListViewCellTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *cellTypeImageView;
@property (nonatomic, strong) UIImageView *providerImageView;
@property (nonatomic, strong) InfoView *departView;
@property (nonatomic, strong) InfoView *arriveView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *stopsAndDurationLabel;

@end

@interface InfoView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@end
