//
//  LoginServices.m
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "LoginServices.h"

@implementation LoginServices
- (void)requestLoginUsername:(NSString *)username
                    password:(NSString *)password
                     success:(void (^)(id responser))successHandle
                     failure:(void (^)(id responser))failureHandle
{
    //合法性验证
    if (username.length > 1 && password.length > 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (successHandle) {
                successHandle(@"登录成功");
            }
        });
    } else {
        if (failureHandle) {
            failureHandle(@"账号不合格");
        }
    }
}
@end
