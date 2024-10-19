//
//  CalculatorViewController.swift
//  Tip Calculator
//
//  Created by Alexey Bolvonovich on 16/10/2024.
//

import UIKit
import Combine
import CombineCocoa
import SnapKit

class CalculatorViewController: UIViewController {
    
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitInputView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    private let viewModel = CalculatorViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(tapGestureRecognizer)
        return tapGestureRecognizer.tapPublisher.flatMap {_ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
        tapGestureRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGestureRecognizer)
        return tapGestureRecognizer.tapPublisher.flatMap {_ in
            Just(())
        }.eraseToAnyPublisher()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
        observe()
    }
    
    private func bind() {
        let input = CalculatorViewModel.Input(
            billPublisher: billInputView.valuePublisher,
            tipPublisher: tipInputView.valuePublisher,
            splitPublisher: splitInputView.valuePublisher
        )
        
        let output = viewModel.transform(input: input)
        
        output.updateViewPublisher.sink { [unowned self] result in
            resultView.configure(result: result)
        }.store(in: &cancellables)
    }
    
    private func observe() {
        viewTapPublisher.sink { [unowned self] in
            view.endEditing(true)
        }.store(in: &cancellables)
        
        logoViewTapPublisher.sink { [unowned self] in
            print("logo tapped")
        }.store(in: &cancellables)
    }
    
    private func layout() {
        view.backgroundColor = ThemeColor.bg
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }
        
        logoView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints {
            $0.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        tipInputView.snp.makeConstraints {
            $0.height.equalTo(56 + 56 + 16)
        }
        
        splitInputView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
}
