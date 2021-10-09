//
//  TYNetWorking.h
//  TyunStackDemos
//
//  Created by T_yun on 2017/3/13.
//  Copyright © 2017年 优谱德. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYNetWorking : NSObject


+ (void)gainSessionKeyWithType:(NSString *)type
                  successBlock:(void(^)(id result))successBlock
                  failureBlock:(void(^)(NSError *error))failureBlock;

@end
