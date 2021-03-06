//
//  CalculatorViewController.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/2/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//

import RxCocoa
import RxOptional
import RxSwift
import UIKit

final class CalculatorViewController: UIViewController {
    private let disposeBag = DisposeBag()
    @IBOutlet private var currencyLbl: UILabel!
    @IBOutlet private var baseLbl: UILabel!
    @IBOutlet private var currencyValueLbl: UILabel!
    @IBOutlet private var baseTextField: UITextField!

    var viewModel: CalculatorViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calculator"
        bindToViewModel()
    }

    private func bindToViewModel() {
        baseTextField.rx.text
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .filterNil()
            .map { Float($0) }
            .filterNil()
            .subscribe(onNext: { [unowned self] value in
                self.viewModel.calculateCurrencyValue(of: value)
            }).disposed(by: disposeBag)
        viewModel.baseCurrency.bind(to: baseLbl.rx.text).disposed(by: disposeBag)
        viewModel.toCurrency.bind(to: currencyLbl.rx.text).disposed(by: disposeBag)
        viewModel.totalValue.bind(to: currencyValueLbl.rx.text).disposed(by: disposeBag)
    }
}
