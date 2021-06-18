//
//  FXMainDemo4VCL.m
//  FXDemos
//
//  Created by FeoniX on 2019/5/21.
//  Copyright © 2019 FX. All rights reserved.
//

#import "FXMainDemo4VCL.h"
#import <Masonry/Masonry.h>

@interface FXMainDemo4VCL ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) NSThread *testTread;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL doing;
@end

@implementation FXMainDemo4VCL
//Ios: Objective-C高级编程书
//一面：
//1：CGSize)intrinsicContentSize:是干什么用的？
//2：编写一个循环引用的代码
//3：assign和weak有什么区别？
//4：layer和view的区别
//5：拖线的时候为什么要设置成weak，设置成strong行不行？
//6：1.OC语言有什么特点？和其他语言（Java、Python）的区别？
//7：为什么说oc是动态的
//8：有没有用过分类？分类与扩展及匿名分类的区别？
//9：self和super的区别？
//10：定义一个对象，它的内存大小是多少？
//11.主要是runloop的原理以及核心源代码；内存管理及weak，autorelease原理；block在c++下面的实现，存储域类型；gcd的原理及应用，source的原理为什么比timer更精准；
//12.消息的转发流程包括主要的5个方法是处理什么；事件响应的传递和响应链，例如手势事件；mataclass结构体中每个成员变量涉及到的知识；
//13，GCD串行队列
//14，自定义对象的占用的空间
//15，dealloc的调用时机
//16，无重复字符的最长子串
//17.基础题问了下事件传递，消息转发，runtime的了解，内存管理，主要聊项目经历，内存循环引用，包括如何使用代码去检测；block的内存管理，字符串字典但属性为什么使用copy可不可以用strong？；App的签名原理；我项目里面写的rac，然后问一下rac的冷热信号问题；最近在看什么书？
//18.为什么更新UI的操作必须放在主线程 https://www.jianshu.com/p/8e11c0e11bf7  http://www.cocoachina.com/ios/20190118/26167.html
//19.assign 定义一个对象会不会报错
//20.重构项目中的重复代码
//21.autolayout与frame的性能比较，autolayout原理
//22.有没有用过nscopy协议
//23.主要是masonry 布局与基础的内存管理
//24. 好的代码是什么样的
//25. 数组 [1 2 3] 怎么打出它的全排列
//26. GCD 异步添加主队列
//27. 用“好的代码”的思路设计一个下载器
//28.CGPoint在内存中是什么样子
//29.运用riblet框架在项目中做了怎样的尝试，Ribs是做什么的
//30.模块解耦设计如何实现，怎样改进
//31.swift和OC比较有哪些方面的优势，swift中struct、enum和类复制的区别
//32.RAC中有哪些操作符，throttle的作用是什么，使用工程中遇到过哪些坑
//33.自定义TabBar的高度遇到过哪些坑
//34.什么是离屏渲染，有哪些方式会触发离屏渲染。
//35.哈希表的底层实现原理，响应式编程和一道算法
//36. asign修饰词野指针循环引用，以及如何避免多线程Autolayout copy协议
//37.二分查找
//38. 事件传递响应机制
//39.消息转发机制
//40.项目中的链式调用如何实现的
//41.设计一个内存缓存，LRU怎么实现
//42.设计模式MVC MVVM VIPER
//43.项目中怎么优化的读信
//44.NSDictionary怎么实现的，哈希表怎么实现
//45.gcd，串行和并行队列的区别，同步（sync）和异步（async）的区别
//46. 事件的专递机制
//47、两个子视图的最近公共父视图
//48、做一个微信的搜索功能，需要支持扩展
//49、1G内存，读取10G的文件，怎么取前K个最大的
//50、main函数之前程序作了什么
//51、Mach-O的执行文件是什么类型
//52、类的isa指针
//53. 先自我介绍 然后每一面都有算法题 手写的 一面上来就难点load之类的 还有响应链 runtime 二面会针对一面答得不好的地方再问还有项目相关 三面是部门老大 会问你自己熟悉的地方 最好挑自己熟悉并且深入的 四面好像是另一个部门的老大 然后又问了一些oc基础的问题加项目加算法
//54. 北京IOS一面：面试题：组件化的理解
// 线程安全的理解
// MVVM架构的理解
// swift调用函数的方式有几种
// 如何自定义一个类似uiview.animation的动画接口
// 由这些问题引发的一些问题
// 常用加密算法
//
// 笔试题
// 合并n个有序数组
// 实现一个缓存，可动态配置FIFO、LRU调度方式
// xib为何weak引用property，strong会有什么问题
// Autolayout原理
// CGPoint在内存中如何存储？
//55.北京IOS
//ARC的理解
//用过什么框架
//UIview中的tintcolor是怎么实现的
//UILabel在autolayout的时候会自动延伸
//text你觉得是怎么实现的
//什么是函子和单子
//有三个view平行放置在superview中怎么用
//autolayout实现
//optional是怎么实现的
//weak的实现方法
//56.swift的面向协议编程思想
//57.uiview的父类，uibutton的父类，他们共同的父类
//58.函数式编程特点
//59、layer和uiview的关系
//60、GCD的队列类型
//61、如何使用GCD同步若干个异步调用
//62、以下代码运行结果如何？
//dispatch_queue_t queue = dispatch_queue_create("SerialQueue", DISPATCH_QUEUE_SERIAL);
//NSLog(@"1");
//dispatch_async(queue, ^{
//NSLog(@"2");
//dispatch_sync(queue, ^{
//NSLog(@"3");
//});
//NSLog(@"4");
//});
//NSLog(@"5");
//63、NSDictionary的实现原理
//64、UI界面开发过程中遇到的性能问题，如何优化；
//65、SEL（@selector）原理以及应用
//66、单例模式的实现以及优缺点
//
//二面：
//1.上来就是谈思想了，除掉履历上的内容，介绍自己，然后面试的题更偏重的是底层，一个函数中生成对象的整个内存分配过程，怎么生成、怎么释放
//2. 请写出出下面代码的执行顺序以及每次执行前等待了多长时间？并解释一下原因？
//DispatchQueue.main.async {
//DispatchQueue.main.async {
//sleep(2)
//print(1)
//    }
//print(2)
//DispatchQueue.main.async {
//print(3)
//    }
//}
//sleep(1)
//3. 上面的DispatchQueue.main全部都改成DispatchQueue.global呢？并解释一下原因？
//4. 如果是下面这种情况呢？请输出print的顺序并解释原因？如果queue.maxConcurrentOperationCount = 1会是什么样子呢？
//let queue = OperationQueue()
//queue.maxConcurrentOperationCount = 2
//queue.addOperation {
//queue.addOperation {
//sleep(1)
//print(1)
//    }
//print(2)
//queue.addOperation {
//print(3)
//    }
//}
//sleep(2)
//5. CGPoint在内存中的分配是如何的？
//struct Point {
//var x: CGFloat
//var y: CGFloat
//}
//class Point2: NSObject {
//var x: CGFloat
//var y: CGFloat
//}
//6. 编写一个函数，不管调用多少次都只执行一次？写一个debounce函数，在time时间内不论调用多少次，它只执行最后一次函数？
//7.KVC，KVO的原理？
//8. block如何做到延迟释放self？
//9. 对数组arr内的元素组合进行全排列？
//input: [1, 2, 3]
//output: [123, 132, 213, 231, 312, 321]
//
//1 （234）
//12（34）
//13（24）
//123（4）
//124（3）
//132（4）
//134（2）
//10.合并N个升序数组为一个升序数组？
//input: [[Int]]
//output: [Int]
//11.设计实现一个下载器？
//12. 项目中的链式调用，对这种封装怎么看，还有没有其他的方式
//项目中C++对象和OC对象的生命周期管理问题，这个着重问了如何处理互相转化的生命周期问题
//项目中的一些自动化如何实现的，如何看待自动化
//dispatch main queue sync之后的死锁问题
//get_current_queue 为什么被废除
//算法：反转链表，写了测试用例
//组件化和模块化
//北京ios四道算法题：
//
//Q1: 翻转单链表
//Q2：二叉树广度遍历
//Q3：快速排序
//Q4：Throttle实现
//
//三面：
//1.LRU算法
//2.设计日志监控SDK
//3.比如说有三种飞机，飞机a是2×16的座位，飞机b是4×18等等，然后比如说有32个乘客，这32个乘客，他依次从飞机门进入去选座位，乘客喜欢 1. 最靠近他的座位, 2.靠近前排的座位3.靠近过道的座位。 需要设计一个映射表，能反映一定数量的乘客和确定的机型的座位情况
//4.leetcode 134（https://leetcode-cn.com/problems/gas-station/）
//5.问了优化
//6.怎么理解编程
//7.讨论了技术和规则的问题，对抗的问题
//8.问了设计模式，比如，策略模式和命令模式的区别
//9.问了性能优化，怎么做，使用fps来测量界面流畅度有什么缺点，弱网络怎么处理，对应的方案是怎么实现的
//10.问了assign 修饰对象有什么作用，autorelease的实现原理
//11.问了TCP为什么是安全的，明文报文和二进制流的优缺点
//
//
//1-3面上海: 一到三面都有问
//自我介绍与项目介绍，说下你对自己评价最高的代码经验与bug处理经验
//UIViewController的生命周期内触发了那些方法
//block有几种类型，分别在哪里使用
//property修饰符种类及使用（weak，assign，copy，strong等）
//项目内遇到的崩溃及解决方案
//    笔试题
//
//一面 字符串单词逆序
//“I love you” 改成 “you love I”
//
//二面 求两个view最近的相同superview
//类似链表操作
//
//三面 二叉树的前序遍历
//  可以考虑用多线程提高效率MVC，MVVM，MVP的理解
- (void)dealloc
{
    NSLog(@"");
}




