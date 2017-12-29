//
//  LoginView.h
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface LoginView : UIView
@property (nonatomic, strong, readonly) UITextField *usernameTF;
@property (nonatomic, strong, readonly) UITextField *passwordTF;
@property (nonatomic, strong, readonly) UIButton *loginButton;

@property (nonatomic, strong) RACSubject *loginSignalSubject;

- (instancetype)initWithViewModel:(LoginViewModel *)viewModel;


@end
