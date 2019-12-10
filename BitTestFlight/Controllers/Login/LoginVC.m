//
//  LoginVC.m
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/17.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"
#import "UserNetAPIManager.h"

@interface LoginVC ()

@property (nonatomic, strong) UITextField *accountTF;

@property (nonatomic, strong) UITextField *passwordTF;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];
    // Do any additional setup after loading the view.
}

#pragma mark - UI
- (void)buildUI {
    self.accountTF = InsertTextField(self.view, nil, 12.0, @"账号", ^(MASConstraintMaker * _Nullable make) {
        make.top.mas_equalTo(100);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kDeviceWidth-100, 50));
    });
    
    self.passwordTF = InsertTextField(self.view, nil, 12.0, @"密码", ^(MASConstraintMaker * _Nullable make) {
        make.top.mas_equalTo(200);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kDeviceWidth-100, 50));
    });
    
    InsertButton(self.view, 14, [UIColor redColor], 101, self, @selector(loginButtonAction:), @"LOGIN", ^(MASConstraintMaker * _Nullable make) {
        make.top.mas_equalTo(300);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kDeviceWidth-100, 50));
    });
}

- (void)loginButtonAction:(UIButton *)button {
    
    if (!self.accountTF.hasText) {
        [NSObject showHudTipStr:@"账号不能为空"];
        return;
    }
    
    if (!self.passwordTF.hasText) {
        [NSObject showHudTipStr:@"密码不能为空"];
        return;
    }
    
    [self.view endEditing:YES];
    
    [self loginWithAccount:self.accountTF.text password:self.passwordTF.text];
}

#pragma mark - NETWORK
- (void)loginWithAccount:(NSString *)account password:(NSString *)password {
    
    // 登录请求和登录成功后的操作
    NSDictionary *params = @{@"mobile":account, @"pwd":password};
    [[UserNetAPIManager sharedManager] loginWithParams:params andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data) {
            [((AppDelegate *)[UIApplication sharedApplication].delegate) setupHomePageViewController];
            // 保存账号数据到沙盒
            [Debugo accountPluginAddAccount:[DGAccount accountWithUsername:account password:password]];
        }else {
            [NSObject showError:error];
        }
    }];
    
    
}

@end
