//
//  Login.h
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/17.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Login : NSObject

+ (BOOL) isLogin;

+ (void) doLogin:(NSDictionary *)loginData;

+ (void) doLogout;

+ (User *)curLoginUser;

@end

NS_ASSUME_NONNULL_END
