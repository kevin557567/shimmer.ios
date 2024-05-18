//
//  ClothingStoreViewController.m
//  zengzi
//
//  Created by 振标 曹 on 13-2-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ClothingStoreViewController.h"

// Cell2 的实现
@implementation Cellx
@synthesize titleLabel, strHtml;

- (void)dealloc{
    self.titleLabel = nil;
    self.strHtml = nil;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //显示资源图片:
        UIImage * images = [UIImage imageNamed:@"pic2.jpg"];
        UIImageView *tempView = [[UIImageView alloc] initWithImage:images];
        tempView.frame = CGRectMake( 13, 3, 32, 32);
        [self.contentView addSubview:tempView];
        
        titleLabel = [[UILabel alloc]initWithFrame:self.window.frame];
        titleLabel.frame = CGRectMake(50,0,250.0,40.0);
        [self.contentView addSubview:titleLabel];
        
        titleLabel.text = strHtml;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(onButton1) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@"新品" forState:UIControlStateNormal];
        button.frame = CGRectMake(250,10,50.0,20.0);
        [self.contentView addSubview:button];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)onButton1
{
    NSLog(@"onButton1");
    NSString *item = @"bacdfefdsfdsafdsf";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:item message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
    [alert show];
}

@end



/////////////////////////////////////////////////////////////////////
@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        struct sttable cellval;
        cellval.hight = 60;
        cellval.strText = @"abcdef";
        cellval.strContext = @"abcdef";
    //  names = [[NSMutableArray alloc] initWithObjects:&cellval,&cellval,&cellval, nil];
        names = [[NSMutableArray alloc] init];
        
        struct sttable cellval1;
        cellval1.hight = 50;
        cellval1.strText = @"abcdedfsfsfsdff";
        cellval1.strContext = @"abcdsdfsdfef";
        
        struct sttable cellval2;
        cellval2.hight = 100;
        cellval2.strText = @"abcddsadasdasef";
        cellval2.strContext = @"abcdef";
        
        [names addObject:[NSValue value:&cellval withObjCType:@encode(struct sttable)]];
        [names addObject:[NSValue value:&cellval1 withObjCType:@encode(struct sttable)]];
        [names addObject:[NSValue value:&cellval2 withObjCType:@encode(struct sttable)]];
        
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
 
 
    return self;
}

- (void)dealloc{
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [names count];
}

//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:nil] autorelease];
    //cell.text = [names objectAtIndex:indexPath.row];
    struct sttable tcell;
    [[names objectAtIndex:indexPath.row] getValue:&tcell];
    
    UIImage * images = [UIImage imageNamed:@"clothing"];
    CGImageRef sourceImageRef = [images CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake(32,0,32,32));
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
   
    
    
    static NSString *CellIdentifier = @"Cell1";
    Cellx *cell = (Cellx*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    如果如果没有多余单元，则需要创建新的单元
    if (cell == nil) {
           cell = [[Cellx alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
           cell.strHtml = tcell.strText;
    }
    
    
   
    //tcell.titleLabel.text = tcell.strText;
    //tcell.schematicImageView.image = newImage;
    //[tcell changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
    return cell;
}


//行高
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    struct sttable tcell;
    [[names objectAtIndex:indexPath.row] getValue:&tcell];
    return tcell.hight;
}

//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *heroSelected=[names objectAtIndex:indexPath.row];
    //indexPath.row得到选中的行号，提取出在数组中的内容。
    UIAlertView *myAlertView;
    myAlertView = [[UIAlertView alloc]initWithTitle:@"dota群英传" message:heroSelected delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [myAlertView show];
    //点击后弹出该对话框。
    [names insertObject:@"AHI" atIndex:0];
    NSIndexPath *indexPathx = [NSIndexPath indexPathForRow:0 inSection:0];
    [tableView insertRowsAtIndexPaths:@[indexPathx] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- ( NSInteger )getTimeNowx
{
    NSDateFormatter *nsdf2=[[NSDateFormatter alloc] init];
    [nsdf2 setDateStyle:NSDateFormatterShortStyle];
    [nsdf2 setDateFormat:@"YYYYMMDDHHmmssSSSS"];
    NSString *t2=[nsdf2 stringFromDate:[NSDate date]];
    return [t2 integerValue];
}

 
#pragma 开始刷新函数
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static NSInteger tickernow = 0;
    NSInteger now = [self getTimeNowx];
     if( now - 2000 > tickernow ){
         tickernow = now;

        // 取内容的高度：
        //    如果内容高度大于UITableView高度，就取TableView高度
        //    如果内容高度小于UITableView高度，就取内容的实际高度
        float height = self.tableView.contentSize.height > self.tableView.frame.size.height ?self.tableView.frame.size.height : self.tableView.contentSize.height;
        
       if ((height - self.tableView.contentSize.height + self.tableView.contentOffset.y) / height > 0.2) {
            
            // 调用上拉刷新方法
           
       //    [names insertObject:@">>>>" atIndex:0];
       //    NSIndexPath *indexPathx = [NSIndexPath indexPathForRow:0 inSection:0];
       //    [self.tableView insertRowsAtIndexPaths:@[indexPathx] withRowAnimation:UITableViewRowAnimationAutomatic];
            
         }
        if (- self.tableView.contentOffset.y / self.tableView.frame.size.height > 0.2) {
            // 调用下拉刷新方法
         //   [names insertObject:@"<<<<" atIndex:0];
         //   NSIndexPath *indexPathx = [NSIndexPath indexPathForRow:0 inSection:0];
         //   [self.tableView insertRowsAtIndexPaths:@[indexPathx] withRowAnimation:UITableViewRowAnimationAutomatic];
         }
   }

}

@end
