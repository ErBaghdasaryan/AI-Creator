//
//  EffectsViewModel.swift
//  AICreatorViewModel
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import Foundation
import AICreatorModel

public protocol IEffectsViewModel {
    
}

public class EffectsViewModel: IEffectsViewModel {

    private let effectsService: IEffectsService

    public init(effectsService: IEffectsService) {
        self.effectsService = effectsService
    }
}
