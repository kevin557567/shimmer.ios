//
//  MainViewController.m
//  shimmer
//
//  Created by kevin on 16/5/24.
//

#import "MainViewController.h"
#import "NodesViewController.h"
#import "UserMgrViewController.h"
#import <ssrNative/ssrNative.h>

//#import "../tun2socks/tun2socks.h"
#import "PacketProcessor/TunnelInterface.h"

#include <curl/curl.h>

#ifndef BYTE
typedef const char BYTE;
typedef char* LPBYTE;
#endif


#define TunnelMTU 1600
#define kTun2SocksStoppedNotification @"kTun2SocksStoppedNotification"


typedef struct _CURL_DOWNLOAD_OBJECT {
    long size;
    LPBYTE data;
} CURL_DOWNLOAD_OBJECT, *LPCURL_DOWNLOAD_OBJECT;


size_t curlCallback(char *data, size_t size, size_t count, void* userdata);
BOOL downloadUrl(const char* url, LPCURL_DOWNLOAD_OBJECT downloadObject);


struct ssr_client_state *g_state = NULL;

int sock_port (int fd) {
    struct sockaddr_in sin;
    socklen_t len = sizeof(sin);
    if (getsockname(fd, (struct sockaddr *)&sin, &len) < 0) {
        NSLog(@"getsock_port(%d) error: %s",
              fd, strerror (errno));
        return 0;
    }else{
        return ntohs(sin.sin_port);
    }
}

void feedback__state(struct ssr_client_state *state, void *p) {
    g_state = state;
    int fd = ssr_get_listen_socket_fd(state);
    int port = sock_port(fd);
    //shadowsocks_handler(port, p);
    state_set_force_quit(state, true, 1000);
    NSLog(@"feedback__state");
}

void info_callback(int dump_level, const char *info, void *p) {
    NSLog(@"%s", info);
}

