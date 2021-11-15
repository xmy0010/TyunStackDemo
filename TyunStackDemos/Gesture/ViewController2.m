//
//  ViewController2.m
//  TyunStackDemos
//
//  Created by zwzh_14 on 2021/10/21.
//  Copyright © 2021 优谱德. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@property (weak, nonatomic) IBOutlet UIImageView *planeImage;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onBtnTap:(id)sender {
//    [self planeDepart];
    
    [self fastDictionary];
}


-(void)planeDepart {
    CGPoint originalCenter = _planeImage.center;//记录原始位置
    [UIView animateKeyframesWithDuration:1.5 delay:0.0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.25 animations:^{
            CGPoint tempCenter = self.planeImage.center;//记录原始位置
            tempCenter.x += 120.0;
            tempCenter.y -= 10.0;
            self.planeImage.center = tempCenter;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.4 animations:^{
            self.planeImage.transform = CGAffineTransformMakeRotation(-M_PI_4 / 2);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
            CGPoint tempCenter = self.planeImage.center;//记录原始位置
            tempCenter.x += 200.0;
            tempCenter.y -= 50.0;
            self.planeImage.center = tempCenter;
            self.planeImage.alpha = 0;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.51 relativeDuration:0.01 animations:^{
            self.planeImage.transform = CGAffineTransformIdentity;
            CGPoint tempCenter = self.planeImage.center;
            tempCenter.x = 0;
            self.planeImage.center = tempCenter;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.45 animations:^{
            self.planeImage.alpha = 1;
            self.planeImage.center = originalCenter;
        }];
        
    } completion:nil];
}

-(void)fastDictionary {
    NSDictionary *dic = @{@"key1":@"value1",@"key2":@"value2",@"key3":@"value3"};
    for (NSString *key in dic) {
        NSString *value = dic[key];
        NSLog(@"key=%@,value=%@",key,value);
    }
}

//-(void)pathAnimation:(CFTimeInterval)beginTime {
//    UIBezierPath *circlePath1 = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:3 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//    UIBezierPath *circlePath2 = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:80 startAngle:0 endAngle:M_PI *2 clockwise:YES];
//    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
//    shapeLayer.strokeColor = UIColor.greenColor.CGColor;
//    shapeLayer.fillColor = UIColor.greenColor.CGColor;
//    shapeLayer.path = circlePath1.CGPath;
//    [self.view.layer addSublayer:shapeLayer];
//
//    //俩个动画
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
//    pathAnimation.fromValue = CFBridgingRelease(circlePath1.CGPath);
//    pathAnimation.toValue = CFBridgingRelease(circlePath2.CGPath);
//
//    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    alphaAnimation.fromValue = @0.8;
//    alphaAnimation.toValue = 0;
//
//    //组动画
//    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
//    animationGroup.beginTime = beginTime;
//    animationGroup.animations = @[pathAnimation, alphaAnimation];
//    animationGroup.duration = 2.76;
//    //不断重复
//    animationGroup.repeatCount = MAXFLOAT;
//    [animationGroup setRemovedOnCompletion:NO];
////    animationGroup.fillMode = @"forwards";
//    //key 用来dubug
//    [shapeLayer addAnimation:animationGroup forKey:@"pathAnimation"];
//}

// tag1.1
//tag 1.4
@end
