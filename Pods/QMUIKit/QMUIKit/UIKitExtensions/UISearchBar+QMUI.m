/*****
 * Tencent is pleased to support the open source community by making QMUI_iOS available.
 * Copyright (C) 2016-2018 THL A29 Limited, a Tencent company. All rights reserved.
 * Licensed under the MIT License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 * http://opensource.org/licenses/MIT
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 *****/

//
//  UISearchBar+QMUI.m
//  qmui
//
//  Created by QMUI Team on 16/5/26.
//

#import "UISearchBar+QMUI.h"
#import "QMUICore.h"
#import "UIImage+QMUI.h"
#import "UIView+QMUI.h"

@implementation UISearchBar (QMUI)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(setPlaceholder:),
            @selector(layoutSubviews),
            @selector(setFrame:),
            @selector(setShowsCancelButton:animated:)
        };
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); index++) {
            SEL originalSelector = selectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"qmuisb_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            ExchangeImplementations([self class], originalSelector, swizzledSelector);
        }
    });
}

static char kAssociatedObjectKey_usedAsTableHeaderView;
- (void)setQmui_usedAsTableHeaderView:(BOOL)qmui_usedAsTableHeaderView {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_usedAsTableHeaderView, @(qmui_usedAsTableHeaderView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)qmui_usedAsTableHeaderView {
    return [((NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_usedAsTableHeaderView)) boolValue];
}

- (void)qmuisb_setPlaceholder:(NSString *)placeholder {
    [self qmuisb_setPlaceholder:placeholder];
    if (self.qmui_placeholderColor || self.qmui_font) {
        NSMutableDictionary<NSString *, id> *attributes = [[NSMutableDictionary alloc] init];
        if (self.qmui_placeholderColor) {
            attributes[NSForegroundColorAttributeName] = self.qmui_placeholderColor;
        }
        if (self.qmui_font) {
            attributes[NSFontAttributeName] = self.qmui_font;
        }
        self.qmui_textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
    }
}

static char kAssociatedObjectKey_PlaceholderColor;
- (void)setQmui_placeholderColor:(UIColor *)qmui_placeholderColor {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_PlaceholderColor, qmui_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.placeholder) {
        // ?????? setPlaceholder ????????? placeholder ???????????????
        self.placeholder = self.placeholder;
    }
}

- (UIColor *)qmui_placeholderColor {
    return (UIColor *)objc_getAssociatedObject(self, &kAssociatedObjectKey_PlaceholderColor);
}

static char kAssociatedObjectKey_TextColor;
- (void)setQmui_textColor:(UIColor *)qmui_textColor {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_TextColor, qmui_textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.qmui_textField.textColor = qmui_textColor;
}

- (UIColor *)qmui_textColor {
    return (UIColor *)objc_getAssociatedObject(self, &kAssociatedObjectKey_TextColor);
}

static char kAssociatedObjectKey_font;
- (void)setQmui_font:(UIFont *)qmui_font {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_font, qmui_font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.placeholder) {
        // ?????? setPlaceholder ????????? placeholder ???????????????
        self.placeholder = self.placeholder;
    }
    
    // ??????????????????????????????
    self.qmui_textField.font = qmui_font;
}

- (UIFont *)qmui_font {
    return (UIFont *)objc_getAssociatedObject(self, &kAssociatedObjectKey_font);
}

- (UITextField *)qmui_textField {
    UITextField *textField = [self valueForKey:@"searchField"];
    return textField;
}

static char kAssociatedObjectKey_textFieldMargins;
- (void)setQmui_textFieldMargins:(UIEdgeInsets)qmui_textFieldMargins {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_textFieldMargins, [NSValue valueWithUIEdgeInsets:qmui_textFieldMargins], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)qmui_textFieldMargins {
    return [((NSValue *)objc_getAssociatedObject(self, &kAssociatedObjectKey_textFieldMargins)) UIEdgeInsetsValue];
}

- (UIButton *)qmui_cancelButton {
    UIButton *cancelButton = [self valueForKey:@"cancelButton"];
    return cancelButton;
}

