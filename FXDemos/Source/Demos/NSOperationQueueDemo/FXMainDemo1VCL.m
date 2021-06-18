//
//  FXMainDemo1VCL.m
//  FXDemos
//
//  Created by suminjie on 2018/8/23.
//  Copyright © 2018年 FX. All rights reserved.
//

#import "FXMainDemo1VCL.h"

@interface FXMainDemo1VCL ()

@end

@implementation FXMainDemo1VCL

//              GCD
//              (任务)同步执行s      （任务）异步执行a
//串行队列    当前线程，一个一个执行    其他线程，一个一个执行
//并行队列    当前线程，一个一个执行    开很多线程，一起执行

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // NSInvocationOperation 调用start方法，默认在当前线程同步执行。貌似只能添加一个任务，因为没有提供实例方法
//    [self NSInvocationOperationTest];
    //NSBlockOperation blockOperationWithBlock 初始化方法完,分装多个任务会开启新的线程，若只有一个任务默认还是在当前线程执行。 可以添加多个任务，通过addExecutionBlock
//    [self NSBlockOperationTest];
    
    
//    [self NSOperationQueueTest];
//    [self NSOperationQueueTest2];
//    [self dispatchApply];
    
    [self gcdGroupTest];
}

#pragma mark - NEW TEST

- (void)newTest{
    
}

#pragma mark - ================ NSInvocationOperation ================
- (void)NSInvocationOperationTest{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperationRun:) object:@{@"key":@"111"}];
    
    [operation start];
    
    dispatch_queue_t queue = dispatch_queue_create("同步队列", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperationRun2:) object:@{@"key":@"222"}];
        
        [operation2 start];
        //operation2 里的任务执行完毕才会执行下面的任务。 他是同步的
        NSLog(@"invocationOperation2%@",[NSThread currentThread]);
    });
    
    NSLog(@"3333333");
}

- (void)invocationOperationRun:(NSObject *)obj{
    NSDictionary *dict = (NSDictionary *)obj;
    NSLog(@"invocationOperation paramet：%@\n%@",dict,[NSThread currentThread]);
}

- (void)invocationOperationRun2:(NSObject *)obj{
    sleep(1);
    NSDictionary *dict = (NSDictionary *)obj;
    NSLog(@"invocationOperation paramet2：%@\n%@",dict,[NSThread currentThread]);
}


#pragma mark - ================ NSBlockOperation ================
//  isReady -> isExecution -> isFinish
//  isReady: 返回 YES 表示操作已经准备好被执行, 如果返回NO则说明还有其他没有先前的相关步骤没有完成。
//  isExecuting: 返回YES表示操作正在执行，反之则没在执行。
//  isFinished : 返回YES表示操作执行成功或者被取消了

- (void)NSBlockOperationTest{
    //NSBlockOperation的使用
    // NSBlockOperation 添加任务后start ,里面的任务是并发执行，从里面的无序打印可以看出。但总体是阻塞了当前线程（主线程）从the end 最后打印可以看出。
    // 与GCD 的同步任务 并发队列不一样。gcd里的是，在当前线程一个一个的执行任务。
    NSLog(@"----NSBlockOperationTestStart-----");
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"X：%@",[NSThread currentThread]);
    }];
    
//    即使不用上面的初始方法，addExecutionBlock 同样会在当前线程和其他线程中执行，就意味着就算是addExecutionBlock方法同样会占用当前线程。这里的当前线程是主线程。
//    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    
    //添加多个Block
    for (NSInteger i = 0; i < 5; i++) {
        [operation addExecutionBlock:^{
            sleep(1);
            NSLog(@"第%ld次：%@", (long)i, [NSThread currentThread]);
        }];
    }
    
    NSLog(@"===start===监测是否sleep 是否阻塞当前线程");
    
    // 开始执行任务
    [operation start];

    NSLog(@"=========the end==========");
}

#pragma mark - ================ NSOperationQueue ================

- (void)NSOperationQueueTest{
    //主队列
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    //1.创建一个其他队列
    //其他队列 在其他线程并行执行(NSOperationQueue 不像GCD一样有串行队列，当可以通过设置maxConcurrentOperationCount最大并发数为1来达到串行执行的效果)
    NSOperationQueue *otherQueue = [[NSOperationQueue alloc] init];
//    otherQueue.maxConcurrentOperationCount = 1;
    //2.创建nsblockOperation对象
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
    
    //3.添加对个block
    for (NSInteger i = 0; i < 5; i++) {
        [blockOperation addExecutionBlock:^{
           NSLog(@"第%ld次：%@", (long)i, [NSThread currentThread]);
        }];
    }
    NSLog(@"hello");
    //4.队列添加任务  在其他队列并行
    [otherQueue addOperation:blockOperation];
//    [mainQueue addOperation:blockOperation];
    
//    for (NSInteger i = 0;i < 1000 ; i++) {
//        NSLog(@"end %d",i);
//    }
    [self task1];
    [self task2];
    [self task3];
//    [self task4];
}

