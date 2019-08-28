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
    var lat:Double = 0.0
    var log:Double = 0.0
    var currentPage:Int = 1
    var totalPage:Int = 1
    var evnBriteObj:JSON?
    var events:[JSON] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getEventsData()
        CoreLocationManager.sharedeInstance.configureLocationManager()
        // Do any additional setup after loading the view, typically from a nib.
    }

    fileprivate func getEventsData() {
        if lat == 0 {return}
        let end_date = Utility.getEndEventDate() + "T00:00:01Z"
        let strat_date = Utility.changeDateInFormat(Date(), formatString: dateFormat) + "T00:00:01Z"
        events.removeAll()
        var reqestData:[String:Any] = [:]
        reqestData["lat"] =  lat
        reqestData["log"] =  log
        reqestData["start_date"] = strat_date
        reqestData["end_date"] = end_date
        reqestData["radius"] = 2 //2mi
        reqestData["page"] = currentPage
        
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
        
        CoreLocationManager.sharedeInstance.gpsValueUpdates = { [weak self](lat,log) in
            self?.lat = lat
            self?.log = log
            self?.getEventsData()
        }
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
