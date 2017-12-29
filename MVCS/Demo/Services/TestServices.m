//
//  TestServices.m
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "TestServices.h"
#import "TestStore.h"
@interface TestServices ()
@property (nonatomic, strong) TestStore *store;
@end
@implementation TestServices
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = (NSArray *)[self.store objectForKey:@"dataArray"];
    }
    return self;
}
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
                  Success:(void (^)(id responser))successHandle
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

#pragma mark - Setter / Getter
- (TestStore *)store
{
    if (!_store) {
        _store = [[TestStore alloc] init];
    }
    return _store;
}
- (void)setDataArray:(NSArray *)dataArray
{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
        [self.store setObject:dataArray forKey:@"dataArray"];
    }
}
@end
