//
//  PgyerAppCell.m
//  BitTestFlight
//
//  Created by chujian.zheng on 2019/12/4.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "PgyerAppCell.h"

@interface PgyerAppCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *typeIconImageView;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UIButton *updateButton;

@end

@implementation PgyerAppCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    
    self.iconImageView = InsertImageView(self.contentView, kDefaultIcon, ^(MASConstraintMaker * _Nullable make) {
        make.top.left.mas_equalTo(12.0);
        make.size.mas_equalTo(CGSizeMake(44.0, 44.0));
        make.bottom.mas_equalTo(-12.0);
    });
    
    self.nameLabel = InsertLabel(self.contentView, NSTextAlignmentLeft, 14, kColorText1, @"", ^(MASConstraintMaker * _Nullable make) {
        make.bottom.equalTo(self.iconImageView.mas_centerY);
        make.left.equalTo(self.iconImageView.mas_right).offset(6.0);
    });
    
    self.typeIconImageView = InsertImageView(self.contentView, kDefaultIcon, ^(MASConstraintMaker * _Nullable make) {
        make.size.mas_equalTo(CGSizeMake(12.0, 12.0));
        make.left.equalTo(self.nameLabel.mas_right).offset(2.0);
        make.centerY.equalTo(self.nameLabel);
    });
    
    self.subTitleLabel = InsertLabel(self.contentView, NSTextAlignmentLeft, 12.0, kColorText2, @"", ^(MASConstraintMaker * _Nullable make) {
        make.top.equalTo(self.iconImageView.mas_centerY).offset(4.0);
        make.left.equalTo(self.nameLabel);
    });
    
    self.updateButton = InsertButton(self.contentView, 14.0, kColorText1, 10001, self, @selector(updateButtonPressed:), @"下载", ^(MASConstraintMaker * _Nullable make) {
        make.size.mas_equalTo(CGSizeMake(80.0, 32.0));
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-12.0);
    });
    self.updateButton.layer.cornerRadius = 6.0;
    self.updateButton.layer.borderColor = kColorText1.CGColor;
    self.updateButton.layer.borderWidth = k1px;
    self.updateButton.layer.masksToBounds = YES;
    self.updateButton.hidden = YES;
    
    InsertColorView(self.contentView, kColorLine, ^(MASConstraintMaker * _Nullable make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(k1px);
    });
}

- (void)updateButtonPressed:(UIButton *)button {
    if (self.didClickBlock) {
        self.didClickBlock(button);
    }
}

- (void)setModel:(FirAppInfoModel *)model {
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon_url] placeholderImage:kDefaultIcon];
    
    self.nameLabel.text = model.name;
    
    self.typeIconImageView.image = [model.type isEqualToString:@"android"] ? IMAGE(@"android_icon") : IMAGE(@"apple_icon");
    
    self.subTitleLabel.text = [NSString stringWithFormat:@"更新时间: %@", [NSDate bs_displayTimeWithTimeStamp:model.updated_at formatter:@"yyyy-MM-dd HH:mm:ss"]];
    
    self.updateButton.hidden = [model.type isEqualToString:@"android"];
}

@end
