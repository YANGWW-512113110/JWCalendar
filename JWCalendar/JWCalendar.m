//
//  JWCalendar.m
//  Quick_start
//
//  Created by administrator on 28/12/2016.
//  Copyright © 2016 YANGWW. All rights reserved.
//

/// 使用UICollection不好控件：
/*
 1. 变更UICollectionView高度时会闪下，从网上查知reloadCollectionView会导致UICollectionView闪，但此处并未reload，只是通过约束变更高度而已
 2. 旋转屏幕时页数发生偏移，需要重新调整
 3. 使用UICollectionView的cell作为日历的每一天时，出现性能问题，时而有卡顿现象
 
 总结：UICollectionView不好控制，虽然自带重用机制；
 
 */

#import "JWCalendar.h"

/// collection的总页数
#define totalPageNumber 3000

@interface JWCalendar()<UIScrollViewDelegate,MonthViewDelegate,WeekCalendarDelegate>

@property (weak,nonatomic) UIScrollView *scrollView;

@property (strong,nonatomic) NSMutableArray<MonthView *> *monthArray;


@property (weak,nonatomic) WeekBarView *weekBar;

@property (weak,nonatomic) WeekCalendar *weekCalendar;

/// JWCalendar初始frame，用于钉住JWCalendar；
@property (assign,nonatomic) CGRect initFrame;

/// 最后一次滑动时的偏移
@property (assign,nonatomic) CGFloat lastScrollPoint;

/// 即将停止的位置；
@property (assign,nonatomic) CGFloat willStopScrollPoint;

/// 屏幕方向是否发生变化
@property (assign,nonatomic) BOOL isStatusBarOrientationChange;

/// scrollview项部约束,用于上称scrollView
@property (weak,nonatomic) NSLayoutConstraint *scrollViewTopConstraint;

/// 若weekBarFollowSlide为NO时，上、下滑动时需要有一行日期被钉住；设置pegDate后，pegDate所在的行会被钉住；pegDate默认为今天或当前月第一天；
@property (strong,nonatomic) NSDate *pegDate;

/// 被钉住日期在日历中所在的行数
@property (assign,nonatomic) NSInteger pegDateRow;

/// 外部UIScrollView的初始偏移值
@property (assign,nonatomic) CGFloat externalScrollViewInitOffset;

@end

@implementation JWCalendar


#pragma mark initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self initUI];
        
        [self setupDefaultValues];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initUI];
        
        [self setupDefaultValues];
    }
    
    return self;
}

- (void)initUI{
    
    self.clipsToBounds = YES;    
    self.isStatusBarOrientationChange = NO;
    self.willStopScrollPoint = 0.0;
    self.backgroundColor = [UIColor clearColor];
    self.monthArray = [NSMutableArray array];


    /// 创建scrollview
    UIScrollView *scrollView = [[UIScrollView alloc] init];
//    scrollView.backgroundColor = [UIColor redColor];
    scrollView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *h_constaint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|" options:0 metrics:nil views:@{@"scrollView":scrollView}];
    NSArray *v_constaint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scrollView]-0-|" options:0 metrics:nil views:@{@"scrollView":scrollView}];
    
    self.scrollViewTopConstraint = v_constaint[0];
    [self addConstraints:h_constaint];
    [self addConstraints:v_constaint];
   
}



