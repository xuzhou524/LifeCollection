//
//  NoteListTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2019/4/9.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "NoteListTableViewCell.h"

@interface NoteListTableViewCell()

@property(nonatomic,strong)UILabel * timeStrLabel;

@end

@implementation NoteListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.contentView.backgroundColor = [LCColor backgroudColor];
    
    _bgView = [UIImageView new];
    _bgView.layer.cornerRadius = 8;
    _bgView.layer.masksToBounds = YES;
    _bgView.userInteractionEnabled = YES;
    _bgView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"还房贷⑤";
    _titleLabel.font = LCFont(17);
    _titleLabel.alpha = 0.8;
    _titleLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.bgView).offset(20);
    }];
    
    _timeStrLabel = [UILabel new];
    _timeStrLabel.text = @"目标日:";
    _timeStrLabel.alpha = 0.5;
    _timeStrLabel.font = LCFont2(13);
    _timeStrLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_timeStrLabel];
    [_timeStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.bgView).offset(-20);
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.text = @"2018-12-18";
    _timeLabel.alpha = 0.5;
    _timeLabel.font = LCFont2(14);
    _timeLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeStrLabel.mas_right).offset(5);
        make.centerY.equalTo(self.timeStrLabel);
    }];

}

-(void)bind:(NoteModel *)model{
    if (model.title) {
        self.titleLabel.text = model.title;
    }else{
        self.titleLabel.text = @"请输入标题";
    }
    
    NSString * imageStr = LCEventBackgroundImage(arc4random_uniform(5));
    self.bgView.image = [UIImage imageNamed:imageStr];
}

@end

