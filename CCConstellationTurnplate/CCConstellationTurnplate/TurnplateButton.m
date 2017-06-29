//
//  TurnplateButton.m
//      CCConstellationTurnplate
//      Chen Chen @ July 4th, 2015
//

#import "TurnplateButton.h"

@implementation TurnplateButton

/**
 *  按钮图像边界方法
 *
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageWidth = 40;
    CGFloat imageHeight = 47;
    CGFloat imageX = (contentRect.size.width - imageWidth) * 0.5;
    CGFloat imageY = 20;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

@end
