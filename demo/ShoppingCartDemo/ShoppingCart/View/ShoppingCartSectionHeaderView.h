//
//  ShoppingCartSectionHeaderView.h
//  ShoppingCartDemo
//
//  Created by dry on 2017/12/6.
//  Copyright © 2017年 MorrisMeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingCart;

@interface ShoppingCartSectionHeaderView : UITableViewHeaderFooterView

- (void)setInfo:(ShoppingCart *)shopCart;

@end
