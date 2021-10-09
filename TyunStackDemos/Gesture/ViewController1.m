//
//  ViewController1.m
//  TyunStackDemos
//
//  Created by zwzh_14 on 2021/9/30.
//  Copyright © 2021 优谱德. All rights reserved.
//

#import "ViewController1.h"
#import "GestureView.h"

@interface ViewController1 ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet GestureView *greenView;
@property (weak, nonatomic) IBOutlet GestureView *yellowView;
@property (weak, nonatomic) IBOutlet GestureView *orangeView;

@end

@implementation ViewController1

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



@end
