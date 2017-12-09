//
//  ShoppingCartSectionHeaderView.h
//  ShoppingCartDemo
//
//  Created by dry on 2017/12/6.
//  Copyright © 2017年 MorrisMeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopModel;
@class ShoppingCartSectionHeaderView;

@protocol ShoppingCartSectionHeaderViewDelegate <NSObject>

- (void)hearderView:(ShoppingCartSectionHeaderView *)headerView isSelected:(BOOL)isSelected section:(NSInteger)section;

@end

@interface ShoppingCartSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id <ShoppingCartSectionHeaderViewDelegate> delegate;
@property (nonatomic) NSInteger section;



- (void)setInfo:(ShopModel *)shopModel;

@end
