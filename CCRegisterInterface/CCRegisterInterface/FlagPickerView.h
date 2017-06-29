//
//  FlagPickerView.h
//      CCRegisterInterface
//      Chen Chen @ June 7th, 2015
//

#import <UIKit/UIKit.h>

@class FlagPickerView;

/**
 *  自定义FlagPickerViewDelegate代理协议
 */
@protocol FlagPickerViewDelegate <NSObject>
@optional

- (void)flagPickerView:(FlagPickerView *)flagPickerView flagSelectWithCountry:(NSString *)country;

@end

@interface FlagPickerView : UIView

/**
 *  FlagPickerViewDelegate代理
 */
@property (weak, nonatomic) id<FlagPickerViewDelegate> delegate;

/**
 *  FlagPickerView指定初始化方法
 */
+ (instancetype)flagPickerView;

@end
