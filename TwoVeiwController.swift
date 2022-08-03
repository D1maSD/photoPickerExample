//
//  ViewController.swift
//  QueueProject
//
//  Created by Мельник Дмитрий on 27.07.2022.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.concurrentPerform(iterations: 200000) {
            print($0)
            print(Thread.current)
        }
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            
//            DispatchQueue.concurrentPerform(iterations: 200000) {
//                print($0)
//                print(Thread.current)
//            }
//            for i in 0...200000 {
//                print(i)
//            }
        }
    }


}

