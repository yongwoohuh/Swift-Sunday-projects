//
//  ViewController.swift
//  iOSmemoryApp
//
//  Created by Yongwoo Huh on 2020/01/18.
//  Copyright © 2020 Yongwoo Huh. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let dataSource = MemoryDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "MemoryViewController") as? MemoryViewController else {
            fatalError("Unable to instantiate memory view controller.")
        }
        
        let item = dataSource.item(at: indexPath.row)
        vc.memoryItem = item
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
