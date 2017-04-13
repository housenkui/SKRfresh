#import <UIKit/UIKit.h>
#import <objc/message.h>
//弱引用
#define  SKWeakSelf  __weak __typeof(self) weakSelf = self;
//日志输出
#ifdef DEBUG
#define SKRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define SKRefreshLog(...)
#endif
//过期提醒
#define SKRefreshDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0,2_0, instead)

//运行时 objc_msgSend
#define SKRefreshMsgSend(...) ((void (*) (void *,SEL,UIView *))objc_msgSend)(__VA_ARGS__)


#define SKRefreshMsgTarget(target) (__bridge void *)(target)

//RGB颜色
#define SKRefreshColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];
//文字颜色
#define SKRefreshLabelTextColor SKRefreshColor(90,90,90)
//字体大小
#define SKRefreshLabelFont   [UIFont boldSystemFontOfSize:14.0];

//常量
UIKIT_EXTERN const CGFloat SKRefreshLabelLeftInset;
UIKIT_EXTERN const CGFloat SKRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat SKRefreshFooterHeight;
UIKIT_EXTERN const CGFloat SKRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat SKRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const SKRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const SKRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const SKRefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const SKRefreshKeyPathPanState;

UIKIT_EXTERN NSString *const SKRefreshHeaderLastUpdatedTimeKey;

UIKIT_EXTERN NSString *const SKRefreshHeaderNormalText;
UIKIT_EXTERN NSString *const SKRefreshHeaderPullingText;
UIKIT_EXTERN NSString *const SKRefreshHeaderRefreshingText;

UIKIT_EXTERN NSString *const SKRefreshAutoFooterNormalText;
UIKIT_EXTERN NSString *const SKRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const SKRefreshAutoFooterNoMoreDataText;

UIKIT_EXTERN NSString *const SKRefreshBackFooterNormalText;
UIKIT_EXTERN NSString *const SKRefreshBackFooterPullingText;
UIKIT_EXTERN NSString *const SKRefreshBackFooterRefreshingText;
UIKIT_EXTERN NSString *const SKRefreshBackFooterNoMoreDataText;

UIKIT_EXTERN NSString *const SKRefreshHeaderLastTimeText;
UIKIT_EXTERN NSString *const SKRefreshHeaderDateTodayText;
UIKIT_EXTERN NSString *const SKRefreshHeaderNoneLastDateText;

//状态检查
#define SKRefreshCheckState \
SKRefreshState oldState = self.state; \
if(state == oldState) return; \
[super setState:state];
