//
//  ViewController.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    private var storeItems = StoreItems() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addNotification()
        self.storeItems.setJSONData(with: Keyword.fileName.value)
    }

    private func addNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(storeItemsSetted(notification:)),
            name: .storeItems,
            object: nil
        )
    }

    @objc private func storeItemsSetted(notification: Notification) {
        guard let storeItems = notification.object as? StoreItems else { return }
        self.storeItems = storeItems
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keyword.customCellName.value, for: indexPath) as? StoreItemTableViewCell
        let storeItem = storeItems[indexPath.row]
        cell?.set(with: storeItem!)
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
