//
//  FXBaseTableViewController.h
//  FXDemos
//
//  Created by suminjie on 2018/9/10.
//  Copyright © 2018年 FX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBaseViewController.h"

@interface FXBaseTableViewController : FXBaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@end
