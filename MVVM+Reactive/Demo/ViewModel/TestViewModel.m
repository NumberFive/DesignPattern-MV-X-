//
//  TestViewModel.m
//  Demo
//
//  Created by 伍小华 on 2017/12/29.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "TestViewModel.h"
#import "TestServices.h"
#import "TestStore.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface TestViewModel ()
@property (nonatomic, strong) TestServices *services;
@property (nonatomic, strong) TestStore *store;
@end
@implementation TestViewModel
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
    @weakify(self);
    [self.services requestDataSuccess:^(id responser) {
        @strongify(self);
        self.dataArray = responser;
        if (successHandle) {
            successHandle(responser);
        }
    } failure:^(id responser) {
        if (failureHandle) {
            failureHandle(responser);
        }
    }];
}
- (void)deleteItemAtIndex:(NSInteger)index
                  success:(void (^)(id responser))successHandle
                  failure:(void (^)(id responser))failureHandle
{
    @weakify(self);
    [self.services deleteItemAtIndex:index
                             success:^(id responser) {
                                 @strongify(self);
                                 NSMutableArray *array = [self.dataArray mutableCopy];
                                 [array removeObjectAtIndex:index];
                                 self.dataArray = array;
                                 if (successHandle) {
                                     successHandle(responser);
                                 }
                             } failure:failureHandle];
}

#pragma mark - Setter / Getter
- (TestServices *)services
{
    if (!_services) {
        _services = [[TestServices alloc] init];
    }
    return _services;
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
