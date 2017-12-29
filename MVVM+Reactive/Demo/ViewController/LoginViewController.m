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

- (void)loginAction
{
    NSString *username = self.viewModel.username;
    NSString *password = self.viewModel.password;
    
    @weakify(self);
    [self.viewModel requestLoginSuccess:^(id responser) {
        @strongify(self);
        [KVNProgress showSuccessWithStatus:@"登录成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(id responser) {
        [KVNProgress showErrorWithStatus:@"登录失败"];
    }];
}
#pragma mark - Setter / Getter
- (LoginView *)loginView
{
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithViewModel:self.viewModel];
        [_loginView.loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
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
