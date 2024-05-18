//
#import "rootViewController.h"


@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
  
@property (nonatomic,retain)NSMutableArray* allDataMutableArray;
  
@end

  
 
@implementation RootViewController
  
  
- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    //self.navigationItem.title = @"表视图的编辑";
    //初始化数组数据
    self.allDataMutableArray = [[NSMutableArray alloc]initWithObjects:@"张三",@"李四",@"我擦",@"123",@"",@"111",@"333",@"张三",@"李四",@"我擦",@"123",@"",@"111",@"333",@"张三",@"李四",@"我擦",@"123",@"",@"111",@"333",@"张三",@"李四",@"我擦",@"123",@"",@"111",@"333",@"张三",@"李四",@"我擦",@"123",@"",@"111",@"333",@"张三",@"李四",@"我擦",@"123",@"kkkkkllll",@"111",@"333", nil];
}

  
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allDataMutableArray.count;
}
  
  
//cell填充
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //定义重用标示符
    static NSString* cellId = @"CELL";
    //每次需要使用单元格的是，先根据重用标识符从重用队列中获取单元格，如果队列中没有，再进行初始化新的单元格
    //每次都会先创建一屏幕的cell，当有cell出屏幕，就会根据重用标识符添加到对应的重用队列中，当屏幕外的cell要进入屏幕，先从队列中获取，如果没有，则初始化cell
    //当重用cell时，需要对上面的控件程序赋值
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
      
    //如果从重用队列中未获取cell，也就是Cell为空
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        //系统提供的控件要配合不同的样式来使用
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"创建的第%d个单元格",self.index++];
    }
      
    //UITableViewCell的属性
    //选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    //辅助视图的样式home
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //设置左侧图片
    cell.imageView.image = [UIImage imageNamed:@"images/icon4.png"];
    //标题视图
    cell.detailTextLabel.text = [NSString stringWithFormat:@"第%ld个cell，%ld个section",indexPath.row,indexPath.section];
    //副标题视图
    cell.textLabel.text = _allDataMutableArray[indexPath.row];
    
    //为相应位置返回定制好的单元格
    return cell;
}

#pragma mark -- 按钮触发方法
//点击添加触发的方法
-(void)addAction:(UIBarButtonItem*)sender
{
     
}
//进入编辑状态
-(void)editAction:(UIBarButtonItem*)sender
{
    [self setEditing:YES animated:NO];
}
//刷新数据
-(void)refreshAction:(UIBarButtonItem*)sender
{
    UITableView *tempTableView = [self.view viewWithTag:1000];
    [tempTableView reloadData];
}
  
  
#pragma mark -- 编辑相关代理方法
  
//系统提供的方法按钮会调用此方法,让tableView处于编辑状态
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
      
    //开启表视图的编辑状态
    UITableView *tempTableView = [self.view viewWithTag:1000];
    [tempTableView setEditing:editing animated:animated];
      
}
//协议设定
//确定cell是否处于编辑状态,为NO就不能进入编辑状态
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
  
  
//编辑状态的提交
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableView *tempTableView = [self.view viewWithTag:1000];
   //如果编辑模式为删除
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //先删除数据源，也就是数组中的内容
        [_allDataMutableArray removeObjectAtIndex:indexPath.row];
        //再删除单元格
        //这里要特别注意，必须先操作数据再操作单元格，不然崩的不要不要的
        [tempTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
      
    //如果编辑模式为插入
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        //先插入到数组
        [_allDataMutableArray insertObject:@"新人" atIndex:indexPath.row];
        //再创建单元格
        [tempTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}
  
//设置编辑的样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果是最后一行，编辑模式为插入
    if (indexPath.row == _allDataMutableArray.count-1) {
        return UITableViewCellEditingStyleInsert;
    }
    else
        return UITableViewCellEditingStyleDelete;
}
  
//移动相关
//实现协议，告诉tableView是否能移动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
  
//移动
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //先得到单元格上的数据
    NSString *tempStr = [self.allDataMutableArray objectAtIndex:sourceIndexPath.row];
    //把原位置的数据删除
    [_allDataMutableArray removeObjectAtIndex:sourceIndexPath.row];
    //把新数据添加到数组中对应的位置
    [_allDataMutableArray insertObject:tempStr atIndex:destinationIndexPath.row];
      
}
  
//监测移动过程，限制最后一行不能移动
-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (sourceIndexPath.row == _allDataMutableArray.count - 1 || proposedDestinationIndexPath.row == _allDataMutableArray.count - 1) {
        return sourceIndexPath;
    }
    else
        return proposedDestinationIndexPath;
}
  
@end
