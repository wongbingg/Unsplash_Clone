//
//  Topic.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/20.
//

import Foundation

enum Topic: CaseIterable {
    case wallpapers
    case threeDRenders
    case nature
    case travel
    case architectureAndInteriors
    case streetPhotography
    case texturesAndPatterns
    case film
    case experimental
    case animals
    case fashionAndBeauty
    case businessAndWork
    case foodAndDrink
    case people
    case spirituality
    case athletics
    case healthAndWellness
    case currentEvents
    case artsAndCulture
    
    var slug: String {
        switch self {
        case .wallpapers: return "wallpapers"
        case .threeDRenders: return "3d-renders"
        case .nature: return "nature"
        case .travel: return "travel"
        case .architectureAndInteriors: return "architecture-interior"
        case .streetPhotography: return "street-photography"
        case .texturesAndPatterns: return "textures-patterns"
        case .film: return "film"
        case .experimental: return "experimental"
        case .animals: return "animals"
        case .fashionAndBeauty: return "fashion-beauty"
        case .businessAndWork: return "business-work"
        case .foodAndDrink: return "food-drink"
        case .people: return "people"
        case .spirituality: return "spirituality"
        case .athletics: return "athletics"
        case .healthAndWellness: return "health"
        case .currentEvents: return "current-events"
        case .artsAndCulture: return "arts-culture"
        }
    }
    
    var title: String {
        switch self {
        case .wallpapers: return "Wallpapers"
        case .threeDRenders: return "3D Renders"
        case .nature: return "Nature"
        case .travel: return "Travel"
        case .architectureAndInteriors: return "Architecture & Interior"
        case .streetPhotography: return "Street Photography"
        case .texturesAndPatterns: return "Textures & Patterns"
        case .film: return "Film"
        case .experimental: return "Experimental"
        case .animals: return "Animals"
        case .fashionAndBeauty: return "Fashion & Beauty"
        case .businessAndWork: return "Business & Work"
        case .foodAndDrink: return "Food & Drink"
        case .people: return "People"
        case .spirituality: return "Spirituality"
        case .athletics: return "Athletics"
        case .healthAndWellness: return "Health & Wellness"
        case .currentEvents: return "Current Events"
        case .artsAndCulture: return "Arts & Culture"
        }
    }
}
