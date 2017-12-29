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
    
    if (!username.length) {
        [self.loginView.usernameTF becomeFirstResponder];
        [KVNProgress showErrorWithStatus:@"请输入账号"];
    } else if (!password.length) {
        [self.loginView.passwordTF becomeFirstResponder];
        [KVNProgress showErrorWithStatus:@"请输入密码"];
    } else {
        [KVNProgress showWithStatus:@"正在登录中..."];
        
        __weak typeof(self) weakSelf = self;
        [self.viewModel requestLoginSuccess:^(id responser) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            UserCenterViewModel *userViewModel = [UserCenterViewModel sharedUserCenterViewModel];
            userViewModel.isLogined = YES;
            
            [KVNProgress showSuccessWithStatus:@"登录成功"];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(id responser) {
            [KVNProgress showErrorWithStatus:@"登录失败"];
        }];
    }
}

#pragma mark - Setter / Getter
- (LoginView *)loginView
{
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithViewModel:self.viewModel];
        [_loginView.loginButton addTarget:self
                                   action:@selector(loginAction)
                         forControlEvents:UIControlEventTouchUpInside];
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
