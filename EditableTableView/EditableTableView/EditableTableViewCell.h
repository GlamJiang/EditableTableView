//
//  EditableTableViewCell.h
//  EditableTableView
//
//  Created by glam on 16/8/13.
//  Copyright © 2016年 glam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditableTableViewCell;
@protocol EditableTableViewCellDelegate <NSObject>
@optional
- (void)editableCellBeginEdit:(EditableTableViewCell *)cell;

@end

@interface EditableTableViewCell : UITableViewCell

@property (assign, nonatomic) id<EditableTableViewCellDelegate> delegate;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (copy, nonatomic) NSString *name;

@end
