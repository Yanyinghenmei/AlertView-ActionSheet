//
//  ViewController.m
//  AlertView&ActionSheet Demo
//
//  Created by Daniel on 16/4/13.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "ZYHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *sheetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 100, 100)];
    sheetBtn.backgroundColor = [UIColor orangeColor];
    [sheetBtn setTitle:@"sheet" forState:UIControlStateNormal];
    [self.view addSubview:sheetBtn];
    [sheetBtn addTarget:self action:@selector(sheetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *alertBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    alertBtn.backgroundColor = [UIColor orangeColor];
    [alertBtn setTitle:@"alert" forState:UIControlStateNormal];
    [self.view addSubview:alertBtn];
    [alertBtn addTarget:self action:@selector(alertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sheetBtnClick:(id)sender {
    ZYActionSheet *sheet = [[ZYActionSheet alloc]
                            initWithSelectedIndex:0 title:@"title"
                            buttonTitles:@[@"button1", @"button2", @"button3"]
                            cancelButtonTitle:@"cancel"
                            buttonClickBlock:^(UIButton * _Nullable btn, NSInteger index) {
                                
        NSLog(@"sheet-- %ld", index);
    }];
    [sheet show];
}

- (void)alertBtnClick:(id)sender {
    
    ZYAlertView *alert = [[ZYAlertView alloc] initWithWidth:0 Title:@"title" message:@"this text is message" cancelButtonTitle:@"取消" sureButtonTitle:@"确定" buttonClickBlock:^(UIButton * _Nullable btn) {
        
    }];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
