//
//  FXWindow.m
//  FXDemos
//
//  Created by suminjie on 2018/11/28.
//  Copyright © 2018 FX. All rights reserved.
//

#import "FXWindow.h"

@implementation FXWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = NO;
        self.windowLevel = UIWindowLevelStatusBar -1;
    }
    return self;
}

@end
