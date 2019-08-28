//
//  ViewController.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import UIKit
import SwiftyJSON
class ViewController: UIViewController {
    
    @IBOutlet weak var eventTableView: UITableView!
    var evnBriteObj:JSON?
    var events:[JSON] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getEventsData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    fileprivate func getEventsData() {
        var reqestData:[String:Any] = [:]
        reqestData["lat"] =  49.279974
        reqestData["log"] = -123.11236500000001
        reqestData["start_date"] = "2019-08-27T00:00:01Z"
        reqestData["end_date"] = "2019-09-1T00:00:01Z"
        reqestData["radius"] = 2
        reqestData["page"] = 1
        
        APIService.getEvents(reqestData) { (successs, erro,model) in
            if successs {
            DispatchQueue.main.async { [weak self] in
                    self?.evnBriteObj = model
                    if let newContent = model?["events"].arrayValue {
                        self?.events.append(contentsOf: newContent)
                        self?.eventTableView.reloadData()
                    }
                }
            }
        }
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func configureTableView() {
        eventTableView.dataSource = self
        eventTableView.delegate = self
        eventTableView.estimatedRowHeight = 120
        eventTableView.rowHeight =  UITableView.automaticDimension
        let mediaMsgNib = UINib(nibName :EventTableViewCell.className, bundle : nil)
        eventTableView.register(mediaMsgNib, forCellReuseIdentifier: EventTableViewCell.identifire)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifire, for: indexPath) as? EventTableViewCell
        cell?.eventData = events[indexPath.row]
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
}
