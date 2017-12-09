//
//  ShoopingCartBottomView.m
//  ShoppingCartDemo
//
//  Created by dry on 2017/12/5.
//  Copyright © 2017年 MorrisMeng. All rights reserved.
//

#import "ShoopingCartBottomView.h"

@interface ShoopingCartBottomView ()
{
    DDButton *_selectAllBtn;
    DDLabel *_priceLabel;
    UIButton *_balanceBtn;
}
@end

@implementation ShoopingCartBottomView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _selectAllBtn.frame = CGRectMake(0, 0, 88+20, self.frame.size.height);
    _priceLabel.frame = CGRectMake(88+20, 0, kScreenWidth-(88+20)*2, self.frame.size.height);
    _balanceBtn.frame = CGRectMake(kScreenWidth-88-20, 0, 88+20, self.frame.size.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _selectAllBtn = [DDButton buttonWithType:UIButtonTypeCustom];
        [_selectAllBtn setImage:[UIImage imageNamed:@"list_unchoose"] forState:UIControlStateNormal];
        [_selectAllBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        [_selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [self addSubview:_selectAllBtn];
        
        _priceLabel = [[DDLabel alloc] init];
        _priceLabel.text = @"总价：";
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_priceLabel];
        
        _balanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_balanceBtn setTitle:@"结算" forState:UIControlStateNormal];
        [_balanceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_balanceBtn setBackgroundColor:RED_COLOR];
        [self addSubview:_balanceBtn];
    }
    return self;
}

@end
