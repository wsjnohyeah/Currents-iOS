//
//  MainControlsVC.swift
//  Currents-iOS
//
//  Created by Ethan Hu on 4/18/18.
//  Copyright © 2018 CUSD Currents. All rights reserved.
//

import UIKit
import SnapKit

class MainControlsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView(frame: CGRect(), style: .grouped)
    var timeSlots = [[TimeSlot]]()
    
    //Constants
    let quickControlViewHeight:CGFloat = 120
    let quickControlSidePadding:CGFloat = 15
    let quickControlLabelFontSize:CGFloat = 22
    let quickControlLabelDiscriptionFontSize:CGFloat = 13
    let quickControlButtonFontSize:CGFloat = 15
    let buttonTopSpacing:CGFloat = 8
    let buttonHeight:CGFloat = 30
    let buttonSideSpacing:CGFloat = 8
    let headerHeight:CGFloat = 40
    let quickControlNavbarOffset:CGFloat = -15

    
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
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(named: "LightBlue")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        let navigationBar = navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(),for: .default)
        navigationBar.shadowImage = UIImage()
        
        view.backgroundColor = UIColor.white
        view.addSubview(quickControlView)
        
        //QuickControls
        quickControlView.backgroundColor = UIColor(named: "LightBlue")
        quickControlView.addSubview(quickControlsLabel)
        quickControlView.addSubview(quickControlsDiscriptionLabel)
        quickControlView.addSubview(quickControlsThirtyMinuteButton)
        quickControlView.addSubview(quickControlsOneHourButton)
        quickControlView.addSubview(quickControlsTwoHourButton)
        quickControlView.addSubview(quickControlsTurnOffButton)
        
        quickControlView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(quickControlNavbarOffset)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.height.equalTo(quickControlViewHeight)
        }
        
        quickControlsLabel.font = UIFont.boldSystemFont(ofSize: quickControlLabelFontSize)
        quickControlsLabel.text = "Quick Controls"
        quickControlsLabel.textColor = UIColor.white
        quickControlsLabel.snp.remakeConstraints { make in
            make.top.equalTo(quickControlView).offset(quickControlSidePadding)
            make.left.equalTo(quickControlView).offset(quickControlSidePadding)
            make.right.equalTo(quickControlView).offset(-quickControlSidePadding)
        }
        
        quickControlsDiscriptionLabel.text = "Make speedy controls to your heating schedule"
        quickControlsDiscriptionLabel.textColor = UIColor.white
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
                button.layer.borderColor = UIColor.white.cgColor
                button.setTitleColor(UIColor.white, for: .normal)
                button.snp.makeConstraints{ (make) -> Void in
                    make.height.equalTo(buttonHeight)
                }
                button.titleLabel?.font = UIFont.systemFont(ofSize: quickControlButtonFontSize)
            }
        }
        controlsButtonStack.snp.makeConstraints { make in
            make.top.equalTo(quickControlsDiscriptionLabel.snp.bottom).offset(buttonTopSpacing)
            make.left.equalTo(quickControlView).offset(quickControlSidePadding)
            make.right.equalTo(quickControlView).offset(-quickControlSidePadding)
            make.bottom.equalTo(quickControlView.snp.bottom).offset(-quickControlSidePadding)
        }
        
        //Tableview
        tableView.register(TimeSlotCell.self, forCellReuseIdentifier: TimeSlotCell.identifier)
        tableView.register(TimeSlotTableHeader.self, forHeaderFooterViewReuseIdentifier: TimeSlotTableHeader.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(quickControlView.snp.bottom)
            make.bottom.equalTo(view)
            make.right.equalTo(view)
            make.left.equalTo(view)
        }
        
        //for testing
        timeSlots = [
            [TimeSlot(from: "2018-04-26 9:00", to: "2018-04-26 12:00"), TimeSlot(from: "2018-04-26 15:00", to: "2018-04-26 18:00")],
            [TimeSlot(from: "2018-04-27 9:00", to: "2018-04-27 12:00"), TimeSlot(from: "2018-04-27 15:00", to: "2018-04-27 18:00"), TimeSlot(from: "2018-04-27 19:00", to: "2018-04-27 21:00"), TimeSlot(from: "2018-04-27 23:00", to: "2018-04-27 23:30")],
            [TimeSlot(from: "2018-04-28 9:00", to: "2018-04-28 12:00"), TimeSlot(from: "2018-04-28 15:00", to: "2018-04-28 18:00")],
            [TimeSlot(from: "2018-04-29 9:00", to: "2018-04-29 12:00"), TimeSlot(from: "2018-04-29 15:00", to: "2018-04-29 18:00"), TimeSlot(from: "2018-04-29 19:00", to: "2018-04-29 21:00"), TimeSlot(from: "2018-04-29 23:00", to: "2018-04-29 23:30")]
        ]
        
        
        
    }
    
    /**
     * Handles the press of the info button. Should segue to the infoVC.
     */
    @objc func infoButtonPressed(_ sender:UIButton) {
        present(InfoVC(), animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return timeSlots.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeSlots[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeSlotCell.identifier, for: indexPath) as! TimeSlotCell
        cell.configure(with: timeSlots[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TimeSlotTableHeader.identifier) as! TimeSlotTableHeader
        header.setTitle(timeSlots[section][0].getMonthDay())
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }

}
