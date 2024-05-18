//
//  ViewController.m
//  CircleVPN
//
//  Created by kevin on 10/11/23.
//

#import "ViewController.h"
 

@interface ViewController ()

@end

@implementation ViewController

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
    connecttip = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100,100)];
    connecttip.text = @"sdfasdfsdafdsfsdfds";
    [self.view addSubview:connecttip];
    
    
    
    UIImageView * imagview1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"121.png"]];
    imagview1.alpha = 0.6;
    imagview1.center = CGPointMake(self.view.center.x, self.view.center.y );
    //[imagview setFrame:CGRectMake( 100, 100, 100, 100)];
    [self.view addSubview:imagview1];
    
    
    
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(100, 100, 400, 400) style:UITableViewStylePlain];
    myTableView.tag = 1000;
      
    //代理
    myTableView.delegate = self;
    myTableView.dataSource = [[NSMutableArray alloc]initWithObjects:@"张三",@"李四",@"我擦",@"123",@"",@"111",@"333",@"张三",@"李四",@"我擦",@"123",@"",@"111",@"333",@"张三",@"李四",@"我擦",@"123",@"",@"111",@"333",@"张三",@"李四",@"我擦",@"123",@"",@"111",@"333",@"张三",@"李四",@"我擦",@"123",@"",@"111",@"333",@"张三",@"李四",@"我擦",@"123",@"kkkkkllll",@"111",@"333", nil];
    
    
    
      
    //添加到父视图
    [self.view addSubview:myTableView];
      
    //显示相关的属性
    myTableView.rowHeight = 70;
    myTableView.separatorColor = [UIColor blueColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.tableHeaderView = [[UIView alloc]init];
    myTableView.tableFooterView = [[UIView alloc]init];
    
    
    
}


@end
