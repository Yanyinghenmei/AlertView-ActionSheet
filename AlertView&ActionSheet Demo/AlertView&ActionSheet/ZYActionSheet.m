//
//  ZYActionSheet.m
//  SpeakEnglish
//
//  Created by Daniel on 16/4/13.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ZYActionSheet.h"

#define SheetTitleColor [UIColor colorWithRed:51/255.00 green:51/255.00 blue:51/255.00 alpha:1]
#define SheetBtnTitleSlecetedColor [UIColor colorWithRed:26/255.00 green:167/255.00 blue:239/255.00 alpha:1]
#define SheetBtnTitleNormalColor [UIColor colorWithRed:119/255.00 green:119/255.00 blue:119/255.00 alpha:1]
#define SheetCancelBtnTitleColor [UIColor colorWithRed:119/255.00 green:119/255.00 blue:119/255.00 alpha:1]
#define SheetLineColor [UIColor colorWithRed:241/255.00 green:241/255.00 blue:241/255.00 alpha:1]

#define SheetTitleFont [UIFont systemFontOfSize:18]
#define SheetBtnFont [UIFont systemFontOfSize:15]
#define SheetCancelFont [UIFont systemFontOfSize:15]

@interface ZYActionSheet ()
@property (nonatomic, strong, nullable)UIControl *control;
@property (nonatomic, strong, nullable)UIView *topView;
@property (nonatomic, strong, nullable)UILabel *titleLab;
@property (nonatomic, strong, nullable)UIButton *cancelBtn;
@end

@implementation ZYActionSheet {
    SheetButtonClickBlock buttonClickBlock;
    CGFloat selfWidth;
}

- (instancetype)initWithSelectedIndex:(NSInteger)index
                                title:(NSString *)title
                         buttonTitles:(NSArray *)buttonTitles
                    cancelButtonTitle:(NSString *)cancelButtonTitle
                     buttonClickBlock:(SheetButtonClickBlock)block {
    
    if (self = [super initWithFrame:CGRectZero]) {
        
        buttonClickBlock = block;
        selfWidth = [UIScreen mainScreen].bounds.size.width - 20;
        CGFloat x = 25;
        CGFloat y = 20;
        CGFloat btnH = 40;
        
        if (title) {
            self.titleLab.text = title;
            CGSize size = [self.titleLab sizeThatFits:CGSizeMake(selfWidth-x*2, MAXFLOAT)];
            self.titleLab.frame = CGRectMake(x, y, selfWidth-x*2, size.height+40);
        }
        
        if (buttonTitles) {
            for (int i = 0; i < buttonTitles.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:
                                 CGRectMake(0, CGRectGetMaxY(self.titleLab.frame) + btnH*i,
                                            selfWidth, btnH)];
                [self.topView addSubview:btn];
                
                btn.titleLabel.font = SheetBtnFont;
                
                [btn setTitleColor:SheetBtnTitleSlecetedColor forState:UIControlStateSelected];
                [btn setTitleColor:SheetBtnTitleNormalColor forState:UIControlStateNormal];
                [btn setTitle:buttonTitles[i] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                
                btn.tag = i;
                
                if (i == index) {
                    btn.selected = YES;
                }
                
                if (!self.titleLab.frame.size.height && i == 0) {
                    continue;
                }
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, CGRectGetMinY(btn.frame), selfWidth-x*2, 0.5f)];
                line.backgroundColor = SheetLineColor;
                [self.topView addSubview:line];
            }
        }
        
        self.topView.frame = CGRectMake(0, 0, selfWidth, self.titleLab.frame.size.height + buttonTitles.count * btnH + y * 2);
        
        if (!title && !buttonTitles) {
            self.topView.frame = CGRectZero;
        }
        
        if (cancelButtonTitle) {
            self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame)+8, selfWidth, btnH);
            
            [self.cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
            
            self.cancelBtn.tag = buttonTitles.count;
        }
        
        CGFloat selfHeight = self.topView.frame.size.height + 8 +_cancelBtn.frame.size.height + 10;
        self.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height, selfWidth, selfHeight);
    }
    return self;

}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [self addSubview:_cancelBtn];
        
        _cancelBtn.layer.cornerRadius = 3;
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        _cancelBtn.titleLabel.font = SheetCancelFont;
        [_cancelBtn setTitleColor:SheetCancelBtnTitleColor forState:UIControlStateNormal];
        
        [_cancelBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc ] initWithFrame:CGRectMake(0, 20, 0, 0)];
        [self.topView addSubview:self.titleLab];
        _titleLab.textColor = SheetTitleColor;
        _titleLab.font = SheetTitleFont;
        _titleLab.numberOfLines = 0;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_topView];
        
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.layer.cornerRadius = 3;
        _topView.layer.masksToBounds = YES;
    }
    return _topView;
}

- (void)buttonClick:(UIButton *)btn {
    
    buttonClickBlock(btn, btn.tag);
    [self dismiss];
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.control];
    [self.control addSubview:self];
    
    CGRect frame = self.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;

    [UIView animateWithDuration:.4f animations:^{
        self.frame = frame;
    }];
    
}

- (void)dismiss {
    
    CGRect frame = self.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height;
    
    [UIView animateWithDuration:.4f animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self.control removeFromSuperview];
        [self removeFromSuperview];
    }];
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
