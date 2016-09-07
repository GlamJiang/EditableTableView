//
//  EditableTableView.h
//  EditableTableView
//
//  Created by glam on 16/8/13.
//  Copyright © 2016年 glam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditableTableView : UITableView

/**
 * 重新获取ContentSize
 * tableView数据源第一次设置或更改后reload的时候需调用这个方法
*/
- (void)resetContentSize;

//编辑某个cell
- (void)editAtIndexPath:(NSIndexPath *)indexPath;

@end
