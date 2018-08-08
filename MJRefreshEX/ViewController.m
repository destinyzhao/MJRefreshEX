//
//  ViewController.m
//  MJRefreshEX
//
//  Created by Destiny on 2018/5/16.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+MJRefreshEX.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation ViewController

- (NSMutableArray *)listArr
{
    if (!_listArr) {
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        [self loadData:YES];
    }];
    
    [self.tableView addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        [self loadData:NO];
    }];
    
    [self loadData:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData:(BOOL)isRef
{
    if (isRef) {
        [self.listArr removeAllObjects];
    }
    for (int i = 0; i < 10; i ++) {
        [self.listArr addObject:@(i)];
    }

    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
