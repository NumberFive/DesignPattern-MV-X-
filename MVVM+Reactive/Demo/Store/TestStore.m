//
//  TestStore.m
//  Demo
//
//  Created by 伍小华 on 2017/12/28.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "TestStore.h"
#import <YYCache.h>
@interface TestStore ()
@property (nonatomic, strong) YYCache *cache;
@end
@implementation TestStore
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key
{
    [self.cache setObject:object forKey:key];
}
- (id<NSCoding>)objectForKey:(NSString *)key
{
    return [self.cache objectForKey:key];
}
#pragma mark - Setter / Getter
- (YYCache *)cache
{
    if (!_cache) {
        _cache = [YYCache cacheWithName:@"TestStore"];
    }
    return _cache;
}
@end
