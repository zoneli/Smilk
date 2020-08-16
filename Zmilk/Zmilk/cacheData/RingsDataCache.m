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
    // 设置通知的提醒时间
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
        notification.fireDate = date;
        // 设置重复间隔
        notification.repeatInterval = kCFCalendarUnitDay;
        
        // 设置提醒的文字内容
        notification.alertBody   = dic[@"name"];
        notification.alertAction = NSLocalizedString(dic[@"name"], nil);
        
        // 通知提示音 使用默认的
        notification.soundName= UILocalNotificationDefaultSoundName;
        
        // 设置应用程序右上角的提醒个数
        notification.applicationIconBadgeNumber++;
        
        // 设定通知的userInfo，用来标识该通知
        NSMutableDictionary *aUserInfo = [[NSMutableDictionary alloc] init];
        [aUserInfo setObject:dic[@"name"] forKey:@"LocalNotificationID"];
        notification.userInfo = aUserInfo;
        // 将通知添加到系统中
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];

    }
    
}

- (void)deleteLocationNotice:(NSDictionary *)dic {
    UIApplication *app=[UIApplication sharedApplication];
    NSArray *array=[app scheduledLocalNotifications];
    NSLog(@"%ld",array.count);
    for (UILocalNotification * local in array) {
        NSDictionary *tempdic= local.userInfo;
        if ([dic[@"LocalNotificationID"] isEqual:tempdic[@"LocalNotificationID"]]) {
            //删除指定的通知
            [app cancelLocalNotification:local];
        }
    }    
}
@end
