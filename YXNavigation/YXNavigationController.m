//
//  YXNavigationController.m
//  baiwandian
//
//  Created by zdy on 15/9/28.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "YXNavigationController.h"

@interface YXNavigationDelegate : NSObject<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, weak) UINavigationController *navController;
@end

@implementation YXNavigationDelegate

- (id)initWithNavigationController:(UINavigationController *)aNavController
{
    if (self = [super init]) {
        _navController = aNavController;
    }
    return self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ((viewController.navigationItem.leftBarButtonItem == nil) &&
        ([navigationController.viewControllers count] >1)) {
        // 使用RenderingMode 避免navigationBar.tintColor 影响
        UIImage *image = [[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backBtnPressed)];
        viewController.navigationItem.leftBarButtonItem = back;
    }
}

- (void)backBtnPressed
{
    [self.navController popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return [self.navController.viewControllers count]>1?YES:NO;
}

@end


@interface YXNavigationController ()
@property (nonatomic, strong) YXNavigationDelegate *navDelegate;
@end

@implementation YXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavDelegate];
    
    self.navigationBar.translucent = NO;
}

- (void)setupNavDelegate
{
    self.navDelegate = [[YXNavigationDelegate alloc] initWithNavigationController:self];
    self.delegate = self.navDelegate;
    self.interactivePopGestureRecognizer.delegate = self.navDelegate;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count]) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}
@end
