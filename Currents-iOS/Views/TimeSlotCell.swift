//
//  TimeSlotCell.swift
//  Currents-iOS
//
//  Created by Ethan Hu on 4/26/18.
//  Copyright © 2018 CUSD Currents. All rights reserved.
//

import UIKit
import SnapKit

class TimeSlotCell: UITableViewCell {

    static let identifier = "timeSlotCell"
    
    var timeSlot:TimeSlot?
    
    
    //Constants
    let buttonLabelSpacing:CGFloat = 10
    let fromToBlockSpacing:CGFloat = 12
    let cellPadding:CGFloat = 5
    let fontSize:CGFloat = 16
    let labelWidth:CGFloat = 90
    
    //View Elements
    let fromButton = UIButton()
    let fromTimeLabel = UILabel()
    let toButton = UIButton()
    let toTimeLabel = UILabel()
    
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayouts()
    }
    
    /**
     * Sets the basic view layout of this cell
     */
    func setLayouts(){
        fromButton.setTitleColor(self.tintColor, for: .normal)
        fromButton.setTitle("FROM", for: .normal)
        fromButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        toButton.setTitleColor(self.tintColor, for: .normal)
        toButton.setTitle("TO", for: .normal)
        toButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        
        fromTimeLabel.font = UIFont.systemFont(ofSize: fontSize)
        toTimeLabel.font = UIFont.systemFont(ofSize: fontSize)
        
        fromTimeLabel.snp.makeConstraints{ make in
            make.width.equalTo(labelWidth)
        }
        
        toTimeLabel.snp.makeConstraints{ make in
            make.width.equalTo(labelWidth)
        }
        
        let leftStack = UIStackView(arrangedSubviews: [fromButton, fromTimeLabel])
        leftStack.alignment = .center
        leftStack.axis = .horizontal
        leftStack.distribution = .fill
        leftStack.spacing = buttonLabelSpacing
        
        let rightStack = UIStackView(arrangedSubviews: [toButton, toTimeLabel])
        rightStack.alignment = .center
        rightStack.axis = .horizontal
        rightStack.distribution = .fill
        rightStack.spacing = buttonLabelSpacing
        
        let cellStack = UIStackView(arrangedSubviews: [leftStack, rightStack])
        cellStack.alignment = .center
        cellStack.axis = .horizontal
        cellStack.distribution = .fill
        cellStack.spacing = fromToBlockSpacing
        
        self.addSubview(cellStack)
        cellStack.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(cellPadding)
            make.bottom.equalTo(self).offset(-cellPadding)
        }
    }
    
    /*
     * Configures the cell to the given time slot
     * - timeSlot: The time slot to populate the cell.
     */
    func configure(with timeSlot:TimeSlot) {
        self.timeSlot = timeSlot
        fromTimeLabel.text = timeSlot.getStartTimeHourMinute()
        toTimeLabel.text = timeSlot.getEndTimeHourMinute()
    }
    
    
    

}
