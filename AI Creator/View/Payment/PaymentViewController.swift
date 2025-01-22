//
//  PaymentViewController.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import UIKit
import AICreatorViewModel
import SnapKit
import ApphudSDK

final class PaymentViewController: BaseViewController {

    var viewModel: ViewModel?

    private let topImage = UIImageView(image: .init(named: "paymentImage"))
    private let forFreeButton = UIButton(type: .system)
    private let continueButton = UIButton(type: .system)
    private var currentIndex: Int = 0

    private let firstUnlimeted = IconLabelView(image: UIImage(named: "checkmarkBlue")!,
                                               text: "Unlimited Video Generations",
                                               textHeight: 15,
                                               imageSize: CGSize(width: 16,
                                                                 height: 16),
                                               spacing: 8)
    private let secondUnlimeted = IconLabelView(image: UIImage(named: "checkmarkBlue")!,
                                               text: "Ad-Free Experience",
                                               textHeight: 15,
                                               imageSize: CGSize(width: 16,
                                                                 height: 16),
                                                spacing: 8)
    private let thirdUnlimeted = IconLabelView(image: UIImage(named: "checkmarkBlue")!,
                                               text: "High-Quality Video Output",
                                               textHeight: 15,
                                               imageSize: CGSize(width: 16,
                                                                 height: 16),
                                               spacing: 8)
    private let fourthUnlimeted = IconLabelView(image: UIImage(named: "checkmarkBlue")!,
                                               text: "Access to All Effects",
                                               textHeight: 15,
                                               imageSize: CGSize(width: 16,
                                                                 height: 16),
                                                spacing: 8)
    private var unlimitedStack: UIStackView!

    private let aiCreator = UILabel(text: "AI Creator",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Bold", size: 28))
    private let pro = UIImageView(image: UIImage(named: "getPro"))

    private let weeklyButton = PaymentButton(isAnnual: .weekly)
    private let yearlyButton = PaymentButton(isAnnual: .yearly)
    private var plansStack: UIStackView!

    private let privacyButton = UIButton(type: .system)

    private let termsButton = UIButton(type: .system)
    private var bottomStack: UIStackView!

//    private var currentProduct: ApphudProduct?
//    public let paywallID = "main"
//    public var productsAppHud: [ApphudProduct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
        self.loadPaywalls()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.forFreeButton.isHidden = false
        }
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .black
        aiCreator.textAlignment = .left

        self.forFreeButton.setImage(.init(named: "paymentClose"), for: .normal)

        self.continueButton.setTitle("Continue", for: .normal)
        self.continueButton.setTitleColor(.black, for: .normal)
        self.continueButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 22)
        self.continueButton.backgroundColor = UIColor(hex: "#EEA272")
        self.continueButton.layer.masksToBounds = true
        self.continueButton.layer.cornerRadius = 8

        self.plansStack = UIStackView(arrangedSubviews: [weeklyButton,
                                                         yearlyButton],
                                      axis: .vertical,
                                      spacing: 8)

        self.privacyButton.setTitle("Privacy policy", for: .normal)
        self.privacyButton.setTitleColor(.white.withAlphaComponent(0.3), for: .normal)
        self.privacyButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12)
        self.termsButton.setTitle("Terms", for: .normal)
        self.termsButton.setTitleColor(.white.withAlphaComponent(0.3), for: .normal)
        self.termsButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12)
        self.bottomStack = UIStackView(arrangedSubviews: [termsButton, privacyButton],
                                       axis: .horizontal,
                                       spacing: 16)
        self.bottomStack.distribution = .fillProportionally

        self.unlimitedStack = UIStackView(arrangedSubviews: [firstUnlimeted,
                                                             secondUnlimeted,
                                                             thirdUnlimeted,
                                                             fourthUnlimeted],
                                          axis: .vertical,
                                          spacing: 8)

        self.forFreeButton.isHidden = true

        self.view.addSubview(topImage)
        self.view.addSubview(aiCreator)
        self.view.addSubview(pro)
        self.view.addSubview(forFreeButton)
        self.view.addSubview(unlimitedStack)
        self.view.addSubview(plansStack)
        self.view.addSubview(continueButton)
        self.view.addSubview(bottomStack)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        topImage.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(354)
        }

        aiCreator.snp.makeConstraints { view in
            view.top.equalTo(topImage.snp.bottom).offset(18)
            view.leading.equalToSuperview().offset(81)
            view.trailing.equalToSuperview().inset(175)
            view.height.equalTo(34)
        }

        pro.snp.makeConstraints { view in
            view.top.equalTo(topImage.snp.bottom).offset(16)
            view.leading.equalTo(aiCreator.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(81)
            view.height.equalTo(38)
        }

        forFreeButton.snp.makeConstraints { view in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(18)
            view.trailing.equalToSuperview().inset(32)
            view.height.equalTo(16)
            view.width.equalTo(16)
        }

        unlimitedStack.snp.makeConstraints { view in
            view.top.equalTo(aiCreator.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(73.5)
            view.trailing.equalToSuperview().inset(73.5)
            view.height.equalTo(112)
        }

        plansStack.snp.makeConstraints { view in
            view.top.equalTo(unlimitedStack.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(136)
        }

        continueButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(56)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(60)
        }

        bottomStack.snp.makeConstraints { view in
            view.top.equalTo(continueButton.snp.bottom).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(16)
            view.width.equalTo(130)
        }
    }

}

