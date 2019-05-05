//
//  SNProductDetailWebView.h
//  仿京东商品详情
//
//  Created by Snake on 2019/4/25.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNProductDetailWebView : UIView

@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, assign) BOOL showTextLabel;

@end

NS_ASSUME_NONNULL_END
