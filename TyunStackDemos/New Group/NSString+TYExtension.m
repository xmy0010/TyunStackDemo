//
//  NSString+TYExtension.m
//  TyunStackDemos
//
//  Created by T_yun on 2017/3/13.
//  Copyright © 2017年 优谱德. All rights reserved.
//

#import "NSString+TYExtension.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>

NSString *xmy_pro;

@implementation NSString (TYExtension)


- (void)setPro:(NSString *)pro{
    
    xmy_pro = pro;
}
- (NSString *)pro{
    
    return xmy_pro;
}

//是否为有效字符串
-(BOOL)isUsefulString {

    if (![self isKindOfClass:[NSString class]]) {
        
        return NO;
    } else if (self == nil || [self isKindOfClass:[NSNull class]]) {
    
        return NO;
    } else if ([self isEqualToString:@"(null)"] || [self isEqualToString:@"<null>"]) {
    
        return NO;
    } else if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
    
        return NO;
    }
    
    return YES;
}

//随机24位数字和字符串混合
+(NSString *)ret24bitString {
    
    
    int NUMBER_OF_CHARS = 24;
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < NUMBER_OF_CHARS; i++) {
        
        int number = arc4random() % 36;
        if (number < 10) {
            
            //随机一个数字
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            [string appendString:tempString];
        } else {
        
            //随机一个字母
            int figure = arc4random() % 26 + 97;
            char charater = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", charater];
            [string appendString:tempString];
        }
    }

    return string;
}

//3des加解密
+ (NSString *)tripleDES:(NSString *)text encryOrDecrypt:(BOOL)isEncry key:(NSString *)key {

    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (isEncry) {
        
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    } else {
    
        NSData *encryptData = [GTMBase64 decodeData:[text dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [encryptData length];
        vplainText = [encryptData bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
//    NSString *initVec = @"p2p_s2iv";
    const void *vkey = (const void *)[key UTF8String];
//    const void *vinitVec = (const void *) [initVec UTF8String];
    
    CCOperation operation = kCCEncrypt;
    if (!isEncry) {
        
        operation = kCCDecrypt;
    }
    ccStatus = CCCrypt(operation,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result;
    NSData *resultData = [NSData dataWithBytes:(const void*)bufferPtr length:(NSUInteger)movedBytes];
    if (isEncry) {
        
        result = [GTMBase64 stringByEncodingData:resultData];
    } else {
    
        result = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    
    return result;
}


//32位 小写
- (NSString *)MD5String {
    
    if ([self isUsefulString]) {
        
        const char *cStr = [self UTF8String];
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5(cStr, strlen(cStr), digest);
        
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
            
            [output appendFormat:@"%02x", digest[i]];
        }
        
        return output;
    }
    
    return @"";
}

@end
