//
//  UserCenterViewModel.m
//  Demo
//
//  Created by 伍小华 on 2017/12/29.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "UserCenterViewModel.h"
#import "UserCenterStore.h"
@interface UserCenterViewModel()
{
    BOOL _isLogined;
}
@property (nonatomic, strong) UserCenterStore *store;
@end
@implementation UserCenterViewModel
@synthesize isLogined = _isLogined;
SINGLE_IMPLEMENTATION(UserCenterViewModel)


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
