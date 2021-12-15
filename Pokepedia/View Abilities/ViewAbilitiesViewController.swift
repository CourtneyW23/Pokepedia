import UIKit

import PokemonFoundation

// ViewController for detailed Abilites content
final class ViewAbilitiesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    private var model: AbilitiesModel!
    var someOther: SomeOtherTableViewCell!
}

extension ViewAbilitiesViewController {
    
    // view content
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Abilities"
      
        tableView.dataSource = self
        tableView.delegate = self
        
        model.delegate = self
    }
}

extension ViewAbilitiesViewController {
    
    // instantiation used to create an object
    
    static func instance(for pokémon: Pokémon) -> ViewAbilitiesViewController {
        let storyboard = UIStoryboard(name: "ViewAbilites", bundle: nil)
        
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! ViewAbilitiesViewController
        
        let items: [Item] = pokémon.abilities?.compactMap { ability in
            guard
                let name = ability.ability?.name,
                let slot = ability.slot,
                let url = ability.ability?.url
            else {
                return nil
            }
            
            return Item(name: name, detail: "Slot #\(slot)", url: url)
        } ?? []
      
        viewController.model = AbilitiesModel(items: items)
        
        return viewController
    }
}

// How tableview content is viewed
extension ViewAbilitiesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        model.userTapped(row: indexPath.row)
    }
}

// Where tableview content comes from
extension ViewAbilitiesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // creating a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "AbilityCell")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "AbilityCell")
        
        let item = model.items[indexPath.row]
        
        cell.textLabel?.text = item.name.capitalized
        cell.detailTextLabel?.text = item.detail
        
        return cell
    }
}

extension ViewAbilitiesViewController: AbilitiesModelDelegate {
    func blockUI() {
        // activityIndicator.startAnimating()
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    func display(ability: Ability) {
        // Display the object using an additional UIViewController subclass. 
        DispatchQueue.main.async { [weak self] in
            let viewController = SomeOtherViewController.instance(for: ability)
            
            self?.show(viewController, sender: nil)
          
            self?.activityIndicator.stopAnimating()
        }
    }
    
    func display(error: Error) {
        // Display error message
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}
