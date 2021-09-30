//
//  Person.h
//  TyunStackDemos
//
//  Created by T_yun on 2016/12/23.
//  Copyright © 2016年 优谱德. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol TYPersonProtocol <NSObject>

@optional
- (void)logA;

- (void)logB;

@end

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, weak) id delegate;

- (void)doDelegate;

- (NSComparisonResult)compare:(Person *)otherObject;

@end
