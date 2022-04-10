//
//  LoginVC.swift
//  30th_Instagram
//
//  Created by 안현주 on 2022/04/10.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
  
  // MARK: - Vars & Lets Part
  private let eyeBtn = UIButton()
  private let hiddenImage = UIImage(named: "password hidden eye icon")
  private let shownImage = UIImage(named: "password shown eye icon")
  
  // MARK: - UI Component Part
  @IBOutlet weak var idTextField: UITextField!
  @IBOutlet weak var pwTextField: UITextField!
  @IBOutlet weak var loginBtn: UIButton!{
    didSet{
      loginBtn.isEnabled = false
      loginBtn.backgroundColor = UIColor(displayP3Red: 126/255, green: 192/255, blue: 250/255, alpha: 1)
    }
  }
  @IBOutlet weak var signUpBtn: UIButton!
  
  // MARK: - Life Cycle Part
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setTextFieldEmpty()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    pressBtn()
    setTextField()
    hideKeyboard()
  }
  
  // MARK: - IBAction Part
  
  
  // MARK: - Custom Method Part
  private func setUI() {
    loginBtn.layer.cornerRadius = 5
    idTextField.clearButtonMode = .whileEditing
    idTextField.clearsOnBeginEditing = true
  }
  
  private func setTextField() {
    [idTextField, pwTextField].forEach{
      $0?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    eyeBtn.setBackgroundImage(hiddenImage, for: .normal)
    eyeBtn.frame = CGRect(x: 0,y: 0,width: 30,height: 30)
    pwTextField.rightView = eyeBtn
    pwTextField.rightViewMode = .always
    pwTextField.delegate = self
  }
  
  private func setTextFieldEmpty() {
    [idTextField, pwTextField].forEach {
      $0.text = ""
    }
  }
  
  private func pressBtn() {
    //Present
    loginBtn.press {
      guard let welcomeVC =  self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as? WelcomeVC else {return}
      
      welcomeVC.userName = self.idTextField.text
      welcomeVC.modalPresentationStyle = .fullScreen
      self.present(welcomeVC, animated: true, completion: nil)
    }
    
    //Push
    signUpBtn.press {
      guard let signUpVC =  self.storyboard?.instantiateViewController(withIdentifier: "SignUpNickNameVC")  else {return}
      
      self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    //Clicked
    eyeBtn.press { [self] in
      eyeBtn.isSelected.toggle()
      
      if eyeBtn.isSelected {
        eyeBtn.setBackgroundImage(shownImage, for: .normal)
        pwTextField.rightView = eyeBtn
        pwTextField.isSecureTextEntry = false
      } else {
        eyeBtn.setBackgroundImage(hiddenImage, for: .normal)
        pwTextField.rightView = eyeBtn
        pwTextField.isSecureTextEntry = true
      }
      
    }
  }
  
  // MARK: - @objc Function Part
  @objc func textFieldDidChange(_ sender:Any?) -> Void {
    loginBtn.isEnabled = idTextField.hasText && pwTextField.hasText
    if loginBtn.isEnabled == true {
      loginBtn.backgroundColor = .systemBlue
    } else {
      loginBtn.backgroundColor = UIColor(displayP3Red: 126/255, green: 192/255, blue: 250/255, alpha: 1)
    }
  }
  
}
// MARK: - Extension Part
