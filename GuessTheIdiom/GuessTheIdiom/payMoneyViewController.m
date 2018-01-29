//
//  payMoneyViewController.m
//  GuessTheIdiom
//
//  Created by Soney_Yin on 2018/1/27.
//  Copyright © 2018年 Soney_Yin. All rights reserved.
//

#import "payMoneyViewController.h"
#import "CollectionViewCell.h"

//屏幕宽高
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface payMoneyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSourcesArray;
@property (nonatomic,strong) NSString *money;

@end

@implementation payMoneyViewController

-(void)setSelectedReturnBlock:(SelectedReturnBlock)selectedReturnBlock{
    
    _selectedReturnBlock = selectedReturnBlock;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"金币充值界面";
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.dataSourcesArray = [[NSMutableArray alloc]initWithObjects:@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100",nil];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 1.设置列间距
    layout.minimumInteritemSpacing = 10;
    // 2.设置行间距
    layout.minimumLineSpacing = 10;
    // 3.设置每个item的大小
    layout.itemSize = CGSizeMake((screenWidth-52)/4, 50);
    // 5.设置布局方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 8.设置分区(组)的EdgeInset（四边距）
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSourcesArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    NSString *str = [NSString stringWithFormat:@"%@金币",[self.dataSourcesArray objectAtIndex:indexPath.item]];
    //创建NSMutableAttributedString
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    //设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(str.length-2, 2)];
    cell.label.attributedText = attrStr;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.money = [_dataSourcesArray objectAtIndex:indexPath.item];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"充值确认" message:[NSString stringWithFormat:@"确认充值%@个金币吗？",self.money] delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [alertView show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            [self showAlert:@"充值成功"];
            _selectedReturnBlock(self.money);
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
    
}
- (void)showAlert:(NSString*)message{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    // 2秒后执行
    [self performSelector:@selector(dimissAlert:)withObject:alert afterDelay:1];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
