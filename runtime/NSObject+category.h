//
//  NSObject+category.h
//  runtime
//
//  Created by 祁宁 on 2017/11/18.
//  Copyright © 2017年 祁宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (category)
@property (nonatomic,copy)NSString *name;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
