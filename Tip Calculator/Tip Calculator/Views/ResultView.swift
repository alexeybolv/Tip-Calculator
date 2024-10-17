//
//  ResultView.swift
//  Tip Calculator
//
//  Created by Alexey Bolvonovich on 16/10/2024.
//

import UIKit

class ResultView: UIView {
    
    private let headerLabel: UILabel = {
        LabelFactory.build(
            text: "Total p/person",
            font: ThemeFont.demibold(ofSize: 18)
        )
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(
            string: "$0.00",
            attributes: [
                .font: ThemeFont.bold(ofSize: 48)
            ]
        )
        text.addAttributes(
            [
                .font: ThemeFont.bold(ofSize: 24)
            ],
            range: NSMakeRange(0, 1)
        )
        label.attributedText = text
        return label
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                headerLabel,
                amountPerPersonLabel,
                horizontalLineView,
                hStackView
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.setCustomSpacing(12.0, after: horizontalLineView)
        return stackView
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                AmountView(),
                AmountView()
            ]
        )
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .white
        addSubview(vStackView)
        vStackView.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(24)
            $0.leading.equalTo(snp.leading).offset(24)
            $0.trailing.equalTo(snp.trailing).offset(-24)
            $0.bottom.equalTo(snp.bottom).offset(-24)
        }
        
        horizontalLineView.snp.makeConstraints {
            $0.height.equalTo(2)
        }
        
        addShadow(
            offset: CGSize(width: 0, height: 3),
            color: .black,
            radius: 12,
            opacity: 0.1
        )
    }
}

class AmountView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .red
    }
}
