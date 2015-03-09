//
//  UtilityMethods.m
//  Giftolyo
//
//  Created by Arda CICEK on 15/12/14.
//  Copyright (c) 2014 bolumyolu. All rights reserved.
//

#import "UtilityMethods.h"
#import "AC.h"

@implementation UtilityMethods

+(UtilityMethods *) sharedInstance
{
    static dispatch_once_t pred;
    static UtilityMethods *_sharedInstance = nil;
    dispatch_once(&pred, ^{
        _sharedInstance = [[UtilityMethods alloc] init];
    });
    return _sharedInstance;
}


- (NSString *) getDocumentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
- (NSString *) readFileAtPath:(NSString *)path{
    NSError *err = nil;
    NSString *result = [[NSString alloc] initWithContentsOfFile:path
                                                       encoding:NSUTF8StringEncoding
                                                          error:&err];
    if(err){
        DDLogError(@"Cannot read file at path %@, err = %@", path, err);
    }
    else{
        return result;
    }
    return nil;
}
- (BOOL) writeString:(NSString *) content toFileAtPath:(NSString *) path{
    if(![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:NO]){
        NSMutableArray *paths = [[path componentsSeparatedByString:@"/"] mutableCopy];
        [paths removeLastObject];
        NSString *directoryPath = [NSString pathWithComponents:paths];
        if(![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]){
            
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
        
    }
    NSError *err = nil;
    BOOL success = [content writeToFile:path
                             atomically:YES
                               encoding:NSUTF8StringEncoding
                                  error:&err];
    
    if(err){
        DDLogError(@"Cannot write file to path %@ err=> %@", path, err);
    }
    return success;
}

#pragma mark - Date
+ (NSDate *) dateFromDateTimeString:(NSString *)dateString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateString = [[dateString componentsSeparatedByString:@"."] firstObject];
    dateString = [dateString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    return [format dateFromString:dateString];
}
+ (NSString *) dateTimeStringFromNSDate:(NSDate *) date{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateString = [format stringFromDate:date];
    dateString = [dateString stringByReplacingOccurrencesOfString:@" " withString:@"T"];
    dateString = [dateString stringByAppendingString:@".000"];
    return dateString;
    //    2013-12-12T11:34:19.833
}
+ (NSString *) dateTimeStringFromDate:(NSDate *) date andTime:(NSDate *) time{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [format stringFromDate:date];
    
    [format setDateFormat:@"HH:mm:ss"];
    
    NSString *timeString = [format stringFromDate:time];
    
    NSString *result = [NSString stringWithFormat:@"%@T%@.000", dateString, timeString];
    return result;
}
+ (NSInteger)minutesFromDate:(NSDate*)fromDateTime toDate:(NSDate*)toDateTime
{
    /*
     NSDate *fromDate;
     NSDate *toDate;
     
     NSCalendar *calendar = [NSCalendar currentCalendar];
     
     [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
     interval:NULL forDate:fromDateTime];
     [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
     interval:NULL forDate:toDateTime];
     
     NSDateComponents *difference = [calendar components:NSMinuteCalendarUnit
     fromDate:fromDate toDate:toDate options:0];
     */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *difference = [calendar components:NSMinuteCalendarUnit
                                               fromDate:fromDateTime toDate:toDateTime options:0];
    
    return [difference minute];
}

#pragma mark - String
+(NSNumber *) getNumberFromFormatedString:(NSString *) original{
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setUsesGroupingSeparator:YES];
    original = [original stringByReplacingOccurrencesOfString:groupingSeparator withString:@""];
    NSNumber *number = [formatter numberFromString:original];
    
    return number;
}
+(NSString *) getFormattedStringFromNumber:(NSNumber *) number{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setUsesGroupingSeparator:YES];
    
    NSString *formattedString = [formatter stringFromNumber:number];
    return formattedString;
}
+(NSString *) formatNumberString:(NSString *) original{
    NSNumber *number = [UtilityMethods getNumberFromFormatedString:original];
    return [UtilityMethods getFormattedStringFromNumber:number];
}
+(NSString *) getPhoneNumberStrFromFormattedString:(NSString *) text{
    NSString *simpleNumber = text;
    if(simpleNumber.length < 1 )
        return nil;
    
    if([[simpleNumber substringToIndex:1] isEqualToString:@"0"]){
        simpleNumber = [simpleNumber substringFromIndex:1];
    }
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s-\\(\\)]" options:NSRegularExpressionCaseInsensitive error:&error];
    simpleNumber = [regex stringByReplacingMatchesInString:simpleNumber options:0 range:NSMakeRange(0, [simpleNumber length]) withTemplate:@""];
    
    return simpleNumber;
}


#pragma mark - Image
+ (NSData *) compressImage:(UIImage *) image toKB:(CGFloat) kb{
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = kb*1024;
    
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    return imageData;
}

@end
