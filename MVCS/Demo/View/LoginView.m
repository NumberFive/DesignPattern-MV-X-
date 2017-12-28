//
//  LoginView.m
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "LoginView.h"
#import <Masonry/Masonry.h>

@interface LoginView ()
{
    UITextField *_usernameTF;
    UITextField *_passwordTF;
    UIButton *_loginButton;
}
@end
@implementation LoginView
@synthesize usernameTF = _usernameTF;
@synthesize passwordTF = _passwordTF;
@synthesize loginButton = _loginButton;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.usernameTF];
        [self addSubview:self.passwordTF];
        [self addSubview:self.loginButton];
        
        CGFloat space = 20;
        CGFloat height = 44.0;
        
        [self.usernameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(space);
            make.right.equalTo(self).offset(-space);
            make.height.equalTo(@(height));
            make.bottom.equalTo(self.passwordTF.mas_top).offset(-space);
        }];
        [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.usernameTF);
            make.centerY.equalTo(self);
        }];
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.usernameTF);
            make.top.equalTo(self.passwordTF.mas_bottom).offset(space);
        }];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.usernameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

#pragma mark - Setter / Getter
- (UITextField *)usernameTF
{
    if (!_usernameTF) {
        _usernameTF = [[UITextField alloc] init];
        _usernameTF.layer.borderWidth = 2.0;
        _usernameTF.layer.borderColor = [UIColor brownColor].CGColor;
        _usernameTF.layer.cornerRadius = 5.0;
        _usernameTF.textColor = [UIColor grayColor];
        _usernameTF.font = [UIFont systemFontOfSize:25.0];
        _usernameTF.placeholder = @"请输入账号";
    }
    return _usernameTF;
}
- (UITextField *)passwordTF
{
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.layer.borderWidth = 2.0;
        _passwordTF.layer.borderColor = [UIColor brownColor].CGColor;
        _passwordTF.layer.cornerRadius = 5.0;
        _passwordTF.textColor = [UIColor grayColor];
        _passwordTF.font = [UIFont systemFontOfSize:25.0];
        _passwordTF.placeholder = @"请输入密码";
        _passwordTF.secureTextEntry = YES;
    }
    return _passwordTF;
}
- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"登  录" forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor brownColor];
        _loginButton.layer.cornerRadius = 5.0;
    }
    return _loginButton;
}
@end
