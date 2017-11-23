//
//  Person.m
//  runtime
//
//  Created by 祁宁 on 2017/11/17.
//  Copyright © 2017年 祁宁. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person
// objective-c的方法至少带有两个隐式参数（self和_cmd)
void goHome(id self, SEL _cmd, NSString *name)
{
    NSLog(@"%@回家了",name);
}

+ (void)load{
    Method method = class_getInstanceMethod(self, @selector(testRun:));
    Method method2 = class_getInstanceMethod(self, @selector(testEat:));
    method_exchangeImplementations(method, method2);
}

// 未实现的对象方法
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == NSSelectorFromString(@"goHome:")){
        class_addMethod([self class], @selector(goHome:), (IMP) goHome, "v@:");
    }
    return [super resolveInstanceMethod:sel];
}

// 未实现的类方法
//+ (BOOL)resolveClassMethod:(SEL)sel{
//
//}

- (void)run:(NSInteger)number{
    NSLog(@"跑了%ld步",number);
    
}

- (void)testRun:(NSInteger)number{
  
    NSLog(@"跑%ld米",number);
}

- (void)testEat:(NSInteger)number{
      NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"吃了%ld顿",number);
}


@end
