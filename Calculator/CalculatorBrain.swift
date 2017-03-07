//
//  CalculatorBrain.swift
//  JCalculator
//
//  Created by Jonatas Ramos Domingos on 07/05/16.
//  Copyright © 2016 Jonatas Ramos Domingos. All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    fileprivate var accumulator = 0.0
    
    func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(M_PI),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "×": Operation.binaryOperation({$0 * $1}),
        "÷": Operation.binaryOperation({$0 / $1}),
        "−": Operation.binaryOperation({$0 - $1}),
        "+": Operation.binaryOperation({$0 + $1}),
        "=": Operation.equals,
        "C" : Operation.clear
    ]
    
    enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        case clear
        
    }
    
    func performOperation(_ symbol: String){
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let foo):
                accumulator = foo(accumulator)
            case .binaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .equals:
                executePendingBinaryOperation()
            case .clear:
                accumulator = 0.0
                pending = nil
                
            }
        }
    }
    
    fileprivate func executePendingBinaryOperation(){
        
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
        }
    }
    
    fileprivate var pending: PendingBinaryOperationInfo?
    struct PendingBinaryOperationInfo{
        var binaryFunction: (Double, Double)-> Double
        var firstOperand: Double
    }
    
    var result: Double{
        get{
            return accumulator
        }
    }
}
