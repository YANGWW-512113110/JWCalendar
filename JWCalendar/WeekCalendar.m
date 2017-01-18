//
//  WeekCalendar.m
//  Quick_start
//
//  Created by administrator on 29/12/2016.
//  Copyright © 2016 YANGWW. All rights reserved.
//

/// collection的总页数
#define totalPageNumber 3000

#import "WeekCalendar.h"

#define collectionReuseIdentifier @"collectionReuseIdentifier"

@interface WeekCalendar()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WeekViewDelegate>

@property (weak,nonatomic) UIScrollView *scrollView;

@property (weak, nonatomic) UICollectionView *collectionView;

/// collectionView默认的索引页，此页显示的是当前月
@property (assign,nonatomic) NSInteger defaultIndex;

@end

@implementation WeekCalendar

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initUI];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initUI];
    }
    
    return self;
}

- (void)initUI{
    
    // 1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = self.bounds.size;
    
    layout.minimumLineSpacing = 0;
    
    // collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    
    // 2.初始化collectionView
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 设置contentview相对于scrollView位置
    collectionView.contentInset = UIEdgeInsetsZero;
    
    collectionView.pagingEnabled = YES;
    
    collectionView.showsHorizontalScrollIndicator = NO;
    
    
    // 3.注册collectionViewCell
    [collectionView registerClass:[WeekView class] forCellWithReuseIdentifier:collectionReuseIdentifier];
    
    
    // 4.设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    self.defaultIndex = totalPageNumber/2;
    
    // 滚动到指定页
    [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:totalPageNumber/2 inSection:0]  atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];


}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return totalPageNumber;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WeekView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionReuseIdentifier forIndexPath:indexPath];
    cell.config = self.config;
    cell.needMarketDate = self.needMarketDate;
    cell.delegate = self;
    
    if(_startDate){
        NSDate *date = [_startDate additionDay:7*(indexPath.row - self.defaultIndex)];
        cell.startDate = date;
    }
    
    return cell;
}

-(void)setStartDate:(NSDate *)startDate{

    _startDate = startDate;

    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:totalPageNumber/2 inSection:0]  atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    [self.collectionView reloadData];
 
}


#pragma mark - <UIScrollViewDelegate>

/// 滚动完毕调用 - 非人为拖拽scrollView导致的滚动完毕
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

/// 滚动完毕调用 - 人为拖拽scrollView导致的滚动完毕
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 将collectionView在控制器view的中心点转化成collectionView上的坐标
    CGPoint pInView = [self convertPoint:self.collectionView.center toView:self.collectionView];
    
    // 获取这一点的indexPath
    NSIndexPath *indexPathNow = [self.collectionView indexPathForItemAtPoint:pInView];
    
    WeekView *week = (WeekView *)[self.collectionView cellForItemAtIndexPath:indexPathNow];
    
    NSDate *date = week.today?week.today:week.startDate;
    
    if([self.delegate respondsToSelector:@selector(weekCalendarEndDecelerating:todayOrStartDate:)]){
        [self.delegate weekCalendarEndDecelerating:self todayOrStartDate:date];
    }
    
}


#pragma mark WeekViewDelegate

-(void)weekViewClickWithDate:(NSDate *)date{

    if([self.delegate respondsToSelector:@selector(weekCalendar:didSelectDate:)]){
        [self.delegate weekCalendar:self didSelectDate:date];
    }
}


-(void)setNeedMarketDate:(NSMutableSet<NSString *> *)needMarketDate{

    _needMarketDate = needMarketDate;
    
    // 动态变更标记
    


}


@end
