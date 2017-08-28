//
//  ViewController.swift
//  Retro_Calculator
//
//  Created by Nikolas Ponomarov on 23.08.17.
//  Copyright © 2017 Nikolas Ponomarov. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Multiply = "*"
        case Divide = "/"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftVaStr = ""
    var rightVaStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // указываем путь к файлу
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        // страхуем себя на случай ошибки
        do {
            btnSound = try AVAudioPlayer(contentsOf: soundURL)
            btnSound.play()
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
        outputLbl.text = "0"
    }
    
    // линк всех кнопок
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    // применение операторов к значениям
    @IBAction func onDividePressed(sender: Any) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: Any) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: Any) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: Any) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: Any) {
        processOperation(operation: currentOperation)
    }
    
    // функция для проигрывания кнопки
    func playSound () {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    // логика подсчета
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightVaStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftVaStr)! * Double(rightVaStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftVaStr)! / Double(rightVaStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftVaStr)! + Double(rightVaStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftVaStr)! - Double(rightVaStr)!)"
                }
                
                leftVaStr = result
                outputLbl.text = result
            }
            currentOperation = operation
        } else {
            leftVaStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

