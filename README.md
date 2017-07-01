# JWCalendar

    这是一个IOS日期控件，可高度自定义；使用Object-C开发，未来将支持Swift。

## 使用


## 发布
    pod lib lint --allow-warnings --use-libraries
    pod trunk push JWCalendar.podspec --allow-warnings --use-libraries


## 结构

程序执行过程：
1. 创建JWCalendar，并在initWithCoder:或initWithFrame:中初始化控件的UI和默认选项；


- 初始UI:
创建UIScrollView，并添加到JWCalendar中；

- 配置默认选项：
监听时区变化
监听状态栏方向
创建外观默认选项


2. 在layoutSubviews中创建UIScrollView的子视图；即，月(MonthView)、周(WeekBarView)、天(DayView)、周日历(WeekCalendar)等;

在layoutSubviews中通过实际尺寸初始化MonthView，并添加到UIScrollView，是为了让UIScrollView方便复用其子视图；
layoutSubviews会被调用多次，但在layoutSubviews中创建在众多视图只会被初始化一次； 
屏幕旋转时layoutSubviews依然会被调用，此时只是更新所有视图的Frame;


MonthView  



WeekBarView



DayView
