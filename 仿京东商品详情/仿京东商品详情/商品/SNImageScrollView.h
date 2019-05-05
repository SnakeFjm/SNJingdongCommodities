//
//  SNImageScrollView.h
//  仿京东商品详情
//
//  Created by Snake on 2019/4/25.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNImageScrollView : UIScrollView <UIGestureRecognizerDelegate>

@property(nonatomic, assign)BOOL isOpen;

@end

NS_ASSUME_NONNULL_END
