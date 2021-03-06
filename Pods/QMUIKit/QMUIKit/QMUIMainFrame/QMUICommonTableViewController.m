/*****
 * Tencent is pleased to support the open source community by making QMUI_iOS available.
 * Copyright (C) 2016-2018 THL A29 Limited, a Tencent company. All rights reserved.
 * Licensed under the MIT License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 * http://opensource.org/licenses/MIT
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 *****/

//
//  QMUICommonTableViewController.m
//  qmui
//
//  Created by QMUI Team on 14-6-24.
//

#import "QMUICommonTableViewController.h"
#import "QMUICore.h"
#import "QMUITableView.h"
#import "QMUIEmptyView.h"
#import "QMUITableViewHeaderFooterView.h"
#import "UIScrollView+QMUI.h"
#import "UITableView+QMUI.h"
#import "UICollectionView+QMUI.h"
#import "UIView+QMUI.h"

NSString *const QMUICommonTableViewControllerSectionHeaderIdentifier = @"QMUISectionHeaderView";
NSString *const QMUICommonTableViewControllerSectionFooterIdentifier = @"QMUISectionFooterView";

@interface QMUICommonTableViewController ()

@property(nonatomic, strong, readwrite) QMUITableView *tableView;
@property(nonatomic, assign) BOOL hasHideTableHeaderViewInitial;

@end


@implementation QMUICommonTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithNibName:nil bundle:nil]) {
        [self didInitializeWithStyle:style];
    }
    return self;
}

- (instancetype)init {
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self init];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self didInitializeWithStyle:UITableViewStylePlain];
    }
    return self;
}

- (void)didInitializeWithStyle:(UITableViewStyle)style {
    _style = style;
    self.hasHideTableHeaderViewInitial = NO;
}

- (void)dealloc {
    // ?????????????????????self.xxx?????????tableView?????????dealloc???self.view??????????????????????????????self.tableView???????????????loadView
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    
    if (@available(iOS 11.0, *)) {
    } else {
        [_tableView removeObserver:self forKeyPath:@"contentInset"];
    }
}

- (NSString *)description {
#ifdef DEBUG
    if (![self isViewLoaded]) {
        return [super description];
    }
    
    NSString *result = [NSString stringWithFormat:@"%@\ntableView:\t\t\t\t%@", [super description], self.tableView];
    NSInteger sections = [self.tableView.dataSource numberOfSectionsInTableView:self.tableView];
    if (sections > 0) {
        NSMutableString *sectionCountString = [[NSMutableString alloc] init];
        [sectionCountString appendFormat:@"\ndataCount(%@):\t\t\t\t(\n", @(sections)];
        NSInteger sections = [self.tableView.dataSource numberOfSectionsInTableView:self.tableView];
        for (NSInteger i = 0; i < sections; i++) {
            NSInteger rows = [self.tableView.dataSource tableView:self.tableView numberOfRowsInSection:i];
            [sectionCountString appendFormat:@"\t\t\t\t\t\t\tsection%@ - rows%@%@\n", @(i), @(rows), i < sections - 1 ? @"," : @""];
        }
        [sectionCountString appendString:@"\t\t\t\t\t\t)"];
        result = [result stringByAppendingString:sectionCountString];
    }
    return result;
#else
    return [super description];
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *backgroundColor = nil;
    if (self.style == UITableViewStylePlain) {
        backgroundColor = TableViewBackgroundColor;
    } else {
        backgroundColor = TableViewGroupedBackgroundColor;
    }
    if (backgroundColor) {
        self.view.backgroundColor = backgroundColor;
    }
}

- (void)initSubviews {
    [super initSubviews];
    [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView qmui_clearsSelection];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self layoutTableView];
    
    [self hideTableHeaderViewInitialIfCanWithAnimated:NO force:NO];
    
    [self layoutEmptyView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context  {
    if ([keyPath isEqualToString:@"contentInset"]) {
        [self handleTableViewContentInsetChangeEvent];
    }
}

#pragma mark - ????????????

- (QMUITableView *)tableView {
    if (!_tableView) {
        BeginIgnoreAvailabilityWarning
        [self loadViewIfNeeded];
        EndIgnoreAvailabilityWarning
    }
    return _tableView;
}

- (void)hideTableHeaderViewInitialIfCanWithAnimated:(BOOL)animated force:(BOOL)force {
    if (self.tableView.tableHeaderView && [self shouldHideTableHeaderViewInitial] && (force || !self.hasHideTableHeaderViewInitial)) {
        CGPoint contentOffset = CGPointMake(self.tableView.contentOffset.x, -self.tableView.qmui_contentInset.top + CGRectGetHeight(self.tableView.tableHeaderView.frame));
        [self.tableView setContentOffset:contentOffset animated:animated];
        self.hasHideTableHeaderViewInitial = YES;
    }
}

- (void)contentSizeCategoryDidChanged:(NSNotification *)notification {
    [super contentSizeCategoryDidChanged:notification];
    [self.tableView reloadData];
}

#pragma mark - ??????????????? QMUIEmptyView

- (void)handleTableViewContentInsetChangeEvent {
    if (self.isEmptyViewShowing) {
        [self layoutEmptyView];
    }
}

- (void)showEmptyView {
    if (!self.emptyView) {
        self.emptyView = [[QMUIEmptyView alloc] init];
    }
    [self.tableView addSubview:self.emptyView];
    [self layoutEmptyView];
}

- (void)hideEmptyView {
    [self.emptyView removeFromSuperview];
}

// ?????????emptyView ?????????????????? tableView.contentInset??????????????????????????? tableView.contentInset ???????????????????????? emptyView ?????????
- (BOOL)layoutEmptyView {
    if (!self.emptyView || !self.emptyView.superview) {
        return NO;
    }
    
    UIEdgeInsets insets = self.tableView.contentInset;
    if (@available(iOS 11, *)) {
        if (self.tableView.contentInsetAdjustmentBehavior != UIScrollViewContentInsetAdjustmentNever) {
            insets = self.tableView.adjustedContentInset;
        }
    }
    
    // ????????? tableHeaderView ??????emptyView ???????????? tableView ??????????????? headerView ?????????
    if (self.tableView.tableHeaderView) {
        self.emptyView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.tableHeaderView.frame), CGRectGetWidth(self.tableView.bounds) - UIEdgeInsetsGetHorizontalValue(insets), CGRectGetHeight(self.tableView.bounds) - UIEdgeInsetsGetVerticalValue(insets) - CGRectGetMaxY(self.tableView.tableHeaderView.frame));
    } else {
        self.emptyView.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds) - UIEdgeInsetsGetHorizontalValue(insets), CGRectGetHeight(self.tableView.bounds) - UIEdgeInsetsGetVerticalValue(insets));
    }
    return YES;
}