@interface MainViewController ()
<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MainViewController
{
    int _readFd;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.view.backgroundColor = [UIColor blueColor];
    self.navigationController.navigationBarHidden = YES;
    
    UIButton *button_startrun = [[UIButton alloc] init];
    button_startrun = [[UIButton alloc]initWithFrame:CGRectMake(20,100,100,20)];
    [button_startrun setTitle:@"StartRun" forState:UIControlStateNormal];
    [button_startrun setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button_startrun];
    [button_startrun addTarget:self action:@selector(onStartRun:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button_stoprun = [[UIButton alloc] init];
    button_stoprun = [[UIButton alloc]initWithFrame:CGRectMake(120,100,100,20)];
    [button_stoprun setTitle:@"StopRun" forState:UIControlStateNormal];
    [button_stoprun setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button_stoprun];
    [button_stoprun addTarget:self action:@selector(onStopRun:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button_vpnstart = [[UIButton alloc] init];
    button_vpnstart = [[UIButton alloc]initWithFrame:CGRectMake(20,150,100,20)];
    [button_vpnstart setTitle:@"VPNStart" forState:UIControlStateNormal];
    [button_vpnstart setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button_vpnstart];
    [button_vpnstart addTarget:self action:@selector(onVPNStart) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button_vpnstop = [[UIButton alloc] init];
    button_vpnstop = [[UIButton alloc]initWithFrame:CGRectMake(120,150,100,20)];
    [button_vpnstop setTitle:@"TunStop" forState:UIControlStateNormal];
    [button_vpnstop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button_vpnstop];
    [button_vpnstop addTarget:self action:@selector(onVPNStop) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button_tunstart = [[UIButton alloc] init];
    button_tunstart = [[UIButton alloc]initWithFrame:CGRectMake(20,200,100,20)];
    [button_tunstart setTitle:@"TunStart" forState:UIControlStateNormal];
    [button_tunstart setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button_tunstart];
    [button_tunstart addTarget:self action:@selector(onTun2sockStart) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button_tunstop = [[UIButton alloc] init];
    button_tunstop = [[UIButton alloc]initWithFrame:CGRectMake(120,200,100,20)];
    [button_tunstop setTitle:@"TunStop" forState:UIControlStateNormal];
    [button_tunstop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button_tunstop];
    [button_tunstop addTarget:self action:@selector(onTun2sockStop) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button_download = [[UIButton alloc] init];
    button_download = [[UIButton alloc]initWithFrame:CGRectMake(20,250,100,20)];
    [button_download setTitle:@"Download" forState:UIControlStateNormal];
    [button_download setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button_download];
    [button_download addTarget:self action:@selector(onDownLoad) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button_checkconn = [[UIButton alloc] init];
    button_checkconn = [[UIButton alloc]initWithFrame:CGRectMake(120,250,100,20)];
    [button_checkconn setTitle:@"CheckConn" forState:UIControlStateNormal];
    [button_checkconn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button_checkconn];
    [button_checkconn addTarget:self action:@selector(onCheckConn) forControlEvents:UIControlEventTouchUpInside];
    
    //UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //imageView.image = [UIImage imageNamed:@"bb.jpeg"];
    //imageView.image.size.width = 100;
    //[self.view addSubview:imageView];
    
    //UIImage *image = [UIImage imageNamed:@"images/cc.gif"];
    //self.view.layer.contents = (id)image.CGImage;
    //self.view.layer.backgroundColor = [UIColor clearColor].CGColor;// 如果需要背景透明加上下面这句
    
    //1.找到gif文件路径
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
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x-160,400,320,350)];
    imageView.animationImages=imageArray;//将图片数组加入UIImageView动画数组中
    imageView.animationDuration=0.5;//每次动画时长
    imageView.layer.backgroundColor = [UIColor clearColor].CGColor;// 如果需要背景透明加上下面这句
    [imageView setHighlightedImage:imageArray[0]];
    [imageView setHighlighted:TRUE];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onServerList:)];
    [imageView addGestureRecognizer:singleTap];
    [self.view addSubview:imageView];
    /*
    UIButton *homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homebtn setFrame:CGRectMake(200, self.view.frame.size.height - 200, 64, 64)];
    [homebtn setImage:[UIImage imageNamed:@"images/itangram"] forState:UIControlStateNormal];
    [homebtn addTarget:self action:@selector(onServerList:) forControlEvents:UIControlEventTouchUpInside];
    homebtn.transform =  CGAffineTransformMakeRotation(M_PI/3);
    [self.view addSubview:homebtn];
     */
    self.tunnel = [TunnelInterface alloc];
    
    
    _dataArray = @[@"LOGIN", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", @"星期日"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(40, 50, 0, 0) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _button_menu = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, 40, 40)];
    _button_menu.backgroundColor = [UIColor yellowColor];
    [_button_menu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button_menu setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_button_menu setTitle:@"收" forState:UIControlStateNormal];
    [_button_menu setTitle:@"弹" forState:UIControlStateSelected];
    [_button_menu addTarget:self action:@selector(clickToPush:) forControlEvents:UIControlEventTouchUpInside];
    [_button_menu setSelected:true];
    [self.view addSubview:_button_menu];
    
    /*
    _selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 50, 130, 40)];
    _selectLabel.text = @" ";
    [_selectLabel.layer setCornerRadius:0];
    [_selectLabel.layer setBorderWidth:1];
    [_selectLabel.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:_selectLabel];
     */
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"animated");
}

- (void)_startShadowsocks:(NSURL*)proxyConfUrl {
    struct server_config * config = config_create();
    string_safe_assign(&config->password, "2passwo02");
    string_safe_assign(&config->method, "aes-128-ctr");
    string_safe_assign(&config->protocol, "auth_aes128_md5");
    string_safe_assign(&config->obfs, "tls1.2_ticket_auth");
    config->udp = false;
    config->idle_timeout = 30;
    config->connect_timeout_ms = 6 * 1000;
    config->udp_timeout = 6;
    string_safe_assign(&config->listen_host, "127.0.0.1");
    config->listen_port = 8892;
    string_safe_assign(&config->remote_host, "165.232.171.96");//165.232.171.96
    config->remote_port = 9999;
    config->over_tls_enable = false;
    config->extend = true;
    config->app_type = 402;
    config->user_id = 43151352;
    config->trace_level = 15;
    string_safe_assign(&config->user_name,"5bd95f7a-fa10-11e9-b0be-02628c2da518");
    string_safe_assign(&config->user_cipher,"a7e955c5-871d-4309-9339-c6a58704ab0f");
    set_dump_info_callback(&info_callback, (__bridge void*)self);
    ssr_run_loop_begin(config, &feedback__state, (__bridge void*)self);
}

- (void)onStartRun:(id)sender{
    [imageView setHighlighted:FALSE];
    [imageView startAnimating];
}

- (void)onStopRun:(id)sender{
    [imageView stopAnimating];
    [imageView setHighlighted:TRUE];
}

- (void)onServerList:(id)sender{
    NodesViewController * view  = [[NodesViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)onVPNStart{
    [NSThread detachNewThreadSelector:@selector(_startShadowsocks:) toTarget:self withObject:NULL];
    NSLog(@"_startShadowsocks");
}

- (void)onVPNStop{
    NSLog(@"stop shadowsocksr");
    ssr_run_loop_shutdown(g_state);
}

- (void) onTun2sockStart{
    NSLog(@"Tun2socks start");
    [[TunnelInterface sharedInterface] startTun2Socks:8892];
    //[[TunnelInterface sharedInterface] setupWithPacketTunnelFlow:self.packetFlow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[TunnelInterface sharedInterface] processPackets];
    });
}

- (void) onTun2sockStop{
    NSLog(@"Tun2socks stop");

    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更新UI
        // 例如，更新一个标签的文本：
        // self.label.text = @"Updated Text";
        
        [[TunnelInterface sharedInterface] stop];
    });

    
    
}

- (void) onDownLoad{
    const char* url = "http://ip-api.com/json";
    NSLog(@"Starting the download of url %s", url);
    CURL_DOWNLOAD_OBJECT downloadObject;
    downloadObject.data = NULL;
    downloadObject.size = 0;
    downloadUrl(url, &downloadObject);
    if( downloadObject.size > 0 ){
        NSString *nss2 = [NSString stringWithUTF8String: downloadObject.data];
        NSLog( @"%@", nss2 );
    }
    if( downloadObject.data ){
        free(downloadObject.data);
    }
}

- (void) onCheckConn{
    NSLog(@"onCheckConn");
    curlCheckConn( );
}

BOOL downloadUrl(const char* url, LPCURL_DOWNLOAD_OBJECT downloadObject ) {
    CURL* curl = curl_easy_init();
    curl_easy_setopt(curl, CURLOPT_URL, url);
    curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, TRUE);
    curl_easy_setopt(curl, CURLOPT_FAILONERROR, TRUE);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, &curlCallback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, downloadObject);
    curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, FALSE);
    
    CURLcode res = curl_easy_perform(curl);
    if (res != CURLE_OK){
        NSLog(@"CURL failed with error code %d", res);
    }
    curl_easy_cleanup(curl);
    return res == CURLE_OK;
}

