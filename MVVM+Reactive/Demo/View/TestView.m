//
//  TestView.m
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "TestView.h"
#import <Masonry.h>
#import "TestServices.h"
#import <MJRefresh/MJRefresh.h>
#import <ReactiveObjC/ReactiveObjC.h>
@interface TestView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic, strong) TestViewModel *viewModel;
@end
@implementation TestView
@synthesize tableView = _tableView;
- (instancetype)initWithViewModel:(TestViewModel *)viewModel;
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
- (void)refreshData
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshAction:)]) {
        @weakify(self);
        [self.delegate refreshAction:^(BOOL result) {
            @strongify(self);
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.viewModel.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteItemAtIndex:complete:)]) {
            @weakify(self);
            [self.delegate deleteItemAtIndex:indexPath.row
                                    complete:^(BOOL result) {
                                        @strongify(self);
                                        if (result) {
                                            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                                                  withRowAnimation:UITableViewRowAnimationFade];
                                        }
                                    }];
        }
    }
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - Setter / Getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 50.0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        @weakify(self);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self refreshData];
        }];
    }
    return _tableView;
}
@end
