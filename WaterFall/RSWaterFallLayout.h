//
//  RSWaterFallLayout.h
//  WaterFall
//
//  Created by RSTaylor on 17/2/18.
//  Copyright © 2017年 RSTaylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RSWaterFallLayout;
@protocol RSWaterFallLayoutDelegate <NSObject>

// 返回index位置下的item的高度
- (CGFloat)waterFallLayout:(RSWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width;


// 返回瀑布流显示的列数
- (NSUInteger)columnCountOfWaterFallLayout:(RSWaterFallLayout *)waterFallLayout;
// 返回行间距
- (CGFloat)rowMarginOfWaterFallLayout:(RSWaterFallLayout *)waterFallLayout;
// 返回列间距
- (CGFloat)columnMarginOfWaterFallLayout:(RSWaterFallLayout *)waterFallLayout;
// 返回边缘间距
- (UIEdgeInsets)edgeInsetsOfWaterFallLayout:(RSWaterFallLayout *)waterFallLayout;

@end

@interface RSWaterFallLayout : UICollectionViewLayout

/** 代理 */
@property (nonatomic, weak) id<RSWaterFallLayoutDelegate> delegate;

@end
