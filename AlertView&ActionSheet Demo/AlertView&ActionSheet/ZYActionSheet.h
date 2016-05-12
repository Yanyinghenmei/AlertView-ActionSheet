//
//  ZYActionSheet.h
//  SpeakEnglish
//
//  Created by Daniel on 16/4/13.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

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