//
//  FXMainDemo2VCL.m
//  FXDemos
//
//  Created by suminjie on 2018/8/23.
//  Copyright © 2018年 FX. All rights reserved.
//

#import "FXMainDemo2VCL.h"

@interface FXMainDemo2VCL ()

@end

@implementation FXMainDemo2VCL


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self autoreleaseePoolTest];
    [self autoreleaseePoolTest2];
    //测试渐变色
    [self gradientLayerTest];
}

- (void)autoreleaseePoolTest{
    
    __weak typeof(self) weak_self = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 100000000; i++){
            @autoreleasepool{
                NSString* string = @"ab c";
                //生成autorelease对象
                NSArray* array = [string componentsSeparatedByString:string];
            }
        }
    });

}

- (void)autoreleaseePoolTest2{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 100000000; i++){
//            @autoreleasepool{
            //生成autorelease对象,内存爆炸
            NSMutableString *muStr = [NSMutableString stringWithFormat:@"hello word"];
            //不生成autorelease对象，内存正常
//            NSMutableString *muStr2 = [[NSMutableString alloc] init];
//            [muStr2 appendString:@"hello word"];
        
//            }
        }
    });

}

- (void)gradientLayerTest {
    //初始化我们需要改变背景色的UIView
    UIView *jView = [[UIView alloc] initWithFrame:CGRectMake(20, 300, 200, 44)];
    [self.view addSubview:jView];
    
    //初始化CAGradientlayer 对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 300, 44);
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [jView.layer addSublayer:gradientLayer];
    
    //设置渐变区域的起始和终点位置（范围0-0 1-1）（0,0)(1,0)水平渐变 (0,0)(0,1)垂直渐变
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    //设置颜色数组,设置2-N组
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor];
    
    //设置颜色分割点（范围0-1）
    gradientLayer.locations = @[@(0.1f),@(0.5f),@(1.0f)];
}
@end
