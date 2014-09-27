//
//  KFAMNumPadView.h
//  Sudoku Grid
//
//  Created by Katharine Finlay on 9/20/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFAMNumPadView : UIView

-(int) getCurrentNumSelected;

-(void) setCurrentNum:(int)number;

@end
