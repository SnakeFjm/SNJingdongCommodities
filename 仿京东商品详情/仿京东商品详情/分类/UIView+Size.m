//
//  UIView+Size.m
//  仿京东商品详情
//
//  Created by Snake on 2019/4/24.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "UIView+Size.h"

@implementation UIView (Size)

- (void)setSn_x:(CGFloat)sn_x
{
    CGRect frame = self.frame;
    frame.origin.x = sn_x;
    self.frame = frame;
}

- (CGFloat)sn_x
{
    return self.frame.origin.x;
}

- (void)setSn_y:(CGFloat)sn_y
{
    CGRect frame = self.frame;
    frame.origin.y = sn_y;
    self.frame = frame;
}

- (CGFloat)sn_y
{
    return self.frame.origin.y;
}

- (void)setSn_width:(CGFloat)sn_width
{
    CGRect frame = self.frame;
    frame.size.width = sn_width;
    self.frame = frame;
}

- (CGFloat)sn_width
{
    return self.frame.size.width;
}

- (void)setSn_height:(CGFloat)sn_height
{
    CGRect frame = self.frame;
    frame.size.height = sn_height;
    self.frame = frame;
}

- (CGFloat)sn_height
{
    return self.frame.size.height;
}

- (void)setSn_origin:(CGPoint)sn_origin
{
    CGRect frame = self.frame;
    frame.origin = sn_origin;
    self.frame = frame;
}

- (CGPoint)sn_origin
{
    return self.frame.origin;
}

- (void)setSn_size:(CGSize)sn_size
{
    CGRect frame = self.frame;
    frame.size = sn_size;
    self.frame = frame;
}

- (CGSize)sn_size
{
    return self.frame.size;
}

- (CGFloat)sn_bottomY
{
    return self.sn_y + self.sn_height;
}

-(void)setSn_bottomY:(CGFloat)sn_bottomY {
    
}

@end
