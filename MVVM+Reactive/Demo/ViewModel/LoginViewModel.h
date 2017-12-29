//
//  LoginViewModel.h
//  Demo
//
//  Created by 伍小华 on 2017/12/29.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
- (void)requestLoginSuccess:(void (^)(id responser))successHandle
                    failure:(void (^)(id responser))failureHandle;
@end
