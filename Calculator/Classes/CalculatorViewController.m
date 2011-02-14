//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Alex Soulim on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()
@property (readonly) CalculatorBrain *brain;
@end


@implementation CalculatorViewController

- (void)dealloc
{
	[brain release];
	[super dealloc];
}

- (CalculatorBrain *)brain
{
	if (!brain) brain = [[CalculatorBrain alloc] init];
	return brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit = sender.titleLabel.text;
	
	if (userIsInTheMiddleOfTypingANumber)
	{
		display.text = [display.text stringByAppendingString:digit];
	}
	else
	{
		display.text = digit;
		userIsInTheMiddleOfTypingANumber = YES;
	}

}

- (IBAction)operationPressed:(UIButton *)sender
{
	if (userIsInTheMiddleOfTypingANumber)
	{
		self.brain.operand = [display.text doubleValue];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	
	NSString *operation = sender.titleLabel.text;
	double result = [self.brain performOperation:operation];
	
	if ([CalculatorBrain variablesInExpression:self.brain.expression]) {
		display.text = [CalculatorBrain descriptionOfExpression:self.brain.expression];		
	} else {
		display.text = [NSString stringWithFormat:@"%g", result];
	}
}

- (IBAction)floatingPointPressed:(UIButton *)sender
{
	NSRange range = [display.text rangeOfString:@"."];
	
	if (userIsInTheMiddleOfTypingANumber)
	{
		if (range.location == NSNotFound)
		{
			display.text = [display.text stringByAppendingString:@"."];
		}		
	}
	else
	{
		display.text = @"0.";
		userIsInTheMiddleOfTypingANumber = YES;
	}
}

- (IBAction)variablePressed:(UIButton *)sender
{
	[self.brain setVariableAsOperand:sender.titleLabel.text];
	display.text = [CalculatorBrain descriptionOfExpression:self.brain.expression];
}

- (IBAction)solvePressed:(UIButton *)sender
{
	NSDictionary *variables = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:1], @"%a", [NSNumber numberWithDouble:2], @"%b", [NSNumber numberWithDouble:3], @"%c", [NSNumber numberWithDouble:4], @"%d", nil];
	double result = [CalculatorBrain evaluteExpression:self.brain.expression
								   usingVariableValues:variables];
	display.text = [NSString stringWithFormat:@"%g", result];
}

@end
