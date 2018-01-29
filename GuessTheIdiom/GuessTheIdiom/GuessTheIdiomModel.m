//
//  GuessTheIdiomModel.m
//  GuessTheIdiom
//
//  Created by Soney_Yin on 2018/1/26.
//  Copyright © 2018年 Soney_Yin. All rights reserved.
//

#import "GuessTheIdiomModel.h"

@implementation GuessTheIdiomModel

-(void)setNameStr:(NSString *)nameStr{
    
    _nameArray = [nameStr componentsSeparatedByString:@","];
    
}

@end
