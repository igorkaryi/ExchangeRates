//
//  MainViewController.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 10.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class MainViewController: BaseViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate var disposeBag = DisposeBag()
    fileprivate var viewModel: MainProtocol?
    
    fileprivate let realm = try! Realm()
    fileprivate var rates: Results<ERRate>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

}


//MARK: Setup
extension MainViewController {
    
    private func setup() {
        viewModel = MainViewModel()
        
        setupTableView()
        
        if isToMakeRequest()  {
            getLatestRatesWithBase(.usd)
        } else {
            rates = realm.objects(ERRate.self)
            tableView.reloadData()
        }
    }
    
    private func isToMakeRequest() -> Bool {
        let time = UserDefaultsClass().getTime(key: UserDefaultsKeys.time)
        
        let calendar = Calendar.current
        guard let timeFrom = time else { return true }
        
        let components = calendar.dateComponents([.minute], from: timeFrom, to: Date())
        guard let minutes = components.minute else { return true }
        
        return minutes > 10
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
}


//MARK: Network
extension MainViewController {
    
    private func getLatestRatesWithBase(_ base: BaseRate) {
        viewModel?.getLatestRatesWithBase(base, completion: { [weak self] (data, error) in
            guard let self = self else { return }
            
            if data != nil {
                self.setData(data)
            } else {
                print(error ?? "")
                self.showAlert(message: error ?? "")
            }
        })
    }
    
    private func setData(_ data: Latest?) {
        guard let items = data?.rates?.items else { return }
        
        removeRealmData()
        
        for item in items {
            let r = self.makeRate(item.title, value: item.value)
            try! realm.write {
                self.realm.add(r)
            }
        }
        
        if !items.isEmpty {
            saveCurrentTime()
            
            rates = realm.objects(ERRate.self)
            tableView.reloadData()
        }
    }
    
    private func saveCurrentTime() {
        UserDefaultsClass().saveTime(value: Date(), key: UserDefaultsKeys.time)
    }
    
    private func removeRealmData() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }

}


//MARK: Local DB
extension MainViewController {
    
    func makeRate(_ title: String?, value: Double?) -> ERRate  {
        let rate = ERRate()
        
        rate.title = title ?? ""
        rate.value = value ?? 0.0
        
        return rate
    }
    
}


//MARK: TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.rateCell, for: indexPath) else { return UITableViewCell() }
        
        let rate = rates?[indexPath.row]
        cell.setModel(rate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let vc = R.storyboard.main.detailViewController() else { return }
        vc.rate = rates?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
