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
    [self planeDepart];
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

@end
