//
//  ShoppingCartModel.m
//  ShoppingCartDemo
//
//  Created by dry on 2017/12/3.
//  Copyright © 2017年 MorrisMeng. All rights reserved.
//

#import "ShoppingCartModel.h"

@implementation ShoppingCartModel

+ (void)requestDataWithSucess:(void(^)(NSArray <__kindof ShoppingCartGoods *>*result))sucess failure:(void(^)(void))failure
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ShopCartList" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    if (dict)
    {
        NSLog(@"%@",dict);
        
        NSArray *shops = dict[@"data"];
        //存储店铺模型的数组
        NSMutableArray *shoppingCartArray = [[NSMutableArray alloc] init];
        for (NSDictionary *shop in shops)
        {
            ShoppingCart *shopCart = [[ShoppingCart alloc] init];
            shopCart.shopId = shop[@"shopId"];
            shopCart.shopName = shop[@"shopName"];

            NSArray *goods = shop[@"goods"];
            //存储商品模型的数组
            NSMutableArray *goosArray = [[NSMutableArray alloc] init];
            for (NSDictionary *goodsDict in goods)
            {
                ShoppingCartGoods *shoppGoods = [[ShoppingCartGoods alloc] init];
                shoppGoods.goodsId = goodsDict[@"goodsId"];
                shoppGoods.goodsName = goodsDict[@"goodsName"];
                shoppGoods.count = goodsDict[@"count"];
                shoppGoods.price = goodsDict[@"price"];
                shoppGoods.imageUrl = goodsDict[@"imageUrl"];
                shoppGoods.isSelected = [goodsDict[@"isSelected"] integerValue];
                
                [goosArray addObject:shoppGoods];
            }
            
            shopCart.goods = goosArray;
            
            [shoppingCartArray addObject:shopCart];
        }
        
        
        if (sucess) {
            sucess(shoppingCartArray);
        }
        
    } else {
        if (failure)(nil);
    }
}

@end




@implementation ShoppingCart

@end




@implementation ShoppingCartGoods

@end

