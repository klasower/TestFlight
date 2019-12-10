//
//  BSNetAPIClient.h
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/16.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethodType;


@interface BSNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
+ (instancetype)changeClient;

+ (NSString *)baseURLStr;
+ (void)changeBaseURLStrTo:(NSString *)baseURLStr;

- (void)requestWithPath:(NSString *)aPath
                 params:(NSDictionary *)params
                   type:(NetworkMethodType)type
                  block:(void (^)(id data, NSError *error))block;

- (void)requestWithPath:(NSString *)aPath
                 params:(NSDictionary *)params
                   type:(NetworkMethodType)type
          autoShowError:(BOOL)autoShowError
                  block:(void (^)(id data, NSError *error))block;

- (void)uploadImage:(UIImage *)image
               Path:(NSString *)aPath
              block:(void (^)(id data, NSError *error))block
      progerssBlock:(void (^)(NSProgress *uploadProgress))progress;

@end

NS_ASSUME_NONNULL_END
