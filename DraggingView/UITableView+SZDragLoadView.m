//
//  UITableView+DragLoadView.m
//  DraggingView
//
//  Created by zhaotai on 16/7/20.
//  Copyright © 2016年 zhaotai. All rights reserved.
//

#import "UITableView+SZDragLoadView.h"
#import "Masonry.h"
#import <objc/runtime.h>

//TopView
static const CGFloat heightTopView    = 50.f;
static const CGFloat MaxDragTopY      = 70.f;
static char * topDragViewKey          = nil;
//BottomView
static const CGFloat heightBottomView = 50.f;
static const CGFloat MaxDragBottomY   = 70.f;
static char * bottomDragViewKey       = nil;

@implementation UITableView (SZDragLoadView)

- (void)dealloc{
    if ([[self topDragView] isKindOfClass:[SZTableDragView class]]) {
        [self removeObserver:self forKeyPath:@"contentOffset"];
    }
    if ([[self bottomDragView] isKindOfClass:[SZTableDragView class]]) {
        [self removeObserver:self forKeyPath:@"contentOffset"];
        [self removeObserver:self forKeyPath:@"contentSize"];
    }
}
//观察者实现
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    CGFloat MaxY = self.contentSize.height - self.frame.size.height;
    //
    if ([keyPath isEqualToString:@"contentOffset"] && self.contentOffset.y < 0) {
        
        SZTableDragView * topDragView = [self topDragView];
        
        if (self.isDragging && topDragView.topViewStyle != TopViewShowing) {
            //拖拽至最大限度后
            if (self.contentOffset.y < -MaxDragTopY) {
                [topDragView topViewDragged];
            } else {
                [topDragView topViewDragging];
            }
        }
        else if (topDragView.topViewStyle == TopViewDragged && !self.isDragging) {
            //
            [topDragView topViewShowing];
            //
            self.contentInset = UIEdgeInsetsMake(heightTopView, 0, 0, 0);
            self.bounces = NO;
        }
    } else if ([keyPath isEqualToString:@"contentOffset"] && self.contentOffset.y > MaxY) {
        
        [self bottomDragView];
        
        SZTableDragView * topDragView = [self bottomDragView];
        
        if (self.isDragging && topDragView.topViewStyle != TopViewShowing) {
            //拖拽至最大限度后
            if (self.contentOffset.y > MaxY + MaxDragBottomY) {
                [topDragView topViewDragged];
            } else {
                [topDragView topViewDragging];
            }
        }
        else if (topDragView.topViewStyle == TopViewDragged && !self.isDragging) {
            //
            [topDragView topViewShowing];
            //
            self.contentInset = UIEdgeInsetsMake(0, 0, heightBottomView, 0);
            self.bounces = NO;
        }
    }
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self bottomDragViewAutoFrame];
    }
}

#pragma mark - PrivatCode

//初始化启用顶部加载视图
- (void)topDragViewEnableWith:(SZTableDragView *)topDragView{
    //顶部加载view的对象实例化
    if (!topDragView) {
        topDragView = [[SZTableDragView alloc] init];
    }
    //添加对象
    [self addSubview:topDragView];
    //设置存储
    objc_setAssociatedObject(self, &topDragViewKey, topDragView, OBJC_ASSOCIATION_ASSIGN);
    //
    [self topDragViewAutoFrame];
    
    //添加观察者
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
//初始化启用顶部加载视图
- (void)topDragViewEnableWith:(SZTableDragView *)topDragView andShowingBlock:(void(^)())blockShowing{
    [self topDragViewEnableWith:topDragView];
    [self topDragView].blockShowing = blockShowing;
}
//获取顶部视图
- (SZTableDragView *)topDragView{
    return (SZTableDragView *)objc_getAssociatedObject(self, &topDragViewKey);
}
//设置位置
- (void)topDragViewAutoFrame{
    SZTableDragView * topDragView = [self topDragView];
    NSLog(@"%lf",self.frame.size.width);
    [topDragView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.bottom.equalTo(self.mas_top);
        make.height.offset(heightTopView);
    }];
}
//停止显示
- (void)topStopShowing{
    [[self topDragView] topViewDragging];
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.bounces = YES;
}

//初始化启用底部加载视图
- (void)bottomDragViewEnableWith:(SZTableDragView *)bottomDragView{
    //顶部加载view的对象实例化
    if (!bottomDragView) {
        bottomDragView = [[SZTableDragView alloc] init];
    }
    //添加对象
    [self addSubview:bottomDragView];
    //设置存储
    objc_setAssociatedObject(self, &bottomDragViewKey, bottomDragView, OBJC_ASSOCIATION_ASSIGN);
    //
    [self bottomDragViewAutoFrame];
    
    //添加观察者
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}
//初始化启用顶部加载视图
- (void)bottomDragViewEnableWith:(SZTableDragView *)bottomDragView andShowingBlock:(void(^)())blockShowing{
    [self bottomDragViewEnableWith:bottomDragView];
    [self bottomDragView].blockShowing = blockShowing;
}
//获取顶部视图
- (SZTableDragView *)bottomDragView{
    return (SZTableDragView *)objc_getAssociatedObject(self, &bottomDragViewKey);
}
//设置位置
- (void)bottomDragViewAutoFrame{
    SZTableDragView * topDragView = [self bottomDragView];
    [topDragView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.top.offset(self.contentSize.height);
        make.height.offset(heightBottomView);
    }];
}
//停止显示
- (void)bottomStopShowing{
    [[self bottomDragView] topViewDragging];
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.bounces = YES;
}

@end
