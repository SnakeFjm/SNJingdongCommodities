//
//  SNImageScrollView.m
//  仿京东商品详情
//
//  Created by Snake on 2019/4/25.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "SNImageScrollView.h"

@implementation SNImageScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.panGestureRecognizer.delegate = self;
        _isOpen = YES;
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        //
        UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)gestureRecognizer;
        CGFloat transitionX = [gesture translationInView:self].x;
        //
        if (transitionX < 0 && !_isOpen) {  //往左滑动
            //
            return NO;
        }
    }
    return YES;
}

@end
