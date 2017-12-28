//
//  LoginViewController.m
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "LoginServices.h"
#import <KVNProgress/KVNProgress.h>

@interface LoginViewController ()
@property (nonatomic, strong) LoginServices *services;
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
    NSString *username = self.loginView.usernameTF.text;
    NSString *password = self.loginView.passwordTF.text;
    
    if (!username.length) {
        [KVNProgress showErrorWithStatus:@"请输入账号"];
    } else if (!password.length) {
        [KVNProgress showErrorWithStatus:@"请输入密码"];
    } else {
        [KVNProgress showWithStatus:@"正在登录中..."];
        
        __weak typeof(self) weakSelf = self;
        [self.services requestLoginUsername:username
                                   password:password
                                    success:^(id responser) {
                                        __strong __typeof(weakSelf) strongSelf = weakSelf;
                                        [KVNProgress showSuccessWithStatus:@"登录成功"];
                                        
                                        [strongSelf.navigationController popViewControllerAnimated:YES];
                                    } failure:^(id responser) {
                                        [KVNProgress showErrorWithStatus:@"登录失败"];
                                    }];
    }
}

#pragma mark - Setter / Getter
- (LoginServices *)services
{
    if (!_services) {
        _services = [[LoginServices alloc] init];
    }
    return _services;
}
- (LoginView *)loginView
{
    if (!_loginView) {
        _loginView = [[LoginView alloc] init];
        [_loginView.loginButton addTarget:self
                                   action:@selector(loginAction)
                         forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginView;
}

@end
