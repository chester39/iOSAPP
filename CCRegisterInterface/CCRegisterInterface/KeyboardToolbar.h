//
//  KeyboardToolbar.h
//      CCRegisterInterface
//      Chen Chen @ June 7th, 2015
//

#import <UIKit/UIKit.h>

@class KeyboardToolbar;

/**
 *  按钮功能枚举数组
 */
typedef enum {
    /**
     *  上一个按钮
     */
    CCKeyboardToolbarItemTypePrevious,
    /**
     *  下一个按钮
     */
    CCKeyboardToolbarItemTypeNext,
    /**
     *  完成按钮
     */
    CCKeyboardToolbarItemTypeDone
} CCKeyboardToolbarItemType;

/**
 *  自定义KeyboardToolbarDelegate代理协议
 */
@protocol KeyboardToolbarDelegate <NSObject>
@optional

- (void)keyboardToolbar:(KeyboardToolbar *)keyboardToolbar didClickItem:(CCKeyboardToolbarItemType)itemType;

@end

@interface KeyboardToolbar : UIView

/**
 *  上一个按钮
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousItem;
/**
 *  下一个按钮
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextItem;
/**
 *  KeyboardToolbarDelegate代理
 */
@property (weak, nonatomic) id<KeyboardToolbarDelegate> delegate;

/**
 *  KeyboardToolbar指定初始化方法
 */
+ (instancetype)keyboardToolbar;

@end
