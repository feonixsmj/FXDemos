//
//  FXMainDemo2VCL.m
//  FXDemos
//
//  Created by suminjie on 2018/8/23.
//  Copyright © 2018年 FX. All rights reserved.
//

#import "FXMainDemo2VCL.h"

#import "FunctionThrotUtil.h"

#import "FXMainDemo3VCL.h"
@interface FXMainDemo2VCL ()

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, weak) FXMainDemo3VCL *weakTest;

@property (nonatomic, copy) NSString *strongStr;

@property (nonatomic, copy) NSMutableArray *array2;

@property (nonatomic, copy) NSString *copystr;
@end

@implementation FXMainDemo2VCL

__weak NSString *weakStr;
__weak NSString *weakAutoStr;

extern uintptr_t _objc_rootRetainCount(id obj);
extern void _objc_autoreleasePoolPrint(void);

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.strongStr = @"123";
//        self.array2 = [NSMutableArray array];
//        [self.array2 addObject:@"12"];

    }
    return self;
}

- (void)createStr {
    
    /*__autoreleasing */NSString *string = [[NSString alloc] initWithFormat:@"Hello, World!"];    // 创建常规对象
    NSString *stringAutorelease = [NSString stringWithFormat:@"Hello, World! Autorelease"]; // 创建autorelease对象
    
    weakStr = string;
    weakAutoStr = stringAutorelease;
    
    NSLog(@"------in the createString()------");
    NSLog(@"%@", weakStr);
    NSLog(@"%@\n\n", weakAutoStr);
}

- (void)testARC{
    @autoreleasepool {
        [self createStr];
        NSLog(@"------in the autoreleasepool------");
        NSLog(@"%@", weakStr);
        NSLog(@"%@\n\n", weakAutoStr);
    }
    NSLog(@"------in the main()------");
    NSLog(@"%@", weakStr);
    NSLog(@"%@\n\n", weakAutoStr);
}

- (void)testWeak{
//    @autoreleasepool {
        NSString *obj = [NSString stringWithFormat:@"Hello, World! Autorelease"];;
        id __weak weakObj = obj;
        NSLog(@"1 %@", weakObj);
        NSLog(@"2 %@", weakObj);
        NSLog(@"3 %@", weakObj);
        NSLog(@"4 %@", weakObj);
        NSLog(@"5 %@", weakObj);
        _objc_autoreleasePoolPrint();
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testARC];
//    [self testWeak];
//    [self autoreleaseePoolTest];
//    [self autoreleaseePoolTest2];
    //测试渐变色
    [self gradientLayerTest];
    [self testSort];
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for (NSInteger i =0 ; i < 10; i ++) {
                NSLog(@"%@",[NSDate date]);
                
                [FunctionThrotUtil startWithTarget:self
                                     delayCallback:@selector(doSomeThing) delay:1];
            }
        });

    });
     */
    
//    dispatch_queue_t queue = dispatch_queue_create("SerialQueue", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"1");
//
//    dispatch_async(queue, ^{
//        NSLog(@"2");
//        dispatch_sync(queue, ^{
//            NSLog(@"3");
//        });
//        NSLog(@"4");
//    });
//
//    NSLog(@"5");
}

//- (void)test{
//    DispatchQueue.main.async {
//        DispatchQueue.main.async {
//            sleep(2)
//            print(1)
//        }
//    print(2)
//        DispatchQueue.main.async {
//            print(3)
//        }
//    }
//    sleep(1)
//}

- (void)doSomeThing{
    NSLog(@"执行====");
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




-(NSArray *)array{
    if (!_array) {
        NSMutableArray *muArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 100; i++) {
            NSInteger random = arc4random() % 100;
            [muArray addObject:@(random)];
        }
        _array = muArray;
    }
    return _array;
}

