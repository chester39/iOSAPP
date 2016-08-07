//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 7th, 2015
//

#import "FlagPickerView.h"
#import "FlagModel.h"
#import "FlagView.h"

@interface FlagPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
/**
 *  国旗数组
 */
@property (strong, nonatomic) NSArray *flagArray;

@end

@implementation FlagPickerView

#pragma mark - 初始化方法

/**
 *  国旗数组惰性初始化方法
 */
- (NSArray *)flagArray
{
    if (_flagArray == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"flags" ofType:@"plist"]];
        NSMutableArray *flags = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            FlagModel *flag = [FlagModel flagModelWithDict:dict];
            [flags addObject:flag];
        }
        _flagArray = flags;
    }
    return _flagArray;
}

+ (instancetype)flagPickerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"FlagPickerView" owner:nil options:nil] lastObject];
}

#pragma mark - UIPickerViewDataSource数据源方法

/**
 *  共有列数方法
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

/**
 *  每列行数方法
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.flagArray.count;
}

#pragma mark - UIPickerViewDataDelegate代理方法

/**
 *  每行内容方法
 */
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    FlagView *flagView = [FlagView flagViewWithReusingView:view];
    flagView.flag = self.flagArray[row];
    return flagView;
}

/**
 *  选中行方法
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger index = [pickerView selectedRowInComponent:0];
    FlagModel *flag = self.flagArray[index];
    if ([self.delegate respondsToSelector:@selector(flagPickerView:flagSelectWithCountry:)]) {
        [self.delegate flagPickerView:self flagSelectWithCountry:flag.name];
    }
}

/**
 *  每行高度方法
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return [FlagView flagViewHeight];
}

@end
