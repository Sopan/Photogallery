//
//  SSOverlayView.m
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import "SSOverlayView.h"

@interface SSOverlayView ()

@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation SSOverlayView

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.numberOfLines = 0;
    }
    
    return _messageLabel;
}


- (instancetype)initWithFrame:(CGRect)iFrame message:(NSString *)iMessage {
    self = [super initWithFrame:iFrame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
        self.messageLabel.text = iMessage;
        [self addSubview:self.messageLabel];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize aLabelSize = [self.messageLabel sizeThatFits:self.frame.size];
    self.messageLabel.frame = CGRectMake(self.frame.size.width / 2.0 - aLabelSize.width / 2.0, self.frame.size.height / 2.0 - aLabelSize.height / 2.0, aLabelSize.width, aLabelSize.height);
}

@end
