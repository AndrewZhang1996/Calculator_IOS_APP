//
//  ViewController.swift
//  Calculator
//
//  Created by 张雲淞 on 2018/4/16.
//  Copyright © 2018年 张雲淞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel! //!非空 不能？
    @IBOutlet weak var MoreOperators: UIView!
    
    var displayValue:Double{
        set{
            display.text=String(newValue)
        }
        get{
            return Double(display.text!)!
        }
    }
    
    var brain = CalculatorBrain()
    
    var userIsInMiddleOfTyping = false //允许输入长整数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
//    @IBAction func CleanScreen() {
//    }
    
    
    @IBAction func performInputNumber(_ sender: UIButton) {//_ 省略了外部的名字
        
        let number = sender.currentTitle! //constant
        //display.text = number
        
        if userIsInMiddleOfTyping {
            
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + number
            
        }else{
            display.text=number
        }
        
        userIsInMiddleOfTyping=true
        
    }
    @IBAction func performOperation(_ sender: UIButton){
        
        
        if userIsInMiddleOfTyping{
            brain.setOperand(operand: displayValue)
            userIsInMiddleOfTyping=false
        }
        if let mathematicalSymbol=sender.currentTitle{
           brain.performOperation(symbol: mathematicalSymbol)
        }
        
        displayValue=brain.result
        
    }
    
    @IBAction func DisplayMoreOperator(_ sender: UIScreenEdgePanGestureRecognizer) {
        MoreOperators.isHidden = false
    }
    @IBAction func HiddenMoreOperator(_ sender: UIScreenEdgePanGestureRecognizer) {
        MoreOperators.isHidden = true
    }
    
}

