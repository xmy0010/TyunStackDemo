/*****
 * Tencent is pleased to support the open source community by making QMUI_iOS available.
 * Copyright (C) 2016-2018 THL A29 Limited, a Tencent company. All rights reserved.
 * Licensed under the MIT License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 * http://opensource.org/licenses/MIT
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 *****/

//
//  UIButton+QMUI.m
//  qmui
//
//  Created by QMUI Team on 15/7/20.
//

#import "UIButton+QMUI.h"
#import "QMUICore.h"

@interface UIButton ()

@property(nonatomic, strong) NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSNumber *> *> * qmui_customizeButtonPropDict;

@end

@implementation UIButton (QMUI)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations([self class], @selector(setTitle:forState:), @selector(qmui_setTitle:forState:));
        ExchangeImplementations([self class], @selector(setTitleColor:forState:), @selector(qmui_setTitleColor:forState:));
        ExchangeImplementations([self class], @selector(setTitleShadowColor:forState:), @selector(qmui_setTitleShadowColor:forState:));
        ExchangeImplementations([self class], @selector(setImage:forState:), @selector(qmui_setImage:forState:));
        ExchangeImplementations([self class], @selector(setBackgroundImage:forState:), @selector(qmui_setBackgroundImage:forState:));
        ExchangeImplementations([self class], @selector(setAttributedTitle:forState:), @selector(qmui_setAttributedTitle:forState:));
    });
}

- (instancetype)qmui_initWithImage:(UIImage *)image title:(NSString *)title {
    BeginIgnoreClangWarning(-Wunused-value)
    [self init];
    EndIgnoreClangWarning
    [self setImage:image forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    return self;
}

- (void)qmui_calculateHeightAfterSetAppearance {
    [self setTitle:@"???" forState:UIControlStateNormal];
    [self sizeToFit];
    [self setTitle:nil forState:UIControlStateNormal];
}

- (BOOL)qmui_hasCustomizedButtonPropForState:(UIControlState)state {
    if (self.qmui_customizeButtonPropDict) {
        return self.qmui_customizeButtonPropDict[@(state)].count > 0;
    }
    
    return NO;
}

- (BOOL)qmui_hasCustomizedButtonPropWithType:(QMUICustomizeButtonPropType)type forState:(UIControlState)state {
    if (self.qmui_customizeButtonPropDict && self.qmui_customizeButtonPropDict[@(state)]) {
        return [self.qmui_customizeButtonPropDict[@(state)][@(type)] boolValue];
    }
    
    return NO;
}

#pragma mark - Hook methods

- (void)qmui_setTitle:(NSString *)title forState:(UIControlState)state {
    [self qmui_setTitle:title forState:state];
    
    [self _markQMUICustomizeType:QMUICustomizeButtonPropTypeTitle forState:state value:title];
    
    if (!title || !self.qmui_titleAttributes.count) {
        return;
    }
    
    if (state == UIControlStateNormal) {
        [self.qmui_titleAttributes enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
            UIControlState state = [key unsignedIntegerValue];
            NSString *titleForState = [self titleForState:state];
            NSAttributedString *string = [[NSAttributedString alloc] initWithString:titleForState attributes:obj];
            [self setAttributedTitle:[self attributedStringWithEndKernRemoved:string] forState:state];
        }];
        return;
    }
    
    if ([self.qmui_titleAttributes objectForKey:@(state)]) {
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:title attributes:self.qmui_titleAttributes[@(state)]];
        [self setAttributedTitle:[self attributedStringWithEndKernRemoved:string] forState:state];
        return;
    }
}

// ?????????????????????????????? state ????????????????????????????????????????????????
- (void)qmui_setTitleColor:(UIColor *)color forState:(UIControlState)state {
    [self qmui_setTitleColor:color forState:state];
    
    [self _markQMUICustomizeType:QMUICustomizeButtonPropTypeTitleColor forState:state value:color];
    
    NSDictionary *attributes = self.qmui_titleAttributes[@(state)];
    if (attributes) {
        NSMutableDictionary *newAttributes = [NSMutableDictionary dictionaryWithDictionary:attributes];
        newAttributes[NSForegroundColorAttributeName] = color;
        [self qmui_setTitleAttributes:[NSDictionary dictionaryWithDictionary:newAttributes] forState:state];
    }
}

- (void)qmui_setTitleShadowColor:(nullable UIColor *)color forState:(UIControlState)state {
    [self qmui_setTitleShadowColor:color forState:state];
    [self _markQMUICustomizeType:QMUICustomizeButtonPropTypeTitleShadowColor forState:state value:color];
}
- (void)qmui_setImage:(nullable UIImage *)image forState:(UIControlState)state {
    [self qmui_setImage:image forState:state];
    [self _markQMUICustomizeType:QMUICustomizeButtonPropTypeImage forState:state value:image];
}
- (void)qmui_setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state {
    [self qmui_setBackgroundImage:image forState:state];
    [self _markQMUICustomizeType:QMUICustomizeButtonPropTypeBackgroundImage forState:state value:image];
}
- (void)qmui_setAttributedTitle:(nullable NSAttributedString *)title forState:(UIControlState)state {
    [self qmui_setAttributedTitle:title forState:state];
    [self _markQMUICustomizeType:QMUICustomizeButtonPropTypeAttributedTitle forState:state value:title];
}

