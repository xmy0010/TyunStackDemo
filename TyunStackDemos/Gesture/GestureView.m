//
//  GestureView.m
//  TyunStackDemos
//
//  Created by zwzh_14 on 2021/10/8.
//  Copyright © 2021 优谱德. All rights reserved.
//

#import "GestureView.h"

@implementation GestureView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"hitTest tag=%ld",(long)self.tag);
    UIView * view = [super hitTest:point withEvent:event];
//    //忽略该事件 向同一个superView的下层传递
//    if (view == self && self.ignoreGesture) {
//        NSArray *views = self.superview.subviews;
//        NSInteger index = [views indexOfObject:self];
//        if (index > 0) {
//            id responder = views[index - 1];
//            if ([responder isKindOfClass:[UIResponder class]]) {
//                return  [responder hitTest:point withEvent:event];
//            }
//        }
//    }
    
    return view;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"pointInside tag=%ld",(long)self.tag);
    return [super pointInside:point withEvent:event];
}



#pragma mark 消息转发
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return [super resolveInstanceMethod:sel];
}

@end
