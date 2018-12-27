//
//  FXMainListCell.m
//  FXDemos
//
//  Created by suminjie on 2018/8/23.
//  Copyright © 2018年 FX. All rights reserved.
//

#import "FXMainListCell.h"

@interface FXMainListCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FXMainListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(FXMainItem *)item{
    if (!item) {
        return;
    }
    _item = item;
    self.titleLabel.text = item.title;
}
@end
