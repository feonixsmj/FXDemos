//
//  FXMainDemo4VCL.m
//  FXDemos
//
//  Created by FeoniX on 2019/5/21.
//  Copyright © 2019 FX. All rights reserved.
//

#import "FXMainDemo4VCL.h"

@interface FXMainDemo4VCL ()

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation FXMainDemo4VCL

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self testNSSet];
    [self testHCImage];
}

//图片合成
- (void)testHCImage{
    [self.view addSubview: self.imageView];
    
    UIImage *upImg = [UIImage imageNamed:@"image1"];
    UIImage *downImg = [UIImage imageNamed:@"image2"];
    CGFloat width = 320.f;
    CGFloat height = 480.f;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));//展开画布，自定义尺寸
    [upImg drawInRect:CGRectMake(0, 0, width, height)];
    [downImg drawInRect:CGRectMake(width - 50, height - 50, 50, 50)];//根据需要定义子图片的位置
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();//关闭画布
    
    self.imageView.image = resultImage;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.frame = CGRectMake(0, 100, 320, 480);
    }
    return _imageView;
}

/*
 3.1:NSSet不可变的set。+(id)setWithObjects:obj1,obj2,...nil使用一组对象创建新的集合
 -(id)initWithObjects:obj1,obj2,....nil使用一组对象初始化新分配的集合
 -(NSUInteger)count返回集合成员个数
 -(BOOL)containsObject:obj确定集合是否包含对象 obj
 -(BOOL)member:obj确定集合是否包含对象 obj
 -(NSEnumerator*)objectEnumerator返回集合中所有对象到一个 NSEnumerator 类型的对象
 -(BOOL)isSubsetOfSet:nsset判断集合是否是NSSet的子集
 -(BOOL)intersectsSet:nsset判断两个集合的交集是否至少存在一个元素
 -(BOOL)isEqualToSet:nsset判断两个集合是否相等
 3.2:NSMutableSet可变的set，可以操作增删改查。
 + (NSMutableSet *)set;
 - (void)addObject:(id)anObject;
 - (void)removeObject:(id)anObject;
 - (void)removeAllObjects;
 - (void)unionSet:(NSSet *)otherSet;// 求并集
 - (void)minusSet:(NSSet *)otherSet;  // 求差集
 - (void)intersectSet:(NSSet *)otherSet;  // 求交集
 
 */

- (void)testNSSet{
    // NSSet 无序且里面值是唯一不重复的
    NSSet *nset = [NSSet setWithArray:@[@"1",@"1",@"2",@"3",@"2"]];
    NSLog(@"%@",nset); // 3,1,2
    NSArray *array = [nset allObjects];
    NSLog(@"%@",array);
    
    NSMutableSet *muset1 = [NSMutableSet setWithArray:@[@"2",@"3",@"5"]];
    
    NSMutableSet *muset2 = [NSMutableSet setWithArray:@[@"2",@"4",@"6"]];
    
//    [muset1 unionSet:muset2];
    [muset1 intersectSet:muset2];
    NSLog(@"%@",muset1);
}


@end