- (void)testTimer{
    self.doing = YES;
    
    NSThread *tread = [[NSThread alloc] initWithTarget:self selector:@selector(testFun) object:nil];
    tread.name = @"测试";

    self.testTread = tread;
    [tread start];
    
//    __weak __typeof(self) weakSelf = self;
//      dispatch_async(dispatch_get_global_queue(0, 0), ^{
//          __strong __typeof(weakSelf) strongSelf = weakSelf;
//          if (strongSelf) {
//              strongSelf.testTread = [NSThread currentThread];
//              [strongSelf.testTread setName:@"线程A"];
//              strongSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:strongSelf selector:@selector(timerAction) userInfo:nil repeats:YES];
//              NSRunLoop *runloop = [NSRunLoop currentRunLoop];
//              [runloop addTimer:strongSelf.timer forMode:NSDefaultRunLoopMode];
//              [runloop run];
//              NSLog(@"runloop finished");
//          }
//      });
    
    
    UIButton *btn  = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 100, 44)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(testBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)testFun{

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    
//   self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"123 %@",[NSThread currentThread]);
//    }];
    NSRunLoop *mainLoop = [NSRunLoop mainRunLoop];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    mainLoop;
    [runloop addTimer:self.timer forMode:NSDefaultRunLoopMode];
//    [runloop run];
//    [runloop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    while (self.doing && [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) {
        
    }

    
    for (NSInteger i = 0; i < 10; i++) {
        NSLog(@"1111");
    }
        
}

