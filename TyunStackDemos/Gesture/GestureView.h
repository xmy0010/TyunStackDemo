//
//  GestureView.h
//  TyunStackDemos
//
//  Created by zwzh_14 on 2021/10/8.
//  Copyright © 2021 优谱德. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GestureView : UIView

///当第一响应对象不是自己  但是点击范围在本视图内 想要响应事件
@property (nonatomic, assign) BOOL acceptGesture;


@end

NS_ASSUME_NONNULL_END
