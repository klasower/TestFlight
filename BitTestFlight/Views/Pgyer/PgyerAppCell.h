//
//  PgyerAppCell.h
//  BitTestFlight
//
//  Created by chujian.zheng on 2019/12/4.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PgyAppInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PgyerAppCell : UITableViewCell

@property (nonatomic, strong) PgyAppInfoModel *model;

@property (nonatomic, copy) void(^didClickBlock)(UIButton *button);

@end

NS_ASSUME_NONNULL_END
