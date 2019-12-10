//
//  HomePageVC.m
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/17.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "HomePageVC.h"
#import "PgyerNetAPIManager.h"
#import "PgyAppInfoModel.h"
#import "PgyerAppCell.h"
#import "PgyerAppDetailVC.h"

@interface HomePageVC()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<PgyAppInfoModel *> *dataArray;

@property (nonatomic, assign) BOOL showAll;

@end

@implementation HomePageVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
    
    [self loadData];
}

#pragma mark - UI
- (void)buildUI {
    self.tableView = InsertTableViewWithRowHeight(self.view, self, self, 44.0, ^(MASConstraintMaker * _Nullable make) {
        [make edges];
    });
    [self.tableView registerClass:PgyerAppCell.class forCellReuseIdentifier:NSStringFromClass(PgyerAppCell.class)];
    
}

#pragma mark - event response
- (void)logoutButtonAction:(UIButton *)button {
    
}

#pragma mark - private methods

- (void)loadData {
    [[PgyerNetAPIManager sharedManager] listMyWithParams:@{@"_api_key":kPgyerApiKey} andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data) {
            self.dataArray = data;
            [self.tableView reloadData];
        }
    }];
}

/// 切换 iOS应用/全部应用
- (void)switchDataSource {
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PgyerAppCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PgyerAppCell.class)];
    
    PgyAppInfoModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.didClickBlock = ^(UIButton * _Nonnull button) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/%@", model.buildKey]]];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PgyerAppDetailVC *vc = [[PgyerAppDetailVC alloc] init];
    vc.appKey = self.dataArray[indexPath.row].appKey;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getters and setters
//
- (NSMutableArray<PgyAppInfoModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
