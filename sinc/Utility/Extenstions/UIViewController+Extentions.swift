//
//  viewController+Extentions.swift
//  sinc
//
//  Created by mac on 04/02/21.
//

import Foundation
import UIKit

protocol SetSelectedImageDelegate {
    func setSelectedImage(image : UIImage)
}

extension UIViewController {
    
    
    
    func loadViewController(Storyboard:StoryBoardIdentifiers,ViewController:ViewControllerIdentifiers) -> UIViewController {
        let storyBoard = UIStoryboard(name: Storyboard.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: ViewController.rawValue)
        return vc
    }
    
///     navigate To Push Cotroller
    func pushViewController( controllerID : ViewControllerIdentifiers,storyBoardID : StoryBoardIdentifiers) {
        let storyBoard = UIStoryboard(name: storyBoardID.rawValue, bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: controllerID.rawValue)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
///     navigate To Present Cotroller
    func presentViewController(controllerID : ViewControllerIdentifiers,storyBoardID : StoryBoardIdentifiers) {
        let storyBoard = UIStoryboard(name: storyBoardID.rawValue, bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: controllerID.rawValue)
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
///    navigate To Previous View Controller
    func popViewController(){
        self.navigationController?.popViewController(animated: true)
    }
///    dismiss View Controller
    func dismissViewController(){
        self.dismiss(animated: true, completion: nil)
    }
///    to root viewController
    func popToRootViewController(){
        self.navigationController?.popToRootViewController(animated: true)
    }
///  show Alert Of Messg
    func showAlert(message : String){
        let alert = UIAlertController(title: "Sink", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCameraOrGallry(){
        let alert:UIAlertController = UIAlertController(title: nil,
                                                        message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { UIAlertAction in
//            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default) { UIAlertAction in
//            self.openGallery()
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action in
            // Called when user taps outside
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

