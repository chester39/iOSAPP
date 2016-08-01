//
//	iOS培训
//		传智播客 & 黑马
//		Chen Chen @ June 3rd, 2015
//

#import "ChatCell.h"
#import "ChatModel.h"
#import "ChatFrame.h"
#import "UIImage+CC.h"

@interface ChatCell()

/**
 *  消息时间
 */
@property (weak, nonatomic) UILabel *timeView;
/**
 *  用户头像
 */
@property (weak, nonatomic) UIImageView *iconView;
/**
 *  消息内容
 */
@property (weak, nonatomic) UIButton *textView;

@end

@implementation ChatCell

#pragma mark - 初始化方法

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CHAT";
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
        cell = [[ChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    return cell;
}

/**
 *  重写聊天尺寸的setter方法
 */
- (void)setChatFrame:(ChatFrame *)chatFrame
{
    _chatFrame = chatFrame;
    ChatModel *chat = chatFrame.chat;
    self.timeView.text = chat.time;
    self.timeView.frame = chatFrame.timeFrame;
    NSString *icon = (chat.type == CCChatTypeMe) ? @"Gatsby" : @"Jobs";
    self.iconView.image = [UIImage imageNamed:icon];
    self.iconView.frame = chatFrame.iconFrame;
    [self.textView setTitle:chat.text forState:UIControlStateNormal];
    if (chat.type == CCChatTypeMe) {
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_send_nor" scale:0.5] forState:UIControlStateNormal];
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_send_press_pic" scale:0.5] forState:UIControlStateHighlighted];
    } else {
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_recive_nor" scale:0.5] forState:UIControlStateNormal];
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_recive_press_pic" scale:0.5] forState:UIControlStateHighlighted];
    }
    self.textView.frame = chatFrame.textFrame;
}

#pragma mark - 系统方法

/**
 *  代码cell初始化方法
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *timeView = [[UILabel alloc] init];
        timeView.textAlignment = NSTextAlignmentCenter;
        timeView.font = CCChatTimeFont;
        timeView.textColor = [UIColor grayColor];
        [self.contentView addSubview:timeView];
        self.timeView = timeView;
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        UIButton *textView = [[UIButton alloc] init];
        textView.titleLabel.font = CCChatTextFont;
        textView.titleLabel.numberOfLines = 0;
        textView.contentEdgeInsets = UIEdgeInsetsMake(CCTextPadding, CCTextPadding, CCTextPadding, CCTextPadding);
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textView];
        self.textView = textView;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
