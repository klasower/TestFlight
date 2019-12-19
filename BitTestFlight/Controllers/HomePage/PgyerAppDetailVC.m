//
//  PgyerAppDetailVC.m
//  BitTestFlight
//
//  Created by chujian.zheng on 2019/12/6.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "PgyerAppDetailVC.h"
#import "PgyAppInfoModel.h"
#import "PgyerNetAPIManager.h"
#import "FirAppInfoModel.h"
#import "FirNetAPIManager.h"

@interface PgyerAppDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FirAppInfoModel *app;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PgyerAppDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)buildUI {
    
    self.title = self.app.name;
    
    if ([self.app.type isEqualToString:@"ios"]) {
        UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [downloadBtn setFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
        [downloadBtn setImage:IMAGE(@"download_icon") forState:UIControlStateNormal];
        [downloadBtn addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:downloadBtn];
    }
    
    self.tableView = InsertGroupTableView(self.view, self, self, 44.0, ^(MASConstraintMaker * _Nullable make) {
        [make edges];
    });
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (void)loadData {
    [[FirNetAPIManager sharedManager] appDetailWithID:self.appID Params:@{@"api_token":kFirApiToken} andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data) {
            self.app = (FirAppInfoModel *)data;
            
            [self buildUI];
            
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - button actions
- (void)download:(UIButton *)button {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/%@", self.app.buildKey]]];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *title;
    NSString *subTitle;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                title = @"Build";
                subTitle = [NSString stringWithFormat:@"%d", self.app.genre_id];
                break;
                
            case 1:
                title = @"上传时间";
//                subTitle = self.app.buildCreated;
                break;
                
            case 2:
                title = @"应用大小";
//                subTitle = [NSString stringWithFormat:@"%0.2fM", self.app.buildFileSize/1024.0/1024.0];
                break;
                
            case 3:
                title = @"版本号";
//                subTitle = [NSString stringWithFormat:@"v%@", self.app.buildVersion];
                break;
                
            case 4:
                title = @"下载链接";
                subTitle = [NSString stringWithFormat:@"https://fir.im/%@", self.app.short_url];
                break;
                
            case 5:
                title = @"下载密码";
                subTitle = self.app.passwd;
                break;
                
            default:
                break;
        }
    }else {
//        PgyAppInfoModel *other = self.app.otherApps[indexPath.row];
//        title = [NSString stringWithFormat:@"v%@      Build: %ld", other.buildVersion, other.buildBuildVersion];
//        subTitle = other.buildCreated;
    }
    
    if (indexPath.section == 1 && [self.app.type isEqualToString:@"ios"]) {
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"download_icon")];
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = subTitle;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 1 ? @"其他版本" : @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && [self.app.type isEqualToString:@"ios"]) {
//        PgyAppInfoModel *app = self.app.otherApps[indexPath.row];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/%@", app.buildKey]]];
    }
}

@end
