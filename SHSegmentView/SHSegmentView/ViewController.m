//
//  ViewController.m
//  SHSegmentView
//
//  Created by shihao on 2017/9/26.
//  Copyright © 2017年 shihao. All rights reserved.
//

#import "ViewController.h"
#import "SHSegmentView.h"

@interface ViewController () <SHSegmentViewDataSource>

@property (weak, nonatomic) IBOutlet SHSegmentView *bgView;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.bgView.dataSource = self;
    [self.bgView reloadData];
    self.bgView.handelCompletion = ^(NSInteger selectIndex) {
         NSLog(@"btn.tag == %ld",(long)selectIndex);
    };
}

- (NSArray<NSString *> *)segmentViewForTitleArray{
    return @[@"订单数",@"订单金额",@"测试"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
