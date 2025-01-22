//
//  GeneratorViewModel.swift
//  AICreatorViewModel
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import Foundation
import AICreatorModel

public protocol IGeneratorViewModel {
    
}

public class GeneratorViewModel: IGeneratorViewModel {

    private let generatorService: IGeneratorService

    public init(generatorService: IGeneratorService) {
        self.generatorService = generatorService
    }
}
