//
//  KLTextView.h
//  KLTextView
//
//  Created by Khang Le on 6/12/13.
//  Copyright (c) 2013 Khang Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSMutableArray *resizedViews;
@property (nonatomic, assign) NSUInteger maxLines;
@property (nonatomic, assign) BOOL resizeSuperView;

@end
