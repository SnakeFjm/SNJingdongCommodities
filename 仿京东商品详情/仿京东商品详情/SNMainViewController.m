//
//  SNMainViewController.m
//  仿京东商品详情
//
//  Created by Snake on 2019/4/24.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "SNMainViewController.h"

#import "SNNavTitleView.h"

#import "SNProductViewController.h"
#import "SNProductDetailViewController.h"
#import "SNCommentViewController.h"

@interface SNMainViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) SNNavTitleView *titleView;

@property (nonatomic, strong) SNProductViewController *productViewController;
@property (nonatomic, strong) SNProductDetailViewController *productDetailViewController;
@property (nonatomic, strong) SNCommentViewController *commentViewController;

@end

@implementation SNMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mainScrollView];
    
    //
    //定制导航栏
    [self customNavView];
    
    //添加商品view
    [self.mainScrollView addSubview:self.productViewController.view];
    
    //添加详情view
    [self.mainScrollView addSubview:self.productDetailViewController.view];
    
    //添加评价view
    [self.mainScrollView addSubview:self.commentViewController.view];
}

- (void)customNavView {
    //
    CGFloat btnHeight = 44.f;
    CGFloat btnWidth = 40.f;
    CGFloat btnSpace = 20.f;
    
    //
    NSArray *titleArr = @[@"商品", @"详情", @"评价"];
    //
    _titleView = [[SNNavTitleView alloc] initWithFrame:CGRectMake(0.f, 0.f, btnWidth * 3 + 2 * btnSpace, btnHeight)];
    _titleView.titleArr = titleArr;
    self.navigationItem.titleView = _titleView;
    
    //
    __weak typeof(self)weakSelf = self;
    _titleView.btnActionBlock = ^(int index) {
        //
        [weakSelf.mainScrollView scrollRectToVisible:CGRectMake(index * weakSelf.view.sn_width, 0.f, weakSelf.view.sn_width, weakSelf.view.sn_height) animated:YES];
    };
    
    //titleView添加对mainScrollView的观察
    __weak typeof(_titleView)weakTitleView = _titleView;
    [_titleView snObserver:_mainScrollView keyPath:@"contentOffset" block:^{
        //
        UIScrollView *scrollView = weakSelf.mainScrollView;
        CGFloat xOffset = scrollView.contentOffset.x;
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        // int index = xOffset / screenWidth;  如果用这个数值，往右滑没问题，但往左滑有问题，可以算一下边界，左边随便移动一下，index值就改变了
        int index;
        if (xOffset == screenWidth) {
            //
            index = 1;
            weakTitleView.indicatorLabel.transform = CGAffineTransformMakeTranslation(index * (btnWidth + btnSpace), 0.f);
        } else if (xOffset == 2 * screenWidth) {
            //
            index = 2;
            weakTitleView.indicatorLabel.transform = CGAffineTransformMakeTranslation(index * (btnWidth + btnSpace), 0.f);
        } else if (xOffset == 0) {
            //
            index = 0;
            weakTitleView.indicatorLabel.transform = CGAffineTransformMakeTranslation(index * (btnWidth + btnSpace), 0.f);
        }
        
    }];
    
    //
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0.f, 0.f, 25.f, 25.f);
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(0.f, 0.f, 25.f, 25.f);
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moreButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    
    self.navigationItem.rightBarButtonItems = @[moreButtonItem, shareButtonItem];
    
}

#pragma mark - Action

- (void)shareAction {
    
    NSLog(@"分享");
    
}

- (void)moreAction {
    
    NSLog(@"更多");
    
}

#pragma mark - getter方法

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.sn_width, self.view.sn_height)];
        _mainScrollView.backgroundColor = [UIColor redColor];
        _mainScrollView.bounces = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.showsHorizontalScrollIndicator = YES;
        _mainScrollView.contentSize = CGSizeMake(3 * self.view.sn_width, self.view.sn_height - 122.f);
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

- (SNProductViewController *)productViewController {
    if (!_productViewController) {
        _productViewController = [[SNProductViewController alloc] init];
        [self addChildViewController:_productViewController];
    }
    return _productViewController;
}

- (SNProductDetailViewController *)productDetailViewController {
    if (!_productDetailViewController) {
        _productDetailViewController = [[SNProductDetailViewController alloc] init];
        _productDetailViewController.view.frame = CGRectMake(self.view.sn_width, 0.f, self.mainScrollView.sn_width, self.mainScrollView.sn_height);
        [self addChildViewController:_productDetailViewController];
    }
    
    return _productDetailViewController;
}

- (SNCommentViewController *)commentViewController {
    if (!_commentViewController) {
        _commentViewController = [[SNCommentViewController alloc] init];
        _commentViewController.view.frame = CGRectMake(self.view.sn_width * 2, 0.f, self.mainScrollView.sn_width, self.mainScrollView.sn_height);
        [self addChildViewController:_commentViewController];
    }
    return _commentViewController;
}

@end
