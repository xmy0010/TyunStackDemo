//
//  ViewController1.m
//  TyunStackDemos
//
//  Created by zwzh_14 on 2021/9/30.
//  Copyright © 2021 优谱德. All rights reserved.
//

#import "ViewController1.h"
#import "GestureView.h"
#import <GameplayKit/GameplayKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface ViewController1 ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet GestureView *greenView;
@property (weak, nonatomic) IBOutlet GestureView *yellowView;
@property (weak, nonatomic) IBOutlet GestureView *orangeView;

@property (nonatomic, strong) AVPlayerLayer *layer;
@property (nonatomic, strong) NSArray *arr;

@end

@implementation ViewController1


- (void)setArr:(NSArray *)arr {
    _arr = arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapView:)];
    tap.delegate = self;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapView:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapView:)];
    
    [self.greenView addGestureRecognizer:tap];
    [self.yellowView addGestureRecognizer:tap1];
    [self.orangeView addGestureRecognizer:tap2];
    
    
    
    self.orangeView.acceptGesture = YES;
    self.yellowView.acceptGesture = YES;
    self.greenView.acceptGesture = YES;
    //    [self.yellowView touchesBegan:<#(nonnull NSSet<UITouch *> *)#> withEvent:<#(nullable UIEvent *)#>]
}


- (IBAction)onBtnClick:(UIButton *)sender {
    
//    NSMutableArray *arr = @[].mutableCopy;
//    for (int i = 0; i < 20; i++) {
//        [arr addObject:[NSNumber numberWithInt:i]];
//    }
//    NSArray *newArr = [self shuffleArray:arr];
//    NSArray *result = [self sortArray:newArr];
//    NSLog(@"%@",result);
    
//    [self testBarrier];
//    [self testAboutQueue];
    [self avplayerForLive];
}

-(void)onTapView:(UITapGestureRecognizer *)sender {
    
    NSInteger tag = sender.view.tag;
    CGPoint location = [sender locationInView:self.view];
    for (GestureView *view in @[_orangeView,_yellowView,_greenView]) {
        if (view.tag == tag) {
            ///系统响应
            NSLog(@"点击tag=%ld",tag);
            continue;
        }
        CGPoint convertPoint = CGPointMake(location.x - view.frame.origin.x, location.y - view.frame.origin.y);
        if ([view.layer containsPoint:convertPoint] && view.acceptGesture) {
            ///在范围内 响应
            [self doSomeThingWithTag:view.tag];
        }
    }
}

- (void)doSomeThingWithTag:(NSInteger)tag {
    if (tag == 1) {
        NSLog(@"tap green view");
    } else if (tag == 2) {
        NSLog(@"tap yellow view");
    } else if (tag == 3) {
        NSLog(@"tap orange view");
    }
}


#pragma mark 随机数组元素
-(NSArray *)shuffleArray:(NSArray *)array {
    NSMutableArray *result = array.mutableCopy;
    int count = (int)array.count;
    for (int i = 0; i < count - 1; i++)
    {
        int nElements = count - i;
        int n = arc4random_uniform(nElements) + i;
//        int n = arc4random_uniform((uint32_t)count);
        [result exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return result.copy;
}

#pragma mark 数组由小到大排序
- (NSArray *)sortArray:(NSArray <NSNumber *>*)array {
    return  [array sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj1 compare:obj2];
    }];
}

#pragma mark block 直接访问实例变量与点语法访问区别
-(void)blcokUserProperty {
        __weak __typeof(self) weakSelf = self;
        void (^block)(void) =  ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            strongSelf->_arr = @[@"1",@"2"];     //不触发setter
    //        strongSelf.arr = @[@"1",@"2"];    //触发setter
        };
        block();
    
        NSLog(@"%@", self.arr);
}

