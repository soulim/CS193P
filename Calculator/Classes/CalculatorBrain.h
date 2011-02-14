//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Alex Soulim on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
	@private
		double operand;
		double waitingOperand;
		double operandInMemory;
		NSString *waitingOperation;
		NSMutableArray *internalExpression;
}

- (void)setVariableAsOperand:(NSString *)variableName;
- (double)performOperation:(NSString *)operation;

@property (readonly) id expression;
@property double operand;

+ (double)evaluteExpression:(id)anExpression
		usingVariableValues:(NSDictionary *)variables;

+ (NSSet *)variablesInExpression:(id)anExpression;
+ (NSString *)descriptionOfExpression:(id)anExpression;

//+ (id)propertyListForExpression:(id)anExpression;
//+ (id)expressionForPropertyList:(id)propertyList;

@end
