//
//  PaymentButton.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import UIKit
import AICreatorModel

final class PaymentButton: UIButton {
    private let title = UILabel(text: "",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Bold", size: 22))
    private let saveLabel = UILabel(text: "Just $1.45/week",
                                    textColor: .white.withAlphaComponent(0.3),
                                    font: UIFont(name: "SFProText-Regular", size: 17))
    private let perWeek = UILabel(text: "",
                                  textColor: .white,
                                  font: UIFont(name: "SFProText-Bold", size: 22))
    var isSelectedState: Bool {
        willSet {
            if newValue {
                self.layer.borderWidth = 1
                self.layer.borderColor = UIColor(hex: "#EEA272")?.cgColor
            } else {
                self.layer.borderWidth = 0
                self.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            }
        }
    }
    private var isAnnual: PlanPresentationModel

    public init(isAnnual: PlanPresentationModel, isSelectedState: Bool = false) {
        self.isAnnual = isAnnual
        self.isSelectedState = isSelectedState
        super.init(frame: .zero)
        setupUI(isAnnual: isAnnual)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(isAnnual: PlanPresentationModel) {

        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)

        self.layer.cornerRadius = 12

        self.title.textAlignment = .left
        self.perWeek.textAlignment = .left
        self.saveLabel.textAlignment = .left

        switch self.isAnnual {
        case .yearly:
            self.title.text = "Yearly"
            self.perWeek.text = "$69.99/year"
            self.addSubview(saveLabel)
        case .weekly:
            self.title.text = "Weekly"
            self.perWeek.text = "$8.99/week"
            break
        }

        self.isSelectedState = false

        addSubview(title)
        addSubview(perWeek)
        setupConstraints()
    }

    private func setupConstraints() {

        title.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(18)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(148)
            view.height.equalTo(28)
        }

        switch self.isAnnual {
        case .yearly:

            saveLabel.snp.makeConstraints { view in
                view.bottom.equalToSuperview().inset(7)
                view.trailing.equalToSuperview().inset(16)
                view.height.equalTo(22)
                view.width.equalTo(140)
            }

            perWeek.snp.makeConstraints { view in
                view.top.equalToSuperview().offset(7)
                view.trailing.equalToSuperview().inset(16)
                view.height.equalTo(28)
                view.width.equalTo(140)
            }
        case .weekly:
            perWeek.snp.makeConstraints { view in
                view.top.equalToSuperview().offset(18)
                view.trailing.equalToSuperview().inset(16)
                view.height.equalTo(28)
                view.width.equalTo(140)
            }
        }
    }

    public func setup(with isYearly: String) {
        self.title.text = isYearly
    }
}

enum PlanPresentationModel {
    case yearly
    case weekly
}
