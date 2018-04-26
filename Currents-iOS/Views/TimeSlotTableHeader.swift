//
//  timeSlotTableHeader.swift
//  Currents-iOS
//
//  Created by Ethan Hu on 4/26/18.
//  Copyright © 2018 CUSD Currents. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TimeSlotTableHeader: UITableViewHeaderFooterView {
    static let identifier = "timeSlotTableHeader"
    
    let sideMargins:CGFloat = 15
    let bottomMargins:CGFloat = 5
    let titleFontSize:CGFloat = 20
    let buttonFontSize:CGFloat = 16
    
    var title = UILabel()
    let editButton = UIButton()
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayouts()
    }
    
    func setLayouts(){
        editButton.setTitleColor(self.tintColor, for: .normal)
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: buttonFontSize)
        
        title.font = UIFont.boldSystemFont(ofSize: titleFontSize)
        
        self.addSubview(title)
        self.addSubview(editButton)
        
        title.snp.makeConstraints{ make in
            make.left.equalTo(self).offset(sideMargins)
            make.bottom.equalTo(self).offset(-bottomMargins)
        }
        
        editButton.snp.makeConstraints{ make in
            make.right.equalTo(self).offset(-sideMargins)
            make.bottom.equalTo(self)
        }
        
    }
    
    func setTitle(_ title:String){
        self.title.text = title
    }
}
