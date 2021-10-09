//
//  Person.m
//  TyunStackDemos
//
//  Created by T_yun on 2016/12/23.
//  Copyright © 2016年 优谱德. All rights reserved.
//

#import "Person.h"

@implementation Person


- (NSComparisonResult)compare:(Person *)otherObject {
    
    return [self.birthday compare:otherObject.birthday];
}

- (void)doDelegate {

    if ([self.delegate respondsToSelector:@selector(logA)]) {
        
        [self.delegate performSelector:@selector(logA)];
    }
    
//    if ([[self.delegate respondsToSelector:<#(SEL)#>]]) {
//        <#statements#>
//    }
}

@end
