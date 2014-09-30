//
//  KFAMGridGenerator.h
//  Sudoku Grid
//
//  Created by Katharine Finlay on 9/29/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFAMGridGenerator : NSObject

- (void)generateNewGrid;

- (int)getNumberWithRow:(int)row
                 andCol:(int)col;

- (void)initialize;

@end
