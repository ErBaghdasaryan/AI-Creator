//
//  TextToVideoView.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 24.01.25.
//

import UIKit

class TextToVideoView: UIView {

    private let header = UILabel(text: "Type Your Prompt Here",
                                 textColor: UIColor(hex: "#EEA272")!,
                                 font: UIFont(name: "SFProText-Regular", size: 22))
    public let text = TextView(placeholder: "Enter your query, set the parameters and be creative")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true

        self.header.textAlignment = .left

        self.addSubview(header)
        self.addSubview(text)
        setupConstraints()
    }

    private func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(28)
        }

        text.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview().inset(10)
        }
    }
}
