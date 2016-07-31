//
//  ViewController.m
//  DHWedImage
//
//  Created by dongHao on 16/7/31.
//  Copyright © 2016年 dongHao. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "DHAppInfo.h"
#import "DHAppInfoCell.h"
#import "DHDownloadManager.h"

@interface ViewController ()
/**
 *  装有模型的数组
 */
@property(nonatomic,strong) NSMutableArray *appInfos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // 获取数据
    [self loadData];
    
}

#pragma mark - 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DHAppInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    // 取得相应的模型
    DHAppInfo *info = self.appInfos[indexPath.row];
    // 设置数据
    cell.iconView.image = [[UIImage alloc] init];
    cell.nameLabel.text = info.name;
    cell.downloadLabel.text = info.download;
    
    
    // 下载图片
    [[DHDownloadManager shareManager] downloadImageWithUrlString:info.icon compeletion:^(UIImage *image) {
        
        cell.iconView.image = image;
        
    }];
    
    return cell;
}

#pragma mark - 解析数据

- (void)loadData {
    
    // 获取url
    NSString *urlString = @"https://raw.githubusercontent.com/myDonghao/DHWebImage/master/apps.json";
    // 初始化一个网络请求的管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"请求成功 %@",[NSThread currentThread]);
        NSLog(@"%@ -- %@",responseObject,[responseObject class]);
        
        // 1. 字典转模型
        NSArray *array = responseObject;
        
        for (NSDictionary *dict in array) {
            // 2. 初始化模型
            DHAppInfo *info = [[DHAppInfo alloc] init];
            // 3. 使用 kvc 方式赋值
            [info setValuesForKeysWithDictionary:dict];
            // 4. 将模型添加到数组中
            [self.appInfos addObject:info];
        }
        
        NSLog(@"%@",self.appInfos);
        // 刷新tableView
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@",error);
        
    }];
    
    
    
    
}

#pragma mark - 懒加载

- (NSMutableArray *)appInfos {
    if (_appInfos == nil) {
        _appInfos = [NSMutableArray array];
    }
    
    return _appInfos;
}

@end
