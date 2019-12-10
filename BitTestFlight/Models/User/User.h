//
//  User.h
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/17.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, copy) NSString *token, *userId, *name, *nickName, *phone, *sex, *birthday;

@end

NS_ASSUME_NONNULL_END
