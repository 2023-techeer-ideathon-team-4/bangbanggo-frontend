//
//  RecordViewController.swift
//  Front_IOS
//
//  Created by 박다미 on 2023/05/27.
//

import UIKit

class RecordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        cell.localLabel.text = "지역명: \(indexPath.row)"
        cell.destinationLabel.text = "관광지: \(indexPath.row)"
        cell.dateLabel.text = "날짜: \(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
