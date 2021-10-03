//
//  NotificationViewController.swift
//  Evocatus
//
//  Created by KONSTANTIN TISHCHENKO on 02.10.2021.
//

import UIKit

class NotificationViewController: UITableViewController {
    
    let headerNameArray = ["ПРЕДСТОЯЩИЕ", "В БЛИЖАЙШЕЕ ВРЕМЯ", "КАЛЕНДАРЬ"]
    
    let cellNameArray = [
        ["Через 6 дней запланированный отпук", "Вечером в офисе др у Jhon Doe"],
        ["Завтра вечерний футбол на коробке"],
        [""]
    ]
    
    private let idOptionsCell = "idOptionsCell"
    private let idOptionsHeader = "idOptionsHeader"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 0.9489265084, green: 0.949085772, blue: 0.9704096913, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsCell)
        tableView.register(HeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeader)
        
        title = "Cобытия"
        
    }
    //MARK: - SaveButtonOptions
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 1
        case 2: return 1
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsCell, for: indexPath) as! OptionsTableViewCell
        
        cell.cellConfigure(nameArray: cellNameArray, indexPath: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 2 ? 250 : 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
//        switch indexPath {
//
//          тут сделаем реализацию перехода на вью по тапу на событие
        
//        default:
//            break
//        }
    }
    
    
    //MARK: - Header
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsHeader) as! HeaderTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}

