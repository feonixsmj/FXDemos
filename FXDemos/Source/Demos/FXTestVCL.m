//
//  FXTestVCL.m
//  FXDemos
//
//  Created by suminjie on 2018/11/28.
//  Copyright © 2018 FX. All rights reserved.
//

#import "FXTestVCL.h"
#import "FXClassTest.h"

@interface FXTestVCL ()

@end

@implementation FXTestVCL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self
            action:@selector(tapAction)
    forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"消失" forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(100, 100, 200, 44);
    btn.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:btn];
    
}



- (void)tapAction{
    NSLog(@"11111");

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
