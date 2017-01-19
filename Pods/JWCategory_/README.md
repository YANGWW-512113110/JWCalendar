
JWCategory是我个人在日常开发中积累的工具库，里面包含了很多方便、实用的工具类；虽然没有什么技术含量，但能提高开发效率；所有的工具方法基本都以分类的方式存在，使用非常方便；并且我会不断更新、完善它，以便进一步提升板砖的效率。

## 目录

* [字符串相关](#NSString+Trim)
* [导航栏按钮](#UIBarButtonItem+JW)
* [按钮](#UIButton+JW)
* [颜色](#UIColor+JW)
* [UILabel](#UILabel+JW)
* [UIView](#UIView+JW)
* [导航栏提示](#导航栏提示信息)
* [图片处理](#UIImageView+JW)


## 安装

- 通过CocoaPods安装：`pod 'JWCategory_'`
- 手动导入：
    * 拖动`JWCategory`到项目目录
    * 导入主头文件：`#import "JWCategory.h"`



## <a id="NSString+Trim"></a>字符串 - NSString+Trim

- 字符串去前后空格
- 字符串去特殊字符
- 字符串去掉前后回车符
- 字符串去掉前后空格和回车符
```objective-c
/**
*  去掉字符串的前后空格
*
*  @param val 字符串
*
*  @return
*/
- (NSString *)trim;


/**
*  去掉字符串的特殊字符
*
*  @param val          字符串
*  @param characterSet 特殊字符
*
*  @return 过滤后的字符串
*/
-(NSString *)trimCharacterSet:(NSCharacterSet *)characterSet;


/**
*  去掉前后回车符
*
*  @param val 字符串
*
*  @return 
*/
- (NSString *)trimNewline;

/**
*  去掉前后空格和回车符
*
*  @param val 字符串
*
*  @return 
*/
- (NSString *)trimWhitespaceAndNewline;
```



## <a id="UIBarButtonItem+JW"></a>导航栏按钮 - UIBarButtonItem+JW

- 创建导航栏左、右按钮，可以只设置图标或title;
- 创建导航栏返回按钮
```objective-c
/**
*  创建一个导航栏按钮，可以只设置图标或title;
*
*  @param leftIcon  按钮图标(图标居左)
*  @param title
*  @param target
*  @param action
*
*  @return
*/
+(NSArray<UIBarButtonItem*> *)itemWithLeftIcon:(NSString *)leftIcon title:(NSString *)title target:(id)target actioin:(SEL)action;


/**
*  创建一个导航栏按钮，可以只设置图标或title;
*
*  @param righhtIcon 按钮图标(图标居右)
*  @param title
*  @param target
*  @param action
*
*  @return
*/
+(NSArray<UIBarButtonItem*> *)itemWithRightIcon:(NSString *)righhtIcon title:(NSString *)title target:(id)target actioin:(SEL)action;

/**
*  创建导航栏返回按钮
*
*  @param icon   icon
*  @param target
*  @param action
*
*  @return 
*/
+(UIBarButtonItem*)leftBackButtonIcon:(NSString *)icon target:(id)target actioin:(SEL)action;

```



## <a id="UIButton+JW"></a>按钮 - UIButton+JW

- 创建图标居上，Title居下的按钮
```objective-c
/**
*  设置按钮为图标居上Title居下
*
*  @param actualWidth 按钮的实际宽度
*/
-(void)titleButtomImageTop;

```


## <a id="UIColor+JW"></a>颜色 - UIColor+JW

- 根据16进制颜色字符串获取UIColor
```objective-c
/**
*   根据十六进制颜色字符串获取UIColor
*
*  @param hexString  十六进制字符串
*
*  @return 
*/
+(UIColor *)hexColor:(NSString *)hexString;
```

## <a id="UILabel+JW"></a>UILabel+JW

- 获取UILabel的实际大小
```objective-c
/// 获取UILabel的实际大小
-(CGSize)textSize;

```

## <a id="UIView+JW"></a>UIView+JW

- 直接获取UIView的x、y、width、heigth、size、origin; 
  例如：获取view的width，无需再view.frame.size.width,而直接view.width;
```objective-c
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

```


## <a id="导航栏提示信息"></a>导航栏提示信息 - UIViewController+JW

- 模拟微信，在导航栏上提示“数据加载...”、"未连接" 等信息；
```objective-c
/**
*  加载数据...
*/
-(void)loadingData;

/**
*  加载数据...
*
*  @param title 自定义加载数据时的提示语
*/
-(void)loadingDataForTitle:(NSString *)title;

/**
*  加载完成
*/
-(void)LoadComplete;

```

## <a id="UIImageView+JW"></a>图片处理 - UIImageView+JW
- 将图片显示为圆形
```objective-c
/**
*  将图片显示为圆形
*
*  @param image 要显示的图片
*/
-(void)showCircularImage:(UIImage *)image;
```