- (void)setupDefaultValues{

    self.weekBarFollowSlide = YES;
    
    _otherConfig = [[JWCalendarConfig alloc] init];
    
    // 监听状态栏的方向；即，布局转了，才会接到这个通知，而不是设备旋转的通知。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:)name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    

    /// 周bar中的字体颜色
    self.otherConfig.weekFontColor = [UIColor colorWithRed:0.1333 green:0.4824 blue:0.8118 alpha:1.0];

    /// 周bar中的字体
    self.otherConfig.weekFont = [UIFont systemFontOfSize:13.0f];
    
    /// 周bar的背景色
    self.otherConfig.weekBackgroundColor = [UIColor colorWithRed:0.9686 green:0.9686 blue:0.9686 alpha:1.0];
    
    /// 周bar中分隔线的颜色
    self.otherConfig.weekLineBetweenColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
    
    
    
    /// 日历中的字体颜色
    self.otherConfig.calendarFontColor =  [UIColor colorWithWhite:0.5059 alpha:1.0];
    
    /// 日历中的字体
    self.otherConfig.calendarFont = [UIFont systemFontOfSize:16.0f];
    
    /// 日历的背景色
    self.otherConfig.calendarBackgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    /// 日历中分隔线的颜色
    self.otherConfig.calendarLineBetweenColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
    
    
    
    /// 选中状态下的日历中字体颜色
    self.otherConfig.calendarFontColorForSelected = [UIColor whiteColor];
    
    /// 选中状态下的日历中字体
    self.otherConfig.calendarFontForSelected = [UIFont systemFontOfSize:16.0f];;
    
    /// 选中状态下的日历背景色
    self.otherConfig.calendarBackgroundColorForSelected = [UIColor colorWithRed:0.1922 green:0.6078 blue:1.0 alpha:1.0];
    
    
    /// 禁用状态下的日历中字体颜色
    self.otherConfig.calendarFontColorForDisable = [UIColor colorWithWhite:0.800 alpha:1.000];
    
    /// 禁用状态下的日历中字体
    self.otherConfig.calendarFontForDisable = [UIFont systemFontOfSize:16.0f];;
    
    /// 禁用状态下的日历背景色
    self.otherConfig.calendarBackgroundColorForDisable = [UIColor whiteColor];;
    
    
    /// 日历中"今天"字体颜色
    self.otherConfig.calendarFontColorForToday = [UIColor redColor];
    
    
    
    
    #pragma mark 间距配置
    
    /// Day View的宽高比
    self.otherConfig.dayViewRate = 1.0;
    
    /// 列间距，默认
    self.otherConfig.columnSpacing = 0.5;
    
    /// 行间距，默认
    self.otherConfig.rowSpacing = 0.5;
    
    /// 周bar中的每个子view的宽高比;周bar中共有7个子view分别表示周一到周日
    self.otherConfig.weekViewRate = 1.0;
    
    // 周bar中子view的水平间距
    self.otherConfig.horizontalSpacingInWeekBar = 0.5;
    
    // 周bar和日历的间距
    self.otherConfig.weekBarAndCalendarSpacing = 0.0;
    
    // 周bar前、后间距
    self.otherConfig.weekBarFrontAndBackMargin = 1.0;
    
    // 周bar底部边线的宽度
    self.otherConfig.weekBarBottomLineWidth = 0.5;
    
    // month view之间的间距
    self.otherConfig.monthCalendarSpacing = 1.0;
    
    // 底部边距
    self.otherConfig.bottomMargin = 1.0;
    
    
}

/// 计算DayView尺寸、计算周bar高度
-(void)calculateDayViewSize{

    // 列间距总宽
    CGFloat totalColumnSpacing = (7 - 1) * self.otherConfig.columnSpacing;
    
    // DayView的大小
    CGFloat dayViewWidth = (self.width - totalColumnSpacing - self.otherConfig.monthCalendarSpacing) / 7.0;
    CGFloat dayViewHeight = dayViewWidth/self.otherConfig.dayViewRate;
    
    self.otherConfig.dayViewSize = CGSizeMake(dayViewWidth,dayViewHeight);
    
    // 周bar
    CGFloat weekHoriziontlColumnSpacing = (7 - 1) * self.otherConfig.horizontalSpacingInWeekBar;
    CGFloat weekSubviewWidth = (self.width - weekHoriziontlColumnSpacing - self.otherConfig.weekBarFrontAndBackMargin * 2) / 7.0;
    CGFloat weekSubviewHeight = weekSubviewWidth/self.otherConfig.weekViewRate;
    
    self.otherConfig.weekBarHeigth = weekSubviewHeight;
    
}

