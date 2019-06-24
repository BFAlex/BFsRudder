//
//  BFsRudderView2.h
//  BFsRudder
//
//  Created by BFsAlex on 2019/6/24.
//  Copyright © 2019年 BFs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BFsRudderView2;
@protocol BFsRudderView2Delegate <NSObject>

- (void)rudderView:(BFsRudderView2 *)rudder didUpdateDragLocation:(CGPoint)dragPoint;

@end

@interface BFsRudderView2 : UIView

@property (nonatomic, weak) id<BFsRudderView2Delegate> delegate;

- (void)updateFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
