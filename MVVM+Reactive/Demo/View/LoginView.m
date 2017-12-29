;//
//  LoginView.m
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "LoginView.h"
#import <Masonry/Masonry.h>

@interface LoginView ()<UITextFieldDelegate>
{
    UITextField *_usernameTF;
    UITextField *_passwordTF;
    UIButton *_loginButton;
    RACSignal *_signal;
}
@property (nonatomic, strong) LoginViewModel *viewModel;
@end
@implementation LoginView
@synthesize usernameTF = _usernameTF;
@synthesize passwordTF = _passwordTF;
@synthesize loginButton = _loginButton;

- (instancetype)initWithViewModel:(LoginViewModel *)viewModel;
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        
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
        
        RAC(self.viewModel, username) = self.usernameTF.rac_textSignal;
        RAC(self.viewModel, password) = self.passwordTF.rac_textSignal;
        
        @weakify(self);
        [[self.usernameTF rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.usernameTF.layer.borderColor = [UIColor redColor].CGColor;
        }];
        [[self.usernameTF rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.usernameTF.layer.borderColor = [UIColor brownColor].CGColor;
        }];
        [[self.passwordTF rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.passwordTF.layer.borderColor = [UIColor redColor].CGColor;
        }];
        [[self.passwordTF rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.passwordTF.layer.borderColor = [UIColor brownColor].CGColor;
        }];

        RACSignal *validUsernameSignal = [self.usernameTF.rac_textSignal map:^(NSString * value) {
            return @(value.length > 1);
        }];
        RACSignal *validPasswordSignal = [self.passwordTF.rac_textSignal map:^(NSString *value) {
            return @(value.length > 1);
        }];
        RAC(self.usernameTF, backgroundColor) = [validUsernameSignal map:^(NSNumber *valid) {
            return valid.boolValue ? [UIColor greenColor] : [UIColor clearColor];
        }];
        RAC(self.passwordTF, backgroundColor) = [validPasswordSignal map:^(NSNumber *valid) {
            return valid.boolValue ? [UIColor greenColor] : [UIColor clearColor];
        }];
        
        RACSignal *loginActiveSignal = [RACSignal combineLatest:@[validUsernameSignal,validPasswordSignal] reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
            return @([usernameValid boolValue]&&[passwordValid boolValue]);
        }];
        [loginActiveSignal subscribeNext:^(NSNumber *active) {
            @strongify(self);
            self.loginButton.enabled = [active boolValue];
            self.loginButton.backgroundColor = active.boolValue ? [UIColor brownColor] : [UIColor grayColor];
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
