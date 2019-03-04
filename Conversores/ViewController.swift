//
//  ViewController.swift
//  Conversores
//
//  Created by Thiago Antonio Ramalho on 27/01/19.
//  Copyright © 2019 Thiago Antonio Ramalho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var btUnitOne: UIButton!
    @IBOutlet weak var btUnitTwo: UIButton!
    @IBOutlet weak var lbResultUnit: UILabel!
    @IBOutlet weak var lbUnit: UILabel!
    
    @IBOutlet weak var lbResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func next(_ sender: UIButton) {
        
        struct Unit{
            var title: String
            var buttonOne: String
            var buttonTwo: String
        }
        
        var unit = Unit(title: "", buttonOne: "", buttonTwo: "")
        
        switch lbUnit.text! {
        case "Temperatura":
            unit.title = "Peso"
            unit.buttonOne = "Kilograma"
            unit.buttonTwo = "libra"
        case "Peso":
            unit.title = "Moeda"
            unit.buttonOne = "Real"
            unit.buttonTwo = "Dólar"
        case "Moeda":
            unit.title = "Distância"
            unit.buttonOne = "Metro"
            unit.buttonTwo = "Kilometro"
        default:
            unit.title = "Temperatura"
            unit.buttonOne = "Celsius"
            unit.buttonTwo = "Fahrenheit"
        }
        
        lbUnit.text = unit.title
        btUnitOne.setTitle(unit.buttonOne, for: .normal)
        btUnitTwo.setTitle(unit.buttonTwo, for: .normal)
        
        calculate(nil)
    }
    
    @IBAction func calculate(_ sender: UIButton?) {
        
        if let sender = sender {
            if sender == btUnitOne {
                btUnitTwo.alpha = 0.5
            } else {
                btUnitOne.alpha = 0.5
            }
            
            sender.alpha = 1.0
        }
        
        convert(isButtonOne: btUnitOne.alpha == 1.0)
    }
    
    private func convert(isButtonOne: Bool) {
        guard let value = Double(tfValue.text!) else { return }
        switch lbUnit.text! {
        case "Temperatura":
            temperature(value, isButtonOne)
        case "Peso":
            weight(value, isButtonOne)
        case "Moeda":
            currency(value, isButtonOne)
        default:
            distance(value, isButtonOne)
        }
        
        view.endEditing(true)
    }
    
    private func temperature(_ value : Double, _ isButtonOne: Bool) {
        
        var result = String(value * 1.8 + 32.0)
        
        if isButtonOne {
            result = String((value - 32.0) / 1.8)
        }
        
        updateView(resultValue: result)
    }
    
    private func weight(_ value : Double, _ isButtonOne: Bool) {
        
        var result = String(value / 2.2046)
        
        if isButtonOne {
            result = String(value * 2.2046)
        }
        
        updateView(resultValue: result)
    }
    
    private func currency(_ value : Double, _ isButtonOne: Bool) {
        var result = String(value * 3.5)
        
        if isButtonOne {
            result = String(value / 3.5)
        }
        
        updateView(resultValue: result)
    }
    
    private func distance(_ value : Double, _ isButtonOne: Bool) {
        
        var result = String(value * 1000)
        
        if isButtonOne {
            result = String(value / 1000)
        }
        
        updateView(resultValue: result)
    }
    
    private func updateView(resultValue : String) {
        
        let label = btUnitOne.alpha == 1.0 ? btUnitTwo.title(for: .normal) : btUnitOne.title(for: .normal)
        
        lbResultUnit.text = label
        lbResult.text = String(format: "%.2f", Double(resultValue) ?? 0.0)
    }
}

