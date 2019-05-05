//
//  ViewController.m
//  仿京东商品详情
//
//  Created by Snake on 2019/4/24.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "ViewController.h"

#import "SNMainViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btn];
}

#pragma mark - Action
- (void)btnAction:(UIButton *)btn {
    //
    SNMainViewController *vc = [[SNMainViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - getter方法

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(100.f, 100.f, 200.f, 100.f)];
        _btn.backgroundColor = [UIColor lightGrayColor];
        //
        [_btn setTitle:@"进入商品详情" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _btn;
}


@end
