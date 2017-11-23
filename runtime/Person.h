//
//  Person.h
//  runtime
//
//  Created by 祁宁 on 2017/11/17.
//  Copyright © 2017年 祁宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject;
@property (nonatomic,copy)NSString *alt;
@property (nonatomic,copy)NSString *publisher;
@property (nonatomic,copy)NSString *isbn10;
@property (nonatomic,copy)NSString *isbn13;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *summary;
@property (nonatomic,copy)NSString *price;
- (void)run:(NSInteger)number;
@end
