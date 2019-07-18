//
//  TableViewController.swift
//  TableVieeList
//
//  Created by Всеволод Андрющенко on 13/07/2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var data = [
        ShowData(isShow: true, list: [ListData(name: "Abbath", isFavour: false),ListData(name: "Accept", isFavour: false), ListData(name: "Amon amarth", isFavour: false)]),
        ShowData(isShow: true, list: [ListData(name: "Batory", isFavour: false),ListData(name: "BlindGuardian", isFavour: false), ListData(name: "Behemoth", isFavour: false)]),
        ShowData(isShow: true, list: [ListData(name: "Crematory", isFavour: false),ListData(name: "Carcass", isFavour: false), ListData(name: "Creadle of filth", isFavour: false)]),
        ShowData(isShow: true, list: [ListData(name: "Death", isFavour: false),ListData(name: "deapishMode", isFavour: false)])
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSerup()
    }
    
    // Marck: setup View
    fileprivate func viewSerup() {
        
        navigationItem.title = "Music"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .orange
        
        let button = UIButton(type: .system)
        button.setTitle("More", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(naviButtonShoweMoreData), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cellss")
        
        tableView.backgroundColor = .lightGray
        tableView.showsVerticalScrollIndicator = false
        
    }
    
    @objc private func naviButtonShoweMoreData(){
        
        var indexPathReload = [IndexPath]()
        
        for sections in data.indices{
            for row in data[sections].list.indices{
                let iPath = IndexPath(row: row, section: sections)
                indexPathReload.append(iPath)
            }
        }
        
        tableView.reloadRows(at: indexPathReload, with: .right)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 35
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data[section].isShow{
             return data[section].list.count
        }else{
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.orange
        button.setTitle("Close", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(changeSectionPress), for: .touchUpInside)
        button.tag = section
        
        return button
    }
    
    // MARK : Click Close/Open Button in section
    @objc private func changeSectionPress(button: UIButton){
        
        let section = button.tag
        var indexPath = [IndexPath]()
        
        for row in  data[section].list.indices  {
            let iPath = IndexPath(row: row, section: section)
            indexPath.append(iPath)
            print(row)
        }
        
        let isShow =  data[section].isShow
        data[section].isShow = !isShow
        
        if isShow{
            tableView.deleteRows(at: indexPath, with: .fade)
            button.setTitle("Open", for: .normal)
        }else{
            tableView.insertRows(at: indexPath, with: .fade)
            button.setTitle("Close", for: .normal)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellss", for: indexPath) as! CustomTableViewCell
        cell.link = self
        let item = data[indexPath.section].list[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryView?.tintColor = item.isFavour ? UIColor.red : .lightGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //Marck: press Star in cell
    func changeFavour(cell: UITableViewCell){
        let indexPathTaped = tableView.indexPath(for: cell)
        if let cellTaped = indexPathTaped{
            let isFavour = data[cellTaped.section].list[cellTaped.row].isFavour
            data[cellTaped.section].list[cellTaped.row].isFavour = !isFavour
            
            tableView.reloadData()
            cell.accessoryView?.tintColor = isFavour ? UIColor.red : .lightGray
        }
        //print(indexPathTaped)
    }

}
