//
//  NoteListTableViewCell.h
//  LifeCollection
//
//  Created by gozap on 2019/4/9.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteModel.h"

@interface NoteListTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * bgView;

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * timeLabel;

-(void)bind:(NoteModel *)model;
@end

