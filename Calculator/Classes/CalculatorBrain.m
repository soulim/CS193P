//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Alex Soulim on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain

- (void)setOperand:(double)aDouble
{
	operand = aDouble;
}

- (void)performWaitingOperation
{
	if ([@"*" isEqual:waitingOperation]) {
		operand = waitingOperand * operand;
	}
	else if ([@"/" isEqual:waitingOperation]) {
		if (operand) {
			operand = waitingOperand / operand;
		}
	}
	else if ([@"+" isEqual:waitingOperation]) {
		operand = waitingOperand + operand;
	}
	else if ([@"-" isEqual:waitingOperation]) {
		operand = waitingOperand - operand;
	}
}

- (double)performOperation:(NSString *)operation
{
	if ([operation isEqual:@"sqrt"]) {
		operand = sqrt(operand);
	}
	else if ([operation isEqual:@"+/-"])
	{
		operand = - operand;
	}
	else if ([operation isEqual:@"1/x"])
	{
		if (operand) {
			operand = 1 / operand;
		}
	}
	else if ([operation isEqual:@"sin"])
	{
		operand = sin(operand);
	}
	else if ([operation isEqual:@"cos"])
	{
		operand = cos(operand);
	}
	else if ([operation isEqual:@"STORE"])
	{
		operandInMemory = operand;
	}
	else if ([operation isEqual:@"RECALL"])
	{
		operand = operandInMemory;
	}
	else if ([operation isEqual:@"M+"])
	{
		operandInMemory += operand;
	}
	else if ([operation isEqual:@"C"])
	{
		operand = 0;
		operandInMemory = 0;
		waitingOperand = 0;
		waitingOperation = nil;
	}
	else
	{
		[self performWaitingOperation];
		waitingOperand = operand;
		waitingOperation = operation;
	}
	return operand;
}

@end
