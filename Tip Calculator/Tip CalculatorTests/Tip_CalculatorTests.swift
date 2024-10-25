//
//  Tip_CalculatorTests.swift
//  Tip CalculatorTests
//
//  Created by Alexey Bolvonovich on 16/10/2024.
//

import XCTest
import Combine
@testable import Tip_Calculator

final class Tip_CalculatorTests: XCTestCase {
    
    private var sut: CalculatorViewModel!
    private var cancellables: Set<AnyCancellable>!
    
    private let logoViewTapSubject: PassthroughSubject<Void, Never> = .init()
    
    override func setUp() {
        sut = CalculatorViewModel()
        cancellables = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
    }
    
    func testResultWithoutTipForOnePerson() {
        let bill: Double = 100
        let tip: Tip = .none
        let split: Int = 1
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        let output = sut.transform(input: input)
        
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func testResultWithoutTipForTwoPerson() {
        let bill: Double = 100
        let tip: Tip = .none
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        let output = sut.transform(input: input)
        
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 50)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func testResultWithTenPercentTipForTwoPerson() {
        let bill: Double = 100
        let tip: Tip = .tenPercent
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        let output = sut.transform(input: input)
        
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 55)
            XCTAssertEqual(result.totalBill, 110)
            XCTAssertEqual(result.totalTip, 10)
        }.store(in: &cancellables)
    }
    
    func testResultWithCustomTipForFourPerson() {
        let bill: Double = 200
        let tip: Tip = .custom(value: 201)
        let split: Int = 4
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        let output = sut.transform(input: input)
        
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100.25)
            XCTAssertEqual(result.totalBill, 401)
            XCTAssertEqual(result.totalTip, 201)
        }.store(in: &cancellables)
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorViewModel.Input {
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher()
        )
    }
}
