//
//  DLTitleImageButton.m
//  TouGuProject
//
//  Created by dzkj on 2017/10/27.
//  Copyright © 2017年 dzkj. All rights reserved.
//

#import "DLTitleImageControl.h"

@interface DLTitleImageControl()
{
    UIButton *_contentButton;
    
    DLTitleImageControlType _type;
    CGSize _imageSize;
    CGFloat _midMargin;
    
    id _target;
    SEL _action;
    
    DLTitleImageControlDidClickControlCallBack _clickControlCallBack;
}

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation DLTitleImageControl

- (id)initWithFrame:(CGRect)frame
               type:(DLTitleImageControlType)type
          imageSize:(CGSize)imageSize
          midMargin:(CGFloat)midMargin
{
    if (self = [super initWithFrame:frame])
    {
        _type = type;
        _imageSize = imageSize;
        _midMargin = midMargin;
        
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_contentButton addTarget:self action:@selector(contentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_contentButton];
    [_contentButton addSubview:self.imageView];
    [_contentButton addSubview:self.titleLabel];
    
    NSTextAlignment alignment;
    
    //左图标，右文字
    if (_type == DLTitleImageControlTypeLeftImage)
    {
        alignment = NSTextAlignmentLeft;
    }
    //上图标，下文字
    else if (_type == DLTitleImageControlTypeTopImage)
    {
        alignment = NSTextAlignmentCenter;
    }
    //右图标，左文字
    else
    {
         alignment = NSTextAlignmentRight;
    }
    
    self.titleLabel.textAlignment = alignment;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _contentButton.frame = self.bounds;
    
    CGRect titleFrame = CGRectZero;
    CGRect imageFrame = CGRectZero;
    CGFloat titleWidth = [self titleWidth];
    CGFloat tWidth = _imageSize.width + titleWidth + _midMargin;

    //左图标，右文字
    if (_type == DLTitleImageControlTypeLeftImage)
    {
        imageFrame = CGRectMake((self.frame.size.width - tWidth) * 0.5, (self.frame.size.height - _imageSize.height) * 0.5, _imageSize.width , _imageSize.height);
        titleFrame = CGRectMake(CGRectGetMaxX(imageFrame) + _midMargin, 0, titleWidth, self.frame.size.height);
    }
    //上图标，下文字
    else if (_type == DLTitleImageControlTypeTopImage)
    {
        imageFrame = CGRectMake((self.frame.size.width - _imageSize.width) * 0.5, self.frame.size.height * 0.5 - _imageSize.height - _midMargin * 0.5, _imageSize.width, _imageSize.height);
        titleFrame = CGRectMake(0, CGRectGetMaxY(imageFrame) + _midMargin, self.frame.size.width, self.frame.size.height * 0.5 - _midMargin * 0.5);
    }
    //右图标，左文字
    else
    {
        titleFrame = CGRectMake((self.frame.size.width - tWidth) * 0.5, 0, titleWidth, self.frame.size.height);
        imageFrame = CGRectMake(CGRectGetMaxX(titleFrame) + _midMargin, self.frame.size.height * 0.5 - _imageSize.height * 0.5, _imageSize.width, _imageSize.height);
        
    }
    
    self.imageView.frame = imageFrame;
    self.titleLabel.frame = titleFrame;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
    
    [self layoutSubviews];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    self.titleLabel.textColor = titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    
    self.titleLabel.font = titleFont;
    
    [self layoutSubviews];
}

- (void)setTitleImageControlDidClickControlCallBack:(DLTitleImageControlDidClickControlCallBack)callback
{
    _clickControlCallBack = callback;
}

#pragma mark - Event Handle
- (void)addTarget:(id)target action:(SEL)action
{
    _target = target;
    _action = action;
}

- (void)contentButtonClick
{
    if (_target && _action)
    {
        id obj = self;
    
        NSMethodSignature *signature = [[_target class] instanceMethodSignatureForSelector:_action];
        NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = _target;
        invocation.selector = _action;
        
        if ([self isHaveParams])
        {
            [invocation setArgument:&obj atIndex:2];
        }
        
        [invocation invoke];
    }
    
    if (_clickControlCallBack)
    {
        _clickControlCallBack(self);
    }
}

- (BOOL)isHaveParams
{
    const char *selectorName = sel_getName(_action);
    
    NSString *actionName = [NSString stringWithUTF8String:selectorName];
    
    if ([actionName rangeOfString:@":"].location != NSNotFound)
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - Getter
- (CGFloat)titleWidth
{
    return [self.titleLabel.text boundingRectWithSize:CGSizeMake(10000, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLabel.font} context:nil].size.width;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
    }
    
    return _titleLabel;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
    }
    
    return _imageView;
}

@end
