//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 7th, 2015
//

#import <UIKit/UIKit.h>

@class CityPickerView;

/**
 *  自定义CityPickerViewDelegate代理协议
 */
@protocol CityPickerViewDelegate <NSObject>
@optional

- (void)cityPickerView:(CityPickerView *)cityPickerView citySelectWithProvince:(NSString *)province city:(NSString *)city;

@end

@interface CityPickerView : UIView

/**
 *  CityPickerViewDelegate代理
 */
@property (weak, nonatomic) id<CityPickerViewDelegate> delegate;

/**
 *  CityPickerView指定初始化方法
 */
+ (instancetype)cityPickerView;

@end
