//
//  PaymentViewModel.swift
//  AICreatorViewModel
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import Foundation
import AICreatorModel

public protocol IPaymentViewModel {

}

public class PaymentViewModel: IPaymentViewModel {

    private let paymentService: IPaymentService

    public init(paymentService: IPaymentService) {
        self.paymentService = paymentService
    }
}
