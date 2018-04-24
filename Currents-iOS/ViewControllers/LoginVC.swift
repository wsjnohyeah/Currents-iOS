//
//  LoginVC.swift
//  Currents-iOS
//
//  Created by Ethan Hu
//  Copyright © 2018 CUSD Currents. All rights reserved.
//

import UIKit
import SnapKit

/**
    Manages the Login page. The user should be allowed to use controls after authentication
 */
class LoginVC: UIViewController {
    //Contants
    let logoTopBottomOffset = CGFloat(integerLiteral: 100)
    let logoSideLength = CGFloat(integerLiteral: 90)
    let currentsLabelFontSize = CGFloat(integerLiteral: 24)
    let currentsLogoLabelOffset = CGFloat(integerLiteral: 10)
    let fieldLeftRightOffset = CGFloat(integerLiteral: 80)
    let fieldLineLeftRightOffset = CGFloat(integerLiteral: 60)
    let fieldLineTopOffset = CGFloat(integerLiteral: 5)
    let fieldTopOffset = CGFloat(integerLiteral: 30)
    let buttonTopOffset = CGFloat(integerLiteral: 50)
    let buttonWidth = CGFloat(integerLiteral: 200)
    let buttonHeight = CGFloat(integerLiteral: 40)

    
    
    //ViewElements
    let logo = UIImageView()
    let currentsLabel = UILabel()
    let userNameField = UITextField()
    let passwordField = UITextField()
    let signInButton = UIButton()
    let userNameFieldBottomLine = UIView()
    let passwordFieldBottomLine = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }
    
    /*
     * Handles the press action of the sign in button.
     * Transits to the main page and save user identity as "logged" in userdefaults
     */
    @objc func signInButtonPressed(_ sender: UIButton){
        let username = userNameField.text ?? ""
        let password = passwordField.text ?? ""
        if let userIdentifier = LoginUtils.auth(username: username, password: password) {
            LoginUtils.saveUniqueUserInfoToDefaults(username: username, identifier: userIdentifier)
            let navVC = UINavigationController(rootViewController: MainControlsVC())
            present(navVC, animated: true, completion: nil)
        }
        else {
            showAlert(withMessage: "Your username or password isn't correct")
        }
    }
    
    /** Shows alert displaying @message */
    func showAlert(withMessage message : String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Manages the view elements, and position them correctly
     */
    func layoutView(){
        view.addSubview(logo)
        view.addSubview(currentsLabel)
        view.addSubview(userNameField)
        view.addSubview(userNameFieldBottomLine)
        view.addSubview(passwordField)
        view.addSubview(passwordFieldBottomLine)
        view.addSubview(signInButton)
        view.backgroundColor = UIColor(named: "LightBlue")
        
        logo.image = UIImage(named: "Logo")
        logo.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view).offset(logoTopBottomOffset)
            make.width.equalTo(logoSideLength)
            make.height.equalTo(logoSideLength)
            make.centerX.equalTo(view)
        }
        
        currentsLabel.text = "Currents"
        currentsLabel.font = UIFont.italicSystemFont(ofSize: currentsLabelFontSize)
        currentsLabel.textColor = UIColor.white
        currentsLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(logo.snp.bottom).offset(currentsLogoLabelOffset)
            make.centerX.equalTo(view)
        }
        
        userNameField.textColor = UIColor.white
        userNameField.attributedPlaceholder = NSAttributedString(string: "User Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        userNameField.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(currentsLabel.snp.bottom).offset(logoTopBottomOffset)
            make.left.equalTo(view).offset(fieldLeftRightOffset)
            make.right.equalTo(view).offset(-fieldLeftRightOffset)
        }
        userNameFieldBottomLine.backgroundColor = UIColor.white
        userNameFieldBottomLine.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(userNameField.snp.bottom).offset(fieldLineTopOffset)
            make.right.equalTo(view).offset(-fieldLineLeftRightOffset)
            make.left.equalTo(view).offset(fieldLineLeftRightOffset)
            make.height.equalTo(1)
        }
        
        passwordField.textColor = UIColor.white
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        passwordField.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(userNameFieldBottomLine.snp.bottom).offset(fieldTopOffset)
            make.left.equalTo(view).offset(fieldLeftRightOffset)
            make.right.equalTo(view).offset(-fieldLeftRightOffset)
        }
        passwordFieldBottomLine.backgroundColor = UIColor.white
        passwordFieldBottomLine.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(passwordField.snp.bottom).offset(fieldLineTopOffset)
            make.right.equalTo(view).offset(-fieldLineLeftRightOffset)
            make.left.equalTo(view).offset(fieldLineLeftRightOffset)
            make.height.equalTo(1)
        }
        
        signInButton.layer.cornerRadius = buttonHeight / 2
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(passwordFieldBottomLine).offset(buttonTopOffset)
            make.centerX.equalTo(view)
            make.height.equalTo(buttonHeight)
            make.width.equalTo(buttonWidth)
        }
        
        signInButton.addTarget(self, action: #selector(signInButtonPressed(_:)), for: .touchUpInside)
        
    }


}
