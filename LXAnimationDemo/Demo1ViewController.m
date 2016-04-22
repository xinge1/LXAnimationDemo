//
//  Demo1ViewController.m
//  LXAnimationDemo
//
//  Created by 刘鑫 on 16/4/19.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "Demo1ViewController.h"

@interface Demo1ViewController ()
@property (nonatomic,strong)UIImageView *testView;

@end

static CGFloat view_w=100;
@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _testView=[[UIImageView alloc] init];
    //_testView.image=[UIImage imageNamed:@"WeiboshareImage"];
    _testView.frame=CGRectMake(0, 200, view_w, view_w);
    _testView.backgroundColor=[UIColor redColor];
    [self.view addSubview:_testView];
    
    NSArray *array=@[@"缩放",@"弹性",@"平移"];
    for (int i = 0; i<array.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(10+60*i, 500, 50, 40);
        btn.tag=i+1;
        btn.backgroundColor=[UIColor redColor];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    /*
    //Duration 动画持续时间
    //animations  动画过程
    [UIView animateWithDuration:<#(NSTimeInterval)#> animations:<#^(void)animations#>];
    
    //block里是动画完成的回调
    [UIView animateWithDuration:<#(NSTimeInterval)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>];
    
    //delay 等待时间
    //options 动画类型
    [UIView animateWithDuration:<#(NSTimeInterval)#> delay:<#(NSTimeInterval)#> options:<#(UIViewAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>];
    
    //弹性动画
    //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
    //velocity:弹性复位的速度
    [UIView animateWithDuration:<#(NSTimeInterval)#> delay:<#(NSTimeInterval)#> usingSpringWithDamping:<#(CGFloat)#> initialSpringVelocity:<#(CGFloat)#> options:<#(UIViewAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>];
    
    //关键帧动画
    [UIView animateKeyframesWithDuration:<#(NSTimeInterval)#> delay:<#(NSTimeInterval)#> options:<#(UIViewKeyframeAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>];
    */
    
    
}

-(void)startAnimation:(UIButton *)btn{
    _testView.transform=CGAffineTransformIdentity;
    switch (btn.tag) {
        case 1:
        {
            
            
            [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [_testView.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.23 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [_testView.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
                    
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [_testView.layer setValue:@(.9) forKeyPath:@"transform.scale"];
                        
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                           [_testView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                            
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }];
            
            
            [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [btn.layer setValue:@(1.3) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    [btn.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                   
                }];
            }];
            
            
            
        }
            break;
            
        case 2:
        {
            //Damping 弹性，0-1，越小弹性越大
            //Velocity 弹性复位速度
            [_testView.layer setValue:@(0) forKeyPath:@"transform.translation.x"];
            [UIView animateWithDuration:.6 delay:0 usingSpringWithDamping:.3 initialSpringVelocity:.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [_testView.layer setValue:@(150) forKeyPath:@"transform.translation.x"];
            } completion:^(BOOL finished) {
                
            }];
            
            
        }
            break;
            
        case 3:
        {
        
            
            [_testView.layer setValue:@(50) forKeyPath:@"position.x"];
            [UIView animateWithDuration:1.3 animations:^{
                [_testView.layer setValue:@(150) forKeyPath:@"position.x"];
            } completion:^(BOOL finished) {

            }];

        }
            break;
            
        case 4:
        {
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.duration=.3;
            scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            scaleAnimation.fromValue = @(1);
            scaleAnimation.toValue = @(1.5);
            scaleAnimation.fillMode = kCAFillModeForwards;
            scaleAnimation.removedOnCompletion = NO;
            [_testView.layer addAnimation:scaleAnimation forKey:@"transformscale"];
        }
            break;
            
        default:
            break;
    }
   
}

-(CABasicAnimation *)opacityForever_Animation:(float)time //永久闪烁的动画

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:0.0];
    
    animation.autoreverses=YES;
    
    animation.duration=time;
    
    animation.repeatCount=FLT_MAX;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
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
