//
//  KFAMNumPadView.m
//  Sudoku Grid
//
//  Created by Katharine Finlay on 9/20/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import "KFAMNumPadView.h"

@implementation KFAMNumPadView {
    NSMutableArray* _numbers;
    int _currentNumber;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeButtonsWithFrame:frame];
        _currentNumber = 1;
        [_numbers[0] setBackgroundColor:[UIColor yellowColor]];
    }
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)makeButtonsWithFrame:(CGRect)frame {
    _numbers = [[NSMutableArray alloc] initWithCapacity:9];
    
    // Each button is 1/12 of the total frame size, the remaining 1/6 is divided between
    // large and small boundaries. Large boundaries are 1/24 of the total frame and small
    // boundaries are 1/72 of the total frame area.
    
    CGFloat buttonSize = frame.size.width/10;
    CGFloat yPosition = (frame.size.height - buttonSize)/2;
    CGFloat boundary = frame.size.width/100;
    NSLog(@"Frame location is %f, %f", frame.origin.x, frame.origin.y);
    
    //create numPad view
    self.backgroundColor = [UIColor blackColor];
    int currentTag = 0;
    CGFloat offset = 0;
    
    for (int c = 0; c < 9; c++) {
        offset = offset + boundary;
        UIButton* button;
        CGRect buttonFrame = CGRectMake(offset, yPosition, buttonSize, buttonSize);
        button = [[UIButton alloc] initWithFrame:buttonFrame];
        [self createButton:button withTag:currentTag];
        
        currentTag++;
        [self addSubview:button];
        [_numbers insertObject:button atIndex:c];
        
        offset = offset + buttonSize;
    }
}

- (void)createButton:(UIButton*) button
             withTag:(int)tag {
    //createbutton
    button.backgroundColor = [UIColor whiteColor];
    NSLog(@"Button added!");
    
    // give button correct attributes
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor whiteColor]];
    
    [button setTitle:[NSString stringWithFormat:@"%d", tag + 1] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.showsTouchWhenHighlighted = YES;
    button.tag = tag;
}

- (void)buttonPressed:(id)sender {
    UIButton* button = (UIButton*) sender;
    NSNumber* num = [NSNumber numberWithInteger:[button tag]];
    NSLog(@"%d", _currentNumber);
    UIButton* oldButton = _numbers[_currentNumber - 1];
    [oldButton setBackgroundColor:[UIColor whiteColor]];
    _currentNumber = num.intValue + 1;
    [button setBackgroundColor:[UIColor yellowColor]];
    
}

-(int) getCurrentNumSelected {
    return _currentNumber;
}


@end
