//
//  KLKeyBoardBar.h
//  KLTextView
//
//  Created by Khang Le on 6/12/13.
//  Copyright (c) 2013 Khang Le. All rights reserved.
//

#import <UIKit/UIKit.h>

enum KLKeyboardLocation {
    KLKeyBoardTop = 0,
    KLKeyBoardBottom = 1
    };

@interface KLKeyboardBar : UIView

@property (nonatomic, strong) NSMutableArray *resizeViews;
@property (nonatomic, assign) BOOL animated;

@end
