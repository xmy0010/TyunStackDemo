//
//  YYMenuLabel.m
//  TyunStackDemos
//
//  Created by zwzh_14 on 2022/1/6.
//  Copyright © 2022 优谱德. All rights reserved.
//

#import "YYMenuLabel.h"

@implementation YYMenuLabel



- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
//    if (action == @selector(cut:) || action == @selector(copy:) || action == @selector(paste:)) return YES;

//    if (action == @selector(reply:)) {
//        return YES;
//    }
    return NO;
}
//
//-(void)reply:(UIMenuController *)menu {
//    NSLog(@"回复");
//}

@end
