//
//  FXMainDemo3VCL.m
//  FXDemos
//
//  Created by suminjie on 2018/8/23.
//  Copyright © 2018年 FX. All rights reserved.
//

#import "FXMainDemo3VCL.h"
#import "FXWindow.h"
#import "FXTestVCL.h"
#import <Foundation/Foundation.h>
#import "FXClassTest.h"

struct struct1 {
    NSInteger page;
};

@interface FXMainDemo3VCL ()
@property (nonatomic, strong) FXWindow *window;
@property (nonatomic, strong) NSArray *array;
@end

@implementation FXMainDemo3VCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self
            action:@selector(tapAction)
  forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"加" forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(100, 30, 200, 44);
    btn.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:btn];
    

//    [self selectionSort];
//    [self bubbleSort];
//    [self insertSort];
//    [self quickSort];
    [self testStruct];
    
    [self binarySearchAlgorithm];
}

- (void)testStruct{
    struct struct1 s1 = {2};
    struct struct1 s2 = s1;
    s2.page = 3;
    
//    NSLog(@"%@, %@",s1,s2);
    
    FXClassTest *class1 = [FXClassTest new];
    FXClassTest *class2 = class1;
    
    class2.page = 3;
    
    NSLog(@"%@, %@",class1,class2);
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


//选择排序
/*
 以升序为例。
 选择排序比较好理解，一句话概括就是依次按位置挑选出适合此位置的元素来填充。
 
 暂定第一个元素为最小元素，往后遍历，逐个与最小元素比较，若发现更小者，与先前的"最小元素"交换位置。
 达到更新最小元素的目的。
 一趟遍历完成后，能确保刚刚完成的这一趟遍历中，最的小元素已经放置在前方了。
 然后缩小排序范围，新一趟排序从数组的第二个元素开始。
 在新一轮排序中重复第1、2步骤，直到范围不能缩小为止，排序完成。

 */
- (void)selectionSort{
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:self.array];

    for (NSInteger i = 0; i < muArray.count-1; i++) {
        for (NSInteger j = i+1; j < muArray.count; j++) {
            NSNumber *left = muArray[i];
            NSNumber *right = muArray[j];
            
            if (left.integerValue > right.integerValue) {
                [muArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    
    NSLog(@"选择 %@",muArray);
}

//冒泡排序
/*
 
 1.在一趟遍历中，不断地对相邻的两个元素进行排序，小的在前大的在后，这样会造成大值不断沉底的效果，
    当一趟遍历完成时，最大的元素会被排在后方正确的位置上。
 2.然后缩小排序范围，即去掉最后方位置正确的元素，对前方数组进行新一轮遍历，
    重复第1步骤。直到范围不能缩小为止，排序完成。
 */

- (void)bubbleSort{
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:self.array];
    //升序
    // 2 1 3

    for (NSInteger i = muArray.count-1; i >0; i--) {
        for (NSInteger j = 0; j < i; j++) {
            NSNumber *left = muArray[j];
            NSNumber *right = muArray[j+1];
            
            if (left.integerValue > right.integerValue) {
                [muArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    NSLog(@"冒泡 %@",muArray);
}

//插入排序
- (void)insertSort{
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:self.array];
    
    //乱序区
    for (NSInteger i = 1; i < muArray.count; i++) {
        //有序区
        for (NSInteger j = i; j >0 &&
             [muArray[j] integerValue] < [muArray[j-1] integerValue]; j--) {
            
            [muArray exchangeObjectAtIndex:j-1 withObjectAtIndex:j];
        }
    }
    
    NSLog(@"插入 %@",muArray);
}

- (void)quickSort{
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:self.array];
    
    [self quickSortArray:muArray
                    left:0
                   right:muArray.count -1];
    NSLog(@"快速排序 %@",muArray);
}

- (void)quickSortArray:(NSMutableArray *)muArray
                  left:(NSInteger)left
                 right:(NSInteger)right{
    if (left > right) {
        return;
    }
    
    NSNumber *temp = muArray[left];
    
    NSInteger i = left;
    NSInteger j = right;
    
    while (i != j) {
        while (j > i && [muArray[j] integerValue] >= temp.integerValue) {
            j --;
        }
        
        while (j > i && [muArray[i] integerValue] <= temp.integerValue) {
            i ++;
        }
        
        if (i < j) {
            NSNumber *t = muArray[j];
            muArray[j] = muArray[i];
            muArray[i] = t;
        }
    }
    
    muArray[left] = muArray[i];
    muArray[i] = temp;
    
    [self quickSortArray:muArray left:left right:i -1];
    [self quickSortArray:muArray left:j+1 right:muArray.count-1];
}

- (void)tapAction{
    NSLog(@"123");
    FXTestVCL *vcl = [FXTestVCL new];
    
    self.window.rootViewController = vcl;
    [self.window makeKeyWindow];
}

- (FXWindow *)window{
    if (!_window) {
        _window = [[FXWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return _window;
}


// 二分查找

- (void)binarySearchAlgorithm{
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:100];
    for (NSInteger i = 0; i < 100; i++) {
        [arr addObject:@(i)];
    }
    
    NSInteger start = 0;
    NSInteger end = arr.count -1 ;
    NSInteger index;
    NSInteger guess = 0;
    
    NSInteger find = 77;
    
    while (start <= end) {
        index = (start + end)/2;
        guess = [arr[index] integerValue];
        
        if (guess < find) {
            start = index + 1;
        } else if (guess > find) {
            end = index - 1;
        } else {
            break;
        }
        
    }
    
    NSLog(@"%ld",index);
    
    
}



@end
