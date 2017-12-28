//
//  TestViewController.m
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "TestViewController.h"
#import "TestView.h"
#import "TestServices.h"
#import <MJRefresh/MJRefresh.h>
#import <KVNProgress.h>
@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) TestView *testView;
@property (nonatomic, strong) TestServices *services;
@end

@implementation TestViewController
- (void)loadView
{
    self.view = self.testView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"操作数据流程";
    [self requestData];
}

- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    [self.services requestDataSuccess:^(id responser) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.testView.tableView.mj_header endRefreshing];
        [strongSelf.testView.tableView reloadData];
    } failure:^(id responser) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.testView.tableView.mj_header endRefreshing];
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.services.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.services.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        __weak typeof(self) weakSelf = self;
        [KVNProgress showWithStatus:@"正在删除数据..."];
        [self.services deleteItemAtIndex:indexPath.row
                                 Success:^(id responser) {
                                     __weak typeof(weakSelf) strongSelf = weakSelf;
                                     [strongSelf.testView.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                     [KVNProgress showSuccessWithStatus:@"删除成功"];
                                 } failure:^(id responser) {
                                     [KVNProgress showErrorWithStatus:@"删除失败"];
                                 }];
    }
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Setter / Getter
- (TestView *)testView
{
    if (!_testView) {
        _testView = [[TestView alloc] init];
        _testView.tableView.delegate = self;
        _testView.tableView.dataSource = self;
        
        __weak typeof(self) weakSelf = self;
        _testView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            __weak typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf requestData];
        }];
    }
    return _testView;
}
- (TestServices *)services
{
    if (!_services) {
        _services = [[TestServices alloc] init];
    }
    return _services;
}
@end
