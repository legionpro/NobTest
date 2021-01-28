//
//  ONTContactsListCell.swift
//  OlehNobelTest
//
//  Created by OLEH POREMSKYY on 30.12.2020.
//

import UIKit

class ONTContactsListCell: UITableViewCell {
    @IBOutlet weak var statusIcon: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var massage: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpData(_ data:PersonListModel?) {
        guard let dat = data else {return}
        if let img = UIImage(named: dat.statusIcon.rawValue) {
            statusIcon.image = img
        }

        if let img = UIImage(named: dat.sex.rawValue) {
            avatarImage.image = img
        }
        
        fullName.text = dat.fullName
        massage.text = dat.statusMessage
    }
}
