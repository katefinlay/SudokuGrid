//
//  KFAMGridModel.h
//  Sudoku Grid
//
//  Created by Katharine Finlay on 9/20/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFAMGridModel : NSObject

-(void) initialize;

- (int)getNumberWithRow:(int)row
                 andCol:(int)col;

- (BOOL)isValidValue:(int)val
                   forRow:(int)row
                   andCol:(int)col;

- (BOOL)isMutableForRow:(int)row
              andCol:(int)col;

- (void)inputNumber:(int)newNum
              atRow:(int)row
             andCol:(int)col;

- (void)makeNewGame;

- (BOOL)checkSolution;
@end
