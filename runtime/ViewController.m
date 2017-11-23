//
//  ViewController.m
//  runtime
//
//  Created by 祁宁 on 2017/11/17.
//  Copyright © 2017年 祁宁. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "Person.h"
#import "NSObject+category.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       [self runTimeMessageSend];
    [self runTimeMethodSwizzling];
    [self runTimeResolveInstanceMethod];
    [self addProperty];
    [self runtimeDictionaryToModel];
}

#pragma mark -- runtime消息发送
- (void)runTimeMessageSend{
    Class personClass = objc_getClass("Person");
    Person *person = objc_msgSend(personClass, @selector(alloc));
    person = objc_msgSend(person, @selector(init));
//    Person *person = [[Person alloc] init];
   objc_msgSend(person, @selector(run:),500);
}

#pragma mark -- runtime方法交换
- (void)runTimeMethodSwizzling{
    Person *person = [[Person alloc] init];
    //调用person私有方法跑，实际调用的却是吃的方法
    objc_msgSend(person, @selector(testRun:),100);
}

#pragma mark -- runtime动态加载方法,调用某个类中未实现的方法
- (void)runTimeResolveInstanceMethod{
    Person *person = [[Person alloc] init];
    [person performSelector:@selector(goHome:) withObject:@"小明"];
}

#pragma mark -- 动态关联属性,给系统的类添加属性
- (void)addProperty{
        NSObject *object = [[NSObject alloc] init];
        object.name = @"11";
        NSLog(@"%@",object.name);
}

#pragma mark -- 字典转模型
- (void)runtimeDictionaryToModel{
    NSString *apiString = @"https://api.douban.com/v2/book/1220562";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:apiString]];
   request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            Person *personModel = [Person modelWithDict:dict];
            NSLog(@"%@",personModel.price);
        }
    }];
    [dataTask resume];
}

@end
