//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 7th, 2015
//

#import "ViewController.h"
#import "CityPickerView.h"
#import "FlagPickerView.h"
#import "KeyboardToolbar.h"

@interface ViewController () <UITextFieldDelegate, CityPickerViewDelegate, FlagPickerViewDelegate, KeyboardToolbarDelegate>

/**
 *  生日文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *birthdayField;
/**
 *  城市文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *cityField;
/**
 *  国籍文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *countryField;
/**
 *  文本框数组
 */
@property (strong, nonatomic) NSMutableArray *fieldArray;
/**
 *  焦点文本框
 */
@property (strong, nonatomic) UITextField *focusField;
/**
 *  键盘工具栏
 */
@property (strong, nonatomic) KeyboardToolbar *keyboardToolbar;

@end

@implementation ViewController

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self settingKeyboard];
    [self settingFieldArray];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  释放内存方法
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 属性设置方法

/**
 *  设置键盘方法
 */
- (void)settingKeyboard
{
    UIDatePicker *dataPicker = [[UIDatePicker alloc] init];
    dataPicker.datePickerMode = UIDatePickerModeDate;
    dataPicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans"];
    [dataPicker addTarget:self action:@selector(changeBirthday:) forControlEvents:UIControlEventValueChanged];
    self.birthdayField.inputView = dataPicker;
    CityPickerView *cityPickerView = [CityPickerView cityPickerView];
    cityPickerView.delegate = self;
    self.cityField.inputView = cityPickerView;
    FlagPickerView *flagPickerView = [FlagPickerView flagPickerView];
    flagPickerView.delegate = self;
    self.countryField.inputView = flagPickerView;
}

/**
 *  设置文本框数组方法
 */
- (void)settingFieldArray
{
    self.fieldArray = [NSMutableArray array];
    KeyboardToolbar *toolbar = [KeyboardToolbar keyboardToolbar];
    toolbar.delegate = self;
    for (UIView *child in self.view.subviews) {
        if ([child isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *)child;
            field.inputAccessoryView = toolbar;
            field.delegate = self;
            [self.fieldArray addObject:field];
        }
    }
    self.keyboardToolbar = toolbar;
    [self.fieldArray sortedArrayUsingComparator:^NSComparisonResult(UITextField *obj1, UITextField *obj2) {
        CGFloat obj1Y = obj1.frame.origin.y;
        CGFloat obj2Y = obj2.frame.origin.y;
        if (obj1Y > obj2Y)
            return NSOrderedDescending;
        else
            return NSOrderedAscending;
    }];
}

#pragma mark - 键盘方法

/**
 *  显示键盘方法
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    CGFloat keyboardDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat fieldMaxY = CGRectGetMaxY(self.focusField.frame);
    CGFloat keyboardHeight = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat keyboardY = self.view.frame.size.height - keyboardHeight;
    CGFloat transformX = 0;
    CGFloat transformY = keyboardY - fieldMaxY;
    [UIView animateWithDuration:keyboardDuration animations:^{
        if (fieldMaxY > keyboardY)
            self.view.transform = CGAffineTransformMakeTranslation(transformX, transformY);
        else
            self.view.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  隐藏键盘方法
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    CGFloat keyboardDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:keyboardDuration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  改变生日方法
 */
- (void)changeBirthday:(UIDatePicker *)datePicker
{
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    date.dateFormat = @"yyyy-MM-dd";
    self.birthdayField.text = [date stringFromDate:datePicker.date];
}

#pragma mark - UITextFieldDelegate代理方法

/**
 *  开始编辑方法
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.focusField = textField;
    NSInteger index = [self.fieldArray indexOfObject:textField];
    self.keyboardToolbar.previousItem.enabled = (index != 0);
    self.keyboardToolbar.nextItem.enabled = (index != self.fieldArray.count - 1);
}

/**
 *  修改内容方法
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return !(textField == self.birthdayField || textField == self.cityField || textField == self.countryField);
}

#pragma mark - CityPickerViewDelegate代理方法

/**
 *  选中城市方法
 */
- (void)cityPickerView:(CityPickerView *)cityPickerView citySelectWithProvince:(NSString *)province city:(NSString *)city
{
    self.cityField.text = [NSString stringWithFormat:@"%@ %@", province, city];
}

#pragma mark - FlagPickerViewDelegate代理方法

/**
 *  选中国旗方法
 */
- (void)flagPickerView:(FlagPickerView *)flagPickerView flagSelectWithCountry:(NSString *)country
{
    self.countryField.text = [NSString stringWithFormat:@"%@", country];
}

#pragma mark - KeyboardToolbarDelegate代理方法

/**
 *  点击按钮方法
 */
- (void)keyboardToolbar:(KeyboardToolbar *)keyboardToolbar didClickItem:(CCKeyboardToolbarItemType)itemType
{
    if (itemType == CCKeyboardToolbarItemTypeDone)
        [self.view endEditing:YES];
    else {
        NSInteger index = [self.fieldArray indexOfObject:self.focusField];
        if (itemType == CCKeyboardToolbarItemTypeNext)
            index++;
        else
            index--;
        [self.fieldArray[index] becomeFirstResponder];
    }
}

@end
