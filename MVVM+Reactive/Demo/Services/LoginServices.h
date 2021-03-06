//
//  LoginServices.h
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginServices : NSObject
- (void)requestLoginUsername:(NSString *)username
                    password:(NSString *)password
                     success:(void (^)(id responser))successHandle
                     failure:(void (^)(id responser))failureHandle;
@end
