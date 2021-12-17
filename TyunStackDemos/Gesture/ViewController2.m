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
@property (weak, nonatomic) IBOutlet UIView *tabBtnsView;
@property (strong, nonatomic)  UIImageView *line;


@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBtns];
}

-(void)setupTabBtns {
    CGFloat btnWidth = 45;
    CGFloat btnHeight = 25;
    CGFloat btnSpace = 10;
    CGFloat totalWidth = 0;
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:_tabBtnsView.bounds];
    [_tabBtnsView addSubview:scroll];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    NSArray *_tabCategorys = @[@"栏目789",@"栏目456",@"栏目123",@"订单",@"23",@"哈哈",@"这样",@"圣诞节看数据的",@"订单",@"23"];
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, btnHeight + 3, 15, 3)];
    line.image = [UIImage imageNamed:@"news_video_slider"];
    _line = line;
    [scroll addSubview:line];
    for (int index = 0; index < _tabCategorys.count; index++) {
        NSString *model = _tabCategorys[index];
        CGRect frame = CGRectMake(index * (btnWidth + btnSpace), 0, btnWidth, btnHeight);
        UIButton *btn = [[UIButton alloc] initWithFrame:frame];
        [btn setTitle:model forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.blackColor  forState:UIControlStateNormal];

        btn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
        if (index == _tabCategorys.count - 1) {
            totalWidth = CGRectGetMaxX(frame);
        }
        if (index == 0) {
            CGPoint center = line.center;
            center.x = btn.center.x;
            line.center = center;
        }
        btn.tag = index;
        [btn addTarget:self action:@selector(onTabBtn:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:btn];
    }
    
    scroll.contentSize = CGSizeMake(totalWidth > _tabBtnsView.frame.size.width ? totalWidth : _tabBtnsView.frame.size.width, _tabBtnsView.frame.size.height);
}
- (void)onTabBtn:(UIButton *)sender {
    NSLog(@"---%ld",sender.tag);
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = self.line.center;
        center.x = sender.center.x;
        self.line.center = center;
    }];
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
        //code11
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

// code1.2
// code1.4
@end
