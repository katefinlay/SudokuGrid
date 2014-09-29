//
//  KFAMGridGenerator.h
//  Sudoku Grid
//
//  Created by Jun Hong Park on 9/26/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KFAMGridModel.h"

@interface KFAMGridGenerator : NSObject

// parse the text file with our grids and randomly select a line representing a grid
- (void)getRawGrid;

// return the int grid array of the selected line
- (KFAMGridModel*)getGridModel;

// return the NSMutableArray of the selected line
- (NSMutableArray*)getArray;


@end
