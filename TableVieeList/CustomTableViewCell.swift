//
//  CustomTableViewCell.swift
//  TableVieeList
//
//  Created by Всеволод Андрющенко on 18/07/2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    var link: TableViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .none
        
        let setFaviorButton = UIButton(type: .system)
        setFaviorButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        setFaviorButton.setImage(UIImage(named: "star"), for: .normal)
        //setFaviorButton.tintColor = .orange
        accessoryView = setFaviorButton
        setFaviorButton.addTarget(self, action: #selector(handlefavourPlase), for:.touchUpInside )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func  handlefavourPlase(){
       link?.changeFavour(cell: self)
    }
}
