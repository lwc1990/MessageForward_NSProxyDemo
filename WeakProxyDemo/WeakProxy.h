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
/* Message Forwarding:顾名思义，消息转发 
 消息转发过程：
 正常过程：如果对象条用自己为实现的方法（即发送位置消息），runtime调用对象的forwardingInvocation：方法，NSobject的默认实现是抛出异常，终止程序。
 转发过程：在跳用对象未实现的方法时，我们需要对runtime要跳用的对象的forwardingInvocation方法重写，自行处理未知消息。
 如果向对象发送其不能处理的消息，会报错，抛出异常，但是Runtime系统提供了第二次处理未知消息的机制。
 二次处理这些未知消息的核心是有两个方法协同完成的。
 - (void)forwardInvocation:(NSInvocation *)anInvocation 
 1.这些方法是由基类NSObject声明实现的，意味着所有类都可以使用。
 2.默认实现调用doesNotRecognizeSelector：方法，然后跑出异常NSInvalidArgumentException,程序终止。
 3.重写此方法，可以实现消息转发 message Forwarding
 4.对象如果要响应非本身实现的方法，还必须重写methodSignatureForSeletor：方法，因为消息转发机制需要获取methodSignature信息生成NSInvocation,然后调用上述方法。
 - (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
 1.此方法也是由基类NSObject声明实现的，所有类都以实用。
 2.aSelector是方法名，receiver是实例对象，方法是实例方法，receiver是类，方法类方法。
 3.此方法除了常用于实现protocols之外，还常用于创建NSInvocation对象的时候，例如消息转发。
  */
@end
