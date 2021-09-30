//
//  AppDelegate.m
//  TyunStackDemos
//
//  Created by T_yun on 2016/11/8.
//  Copyright © 2016年 优谱德. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseWebViewController.h"
#import <BaiduTraceSDK/BaiduTraceSDK.h>
//#import "IQKeyboardManager.h"

#import "TYQuickLookController.h"


@interface AppDelegate ()<BTKTraceDelegate>

@end

@implementation AppDelegate

//- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
//    return  YES;
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    
//    TYQuickLookController *vc = [[TYQuickLookController alloc] init];
//    
//    UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:vc];
//    self.window.rootViewController = loginNC;
//    [self.window makeKeyAndVisible];
    
//    [vc loadHtml5WebViewurlString:@"http://url.cn/5t4Aaan?_wv=41729&_wvx=10"];
    


//    //鹰眼
//    BTKServiceOption *sop = [[BTKServiceOption alloc] initWithAK:@"pXG47UwGGr78VdeuMYYxGaeTIGquFo1M" mcode:@"com.youpude.TyunStackDemos" serviceID:150266 keepAlive:false];
//    [[BTKAction sharedInstance]initInfo:sop];
//
//    BTKStartServiceOption *op = [[BTKStartServiceOption alloc] initWithEntityName:@"entityB"];
//    //        // 初始化地图SDK
//    //        BMKMapManager *mapManager = [[BMKMapManager alloc] init];
//    //        [mapManager start:AK generalDelegate:self];
//    // 开启服务
//    // 设置开启轨迹服务时的服务选项，指定本次服务以“entityA”的名义开启
//
//        //开始采集
//    [[BTKAction sharedInstance] startService:op delegate:self];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        //开始采集
//        [[BTKAction sharedInstance] startGather:self];
//    });
    
    //IQKeybor
//    [IQKeyboardManager sharedManager];

    return YES;
}

//服务开启
- (void)onStartService:(BTKServiceErrorCode)error{

    // 维护状态标志
    if (error == BTK_START_SERVICE_SUCCESS || error == BTK_START_SERVICE_SUCCESS_BUT_OFFLINE) {
        NSLog(@"轨迹服务开启成功");
    } else {
        NSLog(@"轨迹服务开启失败");
    }
}

//采集回调
- (void)onStartGather:(BTKGatherErrorCode)error{

    if (error == BTK_START_GATHER_SUCCESS) {
        NSLog(@"开始采集成功");
    } else {
        NSLog(@"开始采集失败");
    }
}

//自定义字段上传
-(NSDictionary *)onGetCustomData {
    NSMutableDictionary *customData = [NSMutableDictionary dictionaryWithCapacity:3];
    NSArray *intPoll = @[@5000, @7000, @9000];
    NSArray *doublePoll = @[@3.5, @4.6, @5.7];
    NSArray *stringPoll = @[@"aaa", @"bbb", @"ccc"];
    int randomNum = arc4random() % 3;
    // intTest doubleTest stringTest这3个自定义字段需要在轨迹管理台提前设置才有效
    customData[@"intTest"] = intPoll[randomNum];
    customData[@"doubleTest"] = doublePoll[randomNum];
    customData[@"stringTest"] = stringPoll[randomNum];
    return [NSDictionary dictionaryWithDictionary:customData];
}

//消息推送回调
-(void)onGetPushMessage:(BTKPushMessage *)message {
    NSLog(@"收到推送消息，消息类型: %@", @(message.type));
    if (message.type == 0x03) {
        BTKPushMessageFenceAlarmContent *content = (BTKPushMessageFenceAlarmContent *)message.content;
        if (content.actionType == BTK_FENCE_MONITORED_OBJECT_ACTION_TYPE_ENTER) {
            NSLog(@"被监控对象 %@ 进入 服务端地理围栏 %@ ", content.monitoredObject, content.fenceName);
        } else if (content.actionType == BTK_FENCE_MONITORED_OBJECT_ACTION_TYPE_EXIT) {
            NSLog(@"被监控对象 %@ 离开 服务端地理围栏 %@ ", content.monitoredObject, content.fenceName);
        }
    } else if (message.type == 0x04) {
        BTKPushMessageFenceAlarmContent *content = (BTKPushMessageFenceAlarmContent *)message.content;
        if (content.actionType == BTK_FENCE_MONITORED_OBJECT_ACTION_TYPE_ENTER) {
            NSLog(@"被监控对象 %@ 进入 客户端地理围栏 %@ ", content.monitoredObject, content.fenceName);
        } else if (content.actionType == BTK_FENCE_MONITORED_OBJECT_ACTION_TYPE_EXIT) {
            NSLog(@"被监控对象 %@ 离开 客户端地理围栏 %@ ", content.monitoredObject, content.fenceName);
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
