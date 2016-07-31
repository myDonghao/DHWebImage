//
//  DHDownloadOperation.h
//  DHWedImage
//
//  Created by donghao on 16/7/31.
//  Copyright © 2016年 dongHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHDownloadOperation : NSOperation

@property(nonatomic,strong) UIImage *image;
/**
 *  通过一个urlString创建一个操作
 *
 *  @param urlString <#urlString description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)operationWithUrlString:(NSString *)urlString;

@end
