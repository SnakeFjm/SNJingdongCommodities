//
//  NSObject+SNNewKVO.m
//  仿京东商品详情
//
//  Created by Snake on 2019/4/24.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "NSObject+SNNewKVO.h"
#import <objc/runtime.h>

typedef void(^deallocBlock)(void);

@interface SNKVOController : NSObject

@property (nonatomic, strong) NSObject *observedObject;
@property (nonatomic, strong) NSMutableArray<deallocBlock> *blockArr;

@end

@implementation SNKVOController

- (NSMutableArray<deallocBlock> *)blockArr {
    //
    if (!_blockArr) {
        _blockArr = [NSMutableArray array];
    }
    return _blockArr;
}


- (void)dealloc {
    NSLog(@"kvoController dealloc");
    // 对observedObject  removeObserver
    [_blockArr enumerateObjectsUsingBlock:^(deallocBlock  _Nonnull block, NSUInteger idx, BOOL * _Nonnull stop) {
        block();
    }];
}

@end

@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, kvoBlock> *dict;
@property (nonatomic, strong) SNKVOController *kvoController;

@end

@implementation NSObject (SNNewKVO)

- (void)snObserver:(NSObject *)object keyPath:(NSString *)keyPath block:(kvoBlock)block {
    //
    self.dict[keyPath] = block;
    
    // self已经持有了kvoController
    self.kvoController.observedObject = object;
    //
    __unsafe_unretained typeof(self)weakSelf = self;
    //
    [self.kvoController.blockArr addObject:^{
        //
        [object removeObserver:weakSelf forKeyPath:keyPath];
    }];
    
    // 监听
    [object addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //
    kvoBlock block = self.dict[keyPath];
    if (block) {
        block();
    }
}

#pragma mark getter 和 setter方法

- (NSMutableDictionary<NSString *,kvoBlock> *)dict {
    //
    NSMutableDictionary *tmpDict = objc_getAssociatedObject(self, @selector(dict));
    if (!tmpDict) {
        tmpDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(dict), tmpDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tmpDict;
}

- (SNKVOController *)kvoController {
    //
    SNKVOController *tmpKvoController = objc_getAssociatedObject(self, @selector(kvoController));
    if (!tmpKvoController) {
        tmpKvoController = [[SNKVOController alloc] init];
        objc_setAssociatedObject(self, @selector(kvoController), tmpKvoController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tmpKvoController;
}

@end
