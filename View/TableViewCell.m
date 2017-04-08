//
//  TableViewCell.m
//  ContractDetailDemo
//
//  Created by 思 彭 on 2017/4/7.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "TableViewCell.h"
#import <SDAutoLayout.h>
#import "CellModel.h"
#import <Masonry.h>

@interface TableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = FONT_14;
    self.titleLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.titleLabel];
    self.contentLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.font = FONT_14;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [UIColor lightGrayColor];
//    [self.contentView sd_addSubviews:@[self.titleLabel,self.contentLabel]];
    [self layout];
}

- (void)layout {
    
    /*
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .bottomSpaceToView(self.contentView, 10)
    .widthIs(100);
//    .autoHeightRatio(0);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.contentLabel.sd_layout
    .leftSpaceToView(self.titleLabel, 10)
    .topEqualToView(self.titleLabel)
    .rightSpaceToView(self.contentView, 10)
    .bottomSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    
    // 设置距离底部间距
    [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:10];
     */
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.titleLabel);
        
        // 注意是self.contentView.width
        make.width.mas_equalTo(self.contentView.width - self.titleLabel.width - 30);
        // 注意:masonry设置布局,同一行两个label设置右边无效,必须约束一个label的宽度才可以
//        make.right.mas_equalTo(self.contentView).offset(-10);
        make.bottom.mas_equalTo(self.contentView).offset(-10);
    }];
}

- (void)setModel:(CellModel *)model {
    
    _model = model;
    self.titleLabel.text = self.model.titleStr;
    self.contentLabel.text = self.model.contentStr;
}

@end
