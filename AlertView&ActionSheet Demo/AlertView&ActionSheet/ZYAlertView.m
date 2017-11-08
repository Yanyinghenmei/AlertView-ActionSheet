//
//  ZYAlertView.m
//  SpeakEnglish
//
//  Created by Daniel on 16/4/12.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ZYAlertView.h"

#define AlertTitleColor [UIColor colorWithRed:51/255.00 green:51/255.00 blue:51/255.00 alpha:1]
#define AlertMessageColor [UIColor colorWithRed:119/255.00 green:119/255.00 blue:119/255.00 alpha:1]
#define AlertBtnTextColor [UIColor whiteColor]
#define AlertBtnBackgroundColor [UIColor colorWithRed:26/255.00 green:167/255.00 blue:239/255.00 alpha:1]

#define AlertTitleFont [UIFont systemFontOfSize:18]
#define AlertMessageFont [UIFont systemFontOfSize:15]
#define AlertBtnFont [UIFont systemFontOfSize:16]

@interface ZYAlertView ()
@property (nonatomic, strong, nullable)UILabel *titleLab;
@property (nonatomic, strong, nullable)UILabel *messageLab;
@property (nonatomic, strong, nullable)UIButton *cancelButton;
@property (nonatomic, strong, nullable)UIButton *suerButton;
@property (nonatomic, strong, nullable)NSMutableArray *otherButtons;
@property (nonatomic, strong, )UIControl *control;
@end

@implementation ZYAlertView {
    ButtonClickBlock buttonClickBlock;
    CGFloat selfW;
    UIView *line;
}

- (instancetype)initWithWidth:(CGFloat)width
                        Title:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
              sureButtonTitle:(NSString *)sureButtonTitle
             buttonClickBlock:(ButtonClickBlock)block {
    
    selfW = width?width:[UIScreen mainScreen].bounds.size.width - 150;
    
    if (self = [super initWithFrame:CGRectZero]) {
        
        buttonClickBlock = block;
        
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        
        if (title) {
            self.titleLab.text = title;
            CGSize size = [self.titleLab sizeThatFits:CGSizeMake(selfW - 60, [UIScreen mainScreen].bounds.size.height)];
            self.titleLab.frame = CGRectMake(30,
                                             30,
                                             selfW - 60,
                                             size.height);
        }
        
        
        CGFloat gapOfTitleAndMessage = title?15:30;
        if (message) {
            self.messageLab.text = message;
            CGSize size = [self.messageLab sizeThatFits:CGSizeMake(selfW - 60, [UIScreen mainScreen].bounds.size.height)];
            self.messageLab.frame = CGRectMake(30,
                                               CGRectGetMaxY(self.titleLab.frame)+gapOfTitleAndMessage,
                                               selfW - 60,
                                               size.height);
        }
        
        if (cancelButtonTitle) {
            _cancelButton = [self buttonWithTitle:cancelButtonTitle];
        }
        
        if (sureButtonTitle) {
            _suerButton = [self buttonWithTitle:sureButtonTitle];
        }
        
        CGFloat gapOfMessageAndBtn = message?30:5;
        
        if (cancelButtonTitle && sureButtonTitle) {
            _cancelButton.frame = CGRectMake(0,
                                             CGRectGetMaxY(self.messageLab.frame)+gapOfMessageAndBtn,
                                             selfW/2,
                                             40);
            
            _suerButton.frame = CGRectMake(CGRectGetMaxX(_cancelButton.frame),
                                           CGRectGetMaxY(self.messageLab.frame)+gapOfMessageAndBtn,
                                           selfW/2,
                                           40);
            
            line = [[UIView alloc] initWithFrame:CGRectMake(selfW/2,
                                                            CGRectGetMinY(_cancelButton.frame)+8,
                                                            0.5f,
                                                            40-16)];
            line.backgroundColor = AlertBtnTextColor;
            [self addSubview:line];
        }
        
        if (cancelButtonTitle && !sureButtonTitle) {
            _cancelButton.frame = CGRectMake(0,
                                             CGRectGetMaxY(self.messageLab.frame)+gapOfTitleAndMessage,
                                             selfW,
                                             40);
        }
        
        if (sureButtonTitle && !cancelButtonTitle) {
            _suerButton.frame = CGRectMake(0,
                                           CGRectGetMaxY(self.messageLab.frame)+gapOfTitleAndMessage,
                                           selfW,
                                           40);
        }
        
        CGFloat selfH = CGRectGetMaxY(_cancelButton.frame)?CGRectGetMaxY(_cancelButton.frame):CGRectGetMaxY(_suerButton.frame);
        self.frame = CGRectMake(0, 0, selfW, selfH);
        
        if (!title && !message) {
            _cancelButton.center = CGPointMake(_cancelButton.center.x, self.frame.size.height/2);
            _suerButton.center = CGPointMake(_suerButton.center.x, self.frame.size.height/2);
            if (line) {
                line.frame = CGRectMake(selfW/2,
                                        CGRectGetMinY(_cancelButton.frame)+8,
                                        0.5f,
                                        40-16);
            }
        }
    }
    return self;
    
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, selfW - 60, 0)];
        _titleLab.numberOfLines = 0;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = AlertTitleColor;
        _titleLab.font = AlertTitleFont;
        
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

- (UILabel *)messageLab {
    
    if (!_messageLab) {
        _messageLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLab.frame)+15, selfW - 60, 0)];
        _messageLab.numberOfLines = 0;
        _messageLab.textAlignment = NSTextAlignmentCenter;
        _messageLab.textColor = AlertMessageColor;
        _messageLab.font = AlertMessageFont;
        
        [self addSubview:_messageLab];
    }
    return _messageLab;
}

- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLab.frame), 0, 0)];
    [self addSubview:btn];
    
    btn.backgroundColor = AlertBtnBackgroundColor;
    btn.titleLabel.font = AlertBtnFont;
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)buttonClick:(UIButton *)btn {
    [self dismiss];
    if (buttonClickBlock) {
        buttonClickBlock(btn);
    }
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.control];
    [self.control addSubview:self];
    self.center = window.center;
}

- (void)dismiss {
    [self.control removeFromSuperview];
    [self removeFromSuperview];
}

- (UIControl *)control {
    if (!_control) {
        _control = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _control.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [_control addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _control;
}

@end

