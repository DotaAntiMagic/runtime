//
//  NSObject+category.m
//  runtime
//
//  Created by 祁宁 on 2017/11/18.
//  Copyright © 2017年 祁宁. All rights reserved.
//

#import "NSObject+category.h"
#import <objc/message.h>
@implementation NSObject (category)
- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, @"name", name,  OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name{
  return  objc_getAssociatedObject(self, @"name");
}

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    id model = [[self alloc] init];
    // 遍历字典中的模型
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        // 属性名称
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        ivarName = [ivarName substringFromIndex:1];
        if (dict[ivarName])
            [model setValue:dict[ivarName] forKey:ivarName];
    }
    return model;
}
@end
