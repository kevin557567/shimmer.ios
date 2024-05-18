//
//  ClothingStoreViewController.h
//  zengzi
//
//  Created by 振标 曹 on 13-2-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


struct sttable{
    NSString * strText;
    NSInteger hight;
    NSString * strContext;
};


//cell2
@interface Cellx : UITableViewCell
@property (nonatomic,retain)IBOutlet UILabel *titleLabel;
@property (nonatomic,retain)NSString * strHtml;
@end

@interface TableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *names;
}

-(NSInteger ) getTimeNowx;

@end
