// Project 1

// Submitted by Courtney Williams on 7/11/21

import UIKit

import PokemonFoundation

final class PokemonDetailsViewController: UIViewController {
    
    // Attach storyboard to viewcontroller
    
    @IBOutlet weak var stackView: UIStackView!
    private lazy var gameI: UILabel = lazygameIndiceView()
    private lazy var abili: UILabel = lazyabilitiesView()
    private lazy var move: UILabel = lazymovesView()
    private lazy var held: UILabel = lazyHeldItemsView()
    private lazy var type: UILabel = lazyTypesView()
    private lazy var id: UILabel = lazyIdView()
    private lazy var name: UILabel = lazyNameView()
    private lazy var baseEx: UILabel = lazyBaseExpView()
    private lazy var weight: UILabel = lazyWeightView()
    private lazy var height: UILabel = lazyHeightView()
    
    private var pokémon: Pokémon!
    
}

extension PokemonDetailsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Labels
        let idLabel = UILabel()
        let nameLabel = UILabel()
        let baseExperienceLabel = UILabel()
        let heightLabel = UILabel()
        let gameIndicesLabel = UILabel()
        let weightLabel = UILabel()
        let abilitiesLabel = UILabel()
        let movesLabel = UILabel()
        let heldItemsLabel = UILabel()
        let typeLabel = UILabel()
        
        idLabel.text = "Id: "
        nameLabel.text = "Name: "
        baseExperienceLabel.text = "Base Experience: "
        heightLabel.text = "Height: "
        gameIndicesLabel.text = "Game Indices: "
        weightLabel.text = "Weight: "
        abilitiesLabel.text = "Abilities: "
        movesLabel.text = "Moves: "
        heldItemsLabel.text = "Held Items: "
        typeLabel.text = "Type: "
        
        idLabel.font = UIFont(name: "CourierNewPS-BoldMT", size: 25)
        nameLabel.font = UIFont(name: "CourierNewPS-BoldMT", size: 25)
        baseExperienceLabel.font = UIFont(name: "CourierNewPS-BoldMT", size: 25)
        heightLabel.font = UIFont(name: "CourierNewPS-BoldMT", size: 25)
        gameIndicesLabel.font = UIFont(name: "CourierNewPS-BoldMT", size: 25)
        weightLabel.font = UIFont(name: "CourierNewPS-BoldMT", size: 25)
        abilitiesLabel.font = UIFont(name: "CourierNewPS-BoldMT", size: 25)
        movesLabel.font = UIFont(name: "CourierNewPS-BoldMT", size: 25)
        heldItemsLabel.font = UIFont(name: "CourierNewPS-BoldMT", size: 25)
        typeLabel.font = UIFont(name: "CourierNewPS-BoldMT", size: 25)
        
        // calls labels and attribute functions
        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(id)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(baseExperienceLabel)
        stackView.addArrangedSubview(baseEx)
        stackView.addArrangedSubview(heightLabel)
        stackView.addArrangedSubview(height)
        stackView.addArrangedSubview(weightLabel)
        stackView.addArrangedSubview(weight)
        stackView.addArrangedSubview(gameIndicesLabel)
        stackView.addArrangedSubview(gameI)
        stackView.addArrangedSubview(abilitiesLabel)
        stackView.addArrangedSubview(abili)
        stackView.addArrangedSubview(movesLabel)
        stackView.addArrangedSubview(move)
        stackView.addArrangedSubview(heldItemsLabel)
        stackView.addArrangedSubview(held)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(type)
        
    }
}

extension PokemonDetailsViewController {
    
    // instantiation used to create an object
    
    static func instance(for pokemon: Pokémon) -> PokemonDetailsViewController {
        
        let viewController = UIStoryboard(name: "PokemonDetails", bundle: nil).instantiateInitialViewController() as? PokemonDetailsViewController
        viewController?.pokémon = pokemon
        return viewController!
    }
}

extension PokemonDetailsViewController {
    
    // Attribute functions
    
    private func lazyIdView() -> UILabel {
        let id = UILabel()
        id.text = " \(String(describing: pokémon.id!))"
        
        id.font = UIFont(name: "CourierNewPSMT", size: 20)
        return id
    }
    
    private func lazyNameView() -> UILabel {
        let name = UILabel()
        name.text = " \(String(describing: pokémon.name!))"
        name.font = UIFont(name: "CourierNewPSMT", size: 20)
        return name
    }
    
    private func lazyBaseExpView() -> UILabel {
        let baseEx = UILabel()
        baseEx.text = " \(String(describing: pokémon.baseExperience))"
        baseEx.font = UIFont(name: "CourierNewPSMT", size: 20)
        return baseEx
    }
    
    private func lazyHeightView() -> UILabel {
        let height = UILabel()
        height.text = " \(String(describing: pokémon.height!))"
        height.font = UIFont(name: "CourierNewPSMT", size: 20)
        return height
    }
    
    private func lazyWeightView() -> UILabel {
        let weight = UILabel()
        weight.text = " \(String(describing: pokémon.weight!))"
        weight.font = UIFont(name: "CourierNewPSMT", size: 20)
        return weight
    }
        
    private func lazygameIndiceView() -> UILabel {
        let gameI = UILabel()
        for gameI in pokémon.gameIndices! {
            let gameIndices = UILabel()
            gameIndices.text = " \(gameI.version?.name ?? "")"
            stackView.addArrangedSubview(gameIndices)
            gameIndices.font = UIFont(name: "CourierNewPSMT", size: 20)
            
        }
        
        return gameI 
    }
    
    private func lazyabilitiesView() -> UILabel {
        let abili = UILabel()
        for abili in pokémon.abilities! {
            let abilities = UILabel()
            abilities.text = " \(abili.ability?.name ?? "") "
            stackView.addArrangedSubview(abilities)
            abilities.font = UIFont(name: "CourierNewPSMT", size: 20)
        }
        return abili
    }
    
    private func lazymovesView() -> UILabel {
        let move = UILabel()
        for move in pokémon.moves! {
            let moves = UILabel()
            moves.text = " \(move.move?.name ?? "")"
            stackView.addArrangedSubview(moves)
            moves.font = UIFont(name: "CourierNewPSMT", size: 20)
        }
        return move
    }
    
    private func lazyHeldItemsView() -> UILabel {
        let held = UILabel()
        for held in pokémon.heldItems! {
            let heldItem = UILabel()
            heldItem.text = " \(held.item?.name ?? "")"
            stackView.addArrangedSubview(heldItem)
            heldItem.font = UIFont(name: "CourierNewPSMT", size: 20)
        }
        return held
    }
    
    private func lazyTypesView() -> UILabel {
        let type = UILabel()
        for type in pokémon.types! {
            let types = UILabel()
            types.text = " \(type.type?.name ?? "")"
            stackView.addArrangedSubview(types)
            types.font = UIFont(name: "CourierNewPSMT", size: 20)
        }
        return type
    }
}
