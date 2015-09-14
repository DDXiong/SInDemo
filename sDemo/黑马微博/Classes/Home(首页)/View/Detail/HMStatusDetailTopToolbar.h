//
//  HMStatusDetailTopToolbar.h
//  黑马微博
//
//  Created by apple on 14-7-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HMStatusDetailTopToolbarButtonTypeRetweeted,
    HMStatusDetailTopToolbarButtonTypeComment,
} HMStatusDetailTopToolbarButtonType;

@class HMStatusDetailTopToolbar, HMStatus;

@protocol HMStatusDetailTopToolbarDelegate <NSObject>

@optional
- (void)topToolbar:(HMStatusDetailTopToolbar *)topToolbar didSelectedButton:(HMStatusDetailTopToolbarButtonType)buttonType;
@end

@interface HMStatusDetailTopToolbar : UIView
+ (instancetype)toolbar;

@property (nonatomic, weak) id<HMStatusDetailTopToolbarDelegate> delegate;
@property (nonatomic, assign) HMStatus *status;

@property (nonatomic, assign) HMStatusDetailTopToolbarButtonType selectedButtonType;
@end
