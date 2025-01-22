//
//  VideosViewModel.swift
//  AICreatorViewModel
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import Foundation
import AICreatorModel

public protocol IVideosViewModel {
    
}

public class VideosViewModel: IVideosViewModel {

    private let videosService: IVideosService

    public init(videosService: IVideosService) {
        self.videosService = videosService
    }
}
