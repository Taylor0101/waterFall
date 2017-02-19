//
//  RSShopCell.m
//  WaterFall
//
//  Created by RSTaylor on 17/2/18.
//  Copyright © 2017年 RSTaylor. All rights reserved.
//

#import "RSShopCell.h"
#import "UIImageView+WebCache.h"

@implementation RSShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(RSmodel *)model{


    _model = model;
     [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    _zhengwenLab.text = model.zhengwen;
    [_userImag sd_setImageWithURL:[NSURL URLWithString:model.userImg] placeholderImage:[UIImage imageNamed:@"loading"]];
    _userNameLab.text = model.userName;
    _selectBtn.selected = model.isSelect;
    _numberLab.text = model.numberString;
    

}



- (IBAction)selectBtnEvent:(id)sender {
    _model.isSelect = !_model.isSelect;
    if (self.didSelectedBlock) {
        self.didSelectedBlock(_model);
    }
    
}
@end
