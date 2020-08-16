//
//  RingsDataCache.m
//  Zmilk
//
//  Created by lyz on 2020/8/16.
//  Copyright © 2020 zll. All rights reserved.
//

#import "RingsDataCache.h"
#import <UIKit/UIKit.h>

@implementation RingsDataCache

- (NSString *)getCachePath {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [path objectAtIndex:0];
    NSString *plistPath = [filePath stringByAppendingPathComponent:@"data.plist"];
    if (![fm fileExistsAtPath:filePath]) {
        [fm createFileAtPath:filePath contents:nil attributes:nil];
    }
    return plistPath;
}

- (NSArray *)getCacheArray {
    NSString *filePath = [self getCachePath];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
    return array;
}

- (void)saveCacheData:(NSDictionary *)dic {
    [self addLocationNotice:dic];
    NSString *filePath = [self getCachePath];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
    if (array.count>0) {
        NSMutableArray *muArray = [[NSMutableArray alloc] initWithArray:array];
        [muArray addObject:dic];
        [muArray writeToFile:filePath atomically:YES];
    }else{
        NSMutableArray *muArray = [[NSMutableArray alloc] init];
        [muArray addObject:dic];
        [muArray writeToFile:filePath atomically:YES];
    }
}

- (void)deleteCache:(NSDictionary *)dic {
    NSArray *arry = [self getCacheArray];
    NSMutableArray *muArray = [[NSMutableArray alloc] initWithArray:arry];
    NSDate *orData = dic[@"timeFormat"];
    NSString *orName = dic[@"name"];
    for (int i=0; i<muArray.count; i++) {
        NSDictionary * tempdic = [muArray objectAtIndex:i];
        NSDate *data = tempdic[@"timeFormat"];
        NSString *name = tempdic[@"name"];
        if (data == orData && [name isEqualToString:orName]) {
            [self deleteLocationNotice:tempdic];
            [muArray removeObject:tempdic];
            break;
        }
    }
    NSString *filePath = [self getCachePath];
    [muArray writeToFile:filePath atomically:YES];
}

- (NSString *)getMedicineCachePath {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [path objectAtIndex:0];
    NSString *plistPath = [filePath stringByAppendingPathComponent:@"medicine.plist"];
    if (![fm fileExistsAtPath:filePath]) {
        [fm createFileAtPath:filePath contents:nil attributes:nil];
    }
    return plistPath;
}
- (NSArray *)getMedicineCacheArray {
    NSString *filePath = [self getMedicineCachePath];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
    return array;
    
}

- (void)saveMedicineCacheData:(NSDictionary *)dic {
    [self addLocationNotice:dic];
    NSString *filePath = [self getMedicineCachePath];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
    if (array.count>0) {
        NSMutableArray *muArray = [[NSMutableArray alloc] initWithArray:array];
        [muArray addObject:dic];
        [muArray writeToFile:filePath atomically:YES];
    }else{
        NSMutableArray *muArray = [[NSMutableArray alloc] init];
        [muArray addObject:dic];
        [muArray writeToFile:filePath atomically:YES];
    }
}

- (void)deleteMedicneCache:(NSDictionary *)dic {
    NSArray *arry = [self getMedicineCacheArray];
       NSMutableArray *muArray = [[NSMutableArray alloc] initWithArray:arry];
       NSDate *orData = dic[@"timeFormat"];
       NSString *orName = dic[@"name"];
       for (int i=0; i<muArray.count; i++) {
           NSDictionary * tempdic = [muArray objectAtIndex:i];
           NSDate *data = tempdic[@"timeFormat"];
           NSString *name = tempdic[@"name"];
           if (data == orData && [name isEqualToString:orName]) {
               [self deleteLocationNotice:tempdic];
               [muArray removeObject:tempdic];
               break;
           }
       }
       NSString *filePath = [self getMedicineCachePath];
       [muArray writeToFile:filePath atomically:YES];
}

- (void)addLocationNotice:(NSDictionary *)dic {
    NSDate *date = dic[@"timeFormat"];
    if (date) {
        UILocalNotification *notification=[[UILocalNotification alloc] init];
        notification.fireDate = date;
        notification.alertBody = dic[@"name"];
        notification.alertTitle = dic[@"name"];
        notification.repeatInterval=NSCalendarUnitSecond;
        //设置本地通知的时区
        notification.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        notification.applicationIconBadgeNumber=1;
        notification.userInfo=@{@"name":dic[@"name"]};
        notification.soundName=UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    
}

- (void)deleteLocationNotice:(NSDictionary *)dic {
    UIApplication *app=[UIApplication sharedApplication];
    NSArray *array=[app scheduledLocalNotifications];
    NSLog(@"%ld",array.count);
    for (UILocalNotification * local in array) {
        NSDictionary *tempdic= local.userInfo;
        if ([dic[@"name"] isEqual:tempdic[@"name"]]) {
            //删除指定的通知
            [app cancelLocalNotification:local];
        }
    }    
}
@end
