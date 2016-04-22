//
//  ViewController.m
//  LXAnimationDemo
//
//  Created by 刘鑫 on 16/4/19.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "ViewController.h"
#import "Demo1ViewController.h"
#import "Demo3ViewController.h"
#import "Demo4ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *classArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.classArray=[NSMutableArray array];
    [self addViewControl:[Demo1ViewController class]];
    //[self addViewControl:[Demo2ViewController class]];
    [self addViewControl:[Demo3ViewController class]];
    [self addViewControl:[Demo4ViewController class]];
    
    //利用runtim获取属性
//    [self allProperties];
    
}

- (NSArray *)allProperties {
    unsigned int count;
    
    // 获取类的所有属性
    // 如果没有属性，则count为0，properties为nil
    objc_property_t *properties = class_copyPropertyList([CALayer class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (NSUInteger i = 0; i < count; i++) {
        // 获取属性名称
        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        NSLog(@"属性名称=(%@)  属性类型=(%@)",name,[name class]);
        [propertiesArray addObject:name];
    }
    
    // 注意，这里properties是一个数组指针，是C的语法，
    // 我们需要使用free函数来释放内存，否则会造成内存泄露
    free(properties);
    
    return propertiesArray;
}



-(void)addViewControl:(Class)class{
    [self.classArray addObject:class];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idf=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idf];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        
    }
    
    cell.textLabel.text=NSStringFromClass(self.classArray[indexPath.row]);
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消cell点击后的背景
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc=[[self.classArray[indexPath.row] alloc] init];
    vc.title=NSStringFromClass(self.classArray[indexPath.row]);
    vc.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
