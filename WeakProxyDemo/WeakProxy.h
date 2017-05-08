//
//  WeakProxy.h
//  WeakProxyDemo
//
//  Created by syl on 2017/5/8.
//  Copyright © 2017年 personCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakProxy : NSProxy
@property (nonatomic,weak,readonly) id target;
+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;
@end
