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

- (void)getRawGrid;

- (KFAMGridModel*)getGridModel;

- (NSMutableArray*)getArray;


@end
