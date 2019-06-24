//
//  BFsRudderView2.m
//  BFsRudder
//
//  Created by BFsAlex on 2019/6/24.
//  Copyright © 2019年 BFs. All rights reserved.
//

#import "BFsRudderView2.h"

@interface BFsRudderView2 () {
    
    CGPoint     _curCenterPoint;
}
@property (nonatomic, weak) UIImageView *bgImage;
@property (nonatomic, weak) UIImageView *dragImage;

@end

@implementation BFsRudderView2

- (instancetype)init {
    
    if (self = [super init]) {
        //
        [self configCustomSubviews];
    }
    
    return self;
}

#pragma mark - API

- (void)updateFrame:(CGRect)frame {
    //
    self.frame = frame;
    // bg
    self.bgImage.frame = self.bounds;
    self.bgImage.center = self.center;
    // drag img
    CGFloat dragWH = self.bounds.size.width * 0.3;
    CGRect dragBounds = CGRectMake(0, 0, dragWH, dragWH);
    self.dragImage.frame = dragBounds;
    self.dragImage.center = self.center;
    
    
//    NSLog(@"update center point: (x:%f, y:%f)", self.center.x, self.center.y);
    _curCenterPoint = self.center;
    // 样式
    [self updateStyle1AllViews];
}

#pragma mark - Feature

- (void)configCustomSubviews {
    //
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_img"]];
    [self addSubview:bgImg];
    self.bgImage = bgImg;
    //
    UIImageView *dragImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drag_img"]];
    [self addSubview:dragImg];
    self.dragImage = dragImg;
}

- (void)updateStyle1AllViews {
    
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
//    self.layer.borderWidth = 1.f;
//    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.backgroundColor = [UIColor lightGrayColor];
}

- (void)updateDragViewLocation:(CGPoint)toPoint {
    
    // 矩行中
//    CGFloat dragViewR = self.dragImage.bounds.size.width * 0.5;
//    CGFloat updateX = toPoint.x;
//    if (updateX < dragViewR) {
//        updateX = dragViewR;
//    } else if (updateX > self.bounds.size.width - dragViewR) {
//        updateX = self.bounds.size.width - dragViewR;
//    }
//    CGFloat updateY = toPoint.y;
//    if (updateY < dragViewR) {
//        updateY = dragViewR;
//    } else if (updateY > self.bounds.size.height - dragViewR) {
//        updateY = self.bounds.size.height - dragViewR;
//    }
//    self.dragImage.center = CGPointMake(updateX, updateY);
    
    // 圆形中
    CGFloat updateX = toPoint.x - _curCenterPoint.x;
    CGFloat updateY = toPoint.y - _curCenterPoint.y;
    CGFloat largestR = (self.bounds.size.width - self.dragImage.bounds.size.width) * 0.5;
    double touchR = sqrt(pow(updateX, 2) + pow(updateY, 2));
    if (touchR > largestR) {
        updateX = updateX / touchR * largestR;
        updateY = updateY / touchR * largestR;
    }
    self.dragImage.center = CGPointMake(updateX + _curCenterPoint.x, updateY + _curCenterPoint.y);
}

- (void)feekbackDragPoint:(CGPoint)toPoint {
    
    CGPoint updatePoint = CGPointMake(toPoint.x - _curCenterPoint.x, toPoint.y - _curCenterPoint.y);
    if ([self.delegate respondsToSelector:@selector(rudderView:didUpdateDragLocation:)]) {
        [self.delegate rudderView:self didUpdateDragLocation:updatePoint];
    }
}

#pragma mark - Touch Event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //
    CGPoint curPoint = [[touches anyObject] locationInView:self];
    NSLog(@"[%@ %@]\n(x:%f, y:%f)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), curPoint.x, curPoint.y);
    
    [self updateDragViewLocation:curPoint];
    [self feekbackDragPoint:curPoint];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //
    CGPoint curPoint = [[touches anyObject] locationInView:self];
    NSLog(@"[%@ %@]\n(x:%f, y:%f)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), curPoint.x, curPoint.y);
    
    [self updateDragViewLocation:curPoint];
    [self feekbackDragPoint:curPoint];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //
    CGPoint curPoint = [[touches anyObject] locationInView:self];
    NSLog(@"[%@ %@]\n(x:%f, y:%f)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), curPoint.x, curPoint.y);
    NSLog(@"center point: (x:%f, y:%f)", self.center.x, self.center.y);
    
    [self updateDragViewLocation:_curCenterPoint];
    [self feekbackDragPoint:curPoint];
}

//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    //
//    CGPoint curPoint = [[touches anyObject] locationInView:self];
//    NSLog(@"[%@ %@]\n(x:%f, y:%f)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), curPoint.x, curPoint.y);
//    NSLog(@"end center point: (x:%f, y:%f)", self.center.x, self.center.y);
//
//    [self updateDragViewLocation:_curCenterPoint];
//    [self feekbackDragPoint:curPoint];
//}

@end
