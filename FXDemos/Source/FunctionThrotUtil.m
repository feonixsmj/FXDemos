//
//  FunctionThrotUtil.m
//  FXDemos
//
//  Created by 140013 on 2020/8/12.
//  Copyright © 2020 FX. All rights reserved.
//

#import "FunctionThrotUtil.h"

@implementation FunctionThrotUtil

+(void)startWithTarget:(id)aTarget  delayCallback:(SEL) fireBlockAfterDelay{

    [FunctionThrotUtil startWithTarget:aTarget delayCallback:fireBlockAfterDelay delay:1];

}

+(void)startWithTarget:(id)aTarget  delayCallback:(SEL) fireBlockAfterDelay delay: (NSTimeInterval)delay{

    [NSObject cancelPreviousPerformRequestsWithTarget:aTarget selector:fireBlockAfterDelay object:nil];

    [aTarget performSelector:fireBlockAfterDelay withObject:nil afterDelay:delay];

}

@end
