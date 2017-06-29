//
//  UnlockView.h
//      CCGestureUnlock
//      Chen Chen @ June 24th, 2015
//

#import <UIKit/UIKit.h>

@class UnlockView;

/**
 *  自定义UnlockViewDelegate代理协议
 */
@protocol UnlockViewDelegate <NSObject>
@optional

- (void)unlockView:(UnlockView *)unlockView didFinishPath:(NSString *)path;

@end

@interface UnlockView : UIView

/**
 *  UnlockViewDelegate代理
 */
@property (weak, nonatomic) id<UnlockViewDelegate> delegate;

@end
