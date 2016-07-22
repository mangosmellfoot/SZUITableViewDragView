//
//  ViewController.m
//  DraggingView
//
//  Created by zhaotai on 16/7/19.
//  Copyright © 2016年 zhaotai. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UITableView+SZDragLoadView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView * tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor grayColor];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    __weak UITableView * weakTableView = tableView;
    [tableView topDragViewEnableWith:nil andShowingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakTableView topStopShowing];
        });
    }];
    [tableView bottomDragViewEnableWith:nil andShowingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakTableView bottomStopShowing];
            
            [weakTableView removeFromSuperview];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate and UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"很不好！";
    return cell;
}



@end
