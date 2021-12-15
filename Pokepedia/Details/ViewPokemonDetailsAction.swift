// Project 1

// Submitted by Courtney Williams on 7/11/21

import UIKit

import PokemonFoundation
import PokemonUIKit

// PokédexMenuItemAction protocol

class ViewPokémonDetailsAction: PokédexMenuItemAction {
    
    let title: String = "View Attributes"
    
    var image: UIImage? { UIImage(systemName: "photo" )}
}

extension ViewPokémonDetailsAction {
    
    func viewController(for pokémon: Pokémon) -> UIViewController {
        
        return PokemonDetailsViewController.instance(for: pokémon)
    }
}
