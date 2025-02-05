//
//  TextWImage.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 24.01.25.
//

import UIKit

class TextWImage: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
    }

    func configure(with text: String, image: UIImage?, backgroundColor: UIColor?, titleColor: UIColor, font: UIFont) {
        self.setTitle(text, for: .normal)

        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font

        if let image = image {
            self.setImage(image, for: .normal)
            self.imageView?.contentMode = .scaleAspectFit
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        }

        self.backgroundColor = backgroundColor
    }
}

