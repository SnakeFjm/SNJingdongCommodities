//
//  SNProductScrollView.m
//  仿京东商品详情
//
//  Created by Snake on 2019/4/25.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "SNProductScrollView.h"

#import "SNImageScrollView.h"

#import "SNPageNumberView.h"

static const int pageNum = 3;

@interface SNProductScrollView () <UIScrollViewDelegate>
{
    CGFloat lastXOffset;
}

@property (nonatomic, strong) SNImageScrollView *imageScrollView;
@property(nonatomic, strong)UIImageView *leftImageView;
@property(nonatomic, strong)UIImageView *centerImageView;
@property(nonatomic, strong)UIImageView *rightImageView;

@property(nonatomic, strong)SNPageNumberView *pageNumberView;
@property(nonatomic, assign)NSInteger currentIndex;

@end

@implementation SNProductScrollView

- (void)setImageArr:(NSArray *)imageArr {
    _imageArr = imageArr;
    //
    self.backgroundColor = [UIColor whiteColor];
    //
    _currentIndex = 0;
    lastXOffset = 0.f;
    //
    // 添加views
    [self addSubview:self.imageScrollView];
    [self.imageScrollView addSubview:self.leftImageView];
    [self.imageScrollView addSubview:self.centerImageView];
    [self.imageScrollView addSubview:self.rightImageView];
    //
    [self addSubview:self.pageNumberView];
    
}

#pragma mark -scrollview delegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //
    CGFloat xOffset = scrollView.contentOffset.x;
    if (xOffset > self.sn_width / 2 && lastXOffset <= self.sn_width / 2) {
        //
        self.currentIndex += 1;
    } else if (xOffset < self.sn_width / 2 && lastXOffset >= self.sn_width / 2) {
        //
        self.currentIndex -= 1;
    } else if (xOffset > 3*self.sn_width / 2 && lastXOffset <= 3 * self.sn_width / 2) {
        //
        self.currentIndex += 1;
    } else if (xOffset < 3 * self.sn_width / 2 && lastXOffset >= 3 * self.sn_width / 2) {
        //
        self.currentIndex -= 1;
    }
    // 记录lastXOffset
    lastXOffset = xOffset;
    
    // 叠加效果 遮盖图片效果
    if (xOffset < self.sn_width) {  // 第一个页面
        //
        self.leftImageView.sn_x =  0.f + xOffset / 2;
    } else if (xOffset > self.sn_width && xOffset < 2 * self.sn_width) {
        //
        self.centerImageView.sn_x = self.sn_width + (xOffset - self.sn_width) / 2;
    }
    
    // 实现pageNumberView的翻转效果
    [self pageNumberViewAnimation:xOffset];
    
    //解决手势传递问题
    if (_currentIndex == _imageArr.count - 1) {
        //
        self.imageScrollView.isOpen = NO;
    } else {
        //
        self.imageScrollView.isOpen = YES;
    }
    
}

- (void)pageNumberViewAnimation:(CGFloat)xOffset {
    //
    CGFloat tmpOffset = 0.f;
    if (xOffset < self.sn_width / 2) {
        //
        tmpOffset = xOffset;
    } else if (xOffset >= self.sn_width / 2 && xOffset < self.sn_width) {
        //
        tmpOffset = xOffset - self.sn_width;
    } else if (xOffset >= self.sn_width && xOffset <= 3 * self.sn_width / 2) {
        //
        tmpOffset = xOffset - self.sn_width;
    } else if (xOffset >= 3 * self.sn_width / 2 && xOffset <= 2 * self.sn_width) {
        //
        tmpOffset = xOffset - 2 * self.sn_width;
    }
    
    // 绕y轴实现旋转,如果angel为正数，那么旋转方向逆时针；如果angel为负数，那么旋转方向顺时针
    self.pageNumberView.layer.transform = CATransform3DMakeRotation(tmpOffset * M_PI / (self.sn_width), 0, 1, 0);
}

// 修改图片内容
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {   // scrollView减速停止的时候
    // 假设我现在知道当前是第几页 currentIndex有可能为0，也有可能为_imageArray.count-1
    if (_currentIndex > 0 && _currentIndex < _imageArr.count - 1) {
        // 修改图片内容
        self.leftImageView.image = [UIImage imageNamed:_imageArr[_currentIndex - 1]];
        self.leftImageView.frame = CGRectMake(self.sn_width / 2, 0, self.sn_width, self.sn_height);
        //
        self.centerImageView.image = [UIImage imageNamed:_imageArr[_currentIndex]];
        self.centerImageView.frame = CGRectMake(self.sn_width, 0, self.sn_width, self.sn_height);
        //
        self.rightImageView.image = [UIImage imageNamed:_imageArr[_currentIndex + 1]];
        
        // 千万别忘记了
        lastXOffset = self.sn_width;
        
        //修改偏移量，停在中间
        [scrollView scrollRectToVisible:CGRectMake(self.sn_width, 0.f, self.sn_width, self.sn_height) animated:NO];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    //
    self.pageNumberView.text = [NSString stringWithFormat:@"%ld/%ld", (NSInteger)(_currentIndex + 1), _imageArr.count];
}

#pragma mark - getter method

- (SNImageScrollView *)imageScrollView {
    if (!_imageScrollView) {
        _imageScrollView = [[SNImageScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        _imageScrollView.contentSize = CGSizeMake(self.frame.size.width * pageNum, self.frame.size.width);
        _imageScrollView.backgroundColor = [UIColor whiteColor];
        _imageScrollView.pagingEnabled = YES;
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.delegate = self;
    }
    return _imageScrollView;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageArr[_currentIndex]]];
        _leftImageView.frame = CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.width);
        _leftImageView.userInteractionEnabled = YES;
    }
    return _leftImageView;
}

- (UIImageView *)centerImageView {
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageArr[_currentIndex + 1]]];
        _centerImageView.frame = CGRectMake(self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.width);
        _centerImageView.userInteractionEnabled = YES;
    }
    return _centerImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageArr[_currentIndex + 2]]];
        _rightImageView.frame = CGRectMake(2 * self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.width);
        _rightImageView.userInteractionEnabled = YES;
    }
    return _rightImageView;
}

- (SNPageNumberView *)pageNumberView {
    if (!_pageNumberView) {
        // 新建页码展示view
        _pageNumberView = [[SNPageNumberView alloc] initWithFrame:CGRectMake(self.frame.size.width-50.f, self.frame.size.height-40.f, 30.f, 30.f)];
        _pageNumberView.textColor = [UIColor whiteColor];
        _pageNumberView.text = [NSString stringWithFormat:@"%ld/%ld", (NSInteger)(_currentIndex + 1), _imageArr.count];
        _pageNumberView.layer.zPosition = 16.f;
    }
    return _pageNumberView;
}

@end
