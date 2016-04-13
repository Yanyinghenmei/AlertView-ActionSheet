//
//  SEAlertView.m
//  SpeakEnglish
//
//  Created by Daniel on 16/4/12.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "SEAlertView.h"

#define ZYDeviceWidth [UIScreen mainScreen].bounds.size.width
#define ZYDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface SEAlertView ()
@property (nonatomic, strong, nullable)UILabel *titleLab;
@property (nonatomic, strong, nullable)UIButton *cancelButton;
@property (nonatomic, strong, nullable)UIButton *suerButton;
@property (nonatomic, strong, nullable)NSMutableArray *otherButtons;
@property (nonatomic, strong, )UIControl *control;
@end

@implementation SEAlertView {
    AlertButtonClickBlock buttonClickBlock;
    CGFloat selfW;
    UIView *line;
}

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
              sureButtonTitle:(NSString *)sureButtonTitle
             buttonClickBlock:(AlertButtonClickBlock)block {
    
    
    if (self = [super initWithFrame:CGRectZero]) {
        
        buttonClickBlock = block;
        
        selfW = ZYDeviceWidth - 150;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        
        if (title) {
            self.titleLab.text = title;
            CGSize size = [self.titleLab sizeThatFits:CGSizeMake(selfW - 60, ZYDeviceWidth)];
            self.titleLab.frame = CGRectMake(30, 30, selfW - 60, size.height);
        }
        
        if (cancelButtonTitle) {
            _cancelButton = [self buttonWithTitle:cancelButtonTitle];
        }
        
        if (sureButtonTitle) {
            _suerButton = [self buttonWithTitle:sureButtonTitle];
        }
        
        if (cancelButtonTitle && sureButtonTitle) {
            _cancelButton.frame = CGRectMake(0, CGRectGetMaxY(self.titleLab.frame)+30, selfW/2, 40);
            _suerButton.frame = CGRectMake(CGRectGetMaxX(_cancelButton.frame), CGRectGetMaxY(self.titleLab.frame)+30, selfW/2, 40);
            
            line = [[UIView alloc] initWithFrame:CGRectMake(selfW/2, CGRectGetMinY(_cancelButton.frame)+8, 0.5f, 40-16)];
            line.backgroundColor = AlertBtnTitleColor;
            [self addSubview:line];
        }
        
        if (cancelButtonTitle && !sureButtonTitle) {
            _cancelButton.frame = CGRectMake(0, CGRectGetMaxY(self.titleLab.frame)+30, selfW, 40);
        }
        
        if (sureButtonTitle && !cancelButtonTitle) {
            _suerButton.frame = CGRectMake(0, CGRectGetMaxY(self.titleLab.frame)+30, selfW, 40);
        }
        
        self.frame = CGRectMake(0, 0, selfW, self.titleLab.frame.size.height + (cancelButtonTitle?_cancelButton.frame.size.height:_suerButton.frame.size.height) + (title?60:0));
        
        if (!title) {
            _cancelButton.center = CGPointMake(_cancelButton.center.x, self.frame.size.height/2);
            _suerButton.center = CGPointMake(_suerButton.center.x, self.frame.size.height/2);
            if (line) {
                line.frame = CGRectMake(selfW/2, CGRectGetMinY(_cancelButton.frame)+8, 0.5f, 40-16);
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
    buttonClickBlock(btn);
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
