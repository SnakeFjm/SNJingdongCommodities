//
//  NSObject+SNNewKVO.h
//  仿京东商品详情
//
//  Created by Snake on 2019/4/24.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^kvoBlock)(void);

@interface NSObject (SNNewKVO)

- (void)snObserver:(NSObject *)object keyPath:(NSString *)keyPath block:(kvoBlock)block;

@end

NS_ASSUME_NONNULL_END
