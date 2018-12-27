//
//  FXMainDemo3VCL.h
//  FXDemos
//
//  Created by suminjie on 2018/8/23.
//  Copyright © 2018年 FX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NSComparisonResult(^FXSortComparator)(id left, id right);

@interface FXMainDemo3VCL : UIViewController

@property (nonatomic, copy) FXSortComparator comparator;
@end
