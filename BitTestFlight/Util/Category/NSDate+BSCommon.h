//
//  NSDate+BSCommon.h
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/20.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (BSCommon)

+ (NSCalendar *)bs_sharedCalendar;

+ (NSDateFormatter *)bs_sharedDateFormatter;

+ (NSString *)bs_stringFromDate:(NSDate *)date withFormat:(NSString *)format;

+ (NSString *)bs_stringFromDate:(NSDate *)date;

- (NSString *)bs_stringWithFormat:(NSString *)format;

- (NSString *)bs_string;

+ (NSDate *)bs_dateFromString:(NSString *)string;

+ (NSDate *)bs_dateFromString:(NSString *)string withFormat:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
