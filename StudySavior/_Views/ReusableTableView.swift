//
//  ReusableTableView.swift
//  StudySavior
//
//  Created by Ally Klionsky on 5/2/19.
//  Copyright © 2019 Ally Klionsky. All rights reserved.
//

import UIKit

class ReusableTableView: NSObject {
    let cellReuseIdentifier = "StudentCell"
    
    var tableView: UITableView
    var students: [Student]
    
    var didSelectCellClosure: (_ sender: Any) -> Void = {_ in }

    init(_ tv: UITableView, _ data: [Student]) {
        students = data
        tableView = tv
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "StudentCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }

    func loadCell(atIndexPath indexPath: IndexPath, forTableView tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        return cell
    }
}

extension ReusableTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StudentCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! StudentCell
        cell.student = self.students[indexPath.row]
        
        return cell
    }
}

extension ReusableTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.students[indexPath.row].classes.count > 3 ? 174 : 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCellClosure(indexPath)
    }
}
