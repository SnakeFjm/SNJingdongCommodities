//
//  UIView+Size.h
//  仿京东商品详情
//
//  Created by Snake on 2019/4/24.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Size)

@property (nonatomic, assign) CGFloat sn_x;
@property (nonatomic, assign) CGFloat sn_y;
@property (nonatomic, assign) CGFloat sn_width;
@property (nonatomic, assign) CGFloat sn_height;
@property (nonatomic, assign) CGSize sn_size;
@property (nonatomic, assign) CGPoint sn_origin;
@property (nonatomic, assign) CGFloat sn_bottomY;

@end

NS_ASSUME_NONNULL_END
