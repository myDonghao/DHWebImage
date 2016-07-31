//
//  DHAppInfo.h
//  DHWedImage
//
//  Created by donghao on 16/7/31.
//  Copyright © 2016年 dongHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHAppInfo : NSObject
/**
 *  下载数量
 */
@property(copy,nonatomic) NSString *download;
/**
 *  图片地址
 */
@property(copy,nonatomic) NSString *icon;
/**
 *  app名称
 */
@property(copy,nonatomic) NSString *name;
/**
 *  当前模型对象的图片
 */
@property(nonatomic,strong) UIImage *image;

@end
