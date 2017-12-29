//
//  UserCenterStore.m
//  Demo
//
//  Created by 伍小华 on 2017/12/28.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "UserCenterStore.h"
#import <YYCache.h>
@interface UserCenterStore ()
@property (nonatomic, strong) YYCache *cache;
@end
@implementation UserCenterStore
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
        _cache = [YYCache cacheWithName:@"UserCenterStore"];
    }
    return _cache;
}
@end
