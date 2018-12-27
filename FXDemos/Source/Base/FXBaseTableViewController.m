//
//  FXBaseTableViewController.m
//  FXDemos
//
//  Created by suminjie on 2018/9/10.
//  Copyright © 2018年 FX. All rights reserved.
//

#import "FXBaseTableViewController.h"

@interface FXBaseTableViewController ()

@end

@implementation FXBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
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
        
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - ================ UITableView Delegate ================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *itemObj = self.model.items[indexPath.row];
    NSString *itemClassStr = NSStringFromClass(itemObj.class);
    
    NSMutableString *muItemClassStr = [NSMutableString stringWithString:itemClassStr];
    [muItemClassStr replaceCharactersInRange:NSRangeFromString(@"Item") withString:@"Cell"];
    
    NSString *cellClassStr = muItemClassStr;
    
    Class cellClass = NSClassFromString(cellClassStr);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClassStr];
    
    return cell;
    
}

@end
