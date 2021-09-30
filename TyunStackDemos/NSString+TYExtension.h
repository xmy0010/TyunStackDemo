//
//  NSString+TYExtension.h
//  TyunStackDemos
//
//  Created by T_yun on 2017/3/13.
//  Copyright © 2017年 优谱德. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (TYExtension)

@property(nonatomic, copy) NSString *pro;

//判断是否是无效字符串
- (BOOL)isUsefulString;

//MD5加密自身
- (NSString *)MD5String;

//生成随机24位 数字和字母混合字符串
+ (NSString *)ret24bitString;

//3DES加解密
+ (NSString *)tripleDES:(NSString *)text
         encryOrDecrypt:(BOOL)isEncry
                    key:(NSString *)key;


- (void)setPro:(NSString *)pro;

-(NSString *)pro;


@end
