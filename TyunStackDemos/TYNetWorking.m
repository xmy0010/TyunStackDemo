//
//  TYNetWorking.m
//  TyunStackDemos
//
//  Created by T_yun on 2017/3/13.
//  Copyright © 2017年 优谱德. All rights reserved.
//

#import "TYNetWorking.h"
#import <AFNetworking.h>
#import "NSString+TYExtension.h"

#define kImei [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#define kPublic_key @"8D219C38AD1407F46C12H8I1"

@implementation TYNetWorking

//获取context
+(NSDictionary *)getContext {

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [ud objectForKey:@"userInfo"];
    NSString *userId = userInfo[@"userId"];
    if (![userId isUsefulString]) {
        
        userId = @"0";
    }
    
    NSDictionary *context = @{@"imei" : [kImei stringByReplacingOccurrencesOfString:@"-" withString:@""],
                              @"imsi" : @"0",
                              @"userid" : userId};
    
    return context;
}
//获取data
+ (NSDictionary *)getSessionData {


    NSDictionary *data = @{@"imei" : [kImei stringByReplacingOccurrencesOfString:@"-" withString:@""],
                           @"randomcode" : [NSString ret24bitString]};
    
    return data;
}


+ (void)gainSessionKeyWithType:(NSString *)type successBlock:(void (^)(id))successBlock failureBlock:(void (^)(NSError *error))failureBlock {

    if ([type isEqualToString:@"0"]) {
        
        NSDictionary *context = [self getContext];
        NSDictionary *sessionData = [self getSessionData];
        
        NSData *codeData = [NSJSONSerialization dataWithJSONObject:sessionData options:NSJSONWritingPrettyPrinted error:nil];
        NSString *strData = [[NSString alloc] initWithData:codeData encoding:NSUTF8StringEncoding];
        NSString *data = [NSString tripleDES:strData encryOrDecrypt:YES key:kPublic_key];
        NSDictionary *param = @{@"type" : @"0",
                                @"context" : context,
                                @"data" : data,
                                @"verify" :  [strData MD5String]};
        
        [self POSTWithUrl:@"http://192.168.0.183:8080/api/v1/SessionKeys" Parameters:param SuccessBlock:^(id result) {
            if (successBlock) {
                
                successBlock(result);
            }
        } FailureBlock:^(NSError *error) {
            if (failureBlock) {
                
                failureBlock(error);
            }
            
        }];
    }
}


+ (void)POSTWithUrl:(NSString *)url Parameters:(id)param SuccessBlock:(void(^)(id result))successBlock FailureBlock:(void(^)(NSError *error))failureBlock {
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/xml",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.requestSerializer.timeoutInterval = 15;
    
//    NSDictionary *context = @{@"userid" : @"0",
//                              @"imsi" : @"0",
//                              @"imei" : @"522DBEDAFAEC41B19C686E6E7934484E"};
//    param = @{@"type" : @"0",
//              @"data" : @"kOsAAg9bzMy0+YkSNYQkOMbrbQIFLmMqNbvcfOGvZcbf7iZIYmUqwtmd3+O2CiTRRA4gv0Gg2rP1HGtvmYJG6sN3QsxUOvVs7ejOGKp3aECHoDB+8IHR94iX2KE7IO7s",
//              @"verify" : @"8eb1df1578dce023c3be9cce525ac4e1",
//              @"context" : context};
    
    [session POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failureBlock) {
            
            failureBlock(error);
        }
    }];
    

}

@end
