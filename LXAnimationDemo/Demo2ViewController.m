//
//  Demo2ViewController.m
//  LXAnimationDemo
//
//  Created by 刘鑫 on 16/4/22.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "Demo2ViewController.h"

@interface Demo2ViewController ()

@end

@implementation Demo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"圆形加载动画";
    
    //加载动画 范围0-1 可用于下载时显示
    [self animation1:.8];
    
    //loading动画
    [self animation2];
    /*
     UIBezierPath
     UIBezierPath主要是用来绘制路径的，分为一阶、二阶.....n阶。一阶是直线，二阶以上才是曲线。而最终路径的显示还是得依靠CALayer
     初始化方法一共7种
     //方法1：构造bezierPath对象，一般用于自定义路径。
     [UIBezierPath bezierPath];
     
     //方法2：根据某个CGRect绘制路径。
     [UIBezierPath bezierPathWithRect:<#(CGRect)#>];
     
     //方法3：根据某个CGRect绘制内切圆或椭圆（CGRect是正方形即为圆，为长方形则为椭圆）。
     [UIBezierPath bezierPathWithOvalInRect:<#(CGRect)#>];
     
     //方法4：根据某个路径绘制路径。
     [UIBezierPath bezierPathWithCGPath:<#(nonnull CGPathRef)#>];
     
     //方法5：绘制每个角都是圆角的矩形，参数2是半径。
     [UIBezierPath bezierPathWithRoundedRect:<#(CGRect)#> cornerRadius:<#(CGFloat)#>];
     
     //方法6：绘制带圆角的矩形路径，参数2哪个角，参数3，横、纵向半径。
     [UIBezierPath bezierPathWithRoundedRect:<#(CGRect)#> byRoundingCorners:<#(UIRectCorner)#> cornerRadii:<#(CGSize)#>];
     
     //方法7：绘制圆弧路径，参数1是中心点位置，参数2是半径，参数3是开始的弧度值，参数4是结束的弧度值，参数5是是否顺时针(YES是顺时针方向，NO逆时针)。
     [UIBezierPath bezierPathWithArcCenter:<#(CGPoint)#> radius:<#(CGFloat)#> startAngle:<#(CGFloat)#> endAngle:<#(CGFloat)#> clockwise:<#(BOOL)#>];
     ----
     自定义路径常用api
     - (void)moveToPoint:(CGPoint)point; // 移到某个点
     - (void)addLineToPoint:(CGPoint)point; // 绘制直线
     - (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2; //绘制贝塞尔曲线
     - (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint; // 绘制规则的贝塞尔曲线
     - (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise
     // 绘制圆形曲线
     - (void)appendPath:(UIBezierPath *)bezierPath; // 拼接曲线
     */
  
   
}

-(void)animation1:(CGFloat)toValue{
    CGRect rect = CGRectMake(100, 100, 100, 100);
    
    UIBezierPath *beizPath=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:50];
    //先画一个圆
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.path=beizPath.CGPath;
    layer.fillColor=[UIColor clearColor].CGColor;//填充色
    layer.strokeColor=[UIColor redColor].CGColor;//边框颜色
    layer.lineWidth=6.0f;
    layer.lineCap=kCALineCapRound;//线框类型
    [self.view.layer addSublayer:layer];
    
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue=[NSNumber numberWithFloat:0.0f];
    animation.toValue=[NSNumber numberWithFloat:toValue];
    animation.duration=2.0;
    //animation.repeatCount=HUGE;//永久重复动画
    //animation.delegate=self;
    //removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
    //fillMode：决定当前对象在非active时间段的行为.比如动画开始之前,动画结束之后
    //autoreverses:动画结束时是否执行逆动画
    //timingFunction:设定动画的速度变化
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:@"animation"];
    
}

-(void)animation2{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(100, 300, 50, 50)];
    view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view];
    
    UIBezierPath *beizPath=[UIBezierPath bezierPathWithArcCenter:CGPointMake(25, 25) radius:25 startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    //先画一个圆
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.path=beizPath.CGPath;
    layer.fillColor=[UIColor clearColor].CGColor;//填充色
    layer.strokeColor=[UIColor redColor].CGColor;//边框颜色
    layer.lineWidth=3.0f;
    layer.lineCap=kCALineCapRound;//线框类型
    [view.layer addSublayer:layer];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue=@(0);
    animation.toValue=@(M_PI*2);
    animation.duration=.6;
    animation.repeatCount=HUGE;//永久重复动画
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:@"animation"];
}

-(void)animationDidStart:(CAAnimation *)anim{
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