void curlCheckConn(void) {
    CURL_DOWNLOAD_OBJECT downobj;
    memset( &downobj, 0x00, sizeof(CURL_DOWNLOAD_OBJECT));
    CURL* curl = curl_easy_init();
    curl_easy_setopt(curl, CURLOPT_PROXY, "127.0.0.1:8892");//192.168.10.174
    curl_easy_setopt(curl, CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
    curl_easy_setopt(curl, CURLOPT_URL, "http://ip-api.com/json");//http://ip-api.com/json
    curl_easy_setopt(curl, CURLOPT_READFUNCTION, NULL);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, &curlCallback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &downobj);
    //curl_easy_setopt(curl, CURLOPT_NOSIGNAL,1);
    curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT,10);
    curl_easy_setopt(curl, CURLOPT_TIMEOUT,10);
    curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, FALSE);
    CURLcode res = curl_easy_perform(curl);
    if (res != CURLE_OK){
        NSLog(@"CURL failed with error code %d", res);
    }
    curl_easy_cleanup(curl);
    if( downobj.size > 0 ){
        NSString *nss2 = [NSString stringWithUTF8String: downobj.data];
        NSLog( @"%@", nss2 );
    }
}

size_t curlCallback(char *data, size_t size, size_t count, void* userdata) {
    NSLog(@"Downloaded data size is %lu", size*count);
    LPCURL_DOWNLOAD_OBJECT downloadObject = (LPCURL_DOWNLOAD_OBJECT) userdata;
    long newSize = 0;
    long offset = 0;
    LPBYTE dataPtr;
    if (downloadObject->data == NULL){
        newSize = size * count * sizeof(BYTE);
        dataPtr = (LPBYTE)malloc(newSize);
    }else{
        newSize = downloadObject->size + (size * count * sizeof(BYTE));
        dataPtr = (LPBYTE)realloc(downloadObject->data, newSize);
        offset = downloadObject->size;
    }
    if (dataPtr==NULL){//malloc or realloc failed
        if (downloadObject->data != NULL){//realloc failed
            free(downloadObject->data);
            downloadObject->data = NULL;
            downloadObject->size = 0;
        }
        return 0; //this will abort the download
    }
    downloadObject->data = dataPtr;
    downloadObject->size = newSize;
    memcpy(downloadObject->data + offset, data, size * count * sizeof(BYTE));
    return size*count;
}

void sericalTask(void){
    //创建串行队列  (DISPATCH_QUEUE_SERIAL:串行) (DISPATCH_QUEUE_CONCURRENT:并发)
    dispatch_queue_t  queue = dispatch_queue_create("com.fw.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"任务A  thread:%@",[NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"任务B  thread:%@",[NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"任务C  thread:%@",[NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"任务执行完毕，回到主线程 thread:%@",[NSThread currentThread]);
        });
        
    });
    NSLog(@"结束");
    
    
}


void DispathGroup(void){
    //创建分组
    dispatch_group_t dispatchGroup = dispatch_group_create();
    //获取队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //添加并发任务
    for (int i=1; i<=3; i++) {
        dispatch_group_async(dispatchGroup, queue, ^{
            sleep(1);
            NSLog(@"任务%d  thread:%@",i,[NSThread currentThread]);
        });
    }
    //任务执行完毕后，获取通知
    dispatch_group_notify(dispatchGroup, queue, ^{
        NSLog(@"执行完毕  thread:%@",[NSThread currentThread]);
    });
}

void DispathDelay(void){
    // 延迟2秒执行：
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // code to be executed on the main queue after delay
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)clickToPush:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        _tableView.frame = CGRectMake(40, 50, 0, 0);
    }
    else {
        _tableView.frame = CGRectMake(40, 50, 130, 160);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //_selectLabel.text = _dataArray[indexPath.section];
    _tableView.frame = CGRectMake(40, 130, 0, 0);
    _button_menu.selected = !_button_menu.selected;
    
    
    UserMgrViewController * view  = [[UserMgrViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.backgroundColor = [UIColor orangeColor];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = _dataArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
