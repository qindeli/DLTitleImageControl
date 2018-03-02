//
//  ViewController.m
//  DLTitleImageControlDemo
//
//  Created by dzkj on 2018/3/1.
//  Copyright © 2018年 dzkj. All rights reserved.
//

#import "ViewController.h"
#import "DLTitleImageControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //图片在左，文字在右
    {
        DLTitleImageControl *control = [[DLTitleImageControl alloc] initWithFrame:CGRectMake(20, 30, 100, 40) type:DLTitleImageControlTypeLeftImage imageSize:CGSizeMake(30, 30) midMargin:5];//图片大小是30X30  图片和文字间距是5
        control.title = @"按钮";
        control.image = [UIImage imageNamed:@"account_icon"];
        control.backgroundColor = [UIColor redColor];
        control.titleColor = [UIColor whiteColor];
        control.layer.cornerRadius = 5;
        control.layer.masksToBounds = YES;
        [control addTarget:self action:@selector(controlClick:)];
        [self.view addSubview:control];
    }
    
    
    //图片在上，文字在下
    {
        DLTitleImageControl *control = [[DLTitleImageControl alloc] initWithFrame:CGRectMake(20, 80, 100, 70) type:DLTitleImageControlTypeTopImage imageSize:CGSizeMake(30, 30) midMargin:0];
        control.title = @"按钮";
        control.image = [UIImage imageNamed:@"password_icon"];
        control.backgroundColor = [UIColor redColor];
        control.titleColor = [UIColor whiteColor];
        control.titleFont = [UIFont systemFontOfSize:15];
        control.layer.cornerRadius = 5;
        control.layer.masksToBounds = YES;
        [control setTitleImageControlDidClickControlCallBack:^(DLTitleImageControl *control)
        {
            NSLog(@"按钮点击了");
        }];
        [self.view addSubview:control];
    }
    
    //图片在右，文字在左
    {
        DLTitleImageControl *control = [[DLTitleImageControl alloc] initWithFrame:CGRectMake(20, 180, 100, 40) type:DLTitleImageControlTypeRightImage imageSize:CGSizeMake(20, 20) midMargin:5];
        control.title = @"按钮";
        control.image = [UIImage imageNamed:@"password_icon"];
        control.backgroundColor = [UIColor redColor];
        control.titleColor = [UIColor whiteColor];
        control.titleFont = [UIFont systemFontOfSize:15];
        [control addTarget:self action:@selector(controlClick:)];
        control.layer.cornerRadius = 5;
        control.layer.masksToBounds = YES;
        [self.view addSubview:control];
    }
    
}

- (void)controlClick:(DLTitleImageControl *)control
{
    NSLog(@"按钮点击了");
}

@end
