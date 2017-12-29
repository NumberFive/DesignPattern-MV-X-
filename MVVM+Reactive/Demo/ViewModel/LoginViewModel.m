//
//  LoginViewModel.m
//  Demo
//
//  Created by 伍小华 on 2017/12/29.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginServices.h"

@interface LoginViewModel()
@property (nonatomic, strong) LoginServices *services;
@end
@implementation LoginViewModel

- (void)requestLoginSuccess:(void (^)(id responser))successHandle
                     failure:(void (^)(id responser))failureHandle
{
    [self.services requestLoginUsername:self.username
                               password:self.password
                                success:^(id responser) {
                                    if (successHandle) {
                                        successHandle(responser);
                                    }
                                }
                                failure:failureHandle];
}

#pragma mark - Setter / Getter
- (LoginServices *)services
{
    if (!_services) {
        _services = [[LoginServices alloc] init];
    }
    return _services;
}
@end