- (void)timerAction{
    NSLog(@"123 %@",[NSThread currentThread]);
}

- (void)testBtnDidClicked{
    [self cancle];
    return;
    if ([NSThread currentThread] != self.testTread) {
        [self performSelector:@selector(cancle) onThread:self.testTread withObject:nil waitUntilDone:NO];
    }
    
    NSLog(@"执行完了");
}

- (void)cancle{
    [self.timer invalidate];
    self.timer = nil;
    self.doing = NO;
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    
//    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
//    [runloop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
//    NSLog(@"1");
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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


- (void)testGCD{
    dispatch_queue_t queue = dispatch_queue_create("SerialQueue", DISPATCH_QUEUE_CONCURRENT); //DISPATCH_QUEUE_SERIAL
    NSLog(@"1");
    
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    
    NSLog(@"5");

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self testNSSet];
//    [self testTimer];
//    [self testHCImage];
    
//    [self testGCD];
//    [self testMemeryM];
    

    [self testStackView];
}

- (void)testStackView{
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40,40));
    }];
    
    UIView *purpleView = [UIView new];
    purpleView.backgroundColor = [UIColor purpleColor];
    [purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60,60));
    }];
    
    UIView *magentaView = [UIView new];
    magentaView.backgroundColor = [UIColor magentaColor];
    [magentaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50,50));
    }];
    
    
    UIStackView *stackview = [[UIStackView alloc] initWithArrangedSubviews:@[redView,purpleView,magentaView]];
    // item间距
    stackview.spacing = 30;
    // 水平方向布局
    stackview.axis = UILayoutConstraintAxisHorizontal;
    // 底部对齐
    stackview.alignment = UIStackViewAlignmentBottom;
    // 等间距
    stackview.distribution = UIStackViewDistributionEqualSpacing;
    
    [self.view addSubview:stackview];
    
    [stackview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(80);
    }];
    
    // 子视图 hidden，其余视图会自动补齐
//    magentaView.hidden = YES;
}

- (void)testMemeryM{
    
    UIView *view1 = [[UIView alloc] init];
    self.view2 = view1;
    self.view2.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:self.view2];
    
    self.view2.frame =CGRectMake(0, 200, 100, 100);
    
    
}

- (void)btnDidClicked{
    UIViewController *vcl = [UIViewController new];
    [self.navigationController pushViewController:vcl animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

@end
