//
//  TableDragView.m
//  DraggingView
//
//  Created by zhaotai on 16/7/20.
//  Copyright © 2016年 zhaotai. All rights reserved.
//

#import "SZTableDragView.h"
#import "Masonry.h"

@interface SZTableDragView ()

@property(nonatomic,weak) UILabel * label;

@end

@implementation SZTableDragView

#pragma mark - LifeCycle
//创建时调用
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        UILabel * label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor yellowColor];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(10);
            make.bottom.right.equalTo(self).offset(-10);
        }];
        self.label = label;
        label.textColor = [UIColor blackColor];
        _strShowing = @"showing now!";
        _strDragging = @"dragging now!";
        _strDragged = @"dragged now!";
    }
    return self;
}

#pragma mark - PrivateCode

//状态变为正在显示
- (void)topViewShowing{
    _topViewStyle = TopViewShowing;
    self.label.text = self.strShowing;
    if (_blockShowing) {
        _blockShowing();
    }
}
//状态变为正在拖拽
- (void)topViewDragging{
    _topViewStyle = TopViewDragging;
    self.label.text = self.strDragging;
}
//状态变为完成拖拽
- (void)topViewDragged{
    _topViewStyle = TopViewDragged;
    self.label.text = self.strDragged;
}

@end
