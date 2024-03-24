//
//  SecondViewController.m
//  shimmer
//
//  Created by kevin on 21/2/24.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    
    [self.navigationItem setTitle:@"SECOND"];
    [self.navigationItem additionalOverflowItems];
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"<LEFT" style:UIBarButtonItemStyleDone target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(pressRight)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    
    UILabel * label  = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 50, 40)];
    label.text = @"test";
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentRight;
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:label];
    NSArray * arrbtn = [NSArray arrayWithObjects:rightBtn, item, nil];
    
    self.navigationItem.rightBarButtonItems = arrbtn;
    
    
    
    
    
    //self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //UINavigationController * navi = [[UINavigationController alloc] init];
    
    //[navi addChildViewController:self];
    
    //[self.window makeKeyAndVisible];
    
    
    
    
}


- (void) pressLeft{
    NSLog(@"left down");
    //[self.navigationController popoverPresentationController];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) rightLeft{
    NSLog(@"right down");
    //[self.navigationController popoverPresentationController];
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
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
