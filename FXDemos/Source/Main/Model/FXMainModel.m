//
//  FXMainModel.m
//  FXDemos
//
//  Created by suminjie on 2018/8/23.
//  Copyright © 2018年 FX. All rights reserved.
//

#import "FXMainModel.h"

@interface FXMainModel()

@property (nonatomic, strong) NSArray *datas;
@end

@implementation FXMainModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.datas = @[
                       @{@"title":@"Demo1 -NSOperationQueueDemo",
                         @"tag":@(1)
                         },
                       @{@"title":@"test2",
                         @"tag":@(2)
                         },
                       @{@"title":@"test3",
                         @"tag":@(3)
                         }];
    }
    return self;
}

- (NSArray<FXMainItem *> *)items{
    if (!_items) {
        NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:3];
        for (NSDictionary *dict in self.datas) {
            FXMainItem *item = [FXMainItem new];
            item.title = dict[@"title"];
            [muArr addObject:item];
        }
        _items = muArr;
    }
    
    return _items;
}
@end
