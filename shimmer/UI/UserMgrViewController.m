//
//  UIViewController+UserMgrViewController.m
//  shimmer
//
//  Created by kevin on 17/5/24.
//

#import "UserMgrViewController.h"
 

@interface UserMgrViewController ()

@end

@implementation UserMgrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"LOGIN"];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"<BACK" style:UIBarButtonItemStyleDone target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIImageView * imagview1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"images/icon3"]];
    imagview1.alpha = 0.6;
    imagview1.center = CGPointMake(self.view.center.x, self.view.center.y - 200 );
    [imagview setFrame:CGRectMake( 100, 100, 100, 100)];
    [self.view addSubview:imagview1];
    
     
    UILabel* lbUserName = [[UILabel alloc]init];
    lbUserName.frame = CGRectMake(120, 260, 80, 40);
    lbUserName.text = @"用户名：";
    lbUserName.font = [UIFont systemFontOfSize:15];
    lbUserName.textAlignment = NSTextAlignmentLeft;
    lbUserName.textColor = [UIColor blackColor];
     
     // 密码提示
    UILabel* lbPassWord = [[UILabel alloc] init];
    lbPassWord.frame = CGRectMake(120, 320, 80, 40);
    lbPassWord.text = @"密码：";
    lbPassWord.font = [UIFont systemFontOfSize:15];
    lbPassWord.textAlignment = NSTextAlignmentLeft;
    lbPassWord.textColor = [UIColor blackColor];
     
    //用户名输入框
    _tfUserName = [[UITextField alloc] init];
    _tfUserName.frame = CGRectMake(120, 260, 180, 40);
    _tfUserName.placeholder = @"请输入用户名";
    _tfUserName.borderStyle = UITextBorderStyleRoundedRect;

    //密码输入框
    _tfPassWord = [[UITextField alloc] init];
    _tfPassWord.frame = CGRectMake(120, 320, 180, 40);
    _tfPassWord.placeholder = @"请输入密码";
    _tfPassWord.borderStyle = UITextBorderStyleRoundedRect; //vUIKeyboardTypeNumberPad;
    _tfPassWord.secureTextEntry = YES;

    //登陆button
    UIButton * btLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btLogin.frame = CGRectMake(120, 400, 80, 40);
    [btLogin setTitle:@"登陆" forState:UIControlStateNormal];
    [btLogin addTarget:self action:@selector(pressLogin) forControlEvents:UIControlEventTouchUpInside];


    //注册button
    UIButton * btRegister = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btRegister.frame = CGRectMake(120, 460, 80, 40);
    [btRegister setTitle:@"注册" forState:UIControlStateNormal];
    [btRegister addTarget:self action:@selector(pressRegister) forControlEvents:UIControlEventTouchUpInside];


    [self.view addSubview:lbUserName];
    [self.view addSubview:lbPassWord];
    [self.view addSubview:btLogin];
    [self.view addSubview:btRegister];
    [self.view addSubview:_tfUserName];
    [self.view addSubview:_tfPassWord];
}


#pragma mark -- 按钮触发方法

- (void) pressLeft{
    NSLog(@"left down");
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
}


-(void) pressLogin {
    NSString* str1 = @"Michael";
    NSString* str2 = @"123456";
    
    //输入的账号密码都能在其他函数获取
    NSString* strName = _tfUserName.text;
    NSString* strPass = _tfPassWord.text;
    if ([str1 isEqualToString:strName] && [str2 isEqualToString:strPass]) {
        NSLog(@" 用户名密码正确！");
    // 提示框出现
        UIAlertController *_alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号密码正确" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [_alert addAction:sure];
        [self presentViewController:_alert animated:YES completion:nil];
    }
    else {
        UIAlertController *_alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证失败,用户名或密码错误，请检查！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [_alert addAction:sure];
        [self presentViewController:_alert animated:YES completion:nil];
    }
}

-(void) pressRegister {
    UIAlertController *_alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"该功能正在完善 摆了！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [_alert addAction:sure];
    [self presentViewController:_alert animated:YES completion:nil];
}




@end