// 初始显示界面
-(void)initShow{
    
    [self scrollViewDidEndDecelerating:self.scrollView];
  
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    if([self.scrollView subviews].count > 0){
        
        // 屏幕方向发生变化时
        if(self.isStatusBarOrientationChange){
            self.isStatusBarOrientationChange = NO;
            [self calculateDayViewSize];
            [self updateLayout];
            
            self.initFrame = self.frame;
        }

        return;
    }
   
    [self calculateDayViewSize];
    
    // 创建 Month view
    CGFloat baseOffset = (totalPageNumber/2 - 1)*self.width;
    
    NSInteger i=0;
    [self.monthArray removeAllObjects];
    NSDate *currentDate = [NSDate currentDate];
    for(;i<3;i++){
        
        MonthView *view = [[MonthView alloc] initWithFrame:CGRectMake(i*self.width + baseOffset,0,self.width, self.height)];
        
        view.delegate = self;
        view.config = self.otherConfig;
        view.date = [currentDate additionMonth:i-1];
        
        [self.scrollView addSubview:view];
        [self.monthArray addObject:view];
    }
    
    [self.scrollView setContentSize:CGSizeMake(totalPageNumber*self.width,self.scrollView.height)];
    [self.scrollView setContentOffset:CGPointMake((totalPageNumber*self.width)/2,0) animated:NO];
    self.lastScrollPoint = self.scrollView.contentOffset.x;
    
    // 创建 Week view
    WeekBarView *weekBar = [[WeekBarView alloc] initWithFrame:CGRectMake((totalPageNumber*self.width)/2, 0,self.width,self.otherConfig.weekBarHeigth)];
    weekBar.config = self.otherConfig;
    [self.scrollView addSubview:weekBar];
    self.weekBar = weekBar;
    
    // 创建周日历
    if(!self.weekBarFollowSlide){
        CGFloat y = weekBar.y + self.otherConfig.weekBarHeigth + self.otherConfig.weekBarAndCalendarSpacing;
        WeekCalendar *weekCalendar = [[WeekCalendar alloc] initWithFrame:CGRectMake(weekBar.x,y,self.width,self.otherConfig.dayViewSize.height + self.otherConfig.rowSpacing)];
        weekCalendar.config = self.otherConfig;
        weekCalendar.hidden = YES;
        weekCalendar.delegate = self;
        
        [self.scrollView addSubview:weekCalendar];
        self.weekCalendar = weekCalendar;
    }
    
    
    [self initShow];
}

-(void)setDelegate:(id<JWCalendarDelegate>)delegate{

    _delegate = delegate;
    
    if(delegate){
        
        UIViewController *vc = (UIViewController *)delegate;
        
        // 外部VC的edgesForExtendedLayout属性设置直接影响日历控件的上、下偏移是否正确执行；
        // 因为edgesForExtendedLayout中包含UIRectEdgeTop时，VC中的UIScrollView偏移自动被系统置为-64；
        
        // 根据外部VC的edgesForExtendedLayout来设置日历控件上、下偏移的基准
        if(vc.edgesForExtendedLayout && UIRectEdgeTop){
            self.externalScrollViewInitOffset = -64;
        }else{
            self.externalScrollViewInitOffset = 0;
        }
    
    }

}

#pragma mark self.scrollView代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    self.weekBar.x = scrollView.contentOffset.x;
    self.weekCalendar.x = scrollView.contentOffset.x;
    
    // scrollview复用
    if (scrollView.contentOffset.x - self.lastScrollPoint > 0) { // 左滑
        
        MonthView *month = [self.monthArray firstObject];
        
        if((scrollView.contentOffset.x - month.x) > 1.5*scrollView.width){
            
            month.x += month.width*self.monthArray.count;
            [self.monthArray removeObjectAtIndex:0];
            
            month.date = [self.monthArray.lastObject.date additionMonth:1];
            
            [self.monthArray addObject:month];
            
        }
        
    }else if(scrollView.contentOffset.x - self.lastScrollPoint < 0){ // 右滑
        
        MonthView *month = [self.monthArray lastObject];
        if((month.x - scrollView.contentOffset.x) > 1.5*scrollView.width){
            
            month.x -= month.width*self.monthArray.count;
            [self.monthArray removeLastObject];
            month.date = [[self.monthArray firstObject].date additionMonth:-1];
            
            [self.monthArray insertObject:month atIndex:0];
        }
        
        
    }
    
    self.lastScrollPoint = scrollView.contentOffset.x;

}


// 月日历减速停止后调用 - 非人为触发
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndDecelerating:scrollView];
    
}

// 月日历减速停止后调用 - 人为拖动触发
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(self.monthArray && [self.monthArray count] == 0){
        return;
    }
    
    MonthView *monthView = self.monthArray[1];
    
    NSDate *date = monthView.date;
    
    CGFloat monthHeigth = monthView.monthViewHeigth;
    
    if(monthHeigth == 0){
        
        NSInteger rowNumber = date.numberOfWeeksInCurrentMonth; // 日历行数
        // Month view 高度
        monthHeigth = self.otherConfig.dayViewSize.height*rowNumber + (rowNumber -1)*self.otherConfig.rowSpacing + self.otherConfig.bottomMargin;
    }
    
    CGFloat heigth = monthHeigth + self.otherConfig.weekBarAndCalendarSpacing + self.otherConfig.weekBarHeigth;
    
    if([self.delegate respondsToSelector:@selector(calendarEndDecelerating:currentMonth:calendarHeigth:)]){
        [self.delegate calendarEndDecelerating:self currentMonth:date calendarHeigth:heigth];
    }
    
    if([self.delegate respondsToSelector:@selector(calendarMonthChanged:currentMonth:calendarHeigth:)]){
        [self.delegate calendarMonthChanged:self currentMonth:date calendarHeigth:heigth];
    }
    
    self.initFrame = self.frame;
    
    self.pegDate = monthView.today?monthView.today:date.firstDayOfCurrentMonth;
    
    
    // 获取标记数据
    if([self.delegate respondsToSelector:@selector(calendar:monthView:)]){

        [self.delegate calendar:self monthView:self.monthArray[0]];
        [self.delegate calendar:self monthView:self.monthArray[1]];
        [self.delegate calendar:self monthView:self.monthArray[2]];
    }
    
}