- (void)task1{
    NSLog(@"end");
}

- (void)task2{
    NSLog(@"end");
}
- (void)task3{
    NSLog(@"end");
}
- (void)task4{
    NSLog(@"end");
    
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
    
    for (NSInteger i = 0; i < 5; i++) {
        [blockOperation addExecutionBlock:^{
            NSLog(@"第%ld次：%@", (long)i, [NSThread currentThread]);
        }];
    }
    [mainQueue addOperation:blockOperation];
    //N 个任务
    //task1
    //task2
    //task3
    //task4
    //...n
}

- (void)NSOperationQueueTest2{
    //1. 任务一:下载图片
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片-%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    //2.任务二：打水印
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"打水印   - %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    
    //3.任务三：上传图片
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"上传图片 - %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    
    [operation2 addDependency:operation1];
    [operation3 addDependency:operation2];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[operation1,operation2,operation3] waitUntilFinished:NO];
}

// 使用信号量来完成异步队列的任务完成状态 可以使用在gcd-group 和NSOperationQueue-addDependency

- (void)requestB{
//    按顺序执行 网络请求。用于NSOperationQueue中设置依赖关系的任务，因为网络请求异步执行，
//    不会阻塞当前线程，达不到按序执行的效果。
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//    [网络请求:{
//        成功: dispatch_semaphore_signal(sema);
//        失败: dispatch_semaphore_signal(sema);
//    }];
    //一直等待到信号量大于0才执行，并减1
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}


- (void)requestDemo{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    __weak typeof(self) weak_self = self;
    dispatch_group_async(group, queue, ^{
        NSLog(@"请求任务A");
        [weak_self requestA];
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"请求任务B");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"请求任务C");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"所有请求完成");
    });
}

- (void)requestA{
    //    用于GCD Group 以及 NSOperationQueue中设置依赖关系的任务，因为网络请求异步执行，
    //    不会阻塞当前线程，达不到按序执行的效果。
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    //    [异步请求:{
    //        成功: dispatch_semaphore_signal(sema);
    //        失败: dispatch_semaphore_signal(sema);
    //    }];
    //一直等待到信号量大于0才执行，并减1
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

- (void)semaphoreTest{
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    //初始信号量1 ，这里1可以为n
//    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
//    for (NSInteger i = 0; i < 10; i++) {
//        //大于0执行，并减1
//        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//        dispatch_async(queue, ^{
//            NSLog(@"%ld",i);
//            //任务完成，信号量加1
//            dispatch_semaphore_signal(sema);
//        });
//    }
//    //按顺序打印0-9

    
//    dispatch_async(queue, ^{
//        for (NSInteger i = 0; i < 100; i++) {
//            [muArray addObject:@(i)];
//        }
//    });
//    NSLog(@"");
}

- (void)dispatchApply{

    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        [muArr addObject:@(i)];
    }
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(globalQueue, ^{
        //普通for循环，是在一个线程里遍历
//        for (NSInteger i=0; i < 10; i++) {
//            NSLog(@"%ld:thread:%@",i,[NSThread currentThread]);
//        }
        //每个数组元素都添加一个block任务，且在多个线程中执行
        dispatch_apply(muArr.count, globalQueue, ^(size_t index) {
            NSLog(@"%zu: %@ thread:%@",index,muArr[index],[NSThread currentThread]);
        });
        
//        dispatch_apply 函数中的任务全部处理完毕
         
        dispatch_async(dispatch_get_main_queue(), ^{
            //回到主线程处理，用户界面刷新等。
            NSLog(@"done");
        });
    });

}

