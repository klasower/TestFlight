//
//  PgyAppInfoModel.m
//  BitTestFlight
//
//  Created by chujian.zheng on 2019/12/4.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "PgyAppInfoModel.h"

@implementation PgyAppInfoModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"otherApps": [PgyAppInfoModel class],
             };
}

@end
