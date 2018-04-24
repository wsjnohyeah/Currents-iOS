//
//  MainControlsVC.swift
//  Currents-iOS
//
//  Created by Ethan Hu on 4/18/18.
//  Copyright © 2018 CUSD Currents. All rights reserved.
//

import UIKit
import SnapKit

class MainControlsVC: UIViewController {
    //Constants
    let quickControlViewHeight:CGFloat = 120
    let quickControlSidePadding:CGFloat = 15
    let quickControlLabelFontSize:CGFloat = 22
    let quickControlLabelDiscriptionFontSize:CGFloat = 14
    let buttonTopSpacing:CGFloat = 8
    let buttonHeight:CGFloat = 30
    let buttonSideSpacing:CGFloat = 8
    
    
    //View Elements
    let quickControlView = UIView()
    let quickControlsLabel = UILabel()
    let quickControlsDiscriptionLabel = UILabel()
    let quickControlsThirtyMinuteButton = UIButton()
    let quickControlsOneHourButton = UIButton()
    let quickControlsTwoHourButton = UIButton()
    let quickControlsTurnOffButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }
    
    /**
     * Manages the view elements, and position them correctly
     */
    func layoutView(){
        //NavBarStuffs
        navigationItem.title = "Home"
        let infoBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "info"), style: .plain, target: self, action: #selector(infoButtonPressed(_:)))
        navigationItem.leftBarButtonItem = infoBarButton
        view.backgroundColor = UIColor.white
        
        view.addSubview(quickControlView)
        
        //QuickControls
        quickControlView.addSubview(quickControlsLabel)
        quickControlView.addSubview(quickControlsDiscriptionLabel)
        quickControlView.addSubview(quickControlsThirtyMinuteButton)
        quickControlView.addSubview(quickControlsOneHourButton)
        quickControlView.addSubview(quickControlsTwoHourButton)
        quickControlView.addSubview(quickControlsTurnOffButton)
        
        quickControlView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.height.equalTo(quickControlViewHeight)
        }
        
        quickControlsLabel.font = UIFont.boldSystemFont(ofSize: quickControlLabelFontSize)
        quickControlsLabel.text = "Quick Controls"
        quickControlsLabel.textColor = UIColor.black
        quickControlsLabel.snp.remakeConstraints { make in
            make.top.equalTo(quickControlView).offset(quickControlSidePadding)
            make.left.equalTo(quickControlView).offset(quickControlSidePadding)
            make.right.equalTo(quickControlView).offset(-quickControlSidePadding)
        }
        
        quickControlsDiscriptionLabel.text = "Make speedy controls to your heating schedule"
        quickControlsDiscriptionLabel.textColor = UIColor.black
        quickControlsDiscriptionLabel.numberOfLines = 0
        quickControlsDiscriptionLabel.font = UIFont.systemFont(ofSize: quickControlLabelDiscriptionFontSize)
        quickControlsDiscriptionLabel.snp.remakeConstraints { make in
            make.top.equalTo(quickControlsLabel.snp.bottom)
            make.left.equalTo(quickControlView).offset(quickControlSidePadding)
            make.right.equalTo(quickControlView).offset(-quickControlSidePadding)
        }
        
        let controlsButtonStack = UIStackView(arrangedSubviews: [quickControlsThirtyMinuteButton, quickControlsOneHourButton, quickControlsTwoHourButton, quickControlsTurnOffButton])
        controlsButtonStack.spacing = buttonSideSpacing
        controlsButtonStack.distribution = .fillEqually
        controlsButtonStack.alignment = .center
        controlsButtonStack.axis = .horizontal
        
        quickControlView.addSubview(controlsButtonStack)
        
        quickControlsThirtyMinuteButton.setTitle("30 min", for: .normal)
        quickControlsOneHourButton.setTitle("1 hour", for: .normal)
        quickControlsTwoHourButton.setTitle("2 hours", for: .normal)
        quickControlsTurnOffButton.setTitle("off", for: .normal)
        
        
        for buttonView in controlsButtonStack.arrangedSubviews {
            if let button = buttonView as? UIButton {
                button.layer.cornerRadius = buttonHeight / 2
                button.layer.borderWidth = 1
                button.layer.borderColor = view.tintColor.cgColor
                button.setTitleColor(UIColor.black, for: .normal)
                button.snp.makeConstraints{ (make) -> Void in
                    make.height.equalTo(buttonHeight)
                }
            }
        }
        controlsButtonStack.snp.makeConstraints { make in
            make.top.equalTo(quickControlsDiscriptionLabel.snp.bottom).offset(buttonTopSpacing)
            make.left.equalTo(quickControlView).offset(quickControlSidePadding)
            make.right.equalTo(quickControlView).offset(-quickControlSidePadding)
            make.bottom.equalTo(quickControlView.snp.bottom).offset(-quickControlSidePadding)
        }
        
        
        
    }
    
    /**
     * Handles the press of the info button. Should segue to the infoVC.
     */
    @objc func infoButtonPressed(_ sender:UIButton) {
        present(InfoVC(), animated: true, completion: nil)
    }


}
