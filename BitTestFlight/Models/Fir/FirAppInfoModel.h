//
//  FirAppInfoModel.h
//  BitTestFlight
//
//  Created by chujian.zheng on 2019/12/18.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirAppInfoModel : NSObject
///应用的id
@property (nonatomic, copy) NSString *ID;
///ios 或者 android
@property (nonatomic, copy) NSString *type;
///app 名称
@property (nonatomic, copy) NSString *name;
///app 详细描述
@property (nonatomic, copy) NSString *desc;
///app 短链接
@property (nonatomic, copy) NSString *short_url;
///icon的地址
@property (nonatomic, copy) NSString *icon_url;
///应用bundle_id
@property (nonatomic, copy) NSString *bundle_id;
///应用密码参数
@property (nonatomic, copy) NSString *passwd;
///类别 id
@property (nonatomic, assign) NSInteger genre_id;
///创建时间(UTC 时间)
@property (nonatomic, assign) NSInteger created_at;
///更新时间(UTC 时间)
@property (nonatomic, assign) NSInteger updated_at;
///是否公开
@property (nonatomic, assign) BOOL is_opened;
///是否有 combo app
@property (nonatomic, assign) BOOL has_combo;
///是否展示在广场页
@property (nonatomic, assign) BOOL is_show_plaza;
///是否是当前用户的 app
@property (nonatomic, assign) BOOL is_owner;
///应用商店链接是否显示参数
@property (nonatomic, assign) BOOL store_link_visible;

@end

NS_ASSUME_NONNULL_END
