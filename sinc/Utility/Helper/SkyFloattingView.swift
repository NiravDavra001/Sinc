//
//  SkyFloattingView.swift
//  sinc
//
//  Created by mac on 05/02/21.
//

import UIKit

class SkyFloattingView: UIView {
    
    @IBOutlet weak var lblbottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var label : UILabel!
    @IBOutlet weak var txtView : UITextView!
    @IBOutlet weak var mainView : UIView!
    var curOrigin = CGPoint(x: 0,y: 0)
    var nextOrigin = CGPoint(x: 0,y: -30)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func draw(_ rect: CGRect) {
        setUpUI()
    }
    
    func setUpUI(){
        txtView.delegate = self
        txtView.text = "Placeholder"
        txtView.textColor = UIColor.lightGray
        label.text = ""
        label.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_14.rawValue)
        curOrigin = label.frame.origin
        label.frame = CGRect(x: txtView.frame.minX, y: txtView.frame.midY - 10, width: txtView.frame.width, height: 20)
        label.alpha = 0
        label.text = "test"
    }
    private func commonInit() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "SkyFloattingVIew", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view ?? UIView())
    }
}
extension SkyFloattingView : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
            label.text = "PlaceHolder"
        }
        UIView.animate(withDuration: 0.4) {
            self.label.frame = CGRect(x: self.txtView.frame.minX, y: self.txtView.frame.minY, width: self.txtView.frame.width, height: 20)
            self.label.alpha = 0
        } completion: { (_) in
            self.label.text = ""
        }

    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text != "PlaceHolder" {
            if textView.text != "" {
                if textView.textColor == UIColor.lightGray {
                    label.text = "PlaceHolder"
                    textView.text = ""
                    textView.textColor = UIColor.black
                }
                UIView.animate(withDuration: 0.3) {
                    self.label.frame = CGRect(x: self.txtView.frame.minX, y: self.txtView.frame.minY - 20, width: self.txtView.frame.width, height: 20)
                    self.label.alpha = 1
                }
            }
            else if textView.text == "" {
                if textView.text.isEmpty {
                    textView.text = "Placeholder"
                    textView.textColor = UIColor.lightGray
                    label.text = "PlaceHolder"
                }
                UIView.animate(withDuration: 0.4) {
                    self.label.frame = CGRect(x: self.txtView.frame.minX, y: self.txtView.frame.minY, width: self.txtView.frame.width, height: 20)
                    self.label.alpha = 0
                } completion: { (_) in
                    self.label.text = ""
                    
                }
            }
        }
        
        
        return true
    }
}
