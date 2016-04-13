//
//  ZYActionSheet.h
//  SpeakEnglish
//
//  Created by Daniel on 16/4/13.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SheetTitleColor [UIColor blackColor]
#define SheetBtnTitleSlecetedColor [UIColor cyanColor]
#define SheetBtnTitleNormalColor [UIColor lightGrayColor]
#define SheetCancelBtnTitleColor [UIColor blackColor] 
#define SheetLineColor [UIColor lightGrayColor]

#define SheetTitleFont [UIFont systemFontOfSize:18]
#define SheetBtnFont [UIFont systemFontOfSize:15]
#define SheetCancelFont [UIFont systemFontOfSize:15]

typedef void(^SheetButtonClickBlock)(UIButton * _Nullable  btn, NSInteger index);

@interface ZYActionSheet : UIView

- (void)show;
- (void)dismiss;

- (nullable instancetype)initWithSelectedIndex:(NSInteger)index
                                         title:(nullable NSString *)title
                                  buttonTitles:(nullable NSArray *)buttonTitles
                             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                              buttonClickBlock:(nullable SheetButtonClickBlock)block;

@end

/*
 ---------------
      title
      ------
    buttonTitle
       ...
      ------
    cancelTitle
 ---------------
 */