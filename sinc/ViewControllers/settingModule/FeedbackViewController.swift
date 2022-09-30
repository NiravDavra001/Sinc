//
//  FeedbackViewController.swift
//  sinc
//
//  Created by mac on 12/03/21.
//

import UIKit
import KMPlaceholderTextView

class FeedbackViewController: UIViewController {

    @IBOutlet weak var txtFeedbackView: KMPlaceholderTextView!
    
    var viewModel =  SendFeedbackViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        
    }
    
    func setupNavigationController(){
        let sendBtn = UIBarButtonItem(title : "send", style: .plain, target: self, action: #selector(onTapSend))
        self.navigationItem.rightBarButtonItem  = sendBtn
    }
    
    @objc func onTapSend(){
        callFeedbackAPI()
    }
    
    func callFeedbackAPI(){
        
        if txtFeedbackView.text == "" {
            self.showAlert(message: localizedString.enterFeedback.getLocalizableString())
            return
        }
        
        showActivityIndicator(uiView: self.view)
        viewModel.sendFeedbackToserver(feedback: txtFeedbackView.text) { (isFinished, message) in
            if isFinished {
                self.popViewController()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
}
