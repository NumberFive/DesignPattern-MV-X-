//
//  UserCenterStore.h
//  Demo
//
//  Created by 伍小华 on 2017/12/28.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCenterStore : NSObject
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;
- (id<NSCoding>)objectForKey:(NSString *)key;
@end
