//
//  ChatFrame.m
//      CCChatInterface
//      Chen Chen @ June 3rd, 2015
//

#import "ChatFrame.h"
#import "ChatModel.h"
#import "NSString+CC.h"

@implementation ChatFrame

/**
 *  重写聊天模型的setter方法
 */
- (void)setChat:(ChatModel *)chat
{
    _chat = chat;
    CGFloat padding = 10;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (self.chat.isHideTime == NO) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeWidth = screenWidth;
        CGFloat timeHeight = 40;
        _timeFrame = CGRectMake(timeX, timeY, timeWidth, timeHeight);
    }
    CGFloat iconX;
    CGFloat iconY = CGRectGetMaxY(_timeFrame);
    CGFloat iconWidth = 40;
    CGFloat iconHeight = 40;
    if (chat.type == CCChatTypeMe)
        iconX = screenWidth - padding - iconWidth;
    else
        iconX = padding;
    _iconFrame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    CGSize textSize = [self.chat.text textSizeWithFont:CCChatTextFont maxSize:CGSizeMake(200, MAXFLOAT)];
    CGSize textButtonSize = CGSizeMake(textSize.width + CCTextPadding * 2, textSize.height + CCTextPadding * 2);
    CGFloat textX;
    CGFloat textY = iconY;
    if (chat.type == CCChatTypeMe)
        textX = iconX - padding - textButtonSize.width;
    else
        textX = CGRectGetMaxX(_iconFrame) + padding;
    _textFrame = (CGRect){{textX, textY}, textButtonSize};
    _cellHeight = MAX(CGRectGetMaxY(_iconFrame), CGRectGetMaxY(_textFrame)) + padding;
}

@end
