//
//  TextFieldTableViewCell.h
//  LifeCollection
//
//  Created by gozap on 2021/6/7.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UITextField * titleTextField;
@end

