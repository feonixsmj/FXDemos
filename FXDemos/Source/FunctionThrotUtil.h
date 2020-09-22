//
//  FunctionThrotUtil.h
//  FXDemos
//
//  Created by 140013 on 2020/8/12.
//  Copyright © 2020 FX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FunctionThrotUtil : NSObject

+(void)startWithTarget:(id)aTarget  delayCallback:(SEL) fireBlockAfterDelay;

+(void)startWithTarget:(id)aTarget  delayCallback:(SEL) fireBlockAfterDelay delay: (NSTimeInterval)delay;
@end

NS_ASSUME_NONNULL_END
