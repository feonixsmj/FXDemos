//
//  FXMainModel.h
//  FXDemos
//
//  Created by suminjie on 2018/8/23.
//  Copyright © 2018年 FX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXMainItem.h"

@interface FXMainModel : NSObject

@property (nonatomic, strong) NSArray<FXMainItem *> *items;
@end
