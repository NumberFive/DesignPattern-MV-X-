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
    self.navigationItem.title = @"登录";
    
}
- (void)loginAction
{
//    NSString *username
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
