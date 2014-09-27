//
//  KFAMGridView.m
//  viewTutorial
//
//  Created by Katharine Finlay on 9/11/14.
//  Copyright (c) 2014 Kate Finlay. All rights reserved.
//

#import "KFAMGridView.h"

@interface KFAMGridView () {
    NSMutableArray* _cells;
    id _target;
    SEL _action;
}

@end

@implementation KFAMGridView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeButtonsWithFrame:frame];
    }
    return self;
}

-(void)setAction:(SEL)action withTarget:(id)target {
    _target = target;
    _action = action;
}

- (void)buttonPressed:(id)sender {
    UIButton* button = (UIButton*) sender;
    NSNumber* num = [NSNumber numberWithInteger:[button tag]];
    [_target performSelector:_action withObject:num];
}

- (void)makeButtonsWithFrame:(CGRect)frame {
    _cells = [[NSMutableArray alloc] initWithCapacity:9];

    // Each button is 1/12 of the total frame size, the remaining 1/6 is divided between
    // large and small boundaries. Large boundaries are 1/24 of the total frame and small
    // boundaries are 1/72 of the total frame area.
    const CGFloat numDivisions = 12.0;
    CGFloat buttonSize = frame.size.width/numDivisions;
    CGFloat largeBoundary = frame.size.width/(numDivisions*2);
    CGFloat smallBoundary = frame.size.width/(numDivisions*6);
    
    //create grid view
    self.backgroundColor = [UIColor blackColor];
    int currentTag = 0;
    CGFloat yOffset = 0.0;
    
    for (int r = 0; r < 9; r++) {
        CGFloat xOffset = 0.0;
        NSMutableArray* row = [[NSMutableArray alloc] initWithCapacity:9];
        
        if (r % 3 == 0) {
            yOffset = yOffset + largeBoundary;
        } else {
            yOffset = yOffset + smallBoundary;
        }
        
        for (int c = 0; c < 9; c++) {
            if (c % 3 == 0 ) {
                xOffset = xOffset + largeBoundary;
            } else {
                xOffset = xOffset + smallBoundary;
            }
            
            UIButton* button;
            CGRect buttonFrame = CGRectMake(xOffset, yOffset, buttonSize, buttonSize);
            button = [[UIButton alloc] initWithFrame:buttonFrame];
            [self createButton:button withTag:currentTag andSize:buttonSize];
            
            currentTag++;
            [row insertObject:button atIndex:c];
            xOffset = xOffset + buttonSize;
        }
        [_cells insertObject: row atIndex: r];
        yOffset = yOffset + buttonSize;
    }
}

- (void)createButton:(UIButton*) button
                    withTag:(int)tag
                    andSize:(int)buttonSize {
    //createbutton
    button.backgroundColor = [UIColor whiteColor];
    [self addSubview:button];
    
    // give button correct attributes
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.showsTouchWhenHighlighted = YES;
    button.tag = tag;
}


- (UIButton*)getCellWithRow:(int)row
                     andCol:(int)col {
    return _cells[row][col];
}

- (void)displayNumber:(int)newNum
              atRow:(int)row
             andCol:(int)col
             andColor:(UIColor*)color {
    NSLog(@"in display number, trying to show %d at %d %d", newNum, row, col);
    UIButton* currentButton = [self getCellWithRow:row andCol:col];
    [currentButton setTitleColor:color forState:UIControlStateNormal];
    [currentButton setTitle:[NSString stringWithFormat:@"%d", newNum] forState:UIControlStateNormal];
    if (newNum == 0) {
        [currentButton setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
    }
}

//- (void)setValueForCellAtRow:(int)row
//                      andCol:(int)col
//                   withValue:(int)value {
//    
//    UIButton* cell = [self getCellWithRow:row andCol:col];
//    
//    //retrieve the proper number
//    NSString* numToFill;
//    if (value == 0) {
//        numToFill = @"";
//    } else {
//        numToFill = [NSString stringWithFormat:@"%d", value];
//    }
//    
//    [cell setTitle:numToFill forState:UIControlStateNormal];
//}

@end
