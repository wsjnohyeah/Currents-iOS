//
//  infoVC.swift
//  Currents-iOS
//
//  Created by Ethan Hu on 4/18/18.
//  Copyright © 2018 CUSD Currents. All rights reserved.
//

import UIKit
import SnapKit

class InfoVC: UIViewController {
    
    //Constants
    let infoFontSize:CGFloat = 22
    let labelTopOffset = CGFloat(integerLiteral: 100)
    let labelSideOffset:CGFloat = 40
    let buttonTopOffset = CGFloat(integerLiteral: 40)
    let buttonWidth = CGFloat(integerLiteral: 200)
    let buttonHeight = CGFloat(integerLiteral: 40)
    
    //ViewElements
    let infoLabel = UILabel()
    let okButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }
    
    /**
     * Event handler for ok button. should dismiss the current VC.
     */
    @objc func okButtonPressed(_ sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /**
     * Manages the view elements, and position them correctly
     */
    func layoutView(){
        view.backgroundColor = UIColor(named: "LightBlue");
        
        let infoStack = UIStackView(arrangedSubviews: [infoLabel, okButton])
        infoStack.alignment = .center
        infoStack.axis = .vertical
        infoStack.distribution = .fill
        infoStack.spacing = buttonTopOffset
        view.addSubview(infoStack)
        
        infoLabel.numberOfLines = 0
        infoLabel.text = "We predict that you'll be in your office at the following times. \n\nDuring these times, your thermostat will be on. \n\nOtherwise, your thermostat will be turned off to conserve energy. \n\nMake any adjustments to the times as necessary"
        infoLabel.textAlignment = .left
        infoLabel.textColor = UIColor.white
        infoLabel.font = UIFont.systemFont(ofSize: infoFontSize)
        
        
        okButton.layer.cornerRadius = buttonHeight / 2
        okButton.setTitle("OK", for: .normal)
        okButton.layer.borderWidth = 1
        okButton.layer.borderColor = UIColor.white.cgColor
        okButton.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(buttonHeight)
            make.width.equalTo(buttonWidth)
        }
        
        infoStack.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(labelSideOffset)
            make.right.equalTo(view).offset(-labelSideOffset)
            make.centerY.equalTo(view)
        }
        
        okButton.addTarget(self, action: #selector(okButtonPressed(_:)), for: .touchUpInside)
        
    }

    

}