#pragma mark 栅栏函数
-(void)testBarrier {
    dispatch_queue_t queue = dispatch_queue_create("ff", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async(queue, ^{
        NSLog(@"%@--1",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"%@--2",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"%@--3",[NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        for (int i = 0; i <= 500000000; i++) {
            if (i == 5000) {
                NSLog(@"point1");
            } else if (i == 6000) {
                NSLog(@"point2");
            }  else if (i == 7000) {
                NSLog(@"point3");
            }
        }
        NSLog(@"++++++++++++++++++barrier++++++++++++++++");
    });
    NSLog(@"aaaa");
    dispatch_async(queue, ^{
        NSLog(@"%@--4",[NSThread currentThread]);
    });
    NSLog(@"bbbb");
    dispatch_async(queue, ^{
        NSLog(@"%@--5",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"%@--6",[NSThread currentThread]);
    });
    
//    dispatch_barrier_sync和dispatch_barrier_async的共同点：
//    1、都会等待在它前面插入队列的任务（1、2、3）先执行完
//    2、都会等待他们自己的任务（0）执行完再执行后面的任务（4、5、6）
//
//    dispatch_barrier_sync和dispatch_barrier_async的不共同点：
//    在将任务插入到queue的时候，dispatch_barrier_sync需要等待自己的任务（0）结束之后才会继续程序，然后插入被写在它后面的任务（4、5、6），然后执行后面的任务
//    而dispatch_barrier_async将自己的任务（0）插入到queue之后，不会等待自己的任务结束，它会继续把后面的任务（4、5、6）插入到queue
//
//    所以，dispatch_barrier_async的不等待（异步）特性体现在将任务插入队列的过程，它的等待特性体现在任务真正执行的过程。

}

#pragma mark 队列 与 线程
- (void)testAboutQueue {
    NSLog(@"1");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");  //主线程死锁
//    });
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
    
    NSLog(@"4");
     dispatch_sync(dispatch_get_global_queue(0, 0), ^{
         NSLog(@"5");
     });
     NSLog(@"6");
    
    NSLog(@"7");
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
//         sleep(5);    //加这个时候2在8前执行
         NSLog(@"8"); //8在2前执行
     });
     NSLog(@"9");
}


#pragma mark AVPlayer 播放直播
-(void)avplayerForLive {
    
    [self.layer removeFromSuperlayer];
//    NSString *url = @"http://cdn1.cditv.cn/cdtv5/CDTV5.flv/playlist.m3u8?wsSecret=a2632d6b55740a31850b844687442aa3&wsTime=617113ed";
    NSString *url = @"http://39.105.104.59:18080/monitor/org17089/8155743778.m3u8";

   
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[[NSURL alloc] initWithString:url] options:nil];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset automaticallyLoadedAssetKeys:@[NSStringFromSelector(@selector(tracks))]];
//
//    AVPlayer *player = [[AVPlayer alloc] init];
//    [player replaceCurrentItemWithPlayerItem:playerItem];
//    AVPlayerLayer *playerLayer = [AVPlayerLayer layer];
//    self.layer = playerLayer;
//    [playerLayer setPlayer:player];
//    playerLayer.frame = CGRectMake(0, 50, 300, 300);
//    [self.view.layer addSublayer:playerLayer];
//    [player play];
    
        AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
        playerVC.player = [AVPlayer playerWithURL:[url hasPrefix:@"http"] ? [NSURL URLWithString:url]:[NSURL fileURLWithPath:url]];
        playerVC.view.frame = self.view.bounds;
//        [playerVC.player replaceCurrentItemWithPlayerItem:playerItem];
        playerVC.showsPlaybackControls = YES;
    //self.playerVC.entersFullScreenWhenPlaybackBegins = YES;//开启这个播放的时候支持（全屏）横竖屏哦
    //self.playerVC.exitsFullScreenWhenPlaybackEnds = YES;//开启这个所有 item 播放完毕可以退出全屏
        [self.navigationController pushViewController:playerVC animated:YES];
    
        if (playerVC.readyForDisplay) {
            [playerVC.player play];
        }

}

@end
