//
//  ViewController.m
//  Demo
//
//  Created by 伍小华 on 2017/12/27.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "LoginViewController.h"
#import "UserCenterServices.h"
@interface ViewController ()
@property (nonatomic, strong) UINavigationController *nav;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.nav];
    [self.view addSubview:self.nav.view];
    
    UserCenterServices *services = [UserCenterServices sharedUserCenterServices];
    if (!services.isLogined) {
        [self showLogin];
    }
}

- (void)showLogin
{
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.nav pushViewController:vc animated:NO];
}

#pragma mark - Setter / Getter
- (UINavigationController *)nav
{
    if (!_nav) {
        _nav = [[UINavigationController alloc] initWithRootViewController:[[TestViewController alloc] init]];
    }
    return _nav;
}
@end
