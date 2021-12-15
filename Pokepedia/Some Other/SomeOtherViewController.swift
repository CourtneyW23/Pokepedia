import UIKit
import Foundation
import PokemonFoundation

final class SomeOtherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var effectsLabel: UILabel!
    @IBOutlet weak var isMainLabel: UILabel!
    @IBOutlet weak var genLabel: UILabel!
}

extension SomeOtherTableViewCell {
    // linking TableView Cell labels to Ability API info
    func setup(abilities: Ability) {
        nameLabel.text = abilities.name
        idLabel.text = String(abilities.id)
        for effects in abilities.effectEntries {
            effectsLabel.text = effects.effect
       }
        isMainLabel.text = String(abilities.isMainSeries)
        genLabel.text = abilities.generation.name
    }
}

final class SomeOtherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var abilities: [Ability]!
   // View SomeOther content
    override func viewDidLoad() {
        super.viewDidLoad()
 
        title = "Some Other View Controller"
        view.backgroundColor = .systemBackground
       
        tableView.dataSource = self
        tableView.delegate = self
        
    }
}

extension SomeOtherViewController {
    
    // instantiation used to create an object
    static func instance(for ability: Ability) -> SomeOtherViewController {
        
        // swiftlint:disable:next force_cast
        let viewController = UIStoryboard(name: "SomeOther", bundle: nil).instantiateInitialViewController() as! SomeOtherViewController
        
        viewController.abilities = [ability]
        
        return viewController        
    }
}
// How tableview content is viewed
extension SomeOtherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// Where tableview content comes from
extension SomeOtherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return abilities.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return abilities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ability = abilities[indexPath.row]
        // creating a cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SomeOther")
            as? SomeOtherTableViewCell else {
            return SomeOtherTableViewCell()
        }

        cell.nameLabel.text = ability.name
        cell.idLabel.text = String(ability.id)
        for effects in ability.effectEntries {
            cell.effectsLabel?.text = effects.effect
       }
        cell.isMainLabel.text = String(ability.isMainSeries)
        cell.genLabel.text = ability.generation.name
        
        cell.setup(abilities: ability)
      
        return cell
    }
}
