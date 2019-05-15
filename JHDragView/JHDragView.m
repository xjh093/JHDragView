//
//  JHDragView.m
//  JHKit
//
//  Created by HaoCold on 2019/5/15.
//  Copyright © 2019 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2019 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JHDragView.h"

@implementation JHDragView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (CGRectGetWidth(frame) <= 0 ||
        CGRectGetHeight(frame) <= 0) {
        frame = CGRectMake(100, 100, 50, 50);
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor brownColor];
    }
    return self;
}

#pragma mark - override

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    self.center = point;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self shouldResetFrame];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self shouldResetFrame];
}

#pragma mark - private

- (void)shouldResetFrame
{
    CGFloat midX = CGRectGetWidth(self.superview.frame)*0.5;
    CGFloat midY = CGRectGetHeight(self.superview.frame)*0.5;
    CGFloat maxX = midX*2;
    CGFloat maxY = midY*2;
    CGRect frame = self.frame;
    
    if (CGRectGetMinX(frame) < 0 ||
        CGRectGetMidX(frame) <= midX) {
        frame.origin.x = 0;
    }else if (CGRectGetMidX(frame) > midX ||
              CGRectGetMaxX(frame) > maxX) {
        frame.origin.x = maxX - CGRectGetWidth(frame);
    }
    
    if (CGRectGetMinY(frame) < 0) {
        frame.origin.y = 0;
    }else if (CGRectGetMaxY(frame) > maxY) {
        frame.origin.y = maxY - CGRectGetHeight(frame);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = frame;
    }];
}

@end
