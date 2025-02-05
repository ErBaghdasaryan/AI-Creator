//
//  ImageToVideoView.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 24.01.25.
//

import UIKit

class ImageToVideoView: UIView {

    public let upload = TextWImage()
    private let header = UILabel(text: "Type Your Prompt Here",
                                 textColor: UIColor(hex: "#EEA272")!,
                                 font: UIFont(name: "SFProText-Regular", size: 22))
    private let text = TextView(placeholder: "Enter your query, set the parameters and be creative")
    private let image = UIImageView()

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

        self.upload.configure(with: "Upload image",
                              image: UIImage(systemName: "photo"),
                              backgroundColor: UIColor.white.withAlphaComponent(0.05),
                              titleColor: .white,
                              font: UIFont(name: "SFProText-Bold", size: 22)!)
        self.upload.tintColor = .white

        self.image.layer.masksToBounds = true
        self.image.layer.cornerRadius = 8
        self.image.contentMode = .scaleAspectFill

        self.addSubview(upload)
        self.addSubview(header)
        self.addSubview(text)
        self.addSubview(image)
        setupConstraints()
    }

    private func setupConstraints() {
        upload.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(64)
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(upload.snp.bottom).offset(8)
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

    func setImageFromGallery(image: UIImage) {
        self.image.image = image

        self.image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(64)
            view.height.equalTo(64)
        }

        upload.snp.remakeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalTo(self.image.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(64)
        }
    }
}
