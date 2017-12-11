# ShoppingCart
A shopping cart demo.

## 一、效果展示

![GitHub set up-w250](https://github.com/MorrisMeng/ShoppingCart/raw/master/unchoose.png)![GitHub set up-w250](https://github.com/MorrisMeng/ShoppingCart/raw/master/choose_some.png)![GitHub set up-w250](https://github.com/MorrisMeng/ShoppingCart/raw/master/choose_all.png
)

## 二、功能

1、购物车界面显示；
2、商品选择；
3、计算价格；
4、删除商品（暂未实现）；
5、结算。

## 三、代码设计

1、采用MVC设计模式

![GitHub set up-w250](https://github.com/MorrisMeng/ShoppingCart/raw/master/mvc.png)

2、布局全代码frame布局，做了简单的适配；
3、数据回调采用代理；
4、图片加载用了SD，使用了Cocoapods集成；
5、使用了一些基本的宏

## 三、数据处理

#### 3.1 模型处理

购物车模型model，里面包含店铺模型和商品模型
```
#import <Foundation/Foundation.h>
@class ShopModel;
@class GoodsModel;

//购物车模型
@interface ShoppingCartModel : NSObject

//@property (nonatomic, assign) BOOL allSelected;//是否全选
//@property (nonatomic, strong) NSArray <__kindof ShopModel *> *shops;//所有店铺

//请求店铺数据，处理数据并返回结果
+ (void)requestDataWithSucess:(void(^)(NSArray <__kindof ShopModel *>*result))sucess failure:(void(^)(void))failure;

@end

//店铺模型
@interface ShopModel : NSObject

@property (nonatomic, strong) NSString *shopId;//店铺ID
@property (nonatomic, strong) NSString *shopName;//店铺名
@property (nonatomic, assign) BOOL isSelected;//整个section的商品是否被选中
@property (nonatomic, strong) NSArray <__kindof GoodsModel *> *goods;//商品列表

@end

//商品模型
@interface GoodsModel : NSObject

@property (nonatomic, strong) NSString *goodsId;//商品ID
@property (nonatomic, strong) NSString *count;//商品数量
@property (nonatomic, strong) NSString *goodsName;//商品名称
@property (nonatomic, strong) NSString *price;//商品价格
@property (nonatomic, strong) NSString *imageUrl;//商品图片连接
@property (nonatomic, assign) BOOL isSelected;//商品是否被选

@end
```

#### 3.2 数据处理

因为没有服务，所以本地写了一个plist文件，模仿了网络请求，处理数据
```
+ (void)requestDataWithSucess:(void(^)(NSArray <__kindof ShopModel *>*result))sucess failure:(void(^)(void))failure
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
            ShopModel *shopModel = [[ShopModel alloc] init];
            shopModel.shopId = shop[@"shopId"];
            shopModel.shopName = shop[@"shopName"];
            shopModel.isSelected = [shop[@"isSelected"] integerValue];
            
            NSArray *goods = shop[@"goods"];
            //存储商品模型的数组
            NSMutableArray *goosArray = [[NSMutableArray alloc] init];
            for (NSDictionary *goodsDict in goods)
            {
                GoodsModel *goodsModel = [[GoodsModel alloc] init];
                goodsModel.goodsId = goodsDict[@"goodsId"];
                goodsModel.goodsName = goodsDict[@"goodsName"];
                goodsModel.count = goodsDict[@"count"];
                goodsModel.price = goodsDict[@"price"];
                goodsModel.imageUrl = goodsDict[@"imageUrl"];
                goodsModel.isSelected = [goodsDict[@"isSelected"] integerValue];
                
                [goosArray addObject:goodsModel];
            }
            
            shopModel.goods = goosArray;
            
            [shoppingCartArray addObject:shopModel];
        }
        
        if (sucess) {
            sucess(shoppingCartArray);
        }
        
    } else {
        if (failure)(nil);
    }
}
```

#### 3.3 tableView处理

1、列表显示；
2、自定义sectionHeaderView；
3、自定义cell；
4、取数据，刷新列表等；
5、删除（暂未实现）。

数据源：两个数据源，dataSource存储所有的商铺信息，selectedShop存储选中的商品信息。

#### 3.4 计算价格

根据选中的商品数据，异步计算总价格，刷新价格显示
```
- (void)caculatePrice:(GoodsModel *)goodsModel{
    @synchronized (self.selectedShop)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (goodsModel.isSelected) {
                if (![self.selectedShop containsObject:goodsModel]) {
                    [self.selectedShop addObject:goodsModel];
                }
            }
            else {
                if ([self.selectedShop containsObject:goodsModel]) {
                    [self.selectedShop removeObject:goodsModel];
                }
            }
            
            NSDecimalNumber *allPriceDecimal = [NSDecimalNumber zero];
            for (GoodsModel *goods in self.selectedShop) {
                NSString *price = goods.price;
                NSDecimalNumber *decimalPrice = [NSDecimalNumber decimalNumberWithString:price];
                allPriceDecimal = [allPriceDecimal decimalNumberByAdding:decimalPrice];
            }
            NSString *allPriceStr = [allPriceDecimal stringValue];
            NSLog(@"总价：%@",allPriceStr);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([allPriceStr floatValue]>0) {
                    [self.bottomView setPayEnable:YES];
                    self.bottomView.allPriceLabel.text = [NSString stringWithFormat:@"总价：%@",[allPriceDecimal stringValue]];
                } else {
                    [self.bottomView setPayEnable:NO];
                    self.bottomView.allPriceLabel.text = @"总价：";
                }
            });
        });
    }
}
```
这里为了方便代码实现，直接在客户端自己计算价格。


