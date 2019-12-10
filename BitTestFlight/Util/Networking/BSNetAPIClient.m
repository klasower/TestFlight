//
//  BSNetAPIClient.m
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/16.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "BSNetAPIClient.h"
#import "BSCacheCenter.h"
#import "Login.h"
#import "AppDelegate.h"
#import "OpenUDID.h"

#define kNetworkMethodName @[@"Get", @"Post", @"Put", @"Delete"]

@implementation BSNetAPIClient

static BSNetAPIClient *_sharedClient = nil;
static dispatch_once_t onceToken;

+ (instancetype)sharedClient {
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BSNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[BSNetAPIClient baseURLStr]]];
    });
    return _sharedClient;
}

+ (instancetype)changeClient {
    _sharedClient = [[BSNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[BSNetAPIClient baseURLStr]]];
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
//    self.requestSerializer=[AFJSONRequestSerializer serializer];
//    self.responseSerializer = [AFJSONResponseSerializer serializer];
//    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
//    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
    
//    [self.requestSerializer setValue:@"5c08e1c5e4b08e5fd5cb298b" forHTTPHeaderField:@"APP-ID"];
//    [self.requestSerializer setValue:[Login curLoginUser].token forHTTPHeaderField:@"BIT-TOKEN"];
//    [self.requestSerializer setValue:[Login curLoginUser].userId forHTTPHeaderField:@"BIT-UID"];
//    [self.requestSerializer setValue:[ [[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"APP-VERSION"];
//    [self.requestSerializer setValue: [[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"OS-VERSION"];
//    [self.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"DEVICE-ID"];
//    [self.requestSerializer setValue:@"iPhone" forHTTPHeaderField:@"DEVICE-TYPE"];
    
//    self.securityPolicy.allowInvalidCertificates = YES;
    
    return self;
}

- (void)requestWithPath:(NSString *)aPath
                 params:(NSDictionary *)params
                   type:(NetworkMethodType)type
                  block:(void (^)(id data, NSError *error))block {
    [self requestWithPath:aPath params:params type:type autoShowError:YES block:block];
}

- (void)requestWithPath:(NSString *)aPath
                 params:(NSDictionary *)params
                   type:(NetworkMethodType)type
          autoShowError:(BOOL)autoShowError
                  block:(void (^)(id data, NSError *error))block {
    if (!aPath || aPath.length <= 0) {
        return;
    }
    
    DebugLog(@"\n===========request===========\n%@\n%@:\n%@", kNetworkMethodName[type], aPath, params);
    
    aPath = [aPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    switch (type) {
        case Get: {
            //所有 Get 请求，增加缓存机制
            NSMutableString *localPath = [aPath mutableCopy];
            if (params) {
                [localPath appendString:params.description];
            }
            [self GET:aPath parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    responseObject = [BSCacheCenter loadResponseWithPath:localPath];
                    block(responseObject, error);
                }else{
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        [BSCacheCenter saveResponseData:responseObject toPath:localPath];
                    }
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                id responseObject = [BSCacheCenter loadResponseWithPath:localPath];
                !autoShowError || (error.code == NSURLErrorNotConnectedToInternet && responseObject != nil) || [NSObject showError:error];
                block(responseObject, error);
            }];
            
        }
            break;
        case Post: {
            [self POST:aPath parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                !autoShowError || [NSObject showError:error];
                block(nil, error);
            }];
        }
            break;
        case Put: {
            [self PUT:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                !autoShowError || [NSObject showError:error];
                block(nil, error);
            }];
        }
            break;
        case Delete: {
            [self DELETE:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                !autoShowError || [NSObject showError:error];
                block(nil, error);
            }];
        }
            break;
    }
}

- (void)uploadImage:(UIImage *)image
               Path:(NSString *)aPath
              block:(void (^)(id data, NSError *error))block
      progerssBlock:(void (^)(NSProgress *uploadProgress))progress {
    
    NSData *data = [image bs_dataSmallerThan:1024 * 1000];
    //图片命名方式:ap+1+bitUID+_+yyyyMMddHHmmssSSS.jpg
    NSString *imageName = [NSString stringWithFormat:@"ap1%@_%@.jpg", [Login curLoginUser].userId, [[NSDate date] bs_stringWithFormat:@"yyyyMMddHHmmssSSS"]];
    
    [self POST:aPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:imageName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id error = [self handleResponse:responseObject autoShowError:YES];
        if (error) {
            block(nil, error);
        }else{
            block(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil, error);
    }];
}

#pragma mark - Net Error
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError{
    NSError *error = nil;
    //code为非0值时，表示有错
    NSInteger errorCode = [(NSNumber *)[responseJSON valueForKeyPath:@"code"] integerValue];
    
    if (errorCode != 0) {
        error = [NSError errorWithDomain:[BSNetAPIClient baseURLStr] code:errorCode userInfo:responseJSON];
        //错误提示
        if (autoShowError) {
            [NSObject showError:error];
        }
    }
    return error;
}

#pragma mark BaseURL
+ (NSString *)baseURLStr {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:kBaseURLStr] ?: kBaseURLStr;
}

+ (void)changeBaseURLStrTo:(NSString *)baseURLStr {
    if (baseURLStr.length <= 0) {
        baseURLStr = kBaseURLStr;
    }else if (![baseURLStr hasSuffix:@"/"]){
        baseURLStr = [baseURLStr stringByAppendingString:@"/"];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:baseURLStr forKey:kBaseURLStr];
    [defaults synchronize];
    
    [BSNetAPIClient changeClient];
    
}

@end
