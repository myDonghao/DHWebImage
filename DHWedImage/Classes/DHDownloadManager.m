//
//  DHDownloadManager.m
//  DHWedImage
//
//  Created by donghao on 16/7/31.
//  Copyright © 2016年 dongHao. All rights reserved.
//

#import "DHDownloadManager.h"
#import "DHDownloadOperation.h"

@interface DHDownloadManager ()
/**
 *  图片缓存
 */
@property(nonatomic,strong) NSMutableDictionary *imageCache;
/**
 *  操作缓存
 */
@property(nonatomic,strong) NSMutableDictionary *operationCache;
/**
 *  队列
 */
@property(nonatomic,strong) NSOperationQueue *queue;

@end

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
        
        // 初始化
        self.imageCache = [NSMutableDictionary dictionary];
        self.operationCache = [NSMutableDictionary dictionary];
        self.queue = [[NSOperationQueue alloc]init];
        
        // 注册内存警告的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
    }
    return self;
}

- (void)downloadImageWithUrlString:(NSString *)urlString compeletion:(void(^)(UIImage *))compeletion {
    
    // 断言
    NSAssert(compeletion != nil, @"必须传入回调的block");
    
    // 判断操作有没有
    if (self.operationCache[urlString] != nil) {
        NSLog(@"操作已经存在,代表正在下载中....");
        return;
    }
    
    // 创建一个操作去下载图片
    DHDownloadOperation *op = [DHDownloadOperation operationWithUrlString:urlString];
    
    __weak DHDownloadOperation *weakSelf = op;
    [op setCompletionBlock:^{
        
        // 取到图片
        UIImage *image = op.image;
        
        // 回到主线程中调用,将image传出去
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            // 保存到内存中一份
            [self.imageCache setObject:image forKey:urlString];
            // 将操作从缓存中移除
            [self.operationCache removeObjectForKey:urlString];
            
            compeletion(image);
            
        }];
    }];
    
    // 将操作添加到缓存中
    [self.operationCache setObject:op forKey:urlString];
    
    // 将操作添加到队列
    [self.queue addOperation:op];
    
    NSLog(@"创建操作下载图片");
}
/**
 *  收到内存警告应该做的事情
 */
- (void)memoryWarning {
    
    NSLog(@"收到内存警告");
    // 清除图片缓存
    [self.imageCache removeAllObjects];
    // 清除操作缓存
    [self.operationCache removeAllObjects];
    // 将队列中所有操作取消
    [self.queue cancelAllOperations];
    
    
}

- (void)dealloc {
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
