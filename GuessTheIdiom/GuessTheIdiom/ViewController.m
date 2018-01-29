//
//  ViewController.m
//  GuessTheIdiom
//
//  Created by Soney_Yin on 2018/1/26.
//  Copyright © 2018年 Soney_Yin. All rights reserved.
//

#import "ViewController.h"
#import "UpOrDownButton.h"
#import "GuessTheIdiomModel.h"
#import "payMoneyViewController.h"

//屏幕宽高
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIImageView *BigImageView;
@property (weak, nonatomic) IBOutlet UIButton *zhanWeiButton1;
@property (weak, nonatomic) IBOutlet UIButton *zhanWeiButton2;
@property (weak, nonatomic) IBOutlet UIButton *zhanWeiButton3;
@property (weak, nonatomic) IBOutlet UIButton *zhanWeiButton4;
@property (weak, nonatomic) IBOutlet UIImageView *moneyImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhanWeiButton3CenterContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhanWeiButton3Width;
@property (nonatomic,strong) NSMutableArray *buttonArray;
@property (nonatomic,strong) NSMutableArray *dataSourcesArray;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"看图猜成语";
    self.buttonArray = [[NSMutableArray alloc]init];
    self.dataSourcesArray = [[NSMutableArray alloc]init];
    self.moneyImageView.layer.masksToBounds = YES;
    self.moneyImageView.layer.cornerRadius = self.moneyImageView.frame.size.width/2;
    self.BigImageView.layer.masksToBounds = YES;
    self.BigImageView.layer.cornerRadius = 4;
    self.zhanWeiButton1.layer.masksToBounds = self.zhanWeiButton2.layer.masksToBounds = self.zhanWeiButton3.layer.masksToBounds = self.zhanWeiButton4.layer.masksToBounds = YES;
    self.zhanWeiButton1.layer.cornerRadius = self.zhanWeiButton2.layer.cornerRadius = self.zhanWeiButton3.layer.cornerRadius = self.zhanWeiButton4.layer.cornerRadius = 3;
    self.zhanWeiButton3Width.constant = (screenWidth-75)/8;
    self.zhanWeiButton3CenterContent.constant = ((screenWidth-75)/8)/2+3;
    [self createDataSources];//创建数据
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    GuessTheIdiomModel *model = [self.dataSourcesArray objectAtIndex:[[userDefault objectForKey:@"count"] integerValue]];
    self.topLabel.text = [NSString stringWithFormat:@"%ld",[[userDefault objectForKey:@"count"] integerValue]+1];
    self.moneyLabel.text = [NSString stringWithFormat:@"%ld",[[userDefault objectForKey:@"moneyCount"] integerValue]];
    self.BigImageView.image = [UIImage imageNamed:model.imageName];
    for (int i=0; i<24; i++) {
        UpOrDownButton *button = [UpOrDownButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20+(i%8)*((screenWidth-75)/8+5), self.moneyImageView.frame.origin.y+self.moneyImageView.frame.size.height+20+((screenWidth-75)/8+5)*(i/8), (screenWidth-75)/8, (screenWidth-75)/8);
        button.oldCenter = button.center;
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [button setTitle:[model.nameArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"占位符1.jpeg"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(allButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
        [self.view addSubview:button];
    }
}
-(void)createDataSources{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"GuessTheIdiomModel" ofType:@"plist"];
    //newsModel.plist文件
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    for (NSDictionary *dic in data1) {
        GuessTheIdiomModel *model = [[GuessTheIdiomModel alloc]init];
        model.NameMeaning = [dic objectForKey:@"NameMeaning"];
        model.name = [dic objectForKey:@"name"];
        model.imageName = [dic objectForKey:@"imageName"];
        model.nameStr = [dic objectForKey:@"nameStr"];
        [self.dataSourcesArray addObject:model];
    }
}
-(void)allButtonClick:(UpOrDownButton*)sender{
    
    if (!sender.isUp) {
        sender.oldCenter = sender.center;
        ViewController *__weak weakSelf = self;
        if (_zhanWeiButton1.selected) {
            if (_zhanWeiButton2.selected) {
                if (_zhanWeiButton3.selected) {
                    if (_zhanWeiButton4.selected) {
                        return;
                    }else{
                        [UIView animateWithDuration:0.45 animations:^{
                            sender.center = weakSelf.zhanWeiButton4.center;
                            weakSelf.zhanWeiButton4.titleLabel.text = sender.titleLabel.text;
                            weakSelf.zhanWeiButton4.selected = YES;
                            sender.upButton = weakSelf.zhanWeiButton4;
                            sender.isUp = YES;
                        }];
                    }
                }else{
                    [UIView animateWithDuration:0.45 animations:^{
                        sender.center = weakSelf.zhanWeiButton3.center;
                        weakSelf.zhanWeiButton3.titleLabel.text = sender.titleLabel.text;
                        weakSelf.zhanWeiButton3.selected = YES;
                        sender.upButton = weakSelf.zhanWeiButton3;
                        sender.isUp = YES;
                    }];
                }
            }else{
                [UIView animateWithDuration:0.45 animations:^{
                    sender.center = weakSelf.zhanWeiButton2.center;
                    weakSelf.zhanWeiButton2.titleLabel.text = sender.titleLabel.text;
                    weakSelf.zhanWeiButton2.selected = YES;
                    sender.upButton = weakSelf.zhanWeiButton2;
                    sender.isUp = YES;
                }];
            }
        }else{
            [UIView animateWithDuration:0.45 animations:^{
                sender.center = weakSelf.zhanWeiButton1.center;
                weakSelf.zhanWeiButton1.titleLabel.text = sender.titleLabel.text;
                weakSelf.zhanWeiButton1.selected = YES;
                sender.upButton = weakSelf.zhanWeiButton1;
                sender.isUp = YES;
            }];
        }
    }else{
        [UIView animateWithDuration:0.45 animations:^{
            sender.center = sender.oldCenter;
            sender.upButton.selected = NO;
            sender.isUp = NO;
        }];
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    GuessTheIdiomModel *model = [self.dataSourcesArray objectAtIndex:[[userDefault objectForKey:@"count"] integerValue]];
    NSMutableString *mutableStr = [[NSMutableString alloc]init];
    if (_zhanWeiButton1.selected && _zhanWeiButton2.selected && _zhanWeiButton3.selected && _zhanWeiButton4.selected) {
        [mutableStr appendString:_zhanWeiButton1.titleLabel.text];
        [mutableStr appendString:_zhanWeiButton2.titleLabel.text];
        [mutableStr appendString:_zhanWeiButton3.titleLabel.text];
        [mutableStr appendString:_zhanWeiButton4.titleLabel.text];
        if ([model.name isEqualToString:mutableStr]) {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:[NSString stringWithFormat:@"%ld",[[userDefault objectForKey:@"moneyCount"] integerValue]+5] forKey:@"moneyCount"];
            NSInteger count = [[userDefault objectForKey:@"count"] integerValue];
            GuessTheIdiomModel *model = [self.dataSourcesArray objectAtIndex:count];
            if (count>=self.dataSourcesArray.count-1) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"message:[NSString stringWithFormat:@"恭喜你，金币数量+5  \n%@：%@  \n\n同时闯关成功，再来一遍吧",model.name,model.NameMeaning] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
                [alert show];
                [userDefault setObject:@"0" forKey:@"count"];
                [userDefault synchronize];
                return;
            }else{
                [userDefault setObject:[NSString stringWithFormat:@"%ld",[[userDefault objectForKey:@"count"] integerValue]+1] forKey:@"count"];
                [userDefault synchronize];
                [self showAlert:[NSString stringWithFormat:@"恭喜你，金币数量+5  \n\n%@：%@",model.name,model.NameMeaning] withTime:3 withOtherButtonStr:@"确定"];
            }
        }else{
            [self showAlert:@"中间有错误哦" withTime:1 withOtherButtonStr:nil];
        }
    }
}
/**
 *  弹框提示
 */
