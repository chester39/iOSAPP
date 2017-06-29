//
//  KeyboardToolbar.m
//      CCRegisterInterface
//      Chen Chen @ June 7th, 2015
//

#import "KeyboardToolbar.h"

@interface KeyboardToolbar ()

@end

@implementation KeyboardToolbar

#pragma mark - 初始化方法

+ (instancetype)keyboardToolbar
{
    return [[[NSBundle mainBundle] loadNibNamed:@"KeyboardToolbar" owner:nil options:nil] lastObject];
}

#pragma mark - 键盘工具栏方法

/**
 *  点击上一个方法
 */
- (IBAction)clickPreviousItem
{
    if ([self.delegate respondsToSelector:@selector(keyboardToolbar:didClickItem:)])
        [self.delegate keyboardToolbar:self didClickItem:CCKeyboardToolbarItemTypePrevious];
}

/**
 *  点击下一个方法
 */
- (IBAction)clickNextItem
{
    if ([self.delegate respondsToSelector:@selector(keyboardToolbar:didClickItem:)])
        [self.delegate keyboardToolbar:self didClickItem:CCKeyboardToolbarItemTypeNext];
}

/**
 *  点击完成方法
 */
- (IBAction)clickDoneItem
{
    if ([self.delegate respondsToSelector:@selector(keyboardToolbar:didClickItem:)])
        [self.delegate keyboardToolbar:self didClickItem:CCKeyboardToolbarItemTypeDone];
}

@end
