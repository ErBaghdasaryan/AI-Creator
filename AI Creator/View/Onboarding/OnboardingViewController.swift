//
//  OnboardingViewController.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 21.01.25.
//

import UIKit
import AICreatorViewModel
import SnapKit
import StoreKit

class OnboardingViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    var collectionView: UICollectionView!
    private let header = UILabel(text: "Header",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Regular", size: 34))
    private let descriptionLabel = UILabel(text: "Description",
                                           textColor: .white.withAlphaComponent(0.3),
                                           font: UIFont(name: "SFProText-Regular", size: 17))
    private let pageControl = AdvancedPageControlView()
    private let nextButton = UIButton(type: .system)
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        header.textAlignment = .left

        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 2

        self.nextButton.setImage(UIImage(named: "nextButton"), for: .normal)

        let mylayout = UICollectionViewFlowLayout()
        mylayout.itemSize = sizeForItem()
        mylayout.scrollDirection = .horizontal
        mylayout.minimumLineSpacing = 0
        mylayout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(OnboardingCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false

        pageControl.drawer = ExtendedDotDrawer(numberOfPages: 4,
                                               height: 8,
                                               width: 8,
                                               space: 8,
                                               indicatorColor: UIColor(hex: "#EEA272"),
                                               dotsColor: UIColor.white.withAlphaComponent(0.2),
                                               isBordered: true,
                                               borderWidth: 0.0,
                                               indicatorBorderColor: .orange,
                                               indicatorBorderWidth: 0.0)
        pageControl.setPage(0)

        self.view.addSubview(collectionView)
        self.view.addSubview(header)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(nextButton)
        self.view.addSubview(pageControl)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel?.loadData()
    }

    func sizeForItem() -> CGSize {
        let width = self.view.frame.size.width
        let heightt = self.view.frame.size.height
        return CGSize(width: width, height: heightt)
    }

    func setupConstraints() {

        collectionView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }

        header.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(157)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(6)
            view.height.equalTo(41)
        }

        descriptionLabel.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(44)
        }

        nextButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(48)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
            view.width.equalTo(48)
        }

        pageControl.snp.makeConstraints { view in
            view.centerY.equalTo(nextButton.snp.centerY)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(60)
            view.height.equalTo(8)
        }
    }

}

//MARK: Make buttons actions
extension OnboardingViewController {

    private func makeButtonsAction() {
        nextButton.addTarget(self, action: #selector(nextButtonTaped), for: .touchUpInside)
    }

    @objc func nextButtonTaped() {
        guard let navigationController = self.navigationController else { return }

        let numberOfItems = self.collectionView.numberOfItems(inSection: 0)
        let nextRow = self.currentIndex + 1

        if nextRow < numberOfItems {
            let nextIndexPath = IndexPath(item: nextRow, section: 0)
            self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            self.currentIndex = nextRow
            resetLabelSizes(to: currentIndex)
        } else {
            OnboardingRouter.showPaymentViewController(in: navigationController)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleItems = collectionView.indexPathsForVisibleItems.sorted()
        if let visibleItem = visibleItems.first {
            currentIndex = visibleItem.item
        }
    }

    private func resetLabelSizes(to page: Int) {
        switch page {
        case 1:
            pageControl.setPage(1)
            break
        case 2:
            pageControl.setPage(2)
            break
        case 3:
            pageControl.setPage(3)
            break
        case 4:
            pageControl.setPage(4)
            break
        default:
            pageControl.setPage(0)
        }
    }
}

extension OnboardingViewController: IViewModelableController {
    typealias ViewModel = IOnboardingViewModel
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel?.onboardingItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OnboardingCell = collectionView.dequeueReusableCell(for: indexPath)
        descriptionLabel.text = viewModel?.onboardingItems[indexPath.row].description
        header.text = viewModel?.onboardingItems[indexPath.row].header
        cell.setup(image: viewModel?.onboardingItems[indexPath.row].image ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeForItem()
    }
}

//MARK: Preview
import SwiftUI

struct OnboardingViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let onboardingViewController = OnboardingViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) -> OnboardingViewController {
            return onboardingViewController
        }

        func updateUIViewController(_ uiViewController: OnboardingViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) {
        }
    }
}
