//
//  RingsDataCache.h
//  Zmilk
//
//  Created by lyz on 2020/8/16.
//  Copyright © 2020 zll. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RingsDataCache : NSObject

- (NSArray *)getCacheArray;

- (void)saveCacheData:(NSDictionary *)dic;

- (NSArray *)getMedicineCacheArray;

- (void)saveMedicineCacheData:(NSDictionary *)dic;

@end


