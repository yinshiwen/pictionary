//
//  UpOrDownButton.h
//  GuessTheIdiom
//
//  Created by Soney_Yin on 2018/1/26.
//  Copyright © 2018年 Soney_Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpOrDownButton : UIButton

@property (nonatomic,assign) BOOL isUp;
@property (nonatomic,assign) CGPoint oldCenter;
@property (nonatomic,strong) UIButton *upButton;

@end
