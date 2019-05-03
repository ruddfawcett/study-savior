//
//  HomeViewController.swift
//  StudySavior
//
//  Created by Ally Klionsky on 5/2/19.
//  Copyright © 2019 Ally Klionsky. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var reusableTableView: ReusableTableView!
    var students = [Student.ally, Student.elly, Student.liam, Student.rudd]
    
    var filteredStudents = [Student]()
    let searchController = UISearchController(searchResultsController: nil)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search"
        
        navigationController!.navigationBar.layoutMargins.left = 30
        navigationController!.navigationBar.layoutMargins.right = 30
        
        searchController.searchBar.layoutMargins.left = 30
        searchController.searchBar.layoutMargins.right = 30
        

        reusableTableView = ReusableTableView(tableView, students)
        reusableTableView.didSelectCellClosure =  {(s: Any) -> Void in
            self.performSegue(withIdentifier: "showDetail", sender: s)
        }
        
        reusableTableView.tableView.reloadData()
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.navigationItem.searchController?.hairlineView?.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = sender as? IndexPath {
                let student: Student
                if isFiltering() {
                    student = filteredStudents[indexPath.row]
                } else {
                    student = students[indexPath.row]
                }
                
                reusableTableView.tableView.deselectRow(at: indexPath, animated: true)
                
                let controller = segue.destination as! StudentViewController
                controller.isMyProfile = false
                controller.student = student
            }
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredStudents = students.filter({( student : Student) -> Bool in
            return !searchBarIsEmpty() ? student.hash.lowercased().contains(searchText.lowercased()) : false
        })
        
        reusableTableView.students = !searchBarIsEmpty() ? filteredStudents : students
        reusableTableView.tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