static char kAssociatedObjectKey_cancelButtonFont;
- (void)setQmui_cancelButtonFont:(UIFont *)qmui_cancelButtonFont {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_cancelButtonFont, qmui_cancelButtonFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.qmui_cancelButton.titleLabel.font = qmui_cancelButtonFont;
}

- (UIFont *)qmui_cancelButtonFont {
    return (UIFont *)objc_getAssociatedObject(self, &kAssociatedObjectKey_cancelButtonFont);
}

- (void)qmuisb_setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated {
    [self qmuisb_setShowsCancelButton:showsCancelButton animated:animated];
    if (self.qmui_cancelButton && self.qmui_cancelButtonFont) {
        self.qmui_cancelButton.titleLabel.font = self.qmui_cancelButtonFont;
    }
}

- (UISegmentedControl *)qmui_segmentedControl {
    // ?????????segmentedControl ???????????? scopeBar ?????????????????????????????? key ?????????scopeBar???
    UISegmentedControl *segmentedControl = [self valueForKey:@"scopeBar"];
    return segmentedControl;
}

- (BOOL)qmui_isActive {
    // ??????????????? scopeBar ??????????????????????????????????????????????????????
    CGFloat scopeBarHeight = self.qmui_segmentedControl && self.qmui_segmentedControl.superview.qmui_top < self.qmui_textField.qmui_bottom ? 0 : self.qmui_segmentedControl.superview.qmui_height;
    BOOL result = self.qmui_height - scopeBarHeight == 50;
    return result;
}

- (void)qmuisb_layoutSubviews {
    [self qmuisb_layoutSubviews];
    
    [self fixLandscapeStyle];
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.qmui_textFieldMargins, UIEdgeInsetsZero)) {
        self.qmui_textField.frame = CGRectInsetEdges(self.qmui_textField.frame, self.qmui_textFieldMargins);
    }
    
    CGFloat textFieldCornerRadius = SearchBarTextFieldCornerRadius;
    if (textFieldCornerRadius != 0) {
        textFieldCornerRadius = textFieldCornerRadius > 0 ? textFieldCornerRadius : CGRectGetHeight(self.qmui_textField.frame) / 2.0;
    }
    self.qmui_textField.layer.cornerRadius = textFieldCornerRadius;
    self.qmui_textField.clipsToBounds = textFieldCornerRadius != 0;
}

- (void)fixLandscapeStyle {
    if (self.qmui_usedAsTableHeaderView) {
        if (@available(iOS 11, *)) {
            if ([self qmui_isActive] && IS_LANDSCAPE) {
                // 11.0 ?????????????????????????????????searchBar ???????????????????????????????????????????????????????????????
                self.qmui_textField.frame = CGRectSetY(self.qmui_textField.frame, self.qmui_textField.qmui_topWhenCenterInSuperview);
                self.qmui_cancelButton.frame = CGRectSetY(self.qmui_cancelButton.frame, self.qmui_cancelButton.qmui_topWhenCenterInSuperview);
                if (self.qmui_segmentedControl.superview.qmui_top < self.qmui_textField.qmui_bottom) {
                    // scopeBar ????????????????????????
                    self.qmui_segmentedControl.superview.qmui_top = self.qmui_segmentedControl.superview.qmui_topWhenCenterInSuperview;
                }
            }
        }
    }
}

- (UIView *)qmui_backgroundView {
    UIView *backgroundView = [self valueForKey:@"background"];
    return backgroundView;
}

