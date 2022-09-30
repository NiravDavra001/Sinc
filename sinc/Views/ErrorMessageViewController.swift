//
//  ErrorMessageViewController.swift
//  sinc
//
//  Created by mac on 04/02/21.
//

import UIKit

class ErrorMessageViewController: UIViewController {

    
    @IBOutlet weak var closeButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonTouchUInside(){
        self.dismissViewController()
    }

}
