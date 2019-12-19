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

/**
 通过传入的时间戳和日期格式算出年月日
 
 @param timeStamp 时间戳
 @param formatter 时间显示格式
 @return 年月日
 */
+ (NSString *)bs_displayTimeWithTimeStamp:(NSTimeInterval)timeStamp
                                formatter:(NSString *)formatter;

@end

NS_ASSUME_NONNULL_END
