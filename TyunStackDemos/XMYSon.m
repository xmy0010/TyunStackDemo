//
//  XMYSon.m
//  TyunStackDemos
//
//  Created by T_yun on 2018/10/10.
//  Copyright © 2018年 优谱德. All rights reserved.
//

#import "XMYSon.h"

@implementation XMYSon

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

@end
