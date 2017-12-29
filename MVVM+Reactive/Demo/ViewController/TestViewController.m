//
//  TestViewController.m
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "TestViewController.h"
#import "TestView.h"
#import "TestViewModel.h"
#import <KVNProgress.h>

@interface TestViewController ()<TestViewDelegate>
@property (nonatomic, strong) TestView *testView;
@property (nonatomic, strong) TestViewModel *viewModel;
@end

@implementation TestViewController
- (void)loadView
{
    self.view = self.testView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"操作数据流程(左划删除)";
    [self.testView refreshData];
}


#pragma mark - TestViewDelegate
- (void)refreshAction:(void (^)(BOOL result))handle;
{
    [self.viewModel requestDataSuccess:^(id responser) {
        if (handle) {
            handle(YES);
        }
    } failure:^(id responser) {
        if (handle) {
            handle(NO);
        }
    }];
}
- (void)deleteItemAtIndex:(NSInteger)index complete:(void (^)(BOOL result))handle
{
    [KVNProgress showWithStatus:@"正在删除数据..."];
    [self.viewModel deleteItemAtIndex:index
                              success:^(id responser) {
                                  if (handle) {
                                      handle(YES);
                                  }
                                  [KVNProgress showSuccessWithStatus:@"删除成功"];
                              } failure:^(id responser) {
                                  if ((handle)) {
                                      handle(NO);
                                  }
                                  [KVNProgress showErrorWithStatus:@"删除失败"];
                              }];
}

#pragma mark - Setter / Getter
- (TestView *)testView
{
    if (!_testView) {
        _testView = [[TestView alloc] initWithViewModel:self.viewModel];
        _testView.delegate = self;
    }
    return _testView;
}
- (TestViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TestViewModel alloc] init];
    }
    return _viewModel;
}
@end
