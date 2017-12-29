//
//  TestServices.m
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "TestServices.h"

@implementation TestServices
- (void)requestDataSuccess:(void (^)(id responser))successHandle
                   failure:(void (^)(id responser))failureHandle
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.dataArray = @[@"测试0",@"测试1",@"测试2",@"测试3",@"测试4",@"测试5",@"测试6"];
        if (successHandle) {
            successHandle(nil);
        }
    });
}
- (void)deleteItemAtIndex:(NSInteger)index
                  success:(void (^)(id responser))successHandle
                  failure:(void (^)(id responser))failureHandle
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSMutableArray *array = [strongSelf.dataArray mutableCopy];
        [array removeObjectAtIndex:index];
        strongSelf.dataArray = array;
        if (successHandle) {
            successHandle(nil);
        }
    });
}
@end
