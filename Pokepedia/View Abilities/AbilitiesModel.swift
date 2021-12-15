import Foundation
import PokemonFoundation
import UIKit

struct VerboseEffect: Decodable {
    let effect: String
    let shortEffect: String
    let language: NamedAPIResource
}
struct Ability: Decodable {
    let id: Int
    let name: String
    let isMainSeries: Bool
    let generation: NamedAPIResource
    let effectEntries: [VerboseEffect]
    
//    enum CodingKeys: String, CodingKey {
//            case id
//            case name
//            case isMainSeries
//            case generation
//            case effectEntries
//        }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(Int.self, forKey: .id) // decode optionals
//        name = try container.decode(String.self, forKey: .name)
//        isMainSeries = try container.decode(Bool.self, forKey: .isMainSeries)
//    
//        let gen = try container.decode([NamedAPIResource].self, forKey: .generation)
//        self.generation = gen.map {$0}
//
//        let effect = try container.decode([VerboseEffect].self, forKey: .effectEntries)
//        self.effectEntries = effect.map {$0}
//    }
}

protocol AbilitiesModelDelegate: AnyObject {
    
    // block UI
    func blockUI() // method definition
   
    // Display ability
    func display(ability: Ability)
    
    // Display error
    func display(error: Error)
}

final class AbilitiesModel {
    
    private let serviceClient: ServiceClient = ServiceClient()
    let items: [Item]
    
    weak var delegate: AbilitiesModelDelegate?
    
    init(items: [Item]) {
        self.items = items
    }
    
    // Get Data from Ability URL
    func userTapped(row: Int) {
        let item = items[row]
        
        delegate?.blockUI()
        serviceClient.get(from: item.url) { [weak self] result in
            do {
                let data = try result.get()
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let ability = try decoder.decode(Ability.self, from: data)
               
                self?.delegate?.display(ability: ability)
                
            } catch {
                
                self?.delegate?.display(error: error)
            }
        }
    }
}
