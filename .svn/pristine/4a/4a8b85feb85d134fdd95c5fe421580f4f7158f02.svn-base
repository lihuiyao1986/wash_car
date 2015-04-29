//
//  UIViewController+animation.m
//  WashCar
//
//  Created by mac on 14/12/24.
//  Copyright (c) 2014年 cheletong. All rights reserved.
//

#import "UIViewController+animation.h"

@implementation UIViewController (animation)

#pragma mark - 自上而下的动画效果
-(CATransition*)popTopMoveAnimation{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromBottom;
    return animation;
}

#pragma mark - 自左而右的动画效果
-(CATransition*)popLeftMoveAnimation{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromLeft;
    return animation;
}

#pragma mark - 自右而左的动画效果
-(CATransition*)popRightMoveAnimation{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromRight;
    return animation;
}

#pragma mark - 从下而上的动画效果
-(CATransition*)popBottomMoveAnimation{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromTop;
    return animation;
}

#pragma mark - 自上而下的动画效果
-(CATransition*)pushTopMoveAnimation{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromBottom;
    return animation;
}

#pragma mark - 自左而右的动画效果
-(CATransition*)pushLeftMoveAnimation{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromLeft;
    return animation;
}

#pragma mark - 自右而左的动画效果
-(CATransition*)pushRightMoveAnimation{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    return animation;
}

#pragma mark - 从下而上的动画效果
-(CATransition*)pushBottomMoveAnimation{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromTop;
    return animation;
}


@end
