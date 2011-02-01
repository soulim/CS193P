//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Alex Soulim on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
	double operand;
	double waitingOperand;
	double operandInMemory;
	NSString *waitingOperation;
}

- (void)setOperand:(double)aDouble;
- (double)performOperation:(NSString *)operation;

@end
