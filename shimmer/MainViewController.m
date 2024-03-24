//
//  MainViewController.m
//  shimmer
//
//  Created by kevin on 21/2/24.
//

#import "MainViewController.h"
#import "SecondViewController.h"
#import "NodesViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.view.backgroundColor = [UIColor blueColor];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
    UIButton *button = [[UIButton alloc] init];
    button = [[UIButton alloc]initWithFrame:CGRectMake(50,100,50,20)];
    [button setTitle:@"JUMP" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
 
    
    [self.view addSubview:button];
    [button addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button2 = [[UIButton alloc] init];
    button2 = [[UIButton alloc]initWithFrame:CGRectMake(50,200,50,20)];
    [button2 setTitle:@"JUMP" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(jump2:) forControlEvents:UIControlEventTouchUpInside];
    
    //UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //imageView.image = [UIImage imageNamed:@"bb.jpeg"];
    //imageView.image.size.width = 100;
    //[self.view addSubview:imageView];
 
    //UIImage *image = [UIImage imageNamed:@"cc.gif"];
    //self.view.layer.contents = (id)image.CGImage;
    //self.view.layer.backgroundColor = [UIColor clearColor].CGColor;// 如果需要背景透明加上下面这句
    
    //1.找到gif文件路径
    NSString *dataPath = [[NSBundle mainBundle]pathForResource:@"cc" ofType:@"gif"];
    CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:dataPath], NULL);
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (size_t i=0; i<count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        UIImage* imageName=[UIImage imageWithCGImage:image];
        [imageArray addObject:imageName];//存image
        CGImageRelease(image);
    }
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-320)/2, (self.view.frame.size.height-400)/2,320,350)];
    imageView.animationImages=imageArray;//将图片数组加入UIImageView动画数组中
    imageView.animationDuration=0.5;//每次动画时长
    imageView.layer.backgroundColor = [UIColor clearColor].CGColor;// 如果需要背景透明加上下面这句
    [imageView setHighlightedImage:imageArray[0]];
    [imageView setHighlighted:TRUE];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress1:)];
    [imageView addGestureRecognizer:singleTap];
    [self.view addSubview:imageView];
    
    UIButton *homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homebtn setFrame:CGRectMake(200, self.view.frame.size.height - 200, 64, 64)];
    [homebtn setImage:[UIImage imageNamed:@"itangram"] forState:UIControlStateNormal];
    //[homebtn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    homebtn.transform =  CGAffineTransformMakeRotation(M_PI/3);
    [self.view addSubview:homebtn];
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"animated");
}

- (void)buttonpress1:(id)sender{
   // [imageView stopAnimating];
   // [imageView setHighlighted:TRUE];
    NodesViewController * view  = [[NodesViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}


- (void)jump:(id)sender{
    [imageView stopAnimating];
    [imageView setHighlighted:TRUE];
}


- (void)jump2:(id)sender{
    //SecondViewController * typeWritingView  = [[SecondViewController alloc]init];
    //[self.navigationController pushViewController:typeWritingView animated:YES];
    
    [imageView setHighlighted:FALSE];
    [imageView startAnimating];
}


- (void) pressLeft{
    NSLog(@"left down");
    //[self.navigationController popoverPresentationController];

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