- (void)showAlert:(NSString*)message withTime:(NSTimeInterval)timer withOtherButtonStr:(NSString*)str{
    
    UIAlertView *alert;
    if (str.length > 0) {
        alert = [[UIAlertView alloc]initWithTitle:@"提示"message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    }else{
        alert = [[UIAlertView alloc]initWithTitle:@"提示"message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        // 2秒后执行
        [self performSelector:@selector(dimissAlert:)withObject:alert afterDelay:timer];
    }
    [alert show];
}
/**
 *  移除弹框
 */
- (void) dimissAlert:(UIAlertView *)alert {
    if(alert){
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==10086) {
        switch (buttonIndex) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                payMoneyViewController *view = [[payMoneyViewController alloc]initWithNibName:@"payMoneyViewController" bundle:nil];
                [view setSelectedReturnBlock:^(NSString *returnName) {
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:[NSString stringWithFormat:@"%ld",[[userDefault objectForKey:@"moneyCount"] integerValue]+[returnName integerValue]] forKey:@"moneyCount"];
                    [userDefault synchronize];
                    self.moneyLabel.text = [userDefault objectForKey:@"moneyCount"];
                }];
                [self.navigationController pushViewController:view animated:YES];
            }
            default:
                break;
        }
    }else{
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSInteger count = [[userDefault objectForKey:@"count"] integerValue];
        self.topLabel.text = [NSString stringWithFormat:@"%ld",count+1];
        self.moneyLabel.text = [userDefault objectForKey:@"moneyCount"];
        GuessTheIdiomModel *model = [self.dataSourcesArray objectAtIndex:count];
        self.BigImageView.image = [UIImage imageNamed:model.imageName];
        for (int i=0; i<self.buttonArray.count; i++) {
            UpOrDownButton *button = [self.buttonArray objectAtIndex:i];
            button.isUp = NO;
            button.center = button.oldCenter;
            [button setTitle:[model.nameArray objectAtIndex:i] forState:UIControlStateNormal];
            self.zhanWeiButton1.selected = self.zhanWeiButton2.selected = self.zhanWeiButton3.selected = self.zhanWeiButton4.selected = NO;
        }
    }
}
- (IBAction)BigImageViewButtonClick:(UIButton *)sender {
    
    ViewController *__weak weakSelf = self;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger count = [[userDefault objectForKey:@"count"] integerValue];
    GuessTheIdiomModel *model = [self.dataSourcesArray objectAtIndex:count];
    switch (sender.tag) {
        case 0:
        {
            if ([[userDefault objectForKey:@"moneyCount"] integerValue] < 10) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"需要试金币，您的金币不足，是否充值？" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
                alertView.tag = 10086;
                [alertView show];
                return;
            }
            if (_zhanWeiButton1.selected) {
                if (_zhanWeiButton2.selected) {
                    if (_zhanWeiButton3.selected) {
                        if (_zhanWeiButton4.selected) {
                            [self showAlert:@"没位置了你还提示个屁啊！" withTime:1 withOtherButtonStr:nil];
                            return;
                        }else{
                            NSString *forth = [model.name substringWithRange:NSMakeRange(3,1)];
                            for (UpOrDownButton *button in self.buttonArray) {
                                if ([button.titleLabel.text isEqualToString:forth]) {
                                    if (button.isUp) {
                                        if ([_zhanWeiButton1.titleLabel.text isEqualToString:button.titleLabel.text]) {
                                            _zhanWeiButton1.selected = NO;
                                        }else if ([_zhanWeiButton2.titleLabel.text isEqualToString:button.titleLabel.text]){
                                            _zhanWeiButton2.selected = NO;
                                        }else if ([_zhanWeiButton3.titleLabel.text isEqualToString:button.titleLabel.text]){
                                            _zhanWeiButton3.selected = NO;
                                        }
                                    }
                                    [UIView animateWithDuration:0.45 animations:^{
                                        button.center = weakSelf.zhanWeiButton4.center;
                                        weakSelf.zhanWeiButton4.titleLabel.text = button.titleLabel.text;
                                        weakSelf.zhanWeiButton4.selected = YES;
                                        button.upButton = weakSelf.zhanWeiButton4;
                                        button.isUp = YES;
                                    }];
                                    break;
                                }
                            }
                            [userDefault setObject:[NSString stringWithFormat:@"%ld",[[userDefault objectForKey:@"moneyCount"] integerValue]-10] forKey:@"moneyCount"];
                            [userDefault synchronize];
                            self.moneyLabel.text = [userDefault objectForKey:@"moneyCount"];
                        }
                    }else{
                        NSString *third = [model.name substringWithRange:NSMakeRange(2,1)];
                        for (UpOrDownButton *button in self.buttonArray) {
                            if ([button.titleLabel.text isEqualToString:third]) {
                                if (button.isUp) {
                                    if ([_zhanWeiButton1.titleLabel.text isEqualToString:button.titleLabel.text]) {
                                        _zhanWeiButton1.selected = NO;
                                    }else if ([_zhanWeiButton2.titleLabel.text isEqualToString:button.titleLabel.text]){
                                        _zhanWeiButton2.selected = NO;
                                    }else if ([_zhanWeiButton4.titleLabel.text isEqualToString:button.titleLabel.text]){
                                        _zhanWeiButton4.selected = NO;
                                    }
                                }
                                [UIView animateWithDuration:0.45 animations:^{
                                    button.center = weakSelf.zhanWeiButton3.center;
                                    weakSelf.zhanWeiButton3.titleLabel.text = button.titleLabel.text;
                                    weakSelf.zhanWeiButton3.selected = YES;
                                    button.upButton = weakSelf.zhanWeiButton3;
                                    button.isUp = YES;
                                }];
                                break;
                            }
                        }
                        [userDefault setObject:[NSString stringWithFormat:@"%ld",[[userDefault objectForKey:@"moneyCount"] integerValue]-10] forKey:@"moneyCount"];
                        [userDefault synchronize];
                        self.moneyLabel.text = [userDefault objectForKey:@"moneyCount"];
                    }
                }else{
                    NSString *second = [model.name substringWithRange:NSMakeRange(1,1)];
                    for (UpOrDownButton *button in self.buttonArray) {
                        if ([button.titleLabel.text isEqualToString:second]) {
                            if (button.isUp) {
                                if ([_zhanWeiButton1.titleLabel.text isEqualToString:button.titleLabel.text]) {
                                    _zhanWeiButton1.selected = NO;
                                }else if ([_zhanWeiButton3.titleLabel.text isEqualToString:button.titleLabel.text]){
                                    _zhanWeiButton3.selected = NO;
                                }else if ([_zhanWeiButton4.titleLabel.text isEqualToString:button.titleLabel.text]){
                                    _zhanWeiButton4.selected = NO;
                                }
                            }
                            [UIView animateWithDuration:0.45 animations:^{
                                button.center = weakSelf.zhanWeiButton2.center;
                                weakSelf.zhanWeiButton2.titleLabel.text = button.titleLabel.text;
                                weakSelf.zhanWeiButton2.selected = YES;
                                button.upButton = weakSelf.zhanWeiButton2;
                                button.isUp = YES;
                            }];
                            break;
                        }
                    }
                    [userDefault setObject:[NSString stringWithFormat:@"%ld",[[userDefault objectForKey:@"moneyCount"] integerValue]-10] forKey:@"moneyCount"];
                    [userDefault synchronize];
                    self.moneyLabel.text = [userDefault objectForKey:@"moneyCount"];
                }
            }else{
                NSString *first = [model.name substringToIndex:1];
                for (UpOrDownButton *button in self.buttonArray) {
                    if ([button.titleLabel.text isEqualToString:first]) {
                        if (button.isUp) {
                            if ([_zhanWeiButton2.titleLabel.text isEqualToString:button.titleLabel.text]) {
                                _zhanWeiButton2.selected = NO;
                            }else if ([_zhanWeiButton3.titleLabel.text isEqualToString:button.titleLabel.text]){
                                _zhanWeiButton3.selected = NO;
                            }else if ([_zhanWeiButton4.titleLabel.text isEqualToString:button.titleLabel.text]){
                                _zhanWeiButton4.selected = NO;
                            }
                        }
                        [UIView animateWithDuration:0.45 animations:^{
                            button.center = weakSelf.zhanWeiButton1.center;
                            weakSelf.zhanWeiButton1.titleLabel.text = button.titleLabel.text;
                            weakSelf.zhanWeiButton1.selected = YES;
                            button.upButton = weakSelf.zhanWeiButton1;
                            button.isUp = YES;
                        }];
                        break;
                    }
                }
                [userDefault setObject:[NSString stringWithFormat:@"%ld",[[userDefault objectForKey:@"moneyCount"] integerValue]-10] forKey:@"moneyCount"];
                [userDefault synchronize];
                self.moneyLabel.text = [userDefault objectForKey:@"moneyCount"];
            }
        }
            break;
        case 1:
        {
            [self showAlert:@"没有可以求助的对象" withTime:1 withOtherButtonStr:nil];
        }
            break;
        case 2:
        {
            [self showAlert:@"没有地方可以分享" withTime:1 withOtherButtonStr:nil];
        }
            break;
        default:
            break;
    }
    NSMutableString *mutableStr = [[NSMutableString alloc]init];
    if (_zhanWeiButton1.selected && _zhanWeiButton2.selected && _zhanWeiButton3.selected && _zhanWeiButton4.selected) {
        [mutableStr appendString:_zhanWeiButton1.titleLabel.text];
        [mutableStr appendString:_zhanWeiButton2.titleLabel.text];
        [mutableStr appendString:_zhanWeiButton3.titleLabel.text];
        [mutableStr appendString:_zhanWeiButton4.titleLabel.text];
        if ([model.name isEqualToString:mutableStr]) {
            [userDefault setObject:[NSString stringWithFormat:@"%ld",[[userDefault objectForKey:@"moneyCount"] integerValue]+5] forKey:@"moneyCount"];
            NSInteger count = [[userDefault objectForKey:@"count"] integerValue];
            GuessTheIdiomModel *model = [self.dataSourcesArray objectAtIndex:count];
            if (count>=self.dataSourcesArray.count-1) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"message:[NSString stringWithFormat:@"恭喜你，金币数量+5  \n%@：%@  \n\n同时闯关成功，再来一遍吧",model.name,model.NameMeaning] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
                alert.tag = 10086;
                [alert show];
                [userDefault setObject:@"0" forKey:@"count"];
                [userDefault synchronize];
                return;
            }else{
                [userDefault setObject:[NSString stringWithFormat:@"%ld",[[userDefault objectForKey:@"count"] integerValue]+1] forKey:@"count"];
                [userDefault synchronize];
                [self showAlert:[NSString stringWithFormat:@"恭喜你，金币数量+5  \n\n%@：%@",model.name,model.NameMeaning] withTime:3 withOtherButtonStr:@"确定"];
            }
        }else{
            [self showAlert:@"中间有错误哦" withTime:1 withOtherButtonStr:nil];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
