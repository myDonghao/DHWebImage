//
//  DHDownloadManager.m
//  DHWedImage
//
//  Created by donghao on 16/7/31.
//  Copyright © 2016年 dongHao. All rights reserved.
//

#import "DHDownloadManager.h"

@implementation DHDownloadManager

+ (instancetype)shareManager {
    
    static DHDownloadManager *instace;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[DHDownloadManager alloc] init];
    });
    
    return instace;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)downloadImageWithUrlString:(NSString *)urlString compeletion:(void(^)(UIImage *))compeletion {
    
    // 断言
    NSAssert(compeletion != nil, @"必须传入回调的block");
    
    
}


@end
