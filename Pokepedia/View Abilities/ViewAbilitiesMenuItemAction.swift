import UIKit

import PokemonFoundation
import PokemonUIKit

final class ViewAbilitiesMenuItemAction: PokédexMenuItemAction {
    let title: String = "View Abilities"
    
    var image: UIImage? { UIImage(systemName: "photo" ) }
    
    func viewController(for pokémon: Pokémon) -> UIViewController {
        
        return ViewAbilitiesViewController.instance(for: pokémon)
    }
}
