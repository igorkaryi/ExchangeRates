//
//  DetailViewController.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 11.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import UIKit
import RxSwift

class DetailViewController: BaseViewController {
    
    @IBOutlet fileprivate weak var contentView: UIView!
    
    fileprivate var chartView = ChartView.viewWithDefaultNib()
    
    fileprivate var disposeBag = DisposeBag()
    fileprivate var viewModel: DetailProtocol?
    
    var rate: ERRate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        viewModel = DetailViewModel()
        
        setDate()
    }

}

//MARK: Setup Chart
extension DetailViewController {
    
    private func setupChartWithModel(_ model: History?) {
        chartView.setModel(model)
        contentView.addSubview(chartView)
        hideHud()
    }
}


//MARK: Network
extension DetailViewController {
    
    private func setDate() {
        showHud()
        let title = rate?.title ?? ""
        self.title = title
        let startAt = dateWothFormat(daysBefore(7))
        let endAt = dateWothFormat(Date())
        getLatestRatesWithBase(
            .usd,
            symbols: title,
            startAt: startAt,
            endAt: endAt
        )
    }

    private func getLatestRatesWithBase(_ base: BaseRate, symbols: String, startAt: String, endAt: String) {
        viewModel?.getHistoryWithBase(base, symbols: symbols, startAt: startAt, endAt: endAt, completion: { [weak self] (data, error) in
            guard let self = self else { return }
            
            if data != nil {
                self.setupChartWithModel(data)
            } else {
                self.hideHud()
                print(error ?? "")
                self.showAlert(message: error ?? "")
            }
        })
    }
    
    private func daysBefore(_ days: Int) -> Date {
        let date = Calendar.current.date(byAdding: .day, value: -days, to: Date())
        
        return date ?? Date()
    }
    
    private func dateWothFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: date)
        
        return date
    }
    
}
