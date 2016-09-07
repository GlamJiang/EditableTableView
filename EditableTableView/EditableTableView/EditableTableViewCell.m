//
//  EditableTableViewCell.m
//  EditableTableView
//
//  Created by glam on 16/8/13.
//  Copyright © 2016年 glam. All rights reserved.
//

#import "EditableTableViewCell.h"

@interface EditableTableViewCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation EditableTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textField.delegate = self;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(editableCellBeginEdit:)]) {
        [self.delegate editableCellBeginEdit:self];
    }
}

@end
