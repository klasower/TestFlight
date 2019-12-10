//
//  BSCacheCenter.m
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/17.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "BSCacheCenter.h"
#import "Login.h"

#define kPath_ResponseCache @"ResponseCache"

@implementation BSCacheCenter

+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath {
    User *loginUser = [Login curLoginUser];
    if (!loginUser) {
        return NO;
    }else{
        requestPath = [NSString stringWithFormat:@"%@_%@", loginUser.userId, requestPath];
    }
    if ([self createDirInCache:kPath_ResponseCache]) {
        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], requestPath];
        return [data writeToFile:abslutePath atomically:YES];
    }else{
        return NO;
    }
}
+ (id) loadResponseWithPath:(NSString *)requestPath {//返回一个NSDictionary类型的json数据
    User *loginUser = [Login curLoginUser];
    if (!loginUser) {
        return nil;
    }else{
        requestPath = [NSString stringWithFormat:@"%@_%@", loginUser.userId, requestPath];
    }
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], requestPath];
    return [NSMutableDictionary dictionaryWithContentsOfFile:abslutePath];
}

+ (BOOL)deleteResponseCacheForPath:(NSString *)requestPath {
    User *loginUser = [Login curLoginUser];
    if (!loginUser) {
        return NO;
    }else{
        requestPath = [NSString stringWithFormat:@"%@_%@", loginUser.userId, requestPath];
    }
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], requestPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:abslutePath]) {
        return [fileManager removeItemAtPath:abslutePath error:nil];
    }else{
        return NO;
    }
}

+ (BOOL)deleteResponseCache {
    return [self deleteCacheWithPath:kPath_ResponseCache];
}

+ (NSUInteger)getResponseCacheSize {
    NSString *dirPath = [self pathInCacheDirectory:kPath_ResponseCache];
    NSUInteger size = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:dirPath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    return size;
}

+ (BOOL)deleteCacheWithPath:(NSString *)cachePath {
    NSString *dirPath = [self pathInCacheDirectory:cachePath];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES ) {
        isDeleted = [fileManager removeItemAtPath:dirPath error:nil];
    }
    return isDeleted;
}

//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName {
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}

//创建缓存文件夹
+ (BOOL) createDirInCache:(NSString *)dirName {
    NSString *dirPath = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) ) {
        isCreated = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if (existed) {
        isCreated = YES;
    }
    return isCreated;
}

@end
