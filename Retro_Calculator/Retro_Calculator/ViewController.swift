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

    var btnSound: AVAudioPlayer!
    
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
            print(err.localizedDescription)
        }
    }
    
    // линк всех кнопок
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
    }

    // функция для проигрывания кнопки
    func playSound () {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
}

