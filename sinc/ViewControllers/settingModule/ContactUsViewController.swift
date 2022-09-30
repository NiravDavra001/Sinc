//
//  ContactUsViewController.swift
//  sinc
//
//  Created by mac on 12/03/21.
//

import UIKit
import KMPlaceholderTextView

class ContactUsViewController: UIViewController {
    
    var viewModel =  ContactUsViewModel()
    @IBOutlet weak var txtTo: UITextField!
    @IBOutlet weak var txtBCC: UITextField!
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var txtViewMessgae: KMPlaceholderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }
    
    
    func setupNavigationController(){
        let sendBtn = UIBarButtonItem(title : "send", style: .plain, target: self, action: #selector(onTapSend))
        self.navigationItem.rightBarButtonItem  = sendBtn
    }
    
    @objc func onTapSend(){
        callContactUsAPI()
    }
    
    func callContactUsAPI(){
        
        var dict = [String : Any]()
        dict["to"] = txtTo.text
        dict["subject"] = txtSubject.text
        dict["cc_bcc"] = txtBCC.text
        dict["message"] = txtViewMessgae.text
        
        showActivityIndicator(uiView: self.view)
        viewModel.callContactUSAPI(params: dict) { (isFinised, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinised {
                self.popViewController()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
}
