//
//  ViewController.m
//  ContractDetailDemo
//
//  Created by 思 彭 on 2017/4/7.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "SectionHeaderView.h"
#import "CellModel.h"
#import "FooterView.h"
#import "ResultModel.h"
#import <SDAutoLayout.h>
#import "UITableView+FDTemplateLayoutCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL expandFlag;
@property (nonatomic, strong) NSMutableArray *footerDataArray;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"合同详情";
    [self setUI];
    [self initialData];
}

#pragma mark - InitialData

- (void)initialData {
    
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 2; i++) {
        CellModel *model = [[CellModel alloc]init];
        model.titleStr = @"合同编号: ";
        model.contentStr = [NSString stringWithFormat:@"合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号合同编号%ld",i];
        [self.dataArray addObject:model];
    }
    self.footerDataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        ResultModel *model = [[ResultModel alloc]init];
        model.name = @"我";
        model.time = @"2017年12月20日";
        model.content = @"没事不要请假哟!";
        model.flag = @"同意";
        [self.footerDataArray addObject:model];
    }
    [self.tableView reloadData];
}

#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:NSStringFromClass([TableViewCell class])];
    [self.tableView registerClass:[SectionHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SectionHeaderView class])];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//     return ((NSArray *)(self.dataArray[section])).count;
    if (section == 0) {
        return self.dataArray.count;
    } else {
        return self.expandFlag ? 3 : 0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
     */
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewCell class]) forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TableViewCell class])];
//    }
    cell.model = self.dataArray[indexPath.row];
    //    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//     return [self cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width tableView:tableView];
//      return [self.tableView cellHeightForIndexPath:indexPath model:self.dataArray[indexPath.row] keyPath:@"model" cellClass:[TableViewCell class] contentViewWidth:K_SCREEN_WIDTH];
    // 丹丹自适应行高
//    return [tableView zxp_cellHeightWithindexPath:indexPath space:10];
//    return 230;
    // masonry
    return [self.tableView fd_heightForCellWithIdentifier:NSStringFromClass([TableViewCell class]) configuration:^(TableViewCell *cell) {
        cell.fd_enforceFrameLayout = NO;
        cell.model = self.dataArray[indexPath.row];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) return 40;
    return FLT_EPSILON;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        return [FooterView ticketExamineResultViewWithExamineResultArray:self.footerDataArray].height ? : 0.0f;
    }
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        SectionHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SectionHeaderView class])];
        sectionHeaderView.contentView.backgroundColor = [UIColor clearColor];
        sectionHeaderView.block = ^(BOOL selected) {
            NSLog(@"%d",selected);
            self.expandFlag = selected;
            [self.tableView reloadData];
        };
        return sectionHeaderView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    FooterView *ticketExamineResultView;
    if (section == 1) {
        
        ticketExamineResultView = [FooterView ticketExamineResultViewWithExamineResultArray:self.footerDataArray];
        ticketExamineResultView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return ticketExamineResultView;
    } else {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 10)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return view;
    }
    return nil;
}

@end
