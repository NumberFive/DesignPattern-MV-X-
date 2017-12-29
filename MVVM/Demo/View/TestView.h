//
//  TestView.h
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewModel.h"

@protocol TestViewDelegate <NSObject>
- (void)refreshAction:(void (^)(BOOL result))handle;
- (void)deleteItemAtIndex:(NSInteger)index complete:(void (^)(BOOL result))handle;
@end


@interface TestView : UIView
@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, weak) id<TestViewDelegate> delegate;
- (instancetype)initWithViewModel:(TestViewModel *)viewModel;
- (void)refreshData;
@end