#pragma mark - <QMUITableViewDelegate, QMUITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *title = [self tableView:tableView realTitleForHeaderInSection:section];
    if (title) {
        QMUITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:QMUICommonTableViewControllerSectionHeaderIdentifier];
        headerView.parentTableView = tableView;
        headerView.type = QMUITableViewHeaderFooterViewTypeHeader;
        headerView.titleLabel.text = title;
        return headerView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSString *title = [self tableView:tableView realTitleForFooterInSection:section];
    if (title) {
        QMUITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:QMUICommonTableViewControllerSectionFooterIdentifier];
        footerView.parentTableView = tableView;
        footerView.type = QMUITableViewHeaderFooterViewTypeFooter;
        footerView.titleLabel.text = title;
        return footerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([tableView.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        UIView *view = [tableView.delegate tableView:tableView viewForHeaderInSection:section];
        if (view) {
            CGFloat height = [view sizeThatFits:CGSizeMake(CGRectGetWidth(tableView.bounds) - UIEdgeInsetsGetHorizontalValue(tableView.qmui_safeAreaInsets), CGFLOAT_MAX)].height;
            return height;
        }
    }
    // ??????????????? iOS 11 ????????????????????????????????????????????? Plain ????????? tableView ?????????????????? header / footer ????????? 0????????? Grouped ????????? tableView ?????????????????? header / footer ????????? CGFLOAT_MIN
    return tableView.style == UITableViewStylePlain ? 0 : TableViewGroupedSectionHeaderDefaultHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([tableView.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        UIView *view = [tableView.delegate tableView:tableView viewForFooterInSection:section];
        if (view) {
            CGFloat height = [view sizeThatFits:CGSizeMake(CGRectGetWidth(tableView.bounds) - UIEdgeInsetsGetHorizontalValue(tableView.qmui_safeAreaInsets), CGFLOAT_MAX)].height;
            return height;
        }
    }
    // ??????????????? iOS 11 ????????????????????????????????????????????? Plain ????????? tableView ?????????????????? header / footer ????????? 0????????? Grouped ????????? tableView ?????????????????? header / footer ????????? CGFLOAT_MIN
    return tableView.style == UITableViewStylePlain ? 0 : TableViewGroupedSectionFooterDefaultHeight;
}

// ?????????????????????section???header title
- (NSString *)tableView:(UITableView *)tableView realTitleForHeaderInSection:(NSInteger)section {
    if ([tableView.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        NSString *sectionTitle = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
        if (sectionTitle && sectionTitle.length > 0) {
            return sectionTitle;
        }
    }
    return nil;
}

// ?????????????????????section???footer title
- (NSString *)tableView:(UITableView *)tableView realTitleForFooterInSection:(NSInteger)section {
    if ([tableView.dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        NSString *sectionFooter = [tableView.dataSource tableView:tableView titleForFooterInSection:section];
        if (sectionFooter && sectionFooter.length > 0) {
            return sectionFooter;
        }
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}

/**
 *  ?????? contentInset ???????????????????????? emptyView ?????????????????? layoutEmptyView ???????????????
 *  ??? delegate ???????????? iOS 11 ??????????????????????????? iOS ???????????? KVO ?????????????????????????????? initTableView ????????????????????????
 */
- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView {
    if (scrollView != self.tableView) {
        return;
    }
    [self handleTableViewContentInsetChangeEvent];
}

@end


@implementation QMUICommonTableViewController (QMUISubclassingHooks)

- (void)initTableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc] initWithFrame:self.view.bounds style:self.style];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[QMUITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:QMUICommonTableViewControllerSectionHeaderIdentifier];
        [self.tableView registerClass:[QMUITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:QMUICommonTableViewControllerSectionFooterIdentifier];
        [self.view addSubview:self.tableView];
    }
    
    if (@available(iOS 11, *)) {
    } else {
        /**
         *  ?????? contentInset ???????????????????????? emptyView ?????????????????? layoutEmptyView ???????????????
         *  iOS 11 ??????????????? UIScrollViewDelegate ??? scrollViewDidChangeAdjustedContentInset: ?????????
         */
        [self.tableView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionOld context:nil];
    }
}

- (void)layoutTableView {
    BOOL shouldChangeTableViewFrame = !CGRectEqualToRect(self.view.bounds, self.tableView.frame);
    if (shouldChangeTableViewFrame) {
        self.tableView.frame = self.view.bounds;
    }
}

- (BOOL)shouldHideTableHeaderViewInitial {
    return NO;
}

@end
