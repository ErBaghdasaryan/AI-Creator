//
//  OnboardingService.swift
//  AICreatorViewModel
//
//  Created by Er Baghdasaryan on 21.01.25.
//

import UIKit
import AICreatorModel

public protocol IOnboardingService {
    func getOnboardingItems() -> [OnboardingPresentationModel]
}

public class OnboardingService: IOnboardingService {
    public init() { }

    public func getOnboardingItems() -> [OnboardingPresentationModel] {
        [
            OnboardingPresentationModel(image: "onboarding1",
                                        header: "Welcome to AI Creator!",
                                        description: "Explore the future of content creation with AI. Let your imagination take the lead!"),
            OnboardingPresentationModel(image: "onboarding2",
                                        header: "Just type and create!",
                                        description: "Simply describe your idea, and let AI turn it into something extraordinary"),
            OnboardingPresentationModel(image: "onboarding3",
                                        header: "Unique effects!",
                                        description: "Melt it, squish it, crush it, etc."),
            OnboardingPresentationModel(image: "onboarding4",
                                        header: "Start creating now!",
                                        description: "")
        ]
    }
}
