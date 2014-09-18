//
//  KFAMGridView.h
//  viewTutorial
//
//  Created by Katharine Finlay on 9/11/14.
//  Copyright (c) 2014 Kate Finlay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFAMGridView : UIView

- (void)setValueForCellAtRow:(int)row
                      andCol:(int)col
                   withValue:(int)value;

-(void)setAction:(SEL)action withTarget:(id)target;

@end