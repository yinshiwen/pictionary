//
//  payMoneyViewController.h
//  GuessTheIdiom
//
//  Created by Soney_Yin on 2018/1/27.
//  Copyright © 2018年 Soney_Yin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectedReturnBlock)(NSString *returnName);

@interface payMoneyViewController : UIViewController

@property (nonatomic, copy) SelectedReturnBlock selectedReturnBlock;

@end
