//
//  SettingsViewController.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 28.01.25.
//

import AICreatorViewModel
import SnapKit
import StoreKit
import ApphudSDK

class SettingsViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let header = UILabel(text: "AI Creator",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Black", size: 28))
    private let subHeader = UILabel(text: "Settings",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Regular", size: 28))
    private let back = UIButton(type: .system)
    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
        setupTableView()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .black
        self.header.textAlignment = .left
        self.subHeader.textAlignment = .left

        self.back.setImage(UIImage(named: "settingsBack"), for: .normal)

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.view.addSubview(header)
        self.view.addSubview(back)
        self.view.addSubview(subHeader)
        self.view.addSubview(tableView)

        setupConstraints()
        setupNavigationBar()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.tableView.reloadData()
    }

    func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(60)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
        }

        back.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(32)
            view.height.equalTo(32)
        }

        subHeader.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(24)
            view.leading.equalTo(back.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        tableView.snp.makeConstraints { view in
            view.top.equalTo(subHeader.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }

        tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0)
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

//MARK: Make buttons actions
extension SettingsViewController {

    private func makeButtonsAction() {
        back.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }

        navigationController.popViewController(animated: true)
    }

    private func tappedCell(from index: Int) {
        guard let navigationController = self.navigationController else { return }
        switch index {
        case 0:
            self.rateTapped()
        case 1:
            self.shareTapped()
        case 2:
            SettingsRouter.showUsageViewController(in: navigationController)
        case 3:
            self.restorePurchase { result in
                switch result {
                case false:
                    self.showAlert(title: "Error!", message: "An error occurred while restoring the purchase.")
                case true:
                    self.showAlert(title: "Success!", message: "The purchase was successfully restored.")
                default:
                    break
                }
            }
        default:
            break
        }

    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    @MainActor
    func restorePurchase(escaping: @escaping(Bool) -> Void) {
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

    @objc func shareTapped() {
        let appStoreURL = URL(string: "https://apps.apple.com/us/app/seaart-ai/id6740988894")!

        let activityViewController = UIActivityViewController(activityItems: [appStoreURL], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        activityViewController.excludedActivityTypes = [
            .postToWeibo,
            .print,
            .assignToContact,
            .saveToCameraRoll,
            .addToReadingList,
            .postToFlickr,
            .postToVimeo,
            .postToTencentWeibo,
            .openInIBooks,
            .markupAsPDF,
            .mail,
            .airDrop,
            .postToFacebook,
            .postToTwitter,
            .copyToPasteboard
        ]

        present(activityViewController, animated: true, completion: nil)
    }

    @objc func rateTapped() {
        guard let scene = view.window?.windowScene else { return }
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview()
        } else {
            let alertController = UIAlertController(
                title: "Enjoying the app?",
                message: "Please consider leaving us a review in the App Store!",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Go to App Store", style: .default) { _ in
                if let appStoreURL = URL(string: "https://apps.apple.com/us/app/seaart-ai/id6740988894") {
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                }
            })
            present(alertController, animated: true, completion: nil)
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

        EffectsRouter.showPaymentViewController(in: navigationController)
    }

    private func calculateOverallIndex(for indexPath: IndexPath) -> Int {
        var overallIndex = 0

        for section in 0..<indexPath.section {
            overallIndex += viewModel?.settingsItems.count ?? 0
        }

        overallIndex += indexPath.row

        return overallIndex
    }
}

extension SettingsViewController: IViewModelableController {
    typealias ViewModel = ISettingsViewModel
}

//MARK: TableView Delegate & Data source
extension SettingsViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = viewModel?.settingsItems.count
        return rows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let item = self.viewModel?.settingsItems[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.imageView?.image = item.icon
            cell.accessoryType = item.accessoryType
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let overallIndex = calculateOverallIndex(for: indexPath)
        self.tappedCell(from: overallIndex)
    }
}


//MARK: Preview
import SwiftUI

struct SettingsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let settingsViewController = SettingsViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) -> SettingsViewController {
            return settingsViewController
        }

        func updateUIViewController(_ uiViewController: SettingsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) {
        }
    }
}