//MARK: Make buttons actions
extension PaymentViewController {
    
    private func makeButtonsAction() {
        continueButton.addTarget(self, action: #selector(continueButtonTaped), for: .touchUpInside)
        forFreeButton.addTarget(self, action: #selector(forFreeButtonTapped), for: .touchUpInside)
        yearlyButton.addTarget(self, action: #selector(planAction(_:)), for: .touchUpInside)
        weeklyButton.addTarget(self, action: #selector(planAction(_:)), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
    }

    @objc func privacyTapped() {
        guard let navigationController = self.navigationController else { return }
        PaymentRouter.showPrivacyViewController(in: navigationController)
    }

    @objc func termsTapped() {
        guard let navigationController = self.navigationController else { return }
        PaymentRouter.showTermsViewController(in: navigationController)
    }

    @objc func planAction(_ sender: UIButton) {
        switch sender {
        case yearlyButton:
            self.yearlyButton.isSelectedState = true
            self.weeklyButton.isSelectedState = false
//            self.currentProduct = self.productsAppHud.first
        case weeklyButton:
            self.yearlyButton.isSelectedState = false
            self.weeklyButton.isSelectedState = true
//            self.currentProduct = self.productsAppHud[1]
        default:
            break
        }
    }

    @objc func forFreeButtonTapped() {
        if let navigationController = self.navigationController {
            let viewControllers = navigationController.viewControllers

            if let currentIndex = viewControllers.firstIndex(of: self), currentIndex > 0 {
                let previousViewController = viewControllers[currentIndex - 1]

                if previousViewController is OnboardingViewController {
                    UntilOnboardingRouter.showTabBarViewController(in: navigationController)
                } else {
                    navigationController.navigationBar.isHidden = false
                    navigationController.navigationItem.hidesBackButton = false
                    UntilOnboardingRouter.popViewController(in: navigationController)
                }
            }
        }
    }

    @objc func continueButtonTaped() {
//        if let navigationController = self.navigationController {
//            guard let currentProduct = self.currentProduct else { return }
//
//            startPurchase(product: currentProduct) { result in
//                let viewControllers = navigationController.viewControllers
//
//                if let currentIndex = viewControllers.firstIndex(of: self), currentIndex > 0 {
//                    let previousViewController = viewControllers[currentIndex - 1]
//
//                    if previousViewController is OnboardingViewController {
//                        UntilOnboardingRouter.showTabBarViewController(in: navigationController)
//                    } else {
//                        UntilOnboardingRouter.popViewController(in: navigationController)
//                    }
//                }
//            }
//        }
    }

    @objc func restore() {
        guard let navigationController = self.navigationController else { return }
        self.restorePurchase { result in
            print("Restore completed!")
        }

        let viewControllers = navigationController.viewControllers

        if let currentIndex = viewControllers.firstIndex(of: self), currentIndex > 0 {
            let previousViewController = viewControllers[currentIndex - 1]

            if previousViewController is OnboardingViewController {
                UntilOnboardingRouter.showTabBarViewController(in: navigationController)
            } else {
                UntilOnboardingRouter.popViewController(in: navigationController)
            }
        }
    }

    @MainActor
    public func startPurchase(product: ApphudProduct, escaping: @escaping(Bool) -> Void) {
        let selectedProduct = product
        Apphud.purchase(selectedProduct) { result in
            if let error = result.error {
                print(error.localizedDescription)
                escaping(false)
            }

            if let subscription = result.subscription, subscription.isActive() {
                escaping(true)
            } else if let purchase = result.nonRenewingPurchase, purchase.isActive() {
                escaping(true)
            } else {
                if Apphud.hasActiveSubscription() {
                    escaping(true)
                }
            }
        }
    }

    @MainActor
    public func restorePurchase(escaping: @escaping(Bool) -> Void) {
        Apphud.restorePurchases { subscriptions, _, error in
            if let error = error {
                print(error.localizedDescription)
                escaping(false)
            }
            if subscriptions?.first?.isActive() ?? false {
                escaping(true)
            }
            if Apphud.hasActiveSubscription() {
                escaping(true)
            }
        }
    }

    @MainActor
    public func loadPaywalls() {
//        Apphud.paywallsDidLoadCallback { paywalls, arg in
//            if let paywall = paywalls.first(where: { $0.identifier == self.paywallID }) {
//                Apphud.paywallShown(paywall)
//
//                let products = paywall.products
//                self.productsAppHud = products
//            }
//        }
    }
}

extension PaymentViewController: IViewModelableController {
    typealias ViewModel = IPaymentViewModel
}

//MARK: Preview
import SwiftUI

struct PaymentViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let paymentViewController = PaymentViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<PaymentViewControllerProvider.ContainerView>) -> PaymentViewController {
            return paymentViewController
        }

        func updateUIViewController(_ uiViewController: PaymentViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PaymentViewControllerProvider.ContainerView>) {
        }
    }
}
