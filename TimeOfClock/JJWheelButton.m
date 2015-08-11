//
//  JJWheelButton.m
//  LuckWheel
//
//  Created by James on 1/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "JJWheelButton.h"

@implementation JJWheelButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageWidth = 40;
    CGFloat imageHeight = 48;
    CGFloat imageX = (contentRect.size.width - imageWidth) * 0.5;
    CGFloat imageY = 10;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
