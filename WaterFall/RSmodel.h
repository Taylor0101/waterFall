//
//  RSmodel.h
//  WaterFall
//
//  Created by RSTaylor on 17/2/18.
//  Copyright © 2017年 RSTaylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSmodel : NSObject
@property(nonatomic,copy) NSString *userName;//用户名
@property(nonatomic,copy) NSString *userImg;//用户图像url
@property(nonatomic,copy) NSString *zhengwen;//正文label，最多显示三行
@property(nonatomic,copy) NSString *numberString;//被收藏次数记录
@property(nonatomic,assign) BOOL isSelect;//是否收藏，已收藏❤️，变红

@property (nonatomic, strong) NSNumber *h; // 高度
@property (nonatomic, strong) NSNumber *w; // 宽度
@property (nonatomic, copy) NSString *img; // 图片urlString
@property (nonatomic, copy) NSString *price; // 价格


@end
