//
//  FXMainViewController.m
//  FXDemos
//
//  Created by suminjie on 2018/8/23.
//  Copyright © 2018年 FX. All rights reserved.
//

#import "FXMainViewController.h"
#import "FXMainModel.h"
#import "FXMainListCell.h"

@interface FXMainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FXMainModel *model;
@end

@implementation FXMainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [FXMainModel new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Demos";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        UITableView *tableView = [[UITableView alloc] initWithFrame:rect];
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.rowHeight = 50;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [tableView registerNib:[UINib nibWithNibName:@"FXMainListCell" bundle:nil] forCellReuseIdentifier:@"FXMainListCell"];
        
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - ================ UITableView Delegate ================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FXMainListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FXMainListCell"];
    FXMainItem *item = self.model.items[indexPath.row];
    cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FXMainItem *item = self.model.items[indexPath.row];
    NSString *className = [NSString stringWithFormat:@"FXMainDemo%ldVCL",item.index];
    Class class = NSClassFromString(className);
    
    UIViewController *vcl = [[class alloc] init];
    [vcl setValue:item.title forKey:@"title"];
    [self.navigationController pushViewController:vcl animated:YES];
}

@end
