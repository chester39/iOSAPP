//
//  ViewController.m
//      CCOrderFood
//      Chen Chen @ June 6th, 2015
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

/**
 *  水果
 */
@property (weak, nonatomic) IBOutlet UILabel *fruitLabel;
/**
 *  主菜
 */
@property (weak, nonatomic) IBOutlet UILabel *entreeLabel;
/**
 *  饮料
 */
@property (weak, nonatomic) IBOutlet UILabel *drinkLabel;
/**
 *  点菜选择器
 */
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
/**
 *  菜品数组
 */
@property (strong, nonatomic) NSArray *foodArray;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  菜品数组惰性初始化方法
 */
- (NSArray *)foodArray
{
    if (_foodArray == nil)
        _foodArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"foods" ofType:@"plist"]];
    return _foodArray;
}

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    for (int component = 0; component < self.foodArray.count; ++component)
        [self pickerView:nil didSelectRow:0 inComponent:component];
}

#pragma mark - UIPickerViewDataSource数据源方法

/**
 *  共有列数方法
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.foodArray.count;
}

/**
 *  每列行数方法
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.foodArray[component] count];
}

#pragma mark - UIPickerViewDataDelegate代理方法

/**
 *  每行标题方法
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.foodArray[component][row];
}

/**
 *  选中行方法
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
        self.fruitLabel.text = self.foodArray[component][row];
    else if (component == 1)
        self.entreeLabel.text = self.foodArray[component][row];
    else if (component == 2)
        self.drinkLabel.text = self.foodArray[component][row];
}

#pragma mark - 随机方法

/**
 *  随机点菜方法
 */
- (IBAction)randomOrder
{
    for (int component = 0; component < self.foodArray.count; ++component) {
        NSInteger count = [self.foodArray[component] count];
        NSInteger oldRow = [self.pickerView selectedRowInComponent:component];
        NSInteger row = oldRow;
        while (row == oldRow)
            row = arc4random() % count;
        [self.pickerView selectRow:row inComponent:component animated:YES];
        [self pickerView:nil didSelectRow:row inComponent:component];
    }
}

@end
