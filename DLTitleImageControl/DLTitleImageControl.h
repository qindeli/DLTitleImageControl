//
//  DLTitleImageButton.h
//  TouGuProject
//
//  Created by dzkj on 2017/10/27.
//  Copyright © 2017年 dzkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLTitleImageControl;

typedef NS_ENUM(NSInteger, DLTitleImageControlType)
{
    DLTitleImageControlTypeLeftImage,//左图标，右文字
    DLTitleImageControlTypeTopImage,//上图标，下文字
    DLTitleImageControlTypeRightImage//右图标，左文字
};

typedef void(^DLTitleImageControlDidClickControlCallBack)(DLTitleImageControl *control);

@interface DLTitleImageControl : UIView

//文字
@property (nonatomic, copy) NSString *title;

//图片
@property (nonatomic, strong) UIImage *image;

//文字颜色
@property (nonatomic, strong) UIColor *titleColor;

//文字大小
@property (nonatomic, strong) UIFont *titleFont;

/*
 imageSize: 图片大小
 midMargin: 图片和文字的距离
 */
- (id)initWithFrame:(CGRect)frame
               type:(DLTitleImageControlType)type
          imageSize:(CGSize)imageSize
          midMargin:(CGFloat)midMargin;

- (void)addTarget:(id)target action:(SEL)action;

- (void)setTitleImageControlDidClickControlCallBack:(DLTitleImageControlDidClickControlCallBack)callback;

@end