#pragma mark MonthViewDelegate

- (void)monthViewClickWithDate:(NSDate *)date{
    
    if([self.delegate respondsToSelector:@selector(calendar:didSelectDate:)]){
        [self.delegate calendar:self didSelectDate:date];
    }
    
    
    
    
}


#pragma mark WeekCalendarDelegate

-(void)weekCalendarEndDecelerating:(WeekCalendar *)calendar todayOrStartDate:(NSDate *)date{
    
    if([self.delegate respondsToSelector:@selector(calendar:didSelectDate:)]){
        [self.delegate calendar:self didSelectDate:date];
    }

}

-(void)weekCalendar:(WeekCalendar *)weekCalendar didSelectDate:(NSDate *)date{
    
    if([self.delegate respondsToSelector:@selector(calendar:didSelectDate:)]){
        [self.delegate calendar:self didSelectDate:date];
    }
    
}



/// 更新布局
- (void)updateLayout{
    
    // 布局 Month view
    CGFloat baseOffset = (totalPageNumber/2 - 1)*self.width;
    
    for(NSInteger i = 0; i < self.monthArray.count; i++){
        
        self.monthArray[i].x = i*self.width + baseOffset;
        
        self.monthArray[i].width = self.width;
        
    }
    
    [self.scrollView setContentSize:CGSizeMake(totalPageNumber*self.width,self.scrollView.height)];
    [self.scrollView setContentOffset:CGPointMake((totalPageNumber*self.width)/2,0) animated:NO];
    self.lastScrollPoint = self.scrollView.contentOffset.x;
    
    
    // 布局 Week view
    self.weekBar.frame = CGRectMake((totalPageNumber*self.width)/2, 0,self.width,self.otherConfig.weekBarHeigth);
    
    
    // 布局周日历
    
    
    
    
    [self initShow];
}

/// 监听屏幕旋转
- (void)statusBarOrientationChange:(NSNotification *)notification{
    
    //    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    self.isStatusBarOrientationChange = YES;
}


-(void)setPegDate:(NSDate *)pegDate{

    MonthView *monthView = self.monthArray[1];

    NSDate *firstDay = monthView.date.firstDayOfCurrentMonth;
    
    // 获取第一天处于对应周的第几天
    NSInteger weekDay = [firstDay weeklyOrdinality];
    
    // 获取一个小的单位在一个大的单位里面的序数
    NSInteger dayNumber = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:pegDate];
    
    NSInteger number = (weekDay + dayNumber) - 1;
    
    NSInteger rowNumber = (NSInteger)(number/7.0);
    
    if(number % 7 != 0){
        rowNumber++;
    }
    
    self.pegDateRow = rowNumber;
    
    
    // 配置周日历 /////////////////////////////////////////////////////////
    self.weekCalendar.startDate = [pegDate firstDayOfCurrentWeek];
    
    
    
}



