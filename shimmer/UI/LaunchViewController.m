//
//  UIViewController+UserMgrViewController.m
//  shimmer
//
//  Created by kevin on 17/5/24.
//

#import "LaunchViewController.h"
 
@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    NSString *dataPath = [[NSBundle mainBundle]pathForResource:@"images/cc" ofType:@"gif"];
    CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:dataPath], NULL);
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (size_t i=0; i<count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        UIImage* imageName=[UIImage imageWithCGImage:image];
        [imageArray addObject:imageName];//存image
        CGImageRelease(image);
    }
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-320)/2,400,320,350)];
    imageView.animationImages=imageArray;//将图片数组加入UIImageView动画数组中
    imageView.animationDuration=0.5;//每次动画时长
    imageView.layer.backgroundColor = [UIColor clearColor].CGColor;// 如果需要背景透明加上下面这句
    [imageView setHighlightedImage:imageArray[0]];
    [imageView setHighlighted:FALSE];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onServerList:)];
    [imageView addGestureRecognizer:singleTap];
    [self.view addSubview:imageView];
    [imageView startAnimating];
}

@end
