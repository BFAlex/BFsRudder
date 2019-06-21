//
//  BFsRudderView.m
//  BFsRudder
//
//  Created by BFsAlex on 2019/6/21.
//  Copyright © 2019年 BFs. All rights reserved.
//

#import "BFsRudderView.h"

@interface BFsRudderView ()
@property (nonatomic, weak) UIButton *ctlBtn;
@property (nonatomic, weak) UIImageView *ctlImg;
@property (nonatomic, weak) UIImageView *ctlBgImg;

@end

@implementation BFsRudderView

- (instancetype)init {
    
    if (self = [super init]) {
        //
        [self layoutCustomSubviews];
    }
    
    return self;
}

#pragma mark - API

- (void)setupFrame:(CGRect)frame {
    
    self.frame = frame;
    self.clipsToBounds = YES;
    CGFloat updateWidth = frame.size.width;
    CGFloat updateHeight = frame.size.height;
    //
    self.ctlBtn.center = self.center;
    CGRect ctlBtnBounds = self.ctlBtn.bounds;
    CGFloat updateBtnWH = (updateWidth <= updateHeight ? updateWidth : updateHeight) * 0.2;
    ctlBtnBounds.size = CGSizeMake(updateBtnWH, updateBtnWH);
    self.ctlBtn.bounds = ctlBtnBounds;
    self.ctlBtn.layer.cornerRadius = updateBtnWH * 0.5;
    //
    self.ctlImg.frame = self.ctlBtn.frame;
    self.ctlImg.layer.cornerRadius = self.ctlImg.bounds.size.width * 0.5;
    //
    self.ctlBgImg.frame = self.bounds;
}

#pragma mark - Feature

- (void)layoutCustomSubviews {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    self.backgroundColor = [UIColor yellowColor];
    [self configViewGesture:self];
    // Center Btn
    UIButton *ctlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:ctlBtn];
//    [self configViewGesture:ctlBtn];
    CGFloat btnWH = 30.f;
    ctlBtn.frame = CGRectMake(0, 0, btnWH, btnWH);
    ctlBtn.layer.masksToBounds = YES;
    ctlBtn.layer.cornerRadius = btnWH * 0.5;
    ctlBtn.backgroundColor = [UIColor whiteColor];
    self.ctlBtn = ctlBtn;
    // Pan Img
    UIImageView *ctlImg = [[UIImageView alloc] initWithFrame:ctlBtn.frame];
    [self addSubview:ctlImg];
    self.ctlImg = ctlImg;
    ctlImg.layer.masksToBounds = YES;
    ctlImg.image = [UIImage imageNamed:@"ctl_img"];
    if (!ctlImg.image) {
        ctlImg.backgroundColor = [UIColor blueColor];
    }
    // Background img
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:bgImg];
    bgImg.image = [UIImage imageNamed:@"ctl_bg_img"];
    self.ctlBgImg = bgImg;
}

- (void)configViewGesture:(id)view {
    //
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(startPanGesture:)];
    [view addGestureRecognizer:panGR];
}

- (void)startPanGesture:(UIPanGestureRecognizer *)panGR {
    NSLog(@"[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    
    UIGestureRecognizerState curState = panGR.state;
    NSLog(@"cur state: %ld", (long)curState);
    switch (curState) {
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"start pan");
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            self.ctlImg.center = self.ctlBtn.center;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint curPoint = [panGR translationInView:self.ctlBtn];
//            NSLog(@"(x:%f, y:%f)", curPoint.x, curPoint.y);
            CGPoint centerPoint = self.ctlBtn.center;
            centerPoint.x += [self checkUpdateValue:curPoint.x];
            centerPoint.y += [self checkUpdateValue:curPoint.y];
//            if ([self isPanInView:curPoint]) {
                self.ctlImg.center = centerPoint;
//            }
        }
            break;
            
        default:
            NSLog(@"other state: %ld", (long)curState);
            break;
    }
}

- (CGFloat)checkUpdateValue:(CGFloat)value {
    
    CGFloat tmpValue = value > 0 ? value : -value;
    CGFloat usefulR = (self.bounds.size.width - self.ctlImg.bounds.size.width) * 0.5;
    if (tmpValue <= usefulR) {
        return value;
    }
    //
    usefulR *= (value > 0 ? 1 : -1);
    
    return usefulR;
}

- (BOOL)isPanInView:(CGPoint)updatePoint {

    CGFloat updateX = updatePoint.x + self.ctlImg.bounds.size.width * 0.5;
    CGFloat updateY = updatePoint.y + self.ctlImg.bounds.size.width * 0.5;

    CGFloat updateResult = updateX * updateX + updateY * updateY;
    CGFloat r = self.bounds.size.width * 0.5;
    CGFloat cmpResult = r * r;


    return cmpResult >= updateResult;
}

@end
