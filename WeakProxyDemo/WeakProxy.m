//
//  WeakProxy.m
//  WeakProxyDemo
//
//  Created by syl on 2017/5/8.
//  Copyright © 2017年 personCompany. All rights reserved.
//

#import "WeakProxy.h"

@implementation WeakProxy
- (instancetype)initWithTarget:(id)target{
    _target = target;
    return self;
}
+ (instancetype)proxyWithTarget:(id)target{
    return [[self alloc] initWithTarget:target];
}
- (void)forwardInvocation:(NSInvocation *)invocation{
    /* NSInvocation 是包装对象和Selector的
     系统传过来的invocation，已经包装了对象，和对应的方法，以及参数等信息；可以设置对象，方法，方法的参数，方法的返回值。
     然后可以通过 invoke方法让被包装的对象执行对应的方法，我们也可以通过invokeWithTarget：来执行对应的方法，如果对象没有实现对应的方法 就会报错。
     */
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        /* 
         以此程序为例：
         invocation 包装的是WeakProxy对象和timer要执行的事件，在消息转发时，我们可以会发现WeakProxy对象并为实现该
         方法法，这个方法的实现时在timer的持有者也就是self.target中实现的。如果我们在这里直接[invocation invoke]就是
         默认的WeakProxy对象调用方法，就会崩溃；如果我们重新设定invocation的target为self.target就不会有问题，也可以
         直接指定对象来执行[invocation invokeWithTarget:self.target]
         */
        [invocation invokeWithTarget:self.target];
        /*
            根据上面的分析：
         [invocation invoke] 崩溃
         invocation.target = self.target 是可以的 等同于 [invocation invokeWithTarget:self.target]
         */
    }
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    /*方法签名，类似于C++编译时的函数签名，里面包含方法的参数个数，方法返回值信息大多信息是值读的；可以通过NSObject的methodSignatureForSelector：方法获取实例化对象，它主要是协同NSInvocation实现消息转发 ,要保证NSInvocation对象的中的Selector与该方法返回的方法签名中的Seletor一致*/
    return [self.target methodSignatureForSelector:aSelector];
    
}
//invocation的用法： https://github.com/lwc1990/DemoForInvocation.git
- (BOOL)respondsToSelector:(SEL)aSelector{
    return [self.target respondsToSelector:aSelector];
}
@end
