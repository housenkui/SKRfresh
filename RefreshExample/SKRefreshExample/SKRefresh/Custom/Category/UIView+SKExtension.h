#import <UIKit/UIKit.h>

@interface UIView (SKExtension)


//{
//    
//    NSString *name;//Category 里面不支持这样写
//}
//这种思想感觉  好屌啊，这不是简单的成员变量，这些都是在Category下面添加的方法
@property (assign,nonatomic)CGFloat sk_x;
@property (assign,nonatomic)CGFloat sk_y;
@property (assign,nonatomic)CGFloat sk_w;
@property (assign,nonatomic)CGFloat sk_h;
@property (assign,nonatomic)CGSize  sk_size;
@property (assign,nonatomic)CGPoint sk_origin;


@property (assign,nonatomic)CGFloat sk_bounds_x;
@property (assign,nonatomic)CGFloat sk_bounds_y;
@property (assign,nonatomic)CGFloat sk_bounds_w;
@property (assign,nonatomic)CGFloat sk_bounds_h;
@property (assign,nonatomic)CGSize  sk_bounds_size;
@property (assign,nonatomic)CGPoint sk_bounds_origin;

@end
