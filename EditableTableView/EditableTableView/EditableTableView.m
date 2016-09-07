//
//  EditableTableView.m
//  EditableTableView
//
//  Created by glam on 16/8/13.
//  Copyright © 2016年 glam. All rights reserved.
//

#import "EditableTableView.h"

@interface EditableTableView()

@property (assign, nonatomic) CGFloat originOffsetY;
@property (assign, nonatomic) CGFloat editCellY;
@property (assign, nonatomic) CGFloat tableContentHeight;

@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@end

@implementation EditableTableView

- (void)registKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHiden:) name:UIKeyboardDidHideNotification object:nil];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
}
- (void)awakeFromNib
{
    [self registKeyboardObserver];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registKeyboardObserver];
    }
    
    return self;
}

- (void)resetContentSize
{
    self.tableContentHeight = self.contentSize.height;
}
- (void)editAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rectInTableView = [self rectForRowAtIndexPath:indexPath];
    CGRect rect = [self convertRect:rectInTableView toView:[self superview]];
    float originY = [self superview].frame.origin.y;
    
    self.originOffsetY = self.contentOffset.y;
    self.editCellY = rect.origin.y + originY + self.originOffsetY;
    
    [self addGestureRecognizer:self.tapGesture];
}

#pragma mark - KeyboardNotifications
- (void)keyboardFrameChanged:(NSNotification *)noti
{
    NSDictionary *info = [noti userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    CGFloat totalHeight = kbSize.height + self.editCellY + 40;//40?键盘上的提示
    if (totalHeight > screenSize.height) {
        
        CGFloat time = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        [UIView animateWithDuration:time animations:^{
            self.contentOffset = CGPointMake(0, totalHeight - screenSize.height);
        }];
        
    }
    
    [self setContentSize:CGSizeMake(self.contentSize.width, self.tableContentHeight + kbSize.height)];
}

- (void)keyboardDidHiden:(NSNotification *)noti
{
    [self setContentSize:CGSizeMake(self.contentSize.width, self.tableContentHeight)];
    
    NSDictionary *info = [noti userInfo];
    CGFloat time = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:time animations:^{
        self.contentOffset = CGPointMake(0, self.originOffsetY);
    }];
}

#pragma mark - 屏幕点击
- (void)onTap:(UITapGestureRecognizer *)tapGesture
{
    [self endEditing:YES];
    
    [self removeGestureRecognizer:self.tapGesture];
}

@end
