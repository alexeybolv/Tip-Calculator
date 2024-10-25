//
//  BillInputView.swift
//  Tip Calculator
//
//  Created by Alexey Bolvonovich on 16/10/2024.
//

import UIKit
import Combine
import CombineCocoa

class BillInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(
            topText: "Enter",
            bottomText: "your bill"
        )
        return view
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(
            offset: CGSize(width: 0, height: 3),
            color: .black,
            radius: 12,
            opacity: 0.1
        )
        return view
    }()
    
    private let currencyDenominationLabel: UILabel = {
        let label = LabelFactory.build(
            text: "$",
            font: ThemeFont.bold(ofSize: 24)
        )
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = ThemeFont.demibold(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.tintColor = ThemeColor.text
        textField.textColor = ThemeColor.text
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped)
        )
        toolBar.items = [
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
            ),
            doneButton
        ]
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        return textField
    }()
    
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        textField.text = nil
        billSubject.send(0)
    }
    
    private func observe() {
        textField.textPublisher.sink { [unowned self] text in
            billSubject.send(text?.doubleValue ?? 0)
        }.store(in: &cancellables)
    }
    
    private func layout() {
        [headerView, textFieldContainerView].forEach(addSubview(_:))
        
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(textFieldContainerView.snp.centerY)
            $0.width.equalTo(68)
            $0.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }
        
        textFieldContainerView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        textFieldContainerView.addSubview(currencyDenominationLabel)
        textFieldContainerView.addSubview(textField)
        
        currencyDenominationLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(currencyDenominationLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    @objc private func doneButtonTapped() {
        textField.endEditing(true)
    }
}
