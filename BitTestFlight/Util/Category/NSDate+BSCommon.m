//
//  NSDate+BSCommon.m
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/20.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "NSDate+BSCommon.h"

@implementation NSDate (BSCommon)

static NSCalendar *_calendar = nil;
static NSDateFormatter *_displayFormatter = nil;

+ (void)initializeStatics {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            if (_calendar == nil) {
#if __has_feature(objc_arc)
                _calendar = [NSCalendar currentCalendar];
#else
                _calendar = [[NSCalendar currentCalendar] retain];
#endif
            }
            if (_displayFormatter == nil) {
                _displayFormatter = [[NSDateFormatter alloc] init];
            }
        }
    });
}

+ (NSCalendar *)bs_sharedCalendar {
    [self initializeStatics];
    return _calendar;
}

+ (NSDateFormatter *)bs_sharedDateFormatter {
    [self initializeStatics];
    return _displayFormatter;
}

+ (NSString *)bs_stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    return [date bs_stringWithFormat:format];
}

+ (NSString *)bs_stringFromDate:(NSDate *)date {
    return [date bs_string];
}

- (NSString *)bs_stringWithFormat:(NSString *)format {
    [[[self class] bs_sharedDateFormatter] setDateFormat:format];
    NSString *timestamp_str = [[[self class] bs_sharedDateFormatter] stringFromDate:self];
    return timestamp_str;
}

- (NSString *)bs_string {
    return [self bs_stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)bs_dateFromString:(NSString *)string {
    return [NSDate bs_dateFromString:string withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)bs_dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *formatter = [self bs_sharedDateFormatter];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

#pragma mark - 通过传入的毫秒时间戳和日期格式算出年月日
+ (NSString *)bs_displayTimeWithTimeStamp:(NSTimeInterval)timeStamp
                                formatter:(NSString *)formatter {
    
    if ([NSString stringWithFormat:@"%@", @(timeStamp)].length == 13) {
        
        timeStamp /= 1000.0f;
    }
    
    NSDate *timestampDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:formatter];
    
    NSString *dateString = [dateFormatter stringFromDate:timestampDate];
    
    return dateString;
}

@end
