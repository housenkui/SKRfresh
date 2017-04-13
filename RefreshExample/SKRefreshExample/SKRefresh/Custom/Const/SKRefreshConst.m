
#import <UIKit/UIKit.h>

const CGFloat SKRefreshLabelLeftInset = 25;
const CGFloat SKRefreshHeaderHeight  = 54.0;
const CGFloat SKRefreshFooterHeight  = 44.0;
const CGFloat SKRefreshFastAnimationDuration  = 0.25;
const CGFloat SKRefreshSlowAnimationDuration =0.4;

NSString *const SKRefreshKeyPathContentOffset = @"contentOffset";
NSString *const SKRefreshKeyPathContentInset = @"contentInset";
NSString *const SKRefreshKeyPathContentSize = @"contentSize";
NSString *const SKRefreshKeyPathPanState = @"state";

NSString *const SKRefreshHeaderLastUpdatedTimeKey = @"SKRefreshHeaderLastUpdatedTimeKey";

NSString *const SKRefreshHeaderNormalText = @"SKRefreshHeaderNormalText";
NSString *const SKRefreshHeaderPullingText = @"SKRefreshHeaderPullingText";
NSString *const SKRefreshHeaderRefreshingText = @"SKRefreshHeaderRefreshingText";


NSString *const SKRefreshAutoFooterNormalText = @"SKRefreshAutoFooterNormalText";
NSString *const SKRefreshAutoFooterRefreshingText = @"SKRefreshAutoFooterRefreshingText";
NSString *const SKRefreshAutoFooterNoMoreDataText = @"SKRefreshAutoFooterNoMoreDataText";

NSString *const SKRefreshBackFooterNormalText  =@"SKRefreshBackFooterNormalText";
NSString *const SKRefreshBackFooterPullingText  =@"SKRefreshBackFooterPullingText";
NSString *const SKRefreshBackFooterRefreshingText  =@"SKRefreshBackFooterRefreshingText";
NSString *const SKRefreshBackFooterNoMoreDataText  =@"SKRefreshBackFooterNoMoreDataText";

NSString *const SKRefreshHeaderLastTimeText = @"SKRefreshHeaderLastTimeText";

NSString *const SKRefreshHeaderDateTodayText = @"SKRefreshHeaderDateTodayText";

NSString *const SKRefreshHeaderNoneLastDateText = @"SKRefreshHeaderNoneLastDateText";
