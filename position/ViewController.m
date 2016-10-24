//
//  ViewController.m
//  position
//
//  Created by bbsun on 16/10/21.
//  Copyright © 2016年 bbsun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>{
    UIScrollView *MyScrollView;
    NSArray *arrayOfImageView;
    UIPageControl *pageController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 200)];
    MyScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    MyScrollView.showsVerticalScrollIndicator = NO;
    MyScrollView.showsHorizontalScrollIndicator =NO;
    MyScrollView.pagingEnabled=YES;
    MyScrollView.delegate=self;
    MyScrollView.contentSize=CGSizeMake(3*MyScrollView.frame.size.width, 200);
    [self.view addSubview:MyScrollView];
    
    arrayOfImageView=@[@"1",@"2",@"3"];
    for (int i=0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:arrayOfImageView[i]]];
        imageView.frame = CGRectMake(MyScrollView.frame.size.width * i, 0, MyScrollView.frame.size.width, MyScrollView.frame.size.height);
        imageView.userInteractionEnabled = YES;
        [MyScrollView addSubview:imageView];
    }
    
    pageController=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 180, 100, 10)];
    pageController.center=CGPointMake(self.view.frame.size.width/2, 180);
    pageController.numberOfPages=arrayOfImageView.count;
    [self.view addSubview:pageController];
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
}

-(void)runTimePage{
    NSInteger page = pageController.currentPage;
    page++;
    page = page > 2 ? 0 : page ;
    pageController.currentPage = page;
    [self changePage];
}

-(void)changePage{
    NSInteger page = pageController.currentPage;
    [MyScrollView scrollRectToVisible:CGRectMake((MyScrollView.frame.size.width * page + 1), 0, MyScrollView.frame.size.width, 200) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    pageController.currentPage=scrollView.contentOffset.x/scrollView.frame.size.width;
    if (pageController.currentPage==3) {
        [pageController removeFromSuperview];
        [scrollView removeFromSuperview];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
