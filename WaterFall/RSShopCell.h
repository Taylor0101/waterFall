//
//  RSShopCell.h
//  WaterFall
//
//  Created by RSTaylor on 17/2/18.
//  Copyright © 2017年 RSTaylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSmodel.h"

@interface RSShopCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *zhengwenLab;
@property (strong, nonatomic) IBOutlet UIImageView *userImag;
@property (strong, nonatomic) IBOutlet UILabel *userNameLab;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
- (IBAction)selectBtnEvent:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *numberLab;

@property(nonatomic,strong) RSmodel *model;

@property(nonatomic,copy) void (^didSelectedBlock)(RSmodel *model);

@end
