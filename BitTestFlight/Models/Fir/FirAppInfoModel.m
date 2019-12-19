//
//  FirAppInfoModel.m
//  BitTestFlight
//
//  Created by chujian.zheng on 2019/12/18.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "FirAppInfoModel.h"

@implementation FirAppInfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"ID": @"id",
        @"short_url": @"short"
    };
}
@end