#pragma mark - Title Attributes

- (void)qmui_setTitleAttributes:(NSDictionary<NSString *,id> *)attributes forState:(UIControlState)state {
    if (!attributes) {
        [self.qmui_titleAttributes removeObjectForKey:@(state)];
        [self setAttributedTitle:nil forState:state];
        return;
    }
    
    if (!self.qmui_titleAttributes) {
        self.qmui_titleAttributes = [NSMutableDictionary dictionary];
    }
    
    // ??????????????? attributes ?????????????????????????????????????????????????????? setTitleColor:forState: ?????????????????????
    if (![attributes objectForKey:NSForegroundColorAttributeName]) {
        NSMutableDictionary *newAttributes = [NSMutableDictionary dictionaryWithDictionary:attributes];
        newAttributes[NSForegroundColorAttributeName] = [self titleColorForState:state];
        attributes = [NSDictionary dictionaryWithDictionary:newAttributes];
    }
    self.qmui_titleAttributes[@(state)] = attributes;
    
    // ??????????????????????????? attributes ?????????????????? setTitle:forState: ???????????????????????????????????? attributes
    NSString *originalText = [self titleForState:state];
    [self setTitle:originalText forState:state];
    
    // ?????????????????????????????????bug??????????????????? UIControlStateHighlighted????????? normal ??????????????? state?????????????????? NSFont/NSKern/NSUnderlineAttributeName ????????? attributedString ??????????????? setTitle:forState: ??? UIControlStateNormal ?????????????????? string ??????????????? highlighted ????????? normal ????????????font ????????????????????????????????? highlighted ????????????
    // ??????????????????????????????????????????????????? normal ????????? state ???????????? qmui_titleAttributes ???????????????????????? attributedString?????? normal ??????????????? attributedString
    if (self.qmui_titleAttributes.count && !self.qmui_titleAttributes[@(UIControlStateNormal)]) {
        [self qmui_setTitleAttributes:@{} forState:UIControlStateNormal];
    }
}

// ???????????????????????? kern ??????
- (NSAttributedString *)attributedStringWithEndKernRemoved:(NSAttributedString *)string {
    if (!string || !string.length) {
        return string;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:string];
    [attributedString removeAttribute:NSKernAttributeName range:NSMakeRange(string.length - 1, 1)];
    return [[NSAttributedString alloc] initWithAttributedString:attributedString];
}

static char kAssociatedObjectKey_titleAttributes;
- (void)setQmui_titleAttributes:(NSMutableDictionary<NSString *, id> *)qmui_titleAttributes {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_titleAttributes, qmui_titleAttributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSNumber *, NSDictionary *> *)qmui_titleAttributes {
    return (NSMutableDictionary *)objc_getAssociatedObject(self, &kAssociatedObjectKey_titleAttributes);
}

#pragma mark - customize state

static char kAssociatedObjectKey_qmuiCustomizeButtonPropDict;
- (void)setQmui_customizeButtonPropDict:(NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSNumber *> *> *)qmui_customizeButtonPropDict {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_qmuiCustomizeButtonPropDict, qmui_customizeButtonPropDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSNumber *, NSMutableDictionary<NSNumber *, NSNumber *> *> *)qmui_customizeButtonPropDict {
    return (NSMutableDictionary *)objc_getAssociatedObject(self, &kAssociatedObjectKey_qmuiCustomizeButtonPropDict);
}

- (void)_markQMUICustomizeType:(QMUICustomizeButtonPropType)type forState:(UIControlState)state value:(id)value {
    if (value) {
        [self _setQMUICustomizeType:type forState:state];
    } else {
        [self _removeQMUICustomizeType:type forState:state];
    }
}

- (void)_setQMUICustomizeType:(QMUICustomizeButtonPropType)type forState:(UIControlState)state {
    if (!self.qmui_customizeButtonPropDict) {
        self.qmui_customizeButtonPropDict = [NSMutableDictionary dictionary];
    }
    
    if (!self.qmui_customizeButtonPropDict[@(state)]) {
        self.qmui_customizeButtonPropDict[@(state)] = [NSMutableDictionary dictionary];
    }
    
    self.qmui_customizeButtonPropDict[@(state)][@(type)] = @(YES);
}

- (void)_removeQMUICustomizeType:(QMUICustomizeButtonPropType)type forState:(UIControlState)state {
    if (!self.qmui_customizeButtonPropDict || !self.qmui_customizeButtonPropDict[@(state)]) {
        return;
    }
    
    [self.qmui_customizeButtonPropDict[@(state)] removeObjectForKey:@(type)];
}

@end
