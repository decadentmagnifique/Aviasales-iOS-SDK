//
//  JRScreneSceneScrollView.m
//
//  Copyright 2016 Go Travel Un Limited
//  This code is distributed under the terms and conditions of the MIT license.
//

#import "JRScreneSceneScrollView.h"
#import "JRSwipeDeletionTableViewCell.h"
#import "NMRangeSlider.h"

@implementation JRScreneSceneScrollView

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [self setDelaysContentTouches:NO];
    [self setCanCancelContentTouches:NO];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	UIView *result = [super hitTest:point withEvent:event];
    
	if ([result isKindOfClass:[UISlider class]] ||
	    [result isKindOfClass:[NMRangeSlider class]] ||
	    [result isKindOfClass:[UITableView class]]) {
		self.scrollEnabled = NO;
	} else if ([self shouldDisableScrollForSwipeDeletionCell:result]) {
        self.scrollEnabled = NO;
    } else {
		self.scrollEnabled = YES;
	}
	return result;
}

- (BOOL)shouldDisableScrollForSwipeDeletionCell:(UIView *)view {
    if ([view isKindOfClass:[JRSwipeDeletionTableViewCell class]] ) {
        JRSwipeDeletionTableViewCell *cell = (JRSwipeDeletionTableViewCell *)view;
        return cell.swipingDisabled ? NO : YES;
    } else if (view.superview) {
        return [self shouldDisableScrollForSwipeDeletionCell:view.superview];
    } else {
        return NO;
    }
}

@end
