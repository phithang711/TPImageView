//
//  ViewController.swift
//  TPImageView
//
//  Created by Nguyễn Phi Thăng on 01/09/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cancelProcessingButton: UIButton!
    @IBOutlet weak var textProcessingButton: UIButton!
    @IBOutlet weak var tpImageView: TPImageView!
    @IBOutlet weak var tpTextField: TPTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view. = false
        self.setupUI()
        self.addNotificationForKeyboard()
    }
    
    func addNotificationForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: UI Methods
extension ViewController {
    func setupUI() {
        self.setupCancelProcessingButton()
        self.setupTextProcessingButton()
        self.setupTPTextField()
    }
    
    func setupCancelProcessingButton() {
        self.cancelProcessingButton.setTitle("Cancel", for: .normal)
        self.cancelProcessingButton.setTitleColor(UIColor.systemRed, for: .normal)
    }
    
    func setupTextProcessingButton() {
        self.textProcessingButton.setTitle("Image Processing", for: .normal)
    }
    
    func setupTPTextField() {
        self.tpTextField.delegate = self
        
        tpTextField.addTarget(self, action: #selector(becomeFirstResponder), for: .editingDidEndOnExit)
    }
}

// MARK: Action Methods
extension ViewController {
    @IBAction func didTapCancelProcessingButton(_ sender: Any) {
        print("cancel button")
    }
    
    @IBAction func didTapTextProcessingButton(_ sender: Any) {
        print("text processing button")
    }
}

// MARK: Keyboard Methods
extension ViewController : UITextFieldDelegate {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tpTextField.resignFirstResponder()
        return true
    }
}
