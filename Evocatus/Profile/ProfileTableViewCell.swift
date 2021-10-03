//
//  ProfileTableViewCell.swift
//  Evocatus
//
//  Created by KONSTANTIN TISHCHENKO on 02.10.2021.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
   
    @IBOutlet weak var backGroundCellViewOutlet: UIView!
    
    static let identifier = "ProfileTableViewCellReuseIndentifier"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureCellStaticApperance()
        
    }
    
    func configureCellStaticApperance() {
        self.backgroundColor = .clear
        selectedBackgroundView?.backgroundColor = .none
        backGroundCellViewOutlet.layer.cornerRadius = 10
    }
}
