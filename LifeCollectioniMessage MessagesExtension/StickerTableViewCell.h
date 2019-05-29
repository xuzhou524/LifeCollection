//
//  StickerTableViewCell.h
//  LifeCollectioniMessage MessagesExtension
//
//  Created by gozap on 2019/5/29.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"
@interface StickerTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView * bgView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UILabel * dayLabel;

@property(nonatomic,strong)UILabel * classTypeLabel;
@property(nonatomic,strong)UILabel * remindTypeLabel;

-(void)bind:(EventModel *)model;
@end