- (void)qmuisb_setFrame:(CGRect)frame {
    
    if (!self.qmui_usedAsTableHeaderView) {
        [self qmuisb_setFrame:frame];
        return;
    }
    
    // ?????? setFrame: ??????????????? issue???https://github.com/QMUI/QMUI_iOS/issues/233
    
    if (@available(iOS 11, *)) {
        // iOS 11 ?????? tableHeaderView ??????????????? searchBar ?????????????????????????????? y ??????????????????????????????
        
        if (![self qmui_isActive]) {
            [self qmuisb_setFrame:frame];
            return;
        }
        
        if (IS_NOTCHED_SCREEN) {
            // ??????
            if (CGRectGetMinY(frame) == 38) {
                // searching
                frame = CGRectSetY(frame, 44);
            }
            
            // ??????
            if (CGRectGetMinY(frame) == -6) {
                frame = CGRectSetY(frame, 0);
            }
        } else {
            
            // ??????
            if (CGRectGetMinY(frame) == 14) {
                frame = CGRectSetY(frame, 20);
            }
            
            // ??????
            if (CGRectGetMinY(frame) == -6) {
                frame = CGRectSetY(frame, 0);
            }
        }
        
        if (self.layer.animationKeys) {
            // ??????????????????????????????/??????????????????????????????
            if (CGRectGetHeight(self.superview.frame) == (CGRectGetHeight(frame) + StatusBarHeight) && !self.showsScopeBar) {
                frame = CGRectSetHeight(frame, 56);
            }
        }
    }
    
    [self qmuisb_setFrame:frame];
}

- (void)qmui_styledAsQMUISearchBar {
    if (!QMUICMIActivated) {
        return;
    }
    
    // ????????????????????? placeholder ?????????
    UIFont *font = SearchBarFont;
    if (font) {
        self.qmui_font = font;
    }

    // ????????????????????????
    UIColor *textColor = SearchBarTextColor;
    if (textColor) {
        self.qmui_textColor = textColor;
    }

    // placeholder ???????????????
    UIColor *placeholderColor = SearchBarPlaceholderColor;
    if (placeholderColor) {
        self.qmui_placeholderColor = placeholderColor;
    }

    self.placeholder = @"??????";
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;

    // ????????????icon
    UIImage *searchIconImage = SearchBarSearchIconImage;
    if (searchIconImage) {
        if (!CGSizeEqualToSize(searchIconImage.size, CGSizeMake(14, 14))) {
            NSLog(@"???????????????????????????SearchBarSearchIconImage????????????????????? (14, 14)??????????????????????????????????????? %@", NSStringFromCGSize(searchIconImage.size));
        }
        [self setImage:searchIconImage forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    }

    // ????????????????????????????????????icon
    UIImage *clearIconImage = SearchBarClearIconImage;
    if (clearIconImage) {
        [self setImage:clearIconImage forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    }

    // ??????SearchBar??????????????????
    self.tintColor = SearchBarTintColor;

    // ??????????????????
    UIColor *textFieldBackgroundColor = SearchBarTextFieldBackground;
    if (textFieldBackgroundColor) {
        [self setSearchFieldBackgroundImage:[[UIImage qmui_imageWithColor:textFieldBackgroundColor size:CGSizeMake(60, 28) cornerRadius:0] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    }
    
    // ???????????????
    UIColor *textFieldBorderColor = SearchBarTextFieldBorderColor;
    if (textFieldBorderColor) {
        self.qmui_textField.layer.borderWidth = PixelOne;
        self.qmui_textField.layer.borderColor = textFieldBorderColor.CGColor;
    }
    
    // ??????bar?????????
    // ????????? searchBar ?????????????????????????????????????????????????????? barTintColor ??????????????????????????? backgroundImage
    UIImage *backgroundImage = nil;
    
    UIColor *barTintColor = SearchBarBarTintColor;
    if (barTintColor) {
        backgroundImage = [UIImage qmui_imageWithColor:barTintColor size:CGSizeMake(10, 10) cornerRadius:0];
    }
    
    UIColor *bottomBorderColor = SearchBarBottomBorderColor;
    if (bottomBorderColor) {
        if (!backgroundImage) {
            backgroundImage = [UIImage qmui_imageWithColor:UIColorWhite size:CGSizeMake(10, 10) cornerRadius:0];
        }
        backgroundImage = [backgroundImage qmui_imageWithBorderColor:bottomBorderColor borderWidth:PixelOne borderPosition:QMUIImageBorderPositionBottom];
    }
    
    if (backgroundImage) {
        backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
        [self setBackgroundImage:backgroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:backgroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefaultPrompt];
    }
}

@end
