//
//  SNProductDetailWebView.m
//  仿京东商品详情
//
//  Created by Snake on 2019/4/25.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "SNProductDetailWebView.h"

@implementation SNProductDetailWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.sn_width, self.sn_height)];
        _webView.scrollView.backgroundColor = [UIColor clearColor];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://snakefjm.github.io"]]];
        [self addSubview:_webView];
    }
    return self;
}

- (void)setShowTextLabel:(BOOL)showTextLabel {
     _showTextLabel = showTextLabel;
    //
    if (_showTextLabel) {  //显示下拉回到商品主页／释放回到商品主页 文字
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 30.f, self.sn_width, 44.f)];
        _textLabel.text = @"下拉回到商品主页";
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor whiteColor];
        [_webView insertSubview:_textLabel atIndex:0];
        
    }
}

@end
