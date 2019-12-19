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
#import "FirNetAPIManager.h"
#import "FirAppInfoModel.h"

@interface HomePageVC()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<FirAppInfoModel *> *dataArray;

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
    MJWeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
}

#pragma mark - event response
- (void)logoutButtonAction:(UIButton *)button {
    
}

#pragma mark - private methods

- (void)loadData {
    
    [[FirNetAPIManager sharedManager] appsWithParams:@{@"api_token": kFirApiToken} andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
        
        if (data) {
            self.dataArray = data;
            [self.tableView reloadData];
        }
    }];
}

- (void)installAPP:(FirAppInfoModel *)app {
    [[FirNetAPIManager sharedManager] downloadTokenWithID:app.ID Params:@{@"api_token": kFirApiToken} andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data) {
            NSString *url = [NSString stringWithFormat:@"https://download.fir.im/apps/%@/install?download_token=%@", app.ID, data];
            NSString * charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
            NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];
            url = [url stringByAddingPercentEncodingWithAllowedCharacters:set];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"itms-services://?action=download-manifest&url=%@", url]]];
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
    
    FirAppInfoModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    MJWeakSelf
    cell.didClickBlock = ^(UIButton * _Nonnull button) {
        [weakSelf installAPP:model];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    PgyerAppDetailVC *vc = [[PgyerAppDetailVC alloc] init];
//    vc.appID = self.dataArray[indexPath.row].ID;
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getters and setters
//
- (NSMutableArray<FirAppInfoModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
