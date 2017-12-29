//
//  TestViewModel.h
//  Demo
//
//  Created by 伍小华 on 2017/12/29.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestViewModel : NSObject
@property (nonatomic, strong) NSArray *dataArray;

- (void)requestDataSuccess:(void (^)(id responser))successHandle
                   failure:(void (^)(id responser))failureHandle;
- (void)deleteItemAtIndex:(NSInteger)index
                  success:(void (^)(id responser))successHandle
                  failure:(void (^)(id responser))failureHandle;
@end
