//
//  CustomTextView.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 24.01.25.
//

import UIKit

public class TextView: UITextView, UITextViewDelegate {

    private var placeholderText: String = ""
    public var placeholderLabel: UILabel = UILabel()

    public convenience init(placeholder: String) {
        self.init()
        self.placeholderText = placeholder

        configure()
    }

    private func configure() {
        self.layer.cornerRadius = 12
        self.backgroundColor = .clear

        placeholderLabel.text = placeholderText
        placeholderLabel.font = UIFont(name: "SFProText-Regular", size: 17)
        placeholderLabel.sizeToFit()
        placeholderLabel.textAlignment = .left
        placeholderLabel.numberOfLines = 2
        addSubview(placeholderLabel)
        placeholderLabel.isHidden = !text.isEmpty

        self.placeholderLabel.attributedText = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.3)])

        self.textColor = .white
        self.font = UIFont(name: "SFProText-Regular", size: 17)

        self.delegate = self
    }

    // MARK: UITextViewDelegate
    public func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
