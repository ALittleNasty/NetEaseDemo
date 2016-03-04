//
//  YYHomeLabel.m
//  NetEaseDemo
//
//  Created by 胡阳 on 16/2/19.
//  Copyright © 2016年 apple.com. All rights reserved.
//

#import "YYHomeLabel.h"

@implementation YYHomeLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.textAlignment = NSTextAlignmentCenter ;
        self.textColor = [UIColor colorWithRed:0.4 green:0.5 blue:0.6 alpha:1.0];
        self.font = [UIFont systemFontOfSize:15.0];
        self.userInteractionEnabled = YES ;
    }
    return self ;
}


- (void)setScale:(CGFloat)scale
{
    _scale = scale ;
    
    self.textColor = [UIColor colorWithRed:0.4 + _scale * 0.6 green:0.5 - _scale * 0.5 blue:0.6 - _scale * 0.6 alpha:1.0];
    self.transform = CGAffineTransformMakeScale(1.0 + _scale * 0.3, 1.0 + _scale * 0.3);
}

@end
