//
//  UserCenterServices.m
//  Demo
//
//  Created by 伍小华 on 2017/12/28.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "UserCenterServices.h"
#import "UserCenterStore.h"
@interface UserCenterServices ()
{
    BOOL _isLogined;
}
@property (nonatomic, strong) UserCenterStore *store;
@end
@implementation UserCenterServices
@synthesize isLogined = _isLogined;

#pragma mark - Setter / Getter
- (void)setIsLogined:(BOOL)isLogined
{
    if (_isLogined != isLogined) {
        _isLogined = isLogined;
        [self.store setObject:@(isLogined) forKey:@"isLogined"];
    }
}
- (BOOL)isLogined
{
    NSNumber *number = (NSNumber *)[self.store objectForKey:@"isLogined"];
    return number.boolValue;
}
- (UserCenterStore *)store
{
    if (!_store) {
        _store = [[UserCenterStore alloc] init];
    }
    return _store;
}
@end
