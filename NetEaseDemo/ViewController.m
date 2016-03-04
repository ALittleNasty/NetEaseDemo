//
//  ViewController.m
//  NetEaseDemo
//
//  Created by 胡阳 on 16/2/17.
//  Copyright © 2016年 apple.com. All rights reserved.
//

#import "ViewController.h"
#import "YYContentViewController.h"
#import "YYHomeLabel.h"

static CGFloat const titleLabelWidth = 100.f ;
static CGFloat const titleLabelHeight = 40.f ;

@interface ViewController ()<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContentScrollView];
    
    [self setupTitleScrollView];
    
    // 默认显示第一个标题的内容
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}
/**
 *  设置滚动的标题
 */
- (void)setupTitleScrollView
{
    for (int i = 0 ; i < 7; i++) {
        YYHomeLabel *label = [[YYHomeLabel alloc] init];
        label.text = [self.childViewControllers[i] title];
        label.frame = CGRectMake(i * titleLabelWidth, 0.f, titleLabelWidth, titleLabelHeight) ;
//        label.backgroundColor = [self randomColor];
        label.tag = i ;
        
        if (i == 0) {
            label.scale = 1.0 ;
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelTaped:)];
        [label addGestureRecognizer:tap];
        
        [self.titleScrollView addSubview:label];
    }
    
    self.titleScrollView.contentSize = CGSizeMake(7 * titleLabelWidth, 0) ;
    self.contentScrollView.contentSize = CGSizeMake(7 * [UIScreen mainScreen].bounds.size.width, 0) ;
}
/**
 *  设置标题对应的内容
 */
- (void)setupContentScrollView
{
    YYContentViewController *content0 = [[YYContentViewController alloc] init];
    content0.title = @"国际";
    [self addChildViewController:content0];
    
    YYContentViewController *content1 = [[YYContentViewController alloc] init];
    content1.title = @"政治";
    [self addChildViewController:content1];
    
    YYContentViewController *content2 = [[YYContentViewController alloc] init];
    content2.title = @"军事";
    [self addChildViewController:content2];
    
    YYContentViewController *content3 = [[YYContentViewController alloc] init];
    content3.title = @"经济";
    [self addChildViewController:content3];
    
    YYContentViewController *content4 = [[YYContentViewController alloc] init];
    content4.title = @"科技";
    [self addChildViewController:content4];
    
    YYContentViewController *content5 = [[YYContentViewController alloc] init];
    content5.title = @"体育";
    [self addChildViewController:content5];
    
    YYContentViewController *content6 = [[YYContentViewController alloc] init];
    content6.title = @"娱乐";
    [self addChildViewController:content6];
}
/**
 *  标题点击事件
 */
- (void)titleLabelTaped:(UITapGestureRecognizer *)tap
{
    YYHomeLabel *label = (YYHomeLabel *)tap.view ;
//    NSLog(@"%s,------ %zd",__func__,label.tag);
    
    CGPoint offset  = self.contentScrollView.contentOffset ;
    offset.x = self.contentScrollView.frame.size.width * label.tag ;
    
    [self.contentScrollView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  scrollView 滑动停止后调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width ;
    
    YYHomeLabel *label = self.titleScrollView.subviews[index] ;
    CGPoint offset = self.titleScrollView.contentOffset ;
    offset.x = label.center.x - scrollView.frame.size.width * 0.5 ;
    
    // 处理左边偏移 < 0 的情况
    if (offset.x < 0) {
        offset.x = 0 ;
    }
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width ;
    
    // 处理邮编偏移 > maxOffsetX的情况
    if (offset.x > maxOffsetX) {
        offset.x = maxOffsetX ;
    }
    
    
    for (YYHomeLabel *otherLabel in self.titleScrollView.subviews) {
        if (otherLabel != label) {
            otherLabel.scale = 0.0 ;
        }
    }
    
    [self.titleScrollView setContentOffset:offset animated:YES];
    
    
    UIViewController *willShowVC = self.childViewControllers[index] ;
    
    // 如果view已经被添加到self.contentScrollView 那么就不再重复添加了
    if ([willShowVC isViewLoaded]) return ;
    
    willShowVC.view.frame = CGRectMake(scrollView.contentOffset.x, 0.f, scrollView.frame.size.width, scrollView.frame.size.height);
    [self.contentScrollView addSubview:willShowVC.view];
}
/**
 *  手指拖拽结束后调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}
/**
 *  scrollView 滚动的时候就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = self.contentScrollView.contentOffset.x / self.contentScrollView.frame.size.width ;
    
    if (scale < 0 || scale > self.titleScrollView.subviews.count - 1) {
        return ;
    }
    
    NSInteger leftIndex = scale ;
    
    
    YYHomeLabel *leftLabel = self.titleScrollView.subviews[leftIndex] ;
    
    CGFloat rightScale = scale - (float)leftIndex ;
    CGFloat leftScale = 1.0 - rightScale ;
    
    leftLabel.scale = leftScale ;
    
    // 设置两个label的字体颜色渐变
    
    // 防止数组越界出现的bug
    if (leftIndex > self.titleScrollView.subviews.count - 2) {
        return ;
    }
    
    NSInteger rightIndex = leftIndex + 1 ;
    YYHomeLabel *rightLabel = self.titleScrollView.subviews[rightIndex] ;
    rightLabel.scale = rightScale ;
}

#pragma mark - randomColor

- (UIColor *)randomColor
{
    UIColor *color = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
    return color ;
}

- (void)blocktest
{
    // 直接敲inline就会出现block的快速创建代码
    void(^myBlock)(int a) = ^(int a) {
        NSLog(@" --- %d",a) ;
    };
    
    int (^sumBlock)(int a , int b) = ^(int a , int b) {
        
        
        NSLog(@"sum is %d",a+b ) ;
        
        return a + b ;
    };
    
    myBlock(4) ;
    sumBlock(2, 4);
}

@end
