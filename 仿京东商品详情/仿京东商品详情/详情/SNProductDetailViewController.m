//
//  SNProductDetailViewController.m
//  仿京东商品详情
//
//  Created by Snake on 2019/4/24.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "SNProductDetailViewController.h"

#import "SNProductDetailWebView.h"

@interface SNProductDetailViewController ()

@end

@implementation SNProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    SNProductDetailWebView *detailView = [[SNProductDetailWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:detailView];
}

@end
