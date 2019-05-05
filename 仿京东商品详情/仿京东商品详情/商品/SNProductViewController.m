//
//  SNProductViewController.m
//  仿京东商品详情
//
//  Created by Snake on 2019/4/24.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "SNProductViewController.h"

#import "SNNavTitleView.h"

#import "SNProductScrollView.h"

#import "SNProductDetailWebView.h"

static const CGFloat detailWebViewOffsetY = 70.f;

@interface SNProductViewController () <UIScrollViewDelegate>
{
    SNNavTitleView *titleView;
}

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *sonView;
@property (nonatomic, strong) UIScrollView *productUpDownScrollView;
@property (nonatomic, strong) SNProductScrollView *productLeftRightScrollView;
@property (nonatomic, strong) UILabel *displayProductLabel;
@property (nonatomic, strong) SNProductDetailWebView *productDetailWebView;

@end

@implementation SNProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加contentView
    [self.view addSubview:self.contentView];
    
    // 添加上下的scrollView
    [self.contentView addSubview:self.productUpDownScrollView];
    
    //添加商品详情webView
    [self.contentView addSubview:self.productDetailWebView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    //
    titleView = (SNNavTitleView *)self.parentViewController.navigationItem.titleView;
}

#pragma mark - UIScrollView delegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //
    if (scrollView == self.productUpDownScrollView) {
        // 更改productLeftRightScrollView对y值 遮盖图片
        CGFloat yOffset = scrollView.contentOffset.y;
        self.productLeftRightScrollView.sn_y = yOffset / 2;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //
    if (decelerate) {
        // 上下的scrollView
        if (scrollView == self.productUpDownScrollView) {
            //
            CGFloat yOffset = scrollView.contentOffset.y;
            // 滑动到scrollView底部的时候+80的距离
            if (yOffset > self.view.sn_height + 80) {
                //
                [UIView animateWithDuration:0.4 animations:^{
                    //
                    self.contentView.sn_y = -self.view.sn_height;
                    self->titleView.contentOffset = CGPointMake(0.f, 44.f);
                }];
            }
        } else {    // webView的scrollView
            //
            CGFloat yOffset = scrollView.contentOffset.y;
            if (yOffset < detailWebViewOffsetY) {
                [UIView animateWithDuration:0.4f animations:^{
                    //
                    self.contentView.sn_y =  0.f;
                    self->titleView.contentOffset = CGPointMake(0.f, 0.f);
                    
                }];
            }
        }
    }
}

#pragma mark - getter方法

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_SIZE.width, 2 * self.view.sn_height)];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIScrollView *)productUpDownScrollView {
    if (!_productUpDownScrollView) {
        _productUpDownScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_SIZE.width, self.view.sn_height)];
        _productUpDownScrollView.showsVerticalScrollIndicator = YES;
        _productUpDownScrollView.backgroundColor = [UIColor clearColor];
        _productUpDownScrollView.delegate = self;
        _productUpDownScrollView.contentSize = CGSizeMake(SCREEN_SIZE.width, 2 * self.view.sn_height);
        
        // 添加左右的scrollView
        [_productUpDownScrollView addSubview:self.productLeftRightScrollView];
        
        // 添加子view
        CGFloat displayProductLabelHeight = 40.f;
        //
        _sonView = [[UIView alloc] initWithFrame:CGRectMake(0.f, _productLeftRightScrollView.sn_bottomY, SCREEN_SIZE.width, 2 * self.view.sn_height - _productLeftRightScrollView.sn_bottomY - displayProductLabelHeight)];
        _sonView.layer.shadowOffset = CGSizeMake(0.f, -1.f);
        _sonView.layer.shadowOpacity = 0.8f;
        _sonView.layer.shadowColor = [[UIColor grayColor] CGColor];
        _sonView.backgroundColor = [UIColor lightGrayColor];
        [_productUpDownScrollView addSubview:_sonView];
        
        // 添加上拉显示商品详情label
        _displayProductLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, _sonView.sn_bottomY, SCREEN_SIZE.width, displayProductLabelHeight)];
        _displayProductLabel.textAlignment = NSTextAlignmentCenter;
        _displayProductLabel.text = @"上拉显示商品详情";
        [_productUpDownScrollView addSubview:_displayProductLabel];
        
    }
    return _productUpDownScrollView;
}

- (SNProductScrollView *)productLeftRightScrollView {
    if (!_productLeftRightScrollView) {
        //添加轮播图片数组
        NSArray *imageArr = @[@"product_1", @"product_0", @"product_1", @"product_0", @"product_1", @"product_0"];
        
        _productLeftRightScrollView = [[SNProductScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.sn_width, self.view.sn_width)];
        _productLeftRightScrollView.backgroundColor = [UIColor clearColor];
        _productLeftRightScrollView.imageArr = imageArr;
    }
    return _productLeftRightScrollView;
}

- (SNProductDetailWebView *)productDetailWebView {
    if (!_productDetailWebView) {
        _productDetailWebView = [[SNProductDetailWebView alloc] initWithFrame:CGRectMake(0.f, self.view.sn_height, SCREEN_SIZE.width, self.view.sn_height)];
        _productDetailWebView.showTextLabel = YES;
        _productDetailWebView.webView.scrollView.delegate = self;
    }
    return _productDetailWebView;
}

@end
