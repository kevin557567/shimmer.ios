//
//  UIViewController+UserMgrViewController.m
//  shimmer
//
//  Created by kevin on 17/5/24.
//

#import "OptionsViewController.h"
 

@interface OptionsViewController ()

@end

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home"]];
    self.navigationItem.title = @"我的关注";
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    // 设置按钮的大小和图片的大小一样
    [button sizeToFit];
    [button addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    UILabel * connecttip = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100,100)];
    connecttip.text = @"sdfasdfsdafdsfsdfds";
    [self.view addSubview:connecttip];

    
    UIImageView * imagview1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"121.png"]];
    imagview1.alpha = 0.6;
    imagview1.center = CGPointMake(self.view.center.x, self.view.center.y );
    //[imagview setFrame:CGRectMake( 100, 100, 100, 100)];
    [self.view addSubview:imagview1];
}

@end