- (void)selectionSort{
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:self.array];
    
    for (NSInteger i = 0; i < muArray.count -1; i++) {
        
        for (NSInteger j = i+1; j < muArray.count; j++) {
            NSNumber *left = muArray[i];
            NSNumber *right = muArray[j];
            if (left.integerValue > right.integerValue) {
                [muArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    NSLog(@"%@",muArray);
}

- (void)bubbleSort{
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:self.array];
    for (NSInteger i = muArray.count -1; i >0; i --) {
        
        for (NSInteger j = 0; j < i; j ++) {
            NSNumber *left = muArray[j];
            NSNumber *right = muArray[j+1];
            
            if (left.integerValue > right.integerValue) {
                [muArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"%@",muArray);
}

- (void)insertSort{
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:self.array];
    //乱序区
    for (NSInteger i = 1; i < muArray.count; i++) {
        
        for (NSInteger j = i; j > 0 && [muArray[j] integerValue] < [muArray[j-1] integerValue]; j --) {
            
            [muArray exchangeObjectAtIndex:j withObjectAtIndex:j-1];
        }
    }
    
    NSLog(@"%@",muArray);
}


//递归 实现快排
- (void)recursionQuickSort{
    
    NSArray *arr = [self quickSort:self.array];
    
    
    NSLog(@"递归快排 %@", arr);
}

- (NSArray *)quickSort:(NSArray *)array{
    NSMutableArray *less = [NSMutableArray array];
    NSMutableArray *greater = [NSMutableArray array];
//    pivot
    NSInteger pivot = [array.firstObject integerValue];
    
    if (array.count < 2) {
        return array;
    }
    
    for (NSInteger i = 1; i < array.count; i ++) {
        if ([array[i] integerValue] < pivot) {
            [less addObject:array[i]];
        } else {
            [greater addObject:array[i]];
        }
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
    [resultArray addObjectsFromArray:[self quickSort:less]];
    [resultArray addObject:@(pivot)];
    [resultArray addObjectsFromArray:[self quickSort:greater]];
    return resultArray;
}


- (void)testSort{
//    [self selectionSort];
//    [self bubbleSort];
//    [self insertSort];
//    [self recursionQuickSort];
    
//    [self selectionSort2];
//    [self bubbleSort2];
//    [self insertSort2];
    [self recursionQuickSort2];
    
//    [self selectionSort3];
//    [self bubbleSort3];
//    [self insertSort3];
}

- (void)selectionSort2{
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:self.array];
    for (NSInteger i = 0; i < muArray.count -1; i ++) {
        
        for (NSInteger j = i +1 ; j < muArray.count; j ++) {
            if ([muArray[i] integerValue] > [muArray[j] integerValue]) {
                
                [muArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    
    NSLog(@"%@",muArray);
}

- (void)bubbleSort2{
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:self.array];
    
    for (NSInteger i = muArray.count -1; i > 0; i --) {
        
        for (NSInteger j = 0; j < i; j ++) {
            if ([muArray[j] integerValue] > [muArray[j+1] integerValue]) {
                
                [muArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"%@",muArray);
}

- (void)insertSort2{
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:self.array];
    
    for (NSInteger i = 1; i < muArray.count; i ++) {
        
        for (NSInteger j = i; j >0 && [muArray[j] integerValue] < [muArray[j-1] integerValue]; j --) {
            
            [muArray exchangeObjectAtIndex:j withObjectAtIndex:j-1];
            
        }
    }
    NSLog(@"%@",muArray);
}




- (void)selectionSort3{
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:self.array];
    for (NSInteger i = 0; i < muArr.count -1; i++) {
        for (NSInteger j = i +1 ; j < muArr.count; j ++) {
            if ([muArr[i] integerValue] > [muArr[j] integerValue]) {
                [muArr exchangeObjectAtIndex:i withObjectAtIndex: j];
            }
        }
    }
    NSLog(@"%@",muArr);
}

- (void)bubbleSort3{
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:self.array];
    
    for (NSInteger i = muArr.count -1; i > 0; i --) {
        for (NSInteger j = 0; j < i; j++) {
            
            if ([muArr[j] integerValue] > [muArr[j+1] integerValue]) {
                [muArr exchangeObjectAtIndex:j withObjectAtIndex: j+1];
            }
        }
    }
    NSLog(@"%@",muArr);
}

- (void)insertSort3{
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:self.array];
    
    for (NSInteger i = 1; i < muArr.count; i++) {
        for (NSInteger j = i; j >0 && [muArr[j] integerValue] < [muArr[j-1] integerValue]; j --) {
            [muArr exchangeObjectAtIndex:j withObjectAtIndex: j-1];
        }
    }
    NSLog(@"%@",muArr);
}


//递归 实现快排
- (void)recursionQuickSort2{
    
    NSArray *arr = [self quickSort2:self.array];
    
    
    NSLog(@"递归快排 %@", arr);
}

- (NSArray *)quickSort2:(NSArray *)array{
    NSMutableArray *less = [NSMutableArray array];
    NSMutableArray *greater = [NSMutableArray array];
    
    if (array.count <2) {
        return array;
    }
    
    NSInteger pivot = [array.firstObject integerValue];
    
    for (NSInteger i = 1; i < array.count; i ++) {
        if ([array[i] integerValue]< pivot) {
            [less addObject:array[i]];
        } else {
            [greater addObject:array[i]];
        }
    }
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
    
    [result addObjectsFromArray:[self quickSort2:less]];
    [result addObject:@(pivot)];
    [result addObjectsFromArray:[self quickSort2:greater]];
    
    return result;
}
@end
