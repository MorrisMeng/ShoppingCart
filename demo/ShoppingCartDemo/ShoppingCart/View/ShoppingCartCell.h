//
//  ShoppingCartCell.h
//  ShoppingCartDemo
//
//  Created by dry on 2017/12/5.
//  Copyright © 2017年 MorrisMeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
@class ShoppingCartCell;

@protocol ShoppingCartCellDelegate <NSObject>

- (void)cell:(ShoppingCartCell *)cell selected:(BOOL)isSelected indexPath:(NSIndexPath *)indexPath;

@end

@interface ShoppingCartCell : UITableViewCell

@property (nonatomic, weak) id <ShoppingCartCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL select;//是否是选中状态


- (void)setInfo:(GoodsModel *)goodsModel;

@end
