//
//  CommonPickerView.swift
//  sinc
//
//  Created by mac on 15/02/21.
//

import UIKit

class CommonPickerView: UIPickerView {

    
}
extension CommonPickerView : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "sinc"
    }
}
