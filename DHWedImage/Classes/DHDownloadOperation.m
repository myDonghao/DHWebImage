//
//  DHDownloadOperation.m
//  DHWedImage
//
//  Created by donghao on 16/7/31.
//  Copyright © 2016年 dongHao. All rights reserved.
//

#import "DHDownloadOperation.h"
#import "NSString+path.h"

@interface DHDownloadOperation ()

@property(copy,nonatomic) NSString *urlString;

@end

@implementation DHDownloadOperation

+ (instancetype)operationWithUrlString:(NSString *)urlString  {
    
    // 初始化一个操作
    DHDownloadOperation *op = [DHDownloadOperation new];
    // 记录urlString
    op.urlString = urlString;
    
    return op;
}

- (void)main {
    
    // 1. 通过字符串初始化url
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    // 2. 通过 URL 获取二进制数据
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // 3. 将二进制数据转换成image
    UIImage *image = [UIImage imageWithData:data];
    
    // 4. 将数据写入沙盒
    [data writeToFile:[self.urlString appendCachePath] atomically:YES];
    
    self.image = image;
}

@end
