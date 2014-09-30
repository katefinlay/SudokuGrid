//
//  KFAMMockGridModel.m
//  Sudoku Grid
//
//  Created by Katharine Finlay on 9/29/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import "KFAMMockGridModel.h"

@implementation KFAMMockGridModel

- (void) makeGridForTesting {
    int initialGrid[81] =
    {1,0,3,5,0,0,0,0,9,
        0,0,2,4,6,0,0,7,0,
        2,4,0,1,0,0,0,0,0,
        0,0,0,0,2,6,7,0,8,
        0,0,1,0,7,0,9,4,0,
        0,6,4,0,1,0,0,0,2,
        5,0,0,9,0,1,6,0,0,
        0,0,0,0,5,4,0,1,0,
        7,3,0,0,0,0,0,0,0};
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            [self inputNumber:initialGrid[(r*9+c)] atRow:r andCol:c];
        }
    }
}
@end
