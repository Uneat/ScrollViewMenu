//
//  CustomViewController.m
//  CustomScrollViewMenu
//
//  Created by Orient on 2018/1/26.
//  Copyright © 2018年 Orient. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController () <UIScrollViewDelegate>
@property (nonatomic, weak)UIScrollView * scrollView;
@property (nonatomic, weak)UIView * titleView;
@property (nonatomic, strong)UIView * titleBottomView;
@property (nonatomic, assign)NSInteger number;
@property (nonatomic, weak)UIButton * selectBtn;
@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    self.number = 5;
    [self addTitlesMenuView];
    [self createScrollView];
    [self addViewsInTheRollingView:self.number];
}
- (void)addTitlesMenuView{
    NSInteger margin = 10;
    NSInteger btnW = (SCREEN_WIDTH - margin * (self.number+1)) / self.number;
    NSInteger btnH = 40;
    NSInteger bottomViewH = 4;
    
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
    [titleView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:titleView];
    
    for (NSInteger i=0; i<self.number; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(margin + (btnW + margin) * i, 0, btnW, btnH)];
        [button setTitle:[NSString stringWithFormat:@"第%ld页",(long)i+1] forState:UIControlStateNormal];
        [button setTag:2000+i];
//        [button setBackgroundColor:[UIColor cyanColor]];
        [button addTarget:self action:@selector(titleViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
    }
    
    UIView * titleBottomView =[[UIView alloc]initWithFrame:CGRectMake(margin, btnH, btnW, bottomViewH)];
    titleBottomView.layer.cornerRadius = 2;
    self.titleBottomView = titleBottomView;

    self.titleBottomView.backgroundColor = [UIColor redColor];
    [titleView addSubview:self.titleBottomView];
    self.titleView = titleView;
   
    [self.view addSubview:self.titleView];
}

- (void)createScrollView{
    NSInteger scrollViewMarginY = 108;
    NSInteger titleViewH = 44;
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollViewMarginY, SCREEN_WIDTH, SCREEN_HEIGHT - titleViewH)];
    [scrollView setBackgroundColor:[UIColor grayColor]];
    scrollView.contentSize = CGSizeMake(self.number * SCREEN_WIDTH, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    [self.view addSubview:self.scrollView];
}

- (void)addViewsInTheRollingView:(NSInteger)count{

    for (NSInteger i=0; i<count; i++) {
            NSLog(@"add %ld",(long)SCREEN_WIDTH);
        int R = (arc4random() % 256);
        int G = (arc4random() % 256);
        int B = (arc4random() % 256);
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0 + i * SCREEN_WIDTH , 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
        [view setTag:1000+i];
        [view setBackgroundColor:[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
        [label setText:[NSString stringWithFormat:@"第%ld页",(long)(i+1)]];
        [self.scrollView addSubview:view];
         [view addSubview:label];
        

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"1");
//}
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
//    NSLog(@"2");
//}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"开始拖动");
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"拖动结束 %ld",(long)targetContentOffset);
    
    
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"滚动视图拖动确定结束");
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"减速");
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"减速结束 %f",(long)scrollView.contentOffset.x/scrollView.bounds.size.width);
    NSInteger count = (long)scrollView.contentOffset.x/scrollView.bounds.size.width;
    [self titleViewClick:self.titleView.subviews[count]];
}

- (void)titleViewClick:(UIButton *)button{
    self.selectBtn.enabled = YES;
    button.enabled = NO;
    self.selectBtn = button;
    CGPoint center = self.titleBottomView.center;
    center.x = button.center.x;
    
    CGRect frame =  self.titleBottomView.frame;
    frame.size = CGSizeMake(button.frame.size.width, 4);
    [UIView animateWithDuration:0.1f animations:^{
        self.titleBottomView.frame = frame;
        self.titleBottomView.center = center;
    }];
    CGPoint contentOffset = self.scrollView.contentOffset;
    contentOffset.x = (button.tag-2000) * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:contentOffset animated:YES];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"8");
}

//- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
//    NSLog(@"123");
//}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view{
    NSLog(@"9");
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    NSLog(@"0");
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    NSLog(@"a");
    return YES;
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    NSLog(@"b");
}
- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView {
    NSLog(@"c");
}

@end
