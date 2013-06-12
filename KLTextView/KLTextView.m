//
//  KLTextView.m
//  KLTextView
//
//  Created by Khang Le on 6/12/13.
//  Copyright (c) 2013 Khang Le. All rights reserved.
//

#import "KLTextView.h"

#define kMaxLines 5

@interface KLTextView()

- (void)beginEditing:(NSNotification*)notification;
- (void)didChange:(NSNotification*)notification;
- (void)endEditing:(NSNotification*)notification;

@end

@implementation KLTextView

@synthesize placeholder = _placeholder;
@synthesize resizedViews = _resizedViews;
@synthesize resizeSuperView = _resizeSuperView;
@synthesize maxLines = _maxLines;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _resizedViews = [[NSMutableArray alloc] init];
        _resizeSuperView = YES;
        _maxLines = kMaxLines;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame placeholder:(NSString*)placeholder resizedViews:(NSMutableArray*)resizedViews
{
    if (self = [super initWithFrame:frame]) {
        _placeholder = placeholder;
        _resizedViews = resizedViews;
        _resizeSuperView = YES;
    }
    return self;
}

- (void)awakeFromNib
{
    _resizedViews = [[NSMutableArray alloc] init];
    _resizeSuperView = YES;
    _maxLines = kMaxLines;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (NSString*)trimmedText
{
    return [self.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
}

- (void)beginEditing:(NSNotification*)notification
{
    if ([self.text isEqualToString:_placeholder]) {
        self.text = @"";
    }
}

- (void)didChange:(NSNotification*)notification
{
    [self resizeTextView:self];
}

- (void)endEditing:(NSNotification *)notification
{
    if ([self.text isEqualToString:@""]) {
        self.text = _placeholder;
    }
}


- (void)resizeTextView:(UITextView*)textview
{
    CGFloat deltaY = textview.contentSize.height - textview.frame.size.height;
    CGFloat lines = textview.contentSize.height / textview.font.lineHeight;
    if (lines > _maxLines + 1) return;
    
    if (_resizeSuperView) {
        CGRect textSuper = textview.superview.frame;
        textSuper.origin.y -= deltaY;
        textSuper.size.height += deltaY;
        textview.superview.frame = textSuper;
    }
    
    for (UIView *view in _resizedViews) {
        CGRect frame = view.frame;
        frame.size.height -= frame.size.height;
        view.frame = frame;
    }

    CGRect frame = textview.frame;
    frame.size.height = textview.contentSize.height;
    textview.frame = frame;
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
