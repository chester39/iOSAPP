//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ July 4th, 2015
//

#import <UIKit/UIKit.h>

@interface TurnplateView : UIView

/**
 *  TurnplateView指定初始化方法
 */
+ (instancetype)turnplateView;
/**
 *  开始转动方法
 */
- (void)startRotating;
/**
 *  结束转动方法
 */
- (void)stopRotating;

@end
