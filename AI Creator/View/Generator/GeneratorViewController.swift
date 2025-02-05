//
//  GeneratorViewController.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import AICreatorViewModel
import SnapKit
import StoreKit
import AICreatorModel

class GeneratorViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let header = UILabel(text: "AI Creator",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Black", size: 28))
    private let subHeader = UILabel(text: "Generator",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Regular", size: 28))
    private let textToVideo = TextWImage()
    private let imageToVideo = TextWImage()
    private var buttonsStack: UIStackView!
    private let generateButton = TextWImage()

    private let textToView = TextToVideoView()
    private let imageToView = ImageToVideoView()
    private var isTextToImage: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .black
        self.header.textAlignment = .left
        self.subHeader.textAlignment = .left

        textToVideo.configure(with: "Text to Video",
                              image: UIImage(named: "textToVideo"),
                              backgroundColor: UIColor.white.withAlphaComponent(0.05),
                              titleColor: .white,
                              font: UIFont(name: "SFProText-Regular", size: 17)!)
        imageToVideo.configure(with: "Image to Video",
                              image: UIImage(named: "imageToVideo"),
                              backgroundColor: UIColor.white.withAlphaComponent(0.05),
                              titleColor: UIColor.white.withAlphaComponent(0.3),
                              font: UIFont(name: "SFProText-Regular", size: 17)!)
        self.buttonsStack = UIStackView(arrangedSubviews: [textToVideo, imageToVideo],
                                        axis: .horizontal,
                                        spacing: 8)
        self.buttonsStack.distribution = .fillProportionally

        generateButton.configure(with: "Generate",
                                 image:  UIImage(systemName: "sparkles")?.withRenderingMode(.alwaysTemplate),
                                 backgroundColor: UIColor(hex: "#EEA272"),
                                 titleColor: .black,
                                 font: UIFont(name: "SFProText-Bold", size: 22)!)
        generateButton.tintColor = .black

        self.view.addSubview(header)
        self.view.addSubview(subHeader)
        self.view.addSubview(buttonsStack)
        self.view.addSubview(textToView)
        self.view.addSubview(generateButton)
        setupConstraints()
        setupNavigationBar()
        setupViewTapHandling()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(60)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
        }

        subHeader.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        buttonsStack.snp.makeConstraints { view in
            view.top.equalTo(subHeader.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(38)
        }

        textToView.snp.makeConstraints { view in
            view.top.equalTo(buttonsStack.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(230)
        }

        generateButton.snp.makeConstraints { view in
            view.top.equalTo(textToView.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(64)
        }
    }

}

//MARK: Make buttons actions
extension GeneratorViewController {

    private func makeButtonsAction() {
        textToVideo.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        imageToVideo.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        generateButton.addTarget(self, action: #selector(generate), for: .touchUpInside)
        imageToView.upload.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
    }

    @objc private func imageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true)
    }

    @objc private func generate() {
        if self.isTextToImage {
            guard let id = self.viewModel?.userID else { return }
            guard let promt = self.textToView.text.text else { return }
            let bundle = "com.tet.s344rt4i"

            let body = GenerationSendModel(prompt: promt,
                                           userID: id,
                                           appBundle: bundle)

            self.viewModel?.doFirstCall(from: "https://teremappol.shop/video",
                                        httpMethod: "POST",
                                        body: body,
                                        accessToken: "c82d075d-b216-4e24-acbb-5f70db5dd864",
                                        responseModel: FirstResponseModel.self,
                                        completion: { (result: Result<FirstResponseModel, Error>) in
                switch result {
                case .success(let success):
                    print("Success! \(success)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    private func setupViewTapHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc func buttonTapped(_ sender: UIButton) {
        if sender == textToVideo {
            isTextToImage = true

            textToVideo.setTitleColor(.white, for: .normal)
            imageToVideo.setTitleColor(.white.withAlphaComponent(0.3), for: .normal)

            self.updateUI(isTextToVideo: self.isTextToImage)

        } else if sender == imageToVideo {
            isTextToImage = false

            imageToVideo.setTitleColor(.white, for: .normal)
            textToVideo.setTitleColor(.white.withAlphaComponent(0.3), for: .normal)

            self.updateUI(isTextToVideo: self.isTextToImage)
        }
    }

    private func updateUI(isTextToVideo: Bool) {
        switch isTextToVideo {
        case true:
            imageToView.removeFromSuperview()
            self.view.addSubview(textToView)
            textToView.snp.makeConstraints { view in
                view.top.equalTo(buttonsStack.snp.bottom).offset(8)
                view.leading.equalToSuperview().offset(16)
                view.trailing.equalToSuperview().inset(16)
                view.height.equalTo(230)
            }
            generateButton.snp.remakeConstraints { view in
                view.top.equalTo(textToView.snp.bottom).offset(8)
                view.leading.equalToSuperview().offset(16)
                view.trailing.equalToSuperview().inset(16)
                view.height.equalTo(64)
            }
        case false:
            textToView.removeFromSuperview()
            self.view.addSubview(imageToView)
            imageToView.snp.makeConstraints { view in
                view.top.equalTo(buttonsStack.snp.bottom).offset(8)
                view.leading.equalToSuperview().offset(16)
                view.trailing.equalToSuperview().inset(16)
                view.height.equalTo(230)
            }
            generateButton.snp.remakeConstraints { view in
                view.top.equalTo(imageToView.snp.bottom).offset(8)
                view.leading.equalToSuperview().offset(16)
                view.trailing.equalToSuperview().inset(16)
                view.height.equalTo(64)
            }
        }
    }

    private func setupNavigationBar() {
        let paymentButton = UIBarButtonItem(
            image: UIImage(named: "getPurchase"),
            style: .plain,
            target: self,
            action: #selector(openPayment)
        )

        navigationItem.rightBarButtonItems = [paymentButton]
    }

    @objc private func openPayment() {
        guard let navigationController = self.navigationController else { return }

        GeneratorRouter.showPaymentViewController(in: navigationController)
    }
}

extension GeneratorViewController: IViewModelableController {
    typealias ViewModel = IGeneratorViewModel
}

//MARK: Image Picker
extension GeneratorViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.imageToView.setImageFromGallery(image: image)
    }
}

//MARK: Preview
import SwiftUI

struct GeneratorViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let generatorViewController = GeneratorViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<GeneratorViewControllerProvider.ContainerView>) -> GeneratorViewController {
            return generatorViewController
        }

        func updateUIViewController(_ uiViewController: GeneratorViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<GeneratorViewControllerProvider.ContainerView>) {
        }
    }
}
