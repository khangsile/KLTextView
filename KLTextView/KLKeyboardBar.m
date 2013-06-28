//
//  KLKeyBoardBar.m
//  KLTextView
//
//  Created by Khang Le on 6/12/13.
//  Copyright (c) 2013 Khang Le. All rights reserved.
//

#import "KLKeyboardBar.h"

@implementation KLKeyboardBar

@synthesize resizeViews = _resizeViews;
@synthesize animated = _animated;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _resizeViews = [[NSMutableArray alloc] init];
        _animated = YES;
        [self registerForKeyboardNotifications];
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        // Initialization code
        _resizeViews = [[NSMutableArray alloc] init];
        _animated = YES;
        [self registerForKeyboardNotifications];
    }
    return self;
}

- (void)awakeFromNib
{
    _resizeViews = [[NSMutableArray alloc] init];
    _animated = YES;
    [self registerForKeyboardNotifications];
}

- (void)dealloc
{
    [self unregisterForKeyboardNotifications];
}

- (void)registerForKeyboardNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)unregisterForKeyboardNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat insetHeight = keyboardFrame.size.height;
    
    CGRect selfFrame = self.frame;
    selfFrame.origin.y -= insetHeight;
    
    if (_animated) {
        NSValue *value = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSTimeInterval duration = 0;
        [value getValue:&duration];
        
        [UIView animateWithDuration:duration animations:^{
            for (UIView *view in _resizeViews) {
                CGRect frame = view.frame;
                frame.size.height -= insetHeight;
                view.frame = frame;
            }
            self.frame = selfFrame;
        }];
    } else {
        for (UIView *view in _resizeViews) {
            CGRect frame = view.frame;
            frame.size.height -= insetHeight;
            view.frame = frame;
        }
        self.frame = selfFrame;

    }
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat insetHeight = keyboardFrame.size.height;
    
    if (_animated) {
        NSValue *value = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSTimeInterval duration = 0;
        [value getValue:&duration];
        
        [UIView animateWithDuration:duration animations:^{
            for (UIView *view in _resizeViews) {
                CGRect frame = view.frame;
                frame.size.height += insetHeight;
                view.frame = frame;
            }
            self.frame = selfFrame;
        }];
    } else {
        for (UIView *view in _resizeViews) {
            CGRect frame = view.frame;
            frame.size.height += insetHeight;
            view.frame = frame;
        }
        self.frame = selfFrame;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