#pragma mark 外部调用
/// 外部UIScrollView或继承自UIScrollView的控件调用，用于钉住周日历和周bar
-(void)slideWithScrollView:(UIScrollView *)scrollView{
    
    if(self.weekBarFollowSlide){
        return;
    }
    
    // 钉住周bar、显示周日历、更新周日历frame.Y、上/下偏移ScrollView、更新日历高度
    
    if(scrollView.contentOffset.y >  self.externalScrollViewInitOffset){
        
        // 日历控件的最小高度
        CGFloat minimumHeigth = self.otherConfig.weekBarHeigth + self.otherConfig.weekBarAndCalendarSpacing + self.otherConfig.dayViewSize.height + self.otherConfig.bottomMargin;
        
        // self位置保持不变
        CGFloat y = scrollView.contentOffset.y - self.externalScrollViewInitOffset + self.initFrame.origin.y;
        
        // 修改self高度
        CGFloat height = self.initFrame.size.height - scrollView.contentOffset.y;
        if(height <= minimumHeigth){
            height = minimumHeigth;
        }
        self.frame = CGRectMake(self.x, y,self.width,height);
        
        CGFloat scrollViewContentOffsetY = scrollView.contentOffset.y - self.externalScrollViewInitOffset;
        
        // 设置self.scrollView上下偏移
        self.scrollViewTopConstraint.constant = -scrollViewContentOffsetY;
        
        // 钉住周bar
        self.weekBar.y = scrollViewContentOffsetY;
  
        // 钉住周日历
        self.weekCalendar.y = self.weekBar.y + self.otherConfig.weekBarHeigth + self.otherConfig.weekBarAndCalendarSpacing;

        CGFloat rowHeigth = self.otherConfig.dayViewSize.height + self.otherConfig.rowSpacing;
        if(scrollViewContentOffsetY >= (self.pegDateRow-1)*rowHeigth){
            self.weekCalendar.hidden = NO;
        }else{
            self.weekCalendar.hidden = YES;
        }
        
       
    }else{
        
        // 恢复self.frame
        self.frame = self.initFrame;
        
        // 恢复self.scrollView偏移
        self.scrollViewTopConstraint.constant = 0;
        
        // 恢复周bar
        self.weekBar.y = 0;
        
        // 恢复周日历
        self.weekCalendar.y = self.otherConfig.weekBarHeigth + self.otherConfig.weekBarAndCalendarSpacing;
        self.weekCalendar.hidden = YES;
    }
    
    if(scrollView.contentOffset.y == self.externalScrollViewInitOffset ){
        [self scrollViewDidEndDecelerating:self.scrollView];
    }
 
}

/// 外部UIScrollView或继承自UIScrollView的控件调用，用于使滑动停留在合适的位置
- (void)slideWidthWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if(self.weekBarFollowSlide){
        return;
    }
    
    CGRect targetRect = CGRectMake(targetContentOffset->x, targetContentOffset->y, scrollView.frame.size.width, scrollView.frame.size.height);
    
    MonthView *monthView = self.monthArray[1];
    CGFloat monthHeigth = monthView.monthViewHeigth;
    
    
    CGFloat y = self.externalScrollViewInitOffset;
    
    // 偏移控制范围；scrollView偏移目标停止位置为此范围内时控制；超出此范围时不控制；
    CGFloat range = monthHeigth - (self.otherConfig.dayViewSize.height + self.otherConfig.rowSpacing);
    
    CGFloat offsetRange = targetRect.origin.y - self.externalScrollViewInitOffset;
    if(offsetRange > range){
        return;
    }
    
    if(offsetRange >= range/2.0){
        
        // 日历控件的最小高度
        CGFloat minimumHeigth = self.otherConfig.weekBarHeigth + self.otherConfig.weekBarAndCalendarSpacing + self.otherConfig.dayViewSize.height + self.otherConfig.bottomMargin;
        
        y = self.initFrame.size.height - minimumHeigth;
    }
    
    // 欲停止的位置
    *targetContentOffset = CGPointMake(targetContentOffset->x,y);
}

// 回到今天
-(void)jumpToTotay{
    
    NSInteger count = self.monthArray.count;
    NSDate *currentDate = [NSDate currentDate];
    
    for(NSInteger i=0;i<count;i++){
        
        self.monthArray[i].date = [currentDate additionMonth:i-1];
    }
    
    [self initShow];

}

-(void)nextMonth{
    
    // self.willStopScrollPoint用于解决此方法短时间内连续调用导致的contentOffset.x错乱
    
    if(self.willStopScrollPoint == 0){
        
        self.willStopScrollPoint = self.scrollView.contentOffset.x + self.width;
        
    }else{
        self.willStopScrollPoint += self.width;
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.willStopScrollPoint, 0) animated:YES];

}

-(void)previousMonth{

    if(self.willStopScrollPoint == 0){
        
        self.willStopScrollPoint = self.scrollView.contentOffset.x - self.width;
        
    }else{
        self.willStopScrollPoint -= self.width;
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.willStopScrollPoint, 0) animated:YES];

}


-(void)refreshMarketData{

    // 获取标记数据
    if([self.delegate respondsToSelector:@selector(calendar:monthView:)] && self.monthArray.count > 0){
        
        [self.delegate calendar:self monthView:self.monthArray[0]];
        [self.delegate calendar:self monthView:self.monthArray[1]];
        [self.delegate calendar:self monthView:self.monthArray[2]];
    }

    
}

@end
