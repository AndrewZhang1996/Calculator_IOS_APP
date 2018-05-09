//
//  Calculator.swift
//  Calculator
//
//  Created by 张雲淞 on 2018/4/20.
//  Copyright © 2018年 张雲淞. All rights reserved.
//


import Foundation

//swift可以在类外面定义方法，这里定义乘法运算
//func multiply(op1: Double, op2: Double)->Double{
//    return op1*op2
//}

class CalculatorBrain{
    var accumulator = 0.0
    
    
    
    var result: Double{
        get{
            return accumulator
        }
    }
    
    enum Operation{
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals //result已有值 故Equals不需要返回值
    }
    
    var operations:Dictionary<String,Operation>=["∏":Operation.Constant(Double.pi),
                                             "√":Operation.UnaryOperation(sqrt),
                                             "×":Operation.BinaryOperation({return $0*$1}),
                                             "=":Operation.Equals,
                                             "÷":Operation.BinaryOperation({return $0/$1}),
                                             "-":Operation.BinaryOperation({return $0-$1}),
                                             "+":Operation.BinaryOperation({return $0+$1})]
    
    func setOperand(operand: Double){
        accumulator = operand
        print(operand)
    }
    
    func performOperation(symbol: String){
        if let operation=operations[symbol]{
            switch operation {
            case .Constant(let value): accumulator=value
            case .UnaryOperation(let function): accumulator=function(accumulator)//.前是operation
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending=PendingBinaryOperationInfo(firstOperand: accumulator, BinaryFunction: function)
            case .Equals: executePendingBinaryOperation()
            default: break
            }
        }
    }
    
    func executePendingBinaryOperation(){
        if pending != nil{
            accumulator=pending!.BinaryFunction(pending!.firstOperand,accumulator)
            pending=nil
        }
    }
    
    struct PendingBinaryOperationInfo{
        var firstOperand: Double
        var BinaryFunction: (Double,Double)->Double
    }
    
    var pending:PendingBinaryOperationInfo?
}
