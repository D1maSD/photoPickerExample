//
//  ViewController.swift
//  QueueProject
//
//  Created by Мельник Дмитрий on 27.07.2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Thread.isMainThread == true {
            print("True")
        } else {
            print("False")
        }
//        clouserAfter(sec: 3, queue:  .global(qos: )) {
//            for _ in 0...5 {
//                print("Hi")
//                print(Thread.current)
//                self.showAlert()
//            }
//        }
        clouserAfter(sec: 2) {
            print("Hi")
            print(Thread.current)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Training", message: "Ok", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    // alert alertAction addAction present
    
    func clouserAfter(sec: Int, queue: DispatchQueue = DispatchQueue.global(), clouser: @escaping () -> ()) {
        queue.asyncAfter(deadline: DispatchTime.now() + .seconds(sec)) {
            clouser()
        }
    }
    
}

