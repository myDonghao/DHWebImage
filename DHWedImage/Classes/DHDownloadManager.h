//
//  DHDownloadManager.h
//  DHWedImage
//
//  Created by donghao on 16/7/31.
//  Copyright © 2016年 dongHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHDownloadManager : NSObject

/**
 *  全局访问点
 *
 *  @return <#return value description#>
 */
+ (instancetype)shareManager;

/**
 *  通过图片地址下载图片,并通过block回调的方式将图片传回
 *
 *  @param urlString   <#urlString description#>
 *  @param compeletion <#compeletion description#>
 */
- (void)downloadImageWithUrlString:(NSString *)urlString compeletion:(void(^)(UIImage *))compeletion;

@end
