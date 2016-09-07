//
//  ViewController.m
//  EditableTableView
//
//  Created by glam on 16/8/13.
//  Copyright © 2016年 glam. All rights reserved.
//

#import "ViewController.h"
#import "EditableTableView.h"

#import "EditableTableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, EditableTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet EditableTableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"EditableTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView resetContentSize];
}

#pragma mark - UITableViewDelegate&Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.indexPath = indexPath;
    
    cell.delegate = self;
    
    NSString *name = [NSString stringWithFormat:@"姓名:%ld", (long)indexPath.row];
    cell.name = name;
    
    return cell;
}

#pragma mark - EditableTableViewCellDelegate
- (void)editableCellBeginEdit:(EditableTableViewCell *)cell
{
    [self.tableView editAtIndexPath:cell.indexPath];
}

@end
