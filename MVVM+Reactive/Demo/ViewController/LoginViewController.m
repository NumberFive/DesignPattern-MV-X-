//
//  LoginViewController.m
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <KVNProgress/KVNProgress.h>
#import "LoginViewController.h"
#import "LoginView.h"
#import "LoginViewModel.h"
#import "UserCenterViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface LoginViewController ()
@property (nonatomic, strong) LoginViewModel *viewModel;
@property (nonatomic, strong) LoginView *loginView;
@end

@implementation LoginViewController
- (void)loadView
{
    self.view = self.loginView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录(随便输入两位数以上)";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
}

#pragma mark - Setter / Getter
- (LoginView *)loginView
{
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithViewModel:self.viewModel];
        
        @weakify(self);
        [_loginView.loginSignalSubject subscribeNext:^(id  _Nullable x) {
//            [KVNProgress showWithStatus:@"正在登录中..."];
            NSLog(@"subscribeNext");
        } error:^(NSError * _Nullable error) {
            if (error) {
                [KVNProgress showErrorWithStatus:error.localizedDescription];
            }
        } completed:^{
            @strongify(self);
            [KVNProgress showSuccessWithStatus:@"登录成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _loginView;
}
- (LoginViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc] init];
    }
    return _viewModel;
}

@end
