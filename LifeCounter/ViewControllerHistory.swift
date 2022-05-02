//
//  ViewControllerHistory.swift
//  LifeCounter
//
//  Created by Ian Wang on 4/24/22.
//

import UIKit

class ViewControllerHistory: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var historyTable: UITableView!
    
    var history:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTable.delegate = self
        historyTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.text = self.history[indexPath.row]

        return cell
    }
    
    @IBAction func dismissHistory(_ sender: Any) {
        print("Dismiss was pressed")
        self.dismiss(animated: true)
    }
 
}
