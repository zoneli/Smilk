//
//  RingsDataCache.m
//  Zmilk
//
//  Created by lyz on 2020/8/16.
//  Copyright © 2020 zll. All rights reserved.
//

#import "RingsDataCache.h"

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

@end
