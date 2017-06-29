//
//  ViewController.m
//      CCChatInterface
//      Chen Chen @ June 3rd, 2015
//

#import "ViewController.h"
#import "ChatModel.h"
#import "ChatFrame.h"
#import "ChatCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

/**
 *  聊天尺寸数组
 */
@property (strong, nonatomic) NSMutableArray *chatFrameArray;
/**
 *  自动回复数组
 */
@property (strong, nonatomic) NSDictionary *autoReplayArray;
/**
 *  表格视图
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  输入框视图
 */
@property (weak, nonatomic) IBOutlet UITextField *inputView;

@end

@implementation ViewController

#pragma mark - 初始化方法

/**
 *  聊天尺寸数组惰性初始化方法
 */
- (NSMutableArray *)chatFrameArray
{
    if (_chatFrameArray == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"]];
        NSMutableArray *chatFrames = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            ChatFrame *chatFrame = [[ChatFrame alloc] init];
            ChatModel *chat = [ChatModel chatModelWithDict:dict];
            ChatFrame *lastChatFrame = [chatFrames lastObject];
            ChatModel *lastChat = lastChatFrame.chat;
            chat.isHideTime = [chat.time isEqualToString:lastChat.time];
            chatFrame.chat = chat;
            [chatFrames addObject:chatFrame];
        }
        _chatFrameArray = chatFrames;
    }
    return _chatFrameArray;
}

/**
 *  自动回复数组惰性初始化方法
 */
- (NSDictionary *)autoReplayArray
{
    if (_autoReplayArray == nil) {
        _autoReplayArray = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoReplay" ofType:@"plist"]];
    }
    return _autoReplayArray;
}

#pragma mark - 系统方法

/**
 *  视图已经加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.inputView.delegate = self;
    self.inputView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.inputView.leftViewMode = UITextFieldViewModeAlways;
    self.inputView.returnKeyType = UIReturnKeySend;
}

/**
 *  释放内存方法
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  状态栏隐藏方法
 */
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - UITableViewDataSource数据源方法

/**
 *  共有组数方法
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 *  每组行数方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chatFrameArray.count;
}

/**
 *  每行内容方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell *cell = [ChatCell cellWithTableView:tableView];
    cell.chatFrame = self.chatFrameArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate代理方法

/**
 *  每行高度方法
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatFrame *chatFrame = self.chatFrameArray[indexPath.row];
    return chatFrame.cellHeight;
}

/**
 *  将被抓拽方法
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate代理方法

/**
 *  点击返回键方法
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendChat:textField.text type:CCChatTypeMe];
    NSString *replay = [self autoReplayWithText:textField.text];
    [self sendChat:replay type:CCChatTypeOther];
    self.inputView.text = nil;
    return YES;
}

#pragma mark - 消息方法

/**
 *  发送消息方法
 */
- (void)sendChat:(NSString *)text type:(CCChatType)type
{
    ChatModel *chat = [[ChatModel alloc] init];
    chat.text = text;
    chat.type = type;
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    chat.time = [dateFormatter stringFromDate:now];
    ChatFrame *chatFrame = [[ChatFrame alloc] init];
    chatFrame.chat = chat;
    [self.chatFrameArray addObject:chatFrame];
    [self.tableView reloadData];
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.chatFrameArray.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

/**
 *  自动回复消息方法
 */
- (NSString *)autoReplayWithText:(NSString *)text
{
    for (int i = 0; i < text.length; ++i) {
        NSString *word = [text substringWithRange:NSMakeRange(i, 1)];
        if (self.autoReplayArray[word])
            return self.autoReplayArray[word];
    }
    return @"也可以";
}

/**
 *  键盘弹出改变界面尺寸方法
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    self.view.window.backgroundColor = self.tableView.backgroundColor;
    CGFloat keyboardDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat transformX = 0;
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    [UIView animateWithDuration:keyboardDuration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(transformX, transformY);
    }];
}

@end
