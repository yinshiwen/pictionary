//
//  CollectionViewCell.m
//  GuessTheIdiom
//
//  Created by Soney_Yin on 2018/1/27.
//  Copyright © 2018年 Soney_Yin. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 0.8;
    self.layer.borderColor = [UIColor colorWithRed:41.0/255.0 green:154.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor;
}

@end
