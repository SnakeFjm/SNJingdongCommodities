//
//  SNNavTitleView.h
//  仿京东商品详情
//
//  Created by Snake on 2019/4/24.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^btnBlock)(int index);

@interface SNNavTitleView : UIScrollView

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) btnBlock btnActionBlock;
@property (nonatomic, strong) UILabel *indicatorLabel;

@end

NS_ASSUME_NONNULL_END
