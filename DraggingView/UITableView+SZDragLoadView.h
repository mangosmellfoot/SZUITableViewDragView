//
//  UITableView+DragLoadView.h
//  DraggingView
//
//  Created by zhaotai on 16/7/20.
//  Copyright © 2016年 zhaotai. All rights reserved.
//

#import "SZTableDragView.h"

@interface UITableView (DragLoadView)
#pragma mark - TopView
/**
 *  初始化启用顶部加载视图
 *
 *  @param topDragView 顶部要加载的视图
 */
- (void)topDragViewEnableWith:(SZTableDragView *)topDragView;
/**
 *  初始化启用顶部加载视图
 *
 *  @param topDragView  顶部要加载的视图
 *  @param blockShowing 视图显示是执行的代码
 */
- (void)topDragViewEnableWith:(SZTableDragView *)topDragView andShowingBlock:(void(^)())blockShowing;
/**
 *  停止顶部视图的显示
 */
- (void)topStopShowing;
#pragma mark - BottomView
/**
 *  初始化启用底部加载视图
 *
 *  @param topDragView 顶部要加载的视图
 */
- (void)bottomDragViewEnableWith:(SZTableDragView *)bottomDragView;
/**
 *  初始化启用底部加载视图
 *
 *  @param topDragView  顶部要加载的视图
 *  @param blockShowing 视图显示是执行的代码
 */
- (void)bottomDragViewEnableWith:(SZTableDragView *)bottomDragView andShowingBlock:(void(^)())blockShowing;
/**
 *  停止底部视图的显示
 */
- (void)bottomStopShowing;
@end
