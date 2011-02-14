//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Alex Soulim on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

#define VARIABLE_PREFIX @"%"

@implementation CalculatorBrain
@synthesize operand;

+ (double)evaluteExpression:(id)anExpression
		usingVariableValues:(NSDictionary *)variables
{
	NSLog(@"expression %@", anExpression);
	
	CalculatorBrain *brain = [[CalculatorBrain alloc] init];
	NSString *vp = VARIABLE_PREFIX;
	
	for (id obj in anExpression) {
		if ([obj isKindOfClass:[NSNumber class]]) {
			brain.operand = [obj doubleValue];
		} else if ([obj isKindOfClass:[NSString class]]) {
			if ([obj hasPrefix:vp]) {
				brain.operand = [[variables valueForKey:obj] doubleValue];
			} else {
				[brain performOperation:obj];
			}
		}
	}
	
	[brain autorelease];
	return brain.operand;
}

+ (NSSet *)variablesInExpression:(id)anExpression
{
	NSMutableSet *result = [[NSMutableSet alloc] init];
	NSString *vp = VARIABLE_PREFIX;
	
	for (id obj in anExpression) {
		if ([obj isKindOfClass:[NSString class]] && [obj hasPrefix:vp] && ![result member:obj]) {
			[result addObject:obj];
		}
	}
	
	[result autorelease];
	return ([result count] > 0) ? result : nil;
}

+ (NSString *)descriptionOfExpression:(id)anExpression
{
	NSMutableString *result = [[NSMutableString alloc] init];
	for (id obj in anExpression) {
		if ([obj isKindOfClass:[NSNumber class]]) {
			[result appendString:[obj stringValue]];
		} else {
			[result appendString:obj];
		}
	}
	[result autorelease];
	return result;
}

- (NSMutableArray *)internalExpression
{
	if (!internalExpression) internalExpression = [[NSMutableArray alloc] init];
	return internalExpression;
}

- (id)expression
{
	NSMutableArray *result = [self.internalExpression copy];
	[result autorelease];
	return result;
}

- (void)setOperand:(double)anOperand
{
	operand = anOperand;
	[self.internalExpression addObject:[NSNumber numberWithDouble: anOperand]];
}

- (void)setVariableAsOperand:(NSString *)variableName
{
	NSString *vp = VARIABLE_PREFIX;
	[self.internalExpression addObject:[vp stringByAppendingString:variableName]];
}

- (void)performWaitingOperation
{
	if ([@"*" isEqual:waitingOperation]) {
		self.operand = waitingOperand * self.operand;
	}
	else if ([@"/" isEqual:waitingOperation]) {
		if (self.operand) {
			self.operand = waitingOperand / self.operand;
		}
	}
	else if ([@"+" isEqual:waitingOperation]) {
		self.operand = waitingOperand + operand;
	}
	else if ([@"-" isEqual:waitingOperation]) {
		self.operand = waitingOperand - self.operand;
	}
}

- (double)performOperation:(NSString *)operation
{
	[self.internalExpression addObject:operation];
	
	if ([operation isEqual:@"sqrt"]) {
		self.operand = sqrt(self.operand);
	}
	else if ([operation isEqual:@"+/-"])
	{
		self.operand = - self.operand;
	}
	else if ([operation isEqual:@"1/x"])
	{
		if (self.operand) {
			self.operand = 1 / self.operand;
		}
	}
	else if ([operation isEqual:@"sin"])
	{
		self.operand = sin(self.operand);
	}
	else if ([operation isEqual:@"cos"])
	{
		self.operand = cos(self.operand);
	}
	else if ([operation isEqual:@"STORE"])
	{
		operandInMemory = self.operand;
	}
	else if ([operation isEqual:@"RECALL"])
	{
		self.operand = operandInMemory;
	}
	else if ([operation isEqual:@"M+"])
	{
		operandInMemory += self.operand;
	}
	else if ([operation isEqual:@"C"])
	{
		self.operand = 0;
		operandInMemory = 0;
		waitingOperand = 0;
		waitingOperation = nil;
		[self.internalExpression removeAllObjects];
	}
	else if (![CalculatorBrain variablesInExpression:self.internalExpression])
	{
		[self performWaitingOperation];
		waitingOperand = self.operand;
		waitingOperation = operation;
	}
	return self.operand;
}

- (void)dealloc
{
	[waitingOperation release];
	[internalExpression release];
	[super dealloc];
}

@end
