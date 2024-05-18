//
//  MainViewController.h
//  shimmer
//
//  Created by kevin on 21/2/24.
//

#import <UIKit/UIKit.h>
#import "PacketProcessor/TunnelInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController{
    UIImageView * imageView;
    
    
}


@property(strong,nonatomic) TunnelInterface * tunnel;

@property(nonatomic, copy)NSArray *dataArray;
@property(nonatomic, strong)UIButton *button_menu;

@property(nonatomic, strong)UITableView * tableView;


@property(nonatomic, strong)UILabel * selectLabel;


@end

NS_ASSUME_NONNULL_END
