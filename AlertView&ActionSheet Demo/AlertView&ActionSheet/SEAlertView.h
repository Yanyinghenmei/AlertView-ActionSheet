//
//  SEAlertView.h
//  SpeakEnglish
//
//  Created by Daniel on 16/4/12.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertButtonClickBlock)( UIButton * _Nullable btn);

#define AlertTitleColor [UIColor blackColor]
#define AlertBtnTitleColor [UIColor whiteColor]
#define AlertBtnBackgroundColor [UIColor cyanColor]

#define AlertTitleFont [UIFont systemFontOfSize:15]
#define AlertBtnFont [UIFont systemFontOfSize:14]

@interface SEAlertView : UIView

- (void)show;
- (void)dismiss;

- (nullable instancetype)initWithTitle:(nullable NSString *)title
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
              sureButtonTitle:(nullable NSString *)sureButtonTitle
             buttonClickBlock:(nullable AlertButtonClickBlock)block;

@end

/*
示意图:
 
 ----------------------------
              title
   cancelButton | sureButton
 ----------------------------
 
 */