//
//  TableDragView.h
//  DraggingView
//
//  Created by zhaotai on 16/7/20.
//  Copyright © 2016年 zhaotai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TopViewStyle) {
    TopViewDragging = 0,
    TopViewDragged,
    TopViewShowing
};

@interface SZTableDragView : UIView

@property(nonatomic,copy) NSString * strShowing;  //正在显示时的文字
@property(nonatomic,copy) NSString * strDragging;  //正在拖拽时的文字
@property(nonatomic,copy) NSString * strDragged;  //完成拖拽时的文字
/**
 *  view状态
 */
@property(nonatomic,assign) TopViewStyle topViewStyle;
/**
 *  view显示时执行block
 */
@property(nonatomic,copy) void(^blockShowing)();

/**
 *  状态变为正在显示
 */
- (void)topViewShowing;
/**
 *  状态变为正在拖拽
 */
- (void)topViewDragging;
/**
 *  状态变为完成拖拽
 */
- (void)topViewDragged;

@end
