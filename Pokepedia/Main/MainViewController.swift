// Project 1

// Submitted by Courtney Williams on 7/11/21

import UIKit

import PokemonUIKit

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationController = makePokédexViewController()
        
        addFullscreen(navigationController)
    }
}

extension MainViewController {
    
    // Use this initializer to make the navigation controller use your custom bar class.
    
    private func makePokédexViewController() -> UINavigationController {
        
        return UINavigationController(
            rootViewController: PokédexViewController(
                menuItemActions: [
                    ViewPokémonDetailsAction(),
                    ViewAbilitiesMenuItemAction()                    
                ]
            )
        )
    }
}
