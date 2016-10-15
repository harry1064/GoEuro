//
//  GOEuroListViewCellTableViewCell.h
//  UIPractice
//
//  Created by Quinto Technologies Pvt. Ltd. on 15/10/16.
//  Copyright © 2016 Quinto Technologies Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GOEuroListView.h"
@class InfoView;
@interface GOEuroListViewCellTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *cellTypeImageView;
@property (nonatomic, strong) UIImageView *providerImageView;
@property (nonatomic, strong) InfoView *departView;
@property (nonatomic, strong) InfoView *arriveView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *stopsAndDurationLabel;

- (id) initWithType:(LIST_TYPE)type reuseIdentifier:(NSString *)reuseIdentifier;

@end

@interface InfoView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@end