- (void)testGCD{
    //测试 同步执行多个并发队列 有什么效果。
    dispatch_queue_t currentQueue = dispatch_queue_create("CQ", DISPATCH_CURRENT_QUEUE_LABEL);
    
    dispatch_sync(currentQueue, ^{
        NSLog(@"1");
        dispatch_sync(currentQueue, ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    
    //成功死锁。队列始终是FIFO 不管是串行 还是 并行
}

- (void)testGCD2{
    dispatch_queue_t currentQueue = dispatch_queue_create("CQ", DISPATCH_CURRENT_QUEUE_LABEL);
    
    dispatch_async(currentQueue, ^{
        NSLog(@"1");
        [self performSelector:@selector(printSomeThing) withObject:nil afterDelay:0];
        NSLog(@"3");
    });
    //打印 1，3 。  2不打印，子线程不执行（子线程默认没有建立runloop）
}

- (void)printSomeThing{
    NSLog(@"###2");
}

- (void)gcdGroupTest{
//    [self testGCD];
    [self testGCD2];
    
//    [self semaphoreTest];
//    return;
 /*
    NSLog(@"task1");
    dispatch_queue_t otherQueue = dispatch_queue_create("com.test.gcd.serialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t otherQueue2 = dispatch_queue_create("com.test.gcd.serialQueue2", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(otherQueue, ^{
        NSLog(@"task2");
        //发生死锁，当前执行队列和dispatch_sync 执行队列相同且都是同步队列
        dispatch_sync(otherQueue2, ^{
            NSLog(@"task4");
            //task4 排在otherQueue执行任务task5之后，需要task5执行完毕才可以执行。
        });
        //同步执行，需要task4 执行完毕才可以执行task5。
        //task4 等待task5, task5 等待task4,发生死锁。
        NSLog(@"task5");
    });
    //打印 task1 task2 task3(task2,task3顺序不定)
    NSLog(@"task3");
   
    */
    
    
    
    /*
    //主线程中执行
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"thread%@",[NSThread currentThread]);
    });
    
    //打印 thread<NSThread: 0x6000008653c0>{number = 1, name = main}
    
    //主线程中执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"thread%@",[NSThread currentThread]);
    });
    //打印thread<NSThread: 0x600002ec5480>{number = 3, name = (null)}
    
    */
    
    /*
    dispatch_queue_t queue1 = dispatch_queue_create("com.test.gcd.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue1, ^{
       NSLog(@"thread%@",[NSThread currentThread]);
        dispatch_async(queue1, ^{
            NSLog(@"thread%@",[NSThread currentThread]);
        });
    });
    //打印
    //thread<NSThread: 0x600000002500>{number = 3, name = (null)}
    //thread<NSThread: 0x600000002500>{number = 3, name = (null)}
     是否开辟线程由系统内核决定
     */
    
//    DISPATCH_QUEUE_SERIAL
//    serialQueue
    /*
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.test.gcd.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t serialQueue = dispatch_queue_create("com.test.gcd.serialQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_set_target_queue(concurrentQueue, serialQueue);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"task1 thread:%@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"task2 thread:%@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"task3 thread:%@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"task4 thread:%@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"task5 thread:%@",[NSThread currentThread]);
    });
     
    //改变队列的属性，从并行 到 串行， 按序输出
    */
    
    /*
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.test.gcd.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    dispatch_set_target_queue(concurrentQueue, globalQueue);
*/
    // After
    /*
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull *NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"3秒后追加到主线程队列里执行");
    });
     */
    
    //有时打印
    //thread<NSThread: 0x6000037a1f40>{number = 4, name = (null)}
    //thread<NSThread: 0x6000037a1f40>{number = 4, name = (null)}
    //有时打印
    //thread<NSThread: 0x6000037a1f40>{number = 4, name = (null)}
    //thread<NSThread: 0x600003751e40>{number = 6, name = (null)}

//    dispatch_queue_t otherQueue = dispatch_queue_create("com.test.otherQueue", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_queue_t otherQueue2 = dispatch_queue_create("com.test.otherQueue2", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_async(otherQueue, ^{
//        NSLog(@"3,thread%@",[NSThread currentThread]);
//    });
//
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"4,thread%@",[NSThread currentThread]);
//    });
//
//    NSLog(@"2");
//    dispatch_get_main_queue()
//    NSLog(@"程序开始运行");
//    //主线程阻塞,开始执行block里的任务
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        //task2
//        NSLog(@"此句不执行,加到主队列中执行,排在task3后面，安装FIFO原则需要等待 task3执行完毕才能执行");
//    });
//    // task3 等待task2才能执行
//    // task2 等待task3, task3 等待 task2 .死锁
//    NSLog(@"此句不执行,主线程主队列死锁");
//
//    dispatch_queue_t queue1 = dispatch_queue_create("12", DISPATCH_QUEUE_CONCURRENT);
    
    /*
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"task1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"task2");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"task3");
        for (int i = 0; i < 10000000; i++){
            @autoreleasepool{
                NSString* string = @"ab c";
                //生成autorelease对象
                NSArray* array = [string componentsSeparatedByString:string];
            }
        }
    });
    
    //DISPATCH_TIME_FOREVER 永久等待，同样我们可以设置等待的时间

    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull*NSEC_PER_SEC);
    long result = dispatch_group_wait(group, time);
    if (result == 0) {
        // 属于Dispatch Group 的全部处理执行结束
        NSLog(@"task Done");
    } else {
        // 属于Dispatch Group 的某个处理还在执行中
        NSLog(@"task Doing");
    }
     
    //也可以使用dispatch_group_wait 函数
    //    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //    NSLog(@"task Done");
    
    
//    dispatch_group_notify(group, queue, ^{
//        NSLog(@"task Done");
//    });
     
     */
}


//dispatch_group_t group = dispatch_group_create();
//dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull*NSEC_PER_SEC);
//long result = dispatch_group_wait(group, time);
//if (result == 0) {
//   // 属于Dispatch Group 的全部处理执行结束
//   NSLog(@"task Done");
//} else {
//   // 属于Dispatch Group 的某个处理还在执行中
//   NSLog(@"task Doing");
//}
@end
