//
//  ViewController.swift
//  DemoApp
//
//  Created by student on 2023/04/18.
//

import UIKit

class ViewController: UIViewController {
    
    var count: Int = 0
    
    @IBOutlet weak var fizzBuzzLabel: UILabel!
    
    @IBOutlet weak var countUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        fizzBuzzLabel.text = ""
    }

    @IBAction func didTapedCountUpButton(_ sender: UIButton){
        count += 1
        let isFizz: Bool = (count % 3) == 0
        let isBizz: Bool = (count % 5) == 0
        
        switch (isFizz, isBizz){
        case (true, true):
            fizzBuzzLabel.text = "FizzBuzz"
        case (true, _):
            fizzBuzzLabel.text = "Fizz"
        case (_, true):
            fizzBuzzLabel.text = "Buzz"
        default:
            fizzBuzzLabel.text = ""
        }
        
        if (count % 3) == && (count % 5) == 0 {
            fizzBuzzLabel.text = "FizzBuzz"
        }else if (count % 3) == 0 {
            fizzBuzzLabel.text = "Fizz"
        }else if (count % 5) == 0 {
            fizzBuzzLabel.text = "Buzz"
        } else {
            fizzBuzzLabel.text = ""
        }
    }
    
}

