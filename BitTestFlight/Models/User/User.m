//
//  User.m
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/17.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "User.h"

@implementation User

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"userId": @"id"};
}

@end
