//
//  ShoppingCartSectionHeaderView.m
//  ShoppingCartDemo
//
//  Created by dry on 2017/12/6.
//  Copyright © 2017年 MorrisMeng. All rights reserved.
//

#import "ShoppingCartSectionHeaderView.h"
#import "ShoppingCartModel.h"

@interface ShoppingCartSectionHeaderView ()
{
    DDButton *_selectBtn;
    UIImageView *_shopImageView;
    DDLabel *_shopTitleLabel;
}
@end

@implementation ShoppingCartSectionHeaderView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _selectBtn.frame = CGRectMake(10, self.height*0.5-16, 32, 32);
    _shopImageView.frame = CGRectMake(_selectBtn.toLeftMargin+10, self.height*0.5-14, 28, 28);
    _shopTitleLabel.frame = CGRectMake(_shopImageView.toLeftMargin+10, 0, kScreenWidth-(_shopImageView.toLeftMargin+20), self.height);
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _selectBtn = [DDButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"list_unchoose"] forState:UIControlStateNormal];
        [self.contentView addSubview:_selectBtn];
        
        _shopImageView = [[UIImageView alloc] init];
        _shopImageView.image = [UIImage imageNamed:@"shopImage"];
        [self.contentView addSubview:_shopImageView];

        _shopTitleLabel = [[DDLabel alloc] init];
        _shopTitleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_shopTitleLabel];
    }
    return self;
}

- (void)setInfo:(ShoppingCart *)shopCart {
    _shopTitleLabel.text = shopCart.shopName;
}

@end
