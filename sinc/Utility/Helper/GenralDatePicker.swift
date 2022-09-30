//
//  GenralDatePicker.swift
//  sinc
//
//  Created by mac on 25/03/21.
//

import UIKit

class GenralDatePicker: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sepraterView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setupUI(){
        datePicker.datePickerMode = .date
        sepraterView.backgroundColor = .borderColor
        lblTitle.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
    }
    
    func reloadPickerView(){
        
    }
    
    private func commonInit() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "GenralDatePicker", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view ?? UIView())
        setupUI()
    }
}
