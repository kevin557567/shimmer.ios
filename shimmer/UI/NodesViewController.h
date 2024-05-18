//
//  ViewController.h
//  CircleVPN
//
//  Created by kevin on 10/11/23.
//

#import <UIKit/UIKit.h>

struct NSNode{
    int  index;
    char ip[32];
    char country[32];
    char city[32];
    int  height;
    bool checked;
};
 
@interface NodesViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>




@end

