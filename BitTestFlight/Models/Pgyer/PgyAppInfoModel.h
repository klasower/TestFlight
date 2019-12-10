//
//  PgyAppInfoModel.h
//  BitTestFlight
//
//  Created by chujian.zheng on 2019/12/4.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PgyAppInfoModel : NSObject
/// Build Key是唯一标识应用的索引ID
@property (nonatomic, copy) NSString *buildKey;
/// 应用类型（1:iOS; 2:Android）
@property (nonatomic, assign) NSInteger buildType;
/// App 文件大小
@property (nonatomic, assign) NSInteger buildFileSize;
/// 应用名称
@property (nonatomic, copy) NSString *buildName;
/// 版本号, 默认为1.0 (是应用向用户宣传时候用到的标识，例如：1.1、8.2.1等。)
@property (nonatomic, copy) NSString *buildVersion;
/// 上传包的版本编号，默认为1 (即编译的版本号，一般来说，编译一次会变动一次这个版本号, 在 Android 上叫 Version Code。对于 iOS 来说，是字符串类型；对于 Android 来说是一个整数。例如：1001，28等。)
@property (nonatomic, copy) NSString *buildVersionNo;
/// 蒲公英生成的用于区分历史版本的build号
@property (nonatomic, assign) NSInteger buildBuildVersion;
/// 应用程序包名，iOS为BundleId，Android为包名
@property (nonatomic, copy) NSString *buildIdentifier;
/// 应用的Icon图标key，访问地址为 http://appicon.pgyer.com/image/view/app_icons/[应用的Icon图标key]
@property (nonatomic, copy) NSString *buildIcon;
/// 应用上传时间
@property (nonatomic, copy) NSString *buildCreated;
/// 表示一个App组的唯一Key。
@property (nonatomic, copy) NSString *appKey;

// ---- 详情才有的字段 -------
/// 是否是第一个App（1:是; 2:否）
@property (nonatomic, assign) NSInteger buildIsFirst;
/// 是否是最新版（1:是; 2:否）
@property (nonatomic, assign) NSInteger buildIsLastest;
/// 应用介绍
@property (nonatomic, copy) NSString *buildDescription;
/// 应用更新说明
@property (nonatomic, copy) NSString *buildUpdateDescription;
/// 应用截图的key
@property (nonatomic, copy) NSString *buildScreenShots;
/// 应用短链接
@property (nonatomic, copy) NSString *buildShortcutUrl;
/// 应用二维码地址
@property (nonatomic, copy) NSString *buildQRCodeURL;
/// 应用更新时间
@property (nonatomic, copy) NSString *buildUpdated;
/// 历史版本
@property (nonatomic, copy) NSArray<PgyAppInfoModel *> *otherApps;
/// 历史版本数量
@property (nonatomic, assign) NSInteger otherAppsCount;
/// 下载密码
@property (nonatomic, copy) NSString *buildPassword;

@end

NS_ASSUME_NONNULL_END
