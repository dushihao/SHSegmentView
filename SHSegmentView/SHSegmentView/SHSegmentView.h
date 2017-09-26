//
//  contentView.h
//  SHSegmentView
//
//  Created by shihao on 2017/9/26.
//  Copyright © 2017年 shihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHSegmentView;

@protocol SHSegmentViewDataSource <NSObject>

@required
/// 获取数据源
- (NSArray<NSString *> *)segmentViewForTitleArray;


@end

@interface SHSegmentView : UIView

@property (nonatomic,weak) id<SHSegmentViewDataSource> dataSource;

/// 标题数组
@property (nonatomic,strong) NSArray *titleArray;
/// 背景色(未选中背景色)
@property (nonatomic,strong) IBInspectable  UIColor * contentColor;
/// 背景标签颜色（未选中文字颜色）
@property (nonatomic,strong) IBInspectable UIColor * placeHolderColor;
/// 标签背景色（选中背景色）
@property (nonatomic,strong) IBInspectable UIColor * labelBackGroudColor;
/// 标签文字颜色（选中文字颜色）
@property (nonatomic,strong) IBInspectable UIColor * labelTitleColor;

/// 当前选中的索引 default = 0
@property (nonatomic,assign) NSInteger seltedIndex;

///  上下间距个5点距离 default = 2 * 5
@property (nonatomic,assign) CGFloat spacing;

@property (nonatomic) void (^handelCompletion)(NSInteger selectIndex);

- (void)reloadData;
@end
