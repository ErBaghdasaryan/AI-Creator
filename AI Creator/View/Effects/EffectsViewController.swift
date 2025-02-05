//
//  EffectsViewController.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import AICreatorViewModel
import SnapKit
import StoreKit

class EffectsViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let header = UILabel(text: "AI Creator",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Black", size: 28))
    private let subHeader = UILabel(text: "Effects",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Regular", size: 28))

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .black
        self.header.textAlignment = .left
        self.subHeader.textAlignment = .left

        self.view.addSubview(header)
        self.view.addSubview(subHeader)
        setupConstraints()
        setupNavigationBar()
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
    }

}

//MARK: Make buttons actions
extension EffectsViewController {

    private func makeButtonsAction() {
        
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

        EffectsRouter.showPaymentViewController(in: navigationController)
    }
}

extension EffectsViewController: IViewModelableController {
    typealias ViewModel = IEffectsViewModel
}

//MARK: Preview
import SwiftUI

struct EffectsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let effectsViewController = EffectsViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<EffectsViewControllerProvider.ContainerView>) -> EffectsViewController {
            return effectsViewController
        }

        func updateUIViewController(_ uiViewController: EffectsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<EffectsViewControllerProvider.ContainerView>) {
        }
    }
}
