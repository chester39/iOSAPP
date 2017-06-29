//
//  CityPickerView.m
//      CCRegisterInterface
//      Chen Chen @ June 7th, 2015
//

#import "CityPickerView.h"
#import "CityModel.h"

@interface CityPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
/**
 *  城市数组
 */
@property (strong, nonatomic) NSArray *cityArray;

@end

@implementation CityPickerView

#pragma mark - 初始化方法

/**
 *  城市数组惰性初始化方法
 */
- (NSArray *)cityArray
{
    if (_cityArray == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"]];
        NSMutableArray *citys = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            CityModel *city = [CityModel cityModelWithDict:dict];
            [citys addObject:city];
        }
        _cityArray = citys;
    }
    return _cityArray;
}

+ (instancetype)cityPickerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CityPickerView" owner:nil options:nil] lastObject];
}

#pragma mark - UIPickerViewDataSource数据源方法

/**
 *  共有列数方法
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

/**
 *  每列行数方法
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
        return self.cityArray.count;
    else {
        NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
        CityModel *city = self.cityArray[provinceIndex];
        return city.cities.count;
    }
}

#pragma mark - UIPickerViewDataDelegate代理方法

/**
 *  每行标题方法
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        CityModel *city = self.cityArray[row];
        return city.name;
    } else {
        NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
        CityModel *city = self.cityArray[provinceIndex];
        return city.cities[row];
    }
}

/**
 *  选中行方法
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
    CityModel *city = self.cityArray[provinceIndex];
    NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    if ([self.delegate respondsToSelector:@selector(cityPickerView:citySelectWithProvince:city:)])
        [self.delegate cityPickerView:self citySelectWithProvince:city.name city:city.cities[cityIndex]];
}

@end
