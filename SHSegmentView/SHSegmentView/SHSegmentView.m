//
//  contentView.m
//  SHSegmentView
//
//  Created by shihao on 2017/9/26.
//  Copyright © 2017年 shihao. All rights reserved.
//

#import "SHSegmentView.h"

@interface SHSegmentView()

@property (nonatomic) NSMutableArray *defaultButtonArray;
@property (nonatomic) NSMutableArray *buttonArray;
@property (nonatomic) UIView *showView;

@end
@implementation SHSegmentView

#pragma mark - 初始化
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{

    self.seltedIndex = 0;
    self.spacing = 10;
    self.bgBorderColor = [UIColor clearColor];
    self.contentColor = [UIColor redColor];
    self.placeHolderColor = [UIColor whiteColor];
    self.labelBackGroudColor = [UIColor whiteColor];
    self.labelTitleColor = [UIColor redColor];
    
    self.layer.borderColor =  self.bgBorderColor.CGColor ?:self.contentColor.CGColor;
    self.layer.borderWidth = 0.618;
    
    self.titleArray = [NSArray array];
    self.buttonArray = [NSMutableArray arrayWithCapacity:self.titleArray.count];
    self.defaultButtonArray = [NSMutableArray arrayWithCapacity:self.titleArray.count];
    
}

#pragma mark - Convince
- (void)configureDefultButton{
    
    [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = self.contentColor;
        [btn setTitleColor:self.placeHolderColor forState:UIControlStateNormal];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont fontWithName:@".SFUIText-Semibold" size:17]];
        [self.defaultButtonArray addObject: btn];
        [self addSubview:btn];
    }];
}

- (void)configureShowButtonView{
    
    UIView *showView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:showView];
    self.showView = showView;
    
    [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = self.labelBackGroudColor;
        [btn setTitleColor:self.labelTitleColor forState:UIControlStateNormal];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont fontWithName:@".SFUIText-Semibold" size:17]];
        btn.tag = idx;
        [self.buttonArray addObject:btn];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [showView addSubview:btn];
    }];
}

- (void)configureMaskView{
   
    UIView *maskView = [[UIView alloc]init];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.layer.cornerRadius = 17;
    maskView.layer.masksToBounds = YES;
    self.showView.maskView = maskView;
}

- (void)reloadData{

    self.titleArray = [self.dataSource segmentViewForTitleArray];
    // 底层 placeHolder button
    [self configureDefultButton];
    // 显示层view
    [self configureShowButtonView];
    // 遮罩层
    [self configureMaskView];
}

#pragma mark - Layout

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat itemWidth = CGRectGetWidth(self.bounds) / self.titleArray.count;
    
    NSArray *tempArray = @[self.defaultButtonArray,self.buttonArray];
    for (NSArray<UIButton *> *array in tempArray) {
        
        [array enumerateObjectsUsingBlock:^(UIButton  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CGFloat originX = itemWidth * idx;
            obj.frame = CGRectMake(originX, 0, itemWidth, CGRectGetHeight(self.bounds));
        }];
    }
    
    self.showView.maskView.bounds = CGRectMake(0, 0, itemWidth-_spacing, 44-_spacing);
    self.showView.maskView.center = CGPointMake(itemWidth/2 + itemWidth * self.seltedIndex, 22);
}


#pragma mark - Button click
- (void)buttonClick:(UIButton *)btn{
    
    self.seltedIndex = btn.tag;
    !self.handelCompletion ?: self.handelCompletion(btn.tag);
    CGFloat itemWidth = CGRectGetWidth(self.bounds) / self.titleArray.count;
    NSString *seletedTitle = self.titleArray[_seltedIndex];
    CGFloat seletedTitleWidth = [seletedTitle sizeWithAttributes:@{
                                                                   NSFontAttributeName:btn.titleLabel.font,
                                                                   }].width;
    
    CGFloat boundsWidth = itemWidth > seletedTitleWidth + 10 ? itemWidth : seletedTitleWidth + 20;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.showView.maskView.bounds = CGRectMake(0, 0, boundsWidth- _spacing, 44-_spacing);
        self.showView.maskView.center = CGPointMake(itemWidth/2 + itemWidth * self.seltedIndex, 22);
    }];
}

#pragma mark - setter
- (void)setBgBorderColor:(UIColor *)bgBorderColor{
    _bgBorderColor = bgBorderColor;
    self.layer.borderColor =  bgBorderColor.CGColor;
}

- (void)setContentColor:(UIColor *)contentColor{
    _contentColor = contentColor;
    self.backgroundColor = contentColor;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor = placeHolderColor;
    for (UIButton * btn in self.defaultButtonArray) {
        [btn setTitleColor:placeHolderColor forState:UIControlStateNormal];
    }
}

- (void)setLabelBackGroudColor:(UIColor *)labelBackGroudColor{
    _labelBackGroudColor = labelBackGroudColor;
    for (UIButton *btn in self.buttonArray) {
        [btn setBackgroundColor:labelBackGroudColor];
    }
}

- (void)setLabelTitleColor:(UIColor *)labelTitleColor{
    _labelTitleColor = labelTitleColor;
    for (UIButton *btn in self.buttonArray) {
        [btn setTitleColor:labelTitleColor forState:UIControlStateNormal];
    }
}

@end
