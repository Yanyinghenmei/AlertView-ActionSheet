//
//  SEAlertView.h
//  SpeakEnglish
//
//  Created by Daniel on 16/4/12.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickBlock)( UIButton * _Nullable btn);

@interface SEAlertView : UIView

- (void)show;
- (void)dismiss;

- (nullable instancetype)initWithWidth:(CGFloat)width
                                 Title:(nullable NSString *)title
                               message:(nullable NSString *)message
                     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                       sureButtonTitle:(nullable NSString *)sureButtonTitle
                      buttonClickBlock:(nullable ButtonClickBlock)block;

@end

/*
示意图:
 
 ----------------------------
              title
             message
   cancelButton | sureButton
 ----------------------------
 
 */